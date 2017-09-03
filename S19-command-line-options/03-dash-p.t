use v6;

use lib 't/spec/packages';

use Test;

use Test::Util;

plan 3;

=begin pod

Test C<-p> implementation

The C<-p> command line switch mimics the Perl5 C<-p> command line
switch, and wraps the whole script in

  for (lines) {
    ...         # your script
    .say;
  };

=end pod

# L<S19/Reference/"Act like sed.">

#?rakudo.jvm skip 'hangs, RT #131393'
is_run(
    '1',      # program
    "foo\n",  # input
    {
        out => "foo\n",   # expected
    },
    '-p -e 1 works like cat',
    :compiler-args['-p'],
);

#?rakudo.jvm skip 'hangs, RT #131393'
is_run(
    's:g/o/a/',     # program
    "foo\nbar\n",   # input
    {
        out => "faa\nbar\n",
    },
    '-p works in combination with s:g///',
    :compiler-args['-p'],
);

# RT #124247
#?rakudo.jvm skip 'hangs, RT #131393'
is_run(
    's[(\d)] = "{$0 * 10}"',      # program
    "5 breads and 2 fishes\n",  # input
    {
        out => "50 breads and 2 fishes\n",   # expected
    },
    '-p -e using $0 in {} in "" in rhs in assign to s[] form subst',
    :compiler-args['-p'],
);

