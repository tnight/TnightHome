#!/usr/local/bin/perl -w

# Sleep time in seconds
my $sleepTime = 300;

# Item Number to search for
### my $item = 1883;
my $item = 4167;

# Create a user agent object and set its parameters appropriately
use LWP::UserAgent;
$ua = new LWP::UserAgent;
$ua->proxy(['http', 'ftp'], 'http://http-relay.corp.adobe.com:8080/');
$ua->agent("AgentName/0.1");

#
# Keep doing this until we are interrupted
#
while (1) {
    # Create a request
    my $req = new HTTP::Request POST => 
       'http://www.bcc.ctc.edu/scripts/rqservnt.exe';

    # Set the request parameters
    $req->content_type('application/x-www-form-urlencoded');
    $req->content(
        "request=classchd&ayr=1998+-+99&sess=2+-+Fall&item=$item");

    # Pass request to the user agent and get a response back
    my $res = $ua->request($req);

    # Check the outcome of the response
    if ($res->is_success
        && $res->content =~ m/Class Status: OPEN/o)
    {
        $res->content =~ m/Seats Available: (\d+)/o;
        my $seats = $1;

        $res->content =~ m/Course Id: (\w+)\s(\w+)/o;
        my $courseId = $1 . $2;

        $res->content =~ m/Course Title: (.*)/o;
        my $courseTitle = $1;

        my $msg = <<EOM;
Item Number: $item,
Course Id: $courseId,
Course Title: $courseTitle,
Class Status: OPEN,
Seats Available: $seats
EOM

        # Page me so I'll know to register.
        send_email('beep-tnightin@adobe.com', 
            "BCC Class Open", scalar localtime, $msg);
    }

    sleep($sleepTime);
}

#===========================================================================
# Routine: send_email
#
# Purpose: Send an SMTP email given recipient, subject, date, and body.
#---------------------------------------------------------------------------
sub send_email
{
    my $rcpt = $_[0];
    my $subj = $_[1];
    my $date = $_[2];
    my $body = $_[3];


    ##  Variable initializations (for use strict).
    my($to,$admin,$from,$subject,$msgbody,$sendmail,$query);

    ##  Where is sendmail located.
    $sendmail = "/usr/lib/sendmail";

    ##  Set the path for security and taint checking.
    $ENV{'PATH'} = "/usr/bin:/bin";

    ##  If you want to hardcode any of these, just set them up by $sendmail
    ##  in the constants section, they will only be overriden if unset by
    ##  these statements.  You might also choose to append to the message
    ##  here to indicate that the from address is not verified.  In general,
    ##  I would advise you to set them in your pages, this lets the program
    ##  work for many different pages or submissions.
    $to ||= $rcpt;
    $admin = $admin || $rcpt;
    $from ||= 'Class Schedule Script <tnightin@adobe.com>';
    $subject ||= $subj;
    $msgbody ||= $body;

    ##  Start sendmail taking input on STDIN to be sent off.  By using
    ##  sendmail -oit and writing to it with a here file (as below), we
    ##  avoid sh -c gotchas that backticks, system, or "| $mail $addr"
    ##  can fall victim to.  Searching for semi-colons isn't safe enough
    ##  and trying to scrub user inputted fields is both difficult and
    ##  hazardous.
    open(MAIL,"| $sendmail -oi -t") || do {
      die "Sendmail exited with error: $!\n";
    };

    ##  Print message to sendmail filehandle.  Note that you can't create
    ##  a shell or escape out of this by entering in code to the text block 
    ##  or email fields (even backticks).  The to address is taken from the
    ##  submission form (use a hidden field) so that this same backend script
    ##  can service any number of HTML submission forms.
    print MAIL <<"EOHF";
To: $to
From: $from
Subject: $subject
X-Mailer: school1.pl 1.0

$msgbody
EOHF
    close(MAIL);

    ##  Check exit status (the latter uses CGI::Carp).  Give the user
    ##  feedback through a HTML response.
    if($?) {
      die "Sendmail exited with error: $!\n";
    }
}

