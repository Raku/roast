use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 6;

=begin pod

Test C<-n> implementation

The C<-n> command line switch mimics the Perl C<-n> command line
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
subtest '-n -e "" works like awk ""' => {
    plan 3;
    my $proc = run :out, :err, :in, $*EXECUTABLE, '-n', '-e', '';
    $proc.in.print: $str;
    $proc.in.close;
    is $proc.out.slurp(:close), '';
    is $proc.err.slurp(:close), '';
    is $proc.exitcode, 0;
}

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
