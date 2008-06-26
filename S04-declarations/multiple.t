use v6;
use Test;
plan 3;

# L<S04/The Relationship of Blocks and Declarations/"If you declare a lexical 
#  twice in the same scope">

eval_lives_ok 'my $x; my $x', 
              'it is legal to declare my $x twice in the same scope.';

eval_lives_ok 'state $x; state $x', 
              'it is legal to declare state $x twice in the same scope.';

{
    my $x = 2;
    my $y := $x;
    my $x = 3;
    is $y, 3, 'Two lexicals with the name in same scope are the same variable';
}
