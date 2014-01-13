#!/usr/bin/perl -w
#


use Tie::File;
use strict;

tie my @lines, 'Tie::File', $ARGV[0] or die "Could not tie $ARGV[0]\n";

foreach my $line(@lines) {
	my $linebkp = $line;
	if ($line =~ /^\!\[(.+)\]\((.+)\)$/ && $linebkp !~ /^\!\[equation/) {
		print "caption: $1\n";
		print "filename: $2\n";
		$line = "BEGCAP$1ENDCAPFILE$2ENDFILE";
	}
}

untie @lines;
