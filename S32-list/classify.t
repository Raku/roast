use v6;
use Test;

# L<S32::Containers/"List"/"=item classify">

plan 15;

{
    my @list = 1, 2, 3, 4;
    my $classified1 = { even => [2,4],     odd => [1,3]     };
    my $classified2 = { even => [2,4,2,4], odd => [1,3,1,3] };
    my sub subber ($a) { $a % 2 ?? 'odd' !! 'even' };
    my $blocker = { $_ % 2 ?? 'odd' !! 'even' };
    my $hasher  = { 1 => 'odd', 2 => 'even', 3 => 'odd', 4 => 'even' };
    my $arrayer = <huh odd even odd even>.list;

    for &subber, $blocker, $hasher, $arrayer -> $classifier {
        is_deeply @list.classify( $classifier ), $classified1,
          "basic classify from list with {$classifier.^name}";
        is_deeply classify( $classifier, @list ), $classified1,
          "basic classify as subroutine with {$classifier.^name}";
    }
} #4*2

#?pugs todo 'feature'
#?rakudo skip 'Cannot use bind operator with this LHS'
#?niecza skip 'Cannot use bind operator with this LHS'
{ 
    my @list = (1, 2, 3, 4);
    my (@even,@odd);
    lives_ok { (:@even, :@odd) := classify { $_ % 2 ?? 'odd' !! 'even' }, 1,2,3,4}, 'Can bind result list of classify';
    is_deeply(@even, [2,4], "got expected evens");
    is_deeply(@odd,  [1,3], "got expected odds");
} #3

#?pugs todo 'feature'
{
    my %by_five;
    is_deeply
      classify( { $_ * 5 }, 1, 2, 3, 4 ),
      { 5 => [1], 10 => [2], 15 => [3], 20 => [4] },
      'can classify by numbers';
} #1

# .classify should work on non-arrays
{
    is_deeply 42.classify(  {$_} ), { 42 => [42] }, "classify single num";
    is_deeply "A".classify( {$_} ), { A => ["A"] }, "classify single string";
} #2

#?pugs   todo 'feature'
#?niecza todo 'feature'
{
    is_deeply( classify( {.comb}, 100 .. 119, 104, 119 ),
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

# vim: ft=perl6
