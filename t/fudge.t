#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

sub is_fudged_ok($$);

is_fudged_ok 'implname', 'Simple tests for fudging for implementations';


sub is_fudged_ok($$) {
    my ($file, $desc) = @_;
    my ($in, $out)    = ("t/$file.in", "t/$file.out");
    my $contents_in   = do { local( @ARGV, $/ ) = $in;  <> };
    my $contents_out  = do { local( @ARGV, $/ ) = $out; <> };
    is $contents_in, $contents_out, $desc;
}
