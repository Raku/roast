use v6;

use lib 't/spec/packages';

use Test;

use Test::Util;

plan 6;

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
".subst("\r\n", "\n", :g);

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

#?rakudo todo 'NYI RT #129093'
is_run(
    $str,          # input
    {
        out => "foo\n",
    },
    '-n -e "FIRST .say" prints the first line of the input',
    :compiler-args['-n -e "FIRST .say"'],
);

#?rakudo todo 'NYI RT #129093'
is_run(
    $str,          # input
    {
        out => "bar\n",
    },
    '-n -e "LAST .say" prints the last line of the input',
    :compiler-args['-n -e "LAST .say"'],
);

#?rakudo todo 'NYI RT #129093'
is_run(
    $str,          # input
    {
        out => $str,
    },
    '-n -e "NEXT .say" prints each line of the input',
    :compiler-args['-n -e "NEXT .say"'],
);

# vim: ft=perl6
