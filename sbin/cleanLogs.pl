#! /usr/bin/perl -w
#============================================================================
# Program: cleanLogs.pl
#
# Purpose: Keep a log directory (and ultimately volume) from filling up by
#          deleting old log files.
#
# Created: 11/12/1999 by Terry Nightingale <tnight@pobox.com>
#
# Changed: 99/99/9999 by xxx to ...
#----------------------------------------------------------------------------

# For better compile-time error checking
use strict;

# For flexible date handling
use Date::Manip;

# For option processing
use Getopt::Long;

# Begin main routine.

{
    my $usage = <<END;
Usage: cleanLogs.pl [-help] [-logdir <dir>] [-test] [-verbose]

-help          Print this help message
-logdir <dir>  Directory for writing log files (defaults to /logs)
-test          Don't delete files, just print their names
-verbose       Delete files and print their names


END

    # Grab our command-line parameters to see how we should run
    my %options = ();
    GetOptions( \%options, qw(-date=s -help -logdir=s -test -verbose) );

    if ($options{'help'}) {
        print $usage;
        exit(1);
    }

    # Storage for our parameters.
    my ($date, $logDir, $test, $verbose);

    # Set our date and log directory based on our parameters or 
    # the defaults.

    if (! exists $options{'date'}) {
        $options{'date'} = 'today';
    }

    $date = Date::Manip::UnixDate(
        Date::Manip::ParseDate($options{'date'}), '%m%d%Y');

    $logDir = $options{'logdir'} || '/logs';

    # Store the -test and -verbose flags for later use.
    $test    = $options{'test'};
    $verbose = $options{'verbose'};

    # Start our main loop, that of searching for log files and 
    # deleting them.

    opendir(LOGS, $logDir) or die "Cannot opendir $logDir: $!\n";
    while ($_ = readdir(LOGS)) {

        # If we find a log file, but the date is not today's date,
        # delete it.
        if (m/Recalc_[\d_]+\.log/ && ! m/$date/) {
            if ($test) {
                print "Would have deleted $_\n";
	    }
            else {
	        if ($verbose) {
                    print "Deleting $_\n";
		}
                unlink "$logDir/$_" or die "Cannot unlink $_: $!\n";
            }
	}
    }

    close(LOGS);

}

# End main routine.

