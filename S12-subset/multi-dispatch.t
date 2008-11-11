use v6;
use Test;

plan 4;

subset Even of Int where { $_ % 2 == 0 };
subset Odd  of Int where { $_ % 2 == 1 };

multi sub test_subtypes(Even $y){ 'Even' }
multi sub test_subtypes(Odd  $y){ 'Odd'  }

is test_subtypes(3), 'Odd',  'mutli dispatch with type mutual exclusive type constaints 1';
is test_subtypes(4), 'Even', 'mutli dispatch with type mutual exclusive type constaints 1';


multi sub mmd(Even $x) { 'Even' }
multi sub mmd(Int  $x) { 'Odd'  }

is mmd(3), 'Odd' , 'MMD with subset type multi works';
#?rakudo todo 'bug - subset types do not convey the type they restrict to the dispatcher'
is mmd(4), 'Even', 'subset multi is narrower than the general type';
