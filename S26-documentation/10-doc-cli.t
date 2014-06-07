use v6;
use lib 't/spec/packages';

use Test;
use Test::Util;
plan 2;

my $POD = Q:to<POD>;
=begin pod

=head1 Some Heading

Some Text

=end pod
POD

is_run :compiler-args['--doc'], $POD, {
        out => rx/'Some Heading'/ & rx/'Some Text'/, err => '',
    }, 'basic --doc sanity';

my $POD2 = $POD ~ Q:to<CODE>;

DOC INIT { say 'alive'; exit };
CODE

#?rakudo skip 'RT12205'
is_run :compiler-args['--doc'], $POD2 , {
        out => rx/'alive'/, err => '',
    }, 'basic --doc with DOC INIT block';


# vim: ft=perl6
