#!/usr/bin/perl -w

use strict;
use Date::Manip;

my ($beginDate, $endDate, $error);
my $usage = "usage: $0 startDate endDate";

if (scalar(@ARGV) != 2) {
  print STDERR "$usage\n";
  exit 1;
}
else {
  ($beginDate, $endDate) = @ARGV;
}

my $delta = DateCalc(ParseDate($beginDate), ParseDate($endDate), \$error);

if (defined $error) {
  print "\$error = [$error]\n" ;
}
else {
  my $days = Delta_Format($delta, 'approx', 0, "%dt");
  print "Difference between [$beginDate] and [$endDate] in days = [$days].\n";
}

# End of script.
