#!/usr/bin/perl
###################################################
#encode_base64.pl:
###################################################
use strict;
use MIME::Base64 qw( encode_base64 );

open INFILE, '<', $ARGV[0];
binmode INFILE;
open OUTFILE, '>', $ARGV[1];
my $buf;
while ( read( INFILE, $buf, 4096 ) ) {
    print OUTFILE encode_base64($buf);
}

close OUTFILE;
close INFILE;

# End of script
