use v6;

use Test;

use lib 't/spec/packages';
use Test::Util;

plan 2;

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

is_run(
    '1',      # program
    "foo\n",  # input
    {
        out => "foo\n",   # expected
    },
    '-p -e 1 works like cat',
    :compiler-args['-p'],
);

is_run(
    's:g/o/a/',     # program
    "foo\nbar\n",   # input
    {
        out => "faa\nbar\n",
    },
    '-p works in combination with s:g///',
    :compiler-args['-p'],
);
