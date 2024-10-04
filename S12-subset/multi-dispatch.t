use Test;

# L<S12/Types and Subtypes/>

plan 7;

subset Even of Int where { $_ % 2 == 0 };
subset Odd  of Int where { $_ % 2 == 1 };

multi sub test_subtypes(Even $y){ 'Even' }   #OK not used
multi sub test_subtypes(Odd  $y){ 'Odd'  }   #OK not used

is test_subtypes(3), 'Odd',  'mutli dispatch with type mutual exclusive type constaints 1';
is test_subtypes(4), 'Even', 'mutli dispatch with type mutual exclusive type constaints 1';


multi sub mmd(Even $x) { 'Even' }   #OK not used
multi sub mmd(Int  $x) { 'Odd'  }   #OK not used

is mmd(3), 'Odd' , 'MMD with subset type multi works';
is mmd(4), 'Even', 'subset multi is narrower than the general type';

multi foo ($foo where { $_ eq "foo"}) { $foo }
is foo("foo"), "foo", "when we have a single candidate with a constraint, it's enforced";
dies-ok { foo("bar") }, "value that doesn't meet single constraint causes failed dispatch";

# https://github.com/rakudo/rakudo/issues/1801
{
    my $arity-ok;
    subset CAT of Code where .arity == 2;
    multi xz(CAT :$x!) { $x(3,5) }
    multi xz(CAT $x = * <=> *) { $arity-ok = True }
    xz();
    ok $arity-ok, 'did the right candidate get called';
}

# vim: expandtab shiftwidth=4
