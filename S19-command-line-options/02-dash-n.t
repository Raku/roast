use v6;

use Test;

use lib 't/spec/packages';
use Test::Util;

plan 3;

=begin pod

Test C<-n> implementation

The C<-n> command line switch mimics the Perl5 C<-n> command line
switch, and wraps the whole script in

  for (lines) {
    ...         # your script
  };

=end pod

# L<S19/Reference/"Act like awk.">

my $str = "foo
bar
".subst("\r", "", :g);

is_run(
    $str,          # input
    {
        out => $str,
    },
    '-n -e .say works like cat',
    :compiler-args['-n -e .say'],
);

is_run(
    $str,          # input
    {
        out => $str,
    },
    '-ne .say works like cat',
    :compiler-args['-ne .say'],
);

# RT #107992
is_run(
    $str,          # input
    {
        status => 0,
        out    => '',
        err    => '',
    },
    '-n -e "" works like awk ""',
    :compiler-args['-n -e ""'],
);

# vim: ft=perl6
