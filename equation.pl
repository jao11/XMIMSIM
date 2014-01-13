#!/usr/bin/perl -w
#


use Tie::File;
use strict;
use URI::Escape;


tie my @lines, 'Tie::File', $ARGV[0] or die "Could not tie $ARGV[0]\n";

foreach my $line (@lines) {
	if ($line =~ /http:\/\/latex.codecogs.com\/svg.latex\?(.+?)\}/) {
		print "$1\n";
		my $temp = $1;
		$temp =~ s/\\%/%/g;
		my $decoded = uri_unescape($temp);
		print "$decoded\n";
		$line = "\\begin{equation}\n$decoded\n\\end{equation}";
	}
}
untie @lines;
