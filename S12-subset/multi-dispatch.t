use v6;
use Test;

# L<S12/Types and Subtypes/>

plan 6;

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
dies_ok { foo("bar") }, "value that doesn't meet single constraint causes failed dispatch";

# vim: ft=perl6
