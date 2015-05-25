use v6;

use Test;

plan 4;


# L<S06/The C<&?ROUTINE> object/current routine name>
# L<S02/Names/Which routine am I in>
sub foo { return &?ROUTINE.package.^name ~ '::' ~ &?ROUTINE.name }
is(foo(), 'GLOBAL::foo', 'got the right routine name in the default package');

{
    # This testcase might be really redundant
    package Bar {
        sub bar { return &?ROUTINE.package.^name ~ '::' ~ &?ROUTINE.name }
        is(bar(), 'Bar::bar', 'got the right routine name outside the default package');
    }
}

my $bar = sub { &?ROUTINE.name };
is($bar(), '', 'got an empty string for an anon block');

throws-like { EVAL 'my $baz = try { &?ROUTINE.name };' },
  X::Undeclared::Symbols,
  "&?ROUTINE not available outside of a routine";

# vim: ft=perl6
