use v6;
use lib 't/spec/packages';

use Test;
use Test::Util;
plan 1;

my $POD = Q:to<POD>;
=begin pod

=head1 Some Heading

Some Text

=end pod
POD

is_run :compiler-args['--doc'], $POD, {
        out => rx/'Some Heading'/ & rx/'Some Text'/
    }, 'basic --doc sanity';


# vim: ft=perl6
