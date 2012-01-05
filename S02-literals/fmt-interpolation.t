use v6;

use Test;

=begin kwid

=head1 String interpolation and fmt

These tests exercise a bug found at least in r16241 of Pugs

=end kwid

plan 11;

# L<S02/Interpolation rules/Bare scalar variables>

my $x = 'A';
my $y;

is("\$x is $x", '$x is A', 'normal scalar variable interpolation');

is(
   "ord of \$x is $x.ord()",
   'ord of $x is 65',
   'normal scalar variable builtin call as a method'
);
lives_ok(sub { $y = "ord of \$x is $x.ord.fmt('%d')" },
   'fmt and scalar interpolation live');
is($y, 'ord of $x is 65', 'fmt and scalar interpolation behave well');

is("\$x is {$x}", '$x is A', 'normal scalar variable interpolation');
is(
   "ord of \$x is {$x.ord()}",
   'ord of $x is 65',
   'normal scalar variable builtin call as a method'
);
lives_ok(sub { $y = "hex-formatted ord of \$x is {$x.ord().fmt('%x')}" },
   'fmt and code interpolation live');
is(
   $y,
   'hex-formatted ord of $x is 41',
   'fmt and code interpolation behave well'
);

# These tests actually exercise what's a bug in eval() IMHO -- polettix
my $z;
my $expected = 'hex-formatted ord of $x is 41';
is(
   eval(
      q[
         $y = "hex-formatted ord of \$x is {$x.ord().fmt('%x')}";
         $z = 1;
         $y;
      ]
   ),
   $expected,
   'evals ok'
);
ok($z, 'eval was *really* ok');
is($y, $expected, 'fmt and code interpolation behave well');

# vim: ft=perl6
