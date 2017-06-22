#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 12;

sub is_fudged_ok($$$$);

is_fudged_ok '01-implname', 'impl-1', 'v6.0.0', 'test for fudging for implementation names';
is_fudged_ok '01-implname', 'impl-2', 'v6.0.0', 'test for fudging for implementation names';
is_fudged_ok '01-implname', 'impl-1.backend', 'v6.0.0', 'test for fudging for implementation names';

# we just call the implementation 'v6.0.0' here to have the test file have this name in it.
is_fudged_ok '02-version',  'v6.0.0', 'v6.0.0', 'test fudging if Perl 6 version (mis)matches';
is_fudged_ok '02-version',  'v6.0.3', 'v6.0.3', 'test fudging if Perl 6 version (mis)matches';
is_fudged_ok '02-version',  'v6.1.0', 'v6.1.0', 'test fudging if Perl 6 version (mis)matches';

is_fudged_ok '03-count',    'v6.0.0', 'v6.0.0', 'Simple test for fudging for implementations';

# we use different implementations only to get different output files
is_fudged_ok '04-combinations', 'impl.1', 'v6.0.0', 'combinations of fudging for implementation and version';
is_fudged_ok '04-combinations', 'impl.2', 'v6.0.6', 'combinations of fudging for implementation and version';

is_fudged_ok '05-skip', 'impl-1', 'v6.0.0', 'test for skip only working on actual tests';
is_fudged_ok '06-todo', 'impl-1', 'v6.0.0', 'test for todo only working on actual tests';
is_fudged_ok '07-register_function', 'impl-1', 'v6.0.0', 'test for registration of custom test function';

sub is_fudged_ok($$$$) {
    my ($file, $impl, $ver, $desc) = @_;
    my ($in, $out)    = ("t/$file.in", "t/$file.out_$impl");
    my $got           = `$^X fudge --version=$ver $impl $in`;
    my $contents_got  = do { local( @ARGV, $/ ) = $got; <> };
    my $contents_exp  = do { local( @ARGV, $/ ) = $out; <> };
    is $contents_got, $contents_exp, $desc;
}
