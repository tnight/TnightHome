#!/usr/bin/perl
###################################################
#decode_base64.pl:
###################################################
use strict;
use MIME::Base64 qw( decode_base64 );

open INFILE,  '<', $ARGV[0];
open OUTFILE, '>', $ARGV[1];
binmode OUTFILE;
my $buf;
while ( $buf = <INFILE> ) {
    print OUTFILE decode_base64($buf);
}

close OUTFILE;
close INFILE;

# End of script
