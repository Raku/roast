use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 2;

my $POD = Q:to<--END-->;
=begin pod

=head1 Some Heading

Some Text

=end pod
--END--

is_run :compiler-args['--doc'], $POD, {
        out => rx/'Some Heading'/ & rx/'Some Text'/, err => '',
    }, 'basic --doc sanity';

my $POD2 = $POD ~ Q:to<--END-->;

DOC INIT { say 'alive'; exit };
--END--

is_run :compiler-args['--doc'], $POD2 , {
        out => rx/'alive'/, err => '',
    }, 'basic --doc with DOC INIT block';

# vim: expandtab shiftwidth=4
