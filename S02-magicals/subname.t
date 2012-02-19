use v6;

use Test;

plan 4;


# L<S06/The C<&?ROUTINE> object/current routine name>
# L<S02/Names/Which routine am I in>
sub foo { return &?ROUTINE.name }
is(foo(), '&Main::foo', 'got the right routine name in the default package');

{
    # This testcase might be really redundant
    package Bar {
	sub bar { return &?ROUTINE.name }
	is(bar(), '&Bar::bar', 'got the right routine name outside the default package');
    }
}

my $bar = sub { return &?ROUTINE.name };
is($bar(), '<anon>', 'got the right routine name (anon-block)');

my $baz = try { &?ROUTINE.name };
#?pugs todo
ok(not(defined $baz), '&?ROUTINE.name not defined outside of a routine');

# vim: ft=perl6
