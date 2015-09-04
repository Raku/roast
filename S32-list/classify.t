use v6;
use Test;

# L<S32::Containers/"List"/"=item classify">

plan 39;

{
    my @list = 1, 2, 3, 4;
    my $classified1 = { even => [2,4],     odd => [1,3]     };
    my $classified2 = { even => [2,4,2,4], odd => [1,3,1,3] };
    my sub subber ($a) { $a % 2 ?? 'odd' !! 'even' };
    my $blocker = { $_ % 2 ?? 'odd' !! 'even' };
    my $hasher  = { 1 => 'odd', 2 => 'even', 3 => 'odd', 4 => 'even' };
    my $arrayer = <huh odd even odd even>.list;

    for &subber, $blocker, $hasher, $arrayer -> $classifier {
        is-deeply @list.classify( $classifier ), $classified1,
          "basic classify from list with {$classifier.^name}";
        is-deeply classify( $classifier, @list ), $classified1,
          "basic classify as subroutine with {$classifier.^name}";

        classify( $classifier, @list, :into(my %h) );
        is-deeply %h, $classified1,
          "basic classify as sub with {$classifier.^name} and new into";
        classify( $classifier, @list, :into(%h) );
        is-deeply %h, $classified2,
          "basic classify as sub with {$classifier.^name} and existing into";

        @list.classify( $classifier, :into(my %i) );
        is-deeply %i, $classified1,
          "basic classify from list with {$classifier.^name} and new into";
        @list.classify( $classifier, :into(%i) );
        is-deeply %i, $classified2,
          "basic classify from list with {$classifier.^name} and existing into";
    }
    
    {
        classify( &subber, @list, :into(my %b := BagHash.new) );
        is %b<even>, 2, "basic classify as sub with Sub and new into Bag 1) two evens";
        is %b<odd>, 2, "    2) two odds";
        is +%b.keys, 2, "    3) no other keys";
    }
} #4*6

#?rakudo skip 'Cannot use bind operator with this LHS RT #124751'
#?niecza skip 'Cannot use bind operator with this LHS'
{ 
    my @list = (1, 2, 3, 4);
    my (@even,@odd);
    lives-ok { (:@even, :@odd) := classify { $_ % 2 ?? 'odd' !! 'even' }, 1,2,3,4}, 'Can bind result list of classify';
    is-deeply(@even, [2,4], "got expected evens");
    is-deeply(@odd,  [1,3], "got expected odds");
} #3

{
    my $result = { 5 => [1], 10 => [2], 15 => [3], 20 => [4] };
    is-deeply classify( { $_ * 5 }, 1, 2, 3, 4 ), $result,
      'can classify by numbers';
    classify( { $_ * 5 }, 1, 2, 3, 4, :into(my %by_five) );
    is-deeply %by_five, $result,
      'can classify by numbers into an existing empty hash';
    classify( { $_ * 5 }, 1, 2, 3, 4, :into(%by_five) );
    $_[1] = $_[0] for $result.values;
    is-deeply %by_five, $result,
      'can classify by numbers into an existing filled hash';
    classify( { $_ * 5 }, 1, 2, 3, 4, :into(%by_five), :as(* * 2) );
    $_[2] = 2 * $_[1] for $result.values;
    is-deeply %by_five, $result,
      'can classify by numbers into an existing filled hash with an :as';
} #4

# .classify should work on non-arrays
{
    is-deeply 42.classify(  {$_} ), { 42 => [42] }, "classify single num";
    is-deeply "A".classify( {$_} ), { A => ["A"] }, "classify single string";
} #2

#?niecza todo 'feature'
{
    is-deeply( classify( {.comb}, 100 .. 119, 104, 119 ),
      ("1" => {
        "0" => {
          "0" => [100],
          "1" => [101],
          "2" => [102],
          "3" => [103],
          "4" => [104,104],
          "5" => [105],
          "6" => [106],
          "7" => [107],
          "8" => [108],
          "9" => [109],
        },
        "1" => {
          "0" => [110],
          "1" => [111],
          "2" => [112],
          "3" => [113],
          "4" => [114],
          "5" => [115],
          "6" => [116],
          "7" => [117],
          "8" => [118],
          "9" => [119,119],
        }
      }).hash, 'multi-level classify' );
}

is classify( { "foo" }, () ).elems, 0, 'classify an empty list';

#?rakudo todo "Not sure how this should be fixed"
lives-ok { my %b := BagHash.new(); %b.classify-list( {.comb}, 20..40 ); }, "Baggy classify-list shouldn't die on this case";

# vim: ft=perl6
