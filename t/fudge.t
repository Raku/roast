#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

sub is_fudged_ok($$$);

is_fudged_ok '01-implname', 'impl-1', 'Simple test for fudging for implementations';
is_fudged_ok '01-implname', 'impl-2', 'Simple test for fudging for implementations';


sub is_fudged_ok($$$) {
    my ($file, $impl, $desc) = @_;
    my ($in, $out)    = ("t/$file.in", "t/$file.out_$impl");
    my $got           = `$^X fudge --version=v6.0.3 $impl $in`;
    my $contents_got  = do { local( @ARGV, $/ ) = $got; <> };
    my $contents_exp  = do { local( @ARGV, $/ ) = $out; <> };
    is $contents_got, $contents_exp, $desc;
}
