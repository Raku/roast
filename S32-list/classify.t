use v6;
use Test;

# L<S32::Containers/"List"/"=item classify">

plan 46;

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

        my %hash;
        is_deeply %hash.classify( $classifier, @list ), $classified1,
          "basic classify from hash with {$classifier.^name}";
        is_deeply %hash, $classified1,
          "basic classify in hash with {$classifier.^name}";
        is_deeply %hash.classify( $classifier, @list ), $classified2,
          "additional classify from hash with {$classifier.^name}";
        is_deeply %hash, $classified2,
          "additional classify in hash with {$classifier.^name}";

#?niecza skip '%thash{Str} NYI'
{
        my List %thash{Str};
        is_deeply %thash.classify( $classifier, @list ), $classified1,
          "basic classify from typed hash with {$classifier.^name}";
        is_deeply %thash, $classified1,
          "basic classify in typed hash with {$classifier.^name}";
        is_deeply %thash.classify( $classifier, @list ), $classified2,
          "additional classify typed from hash with {$classifier.^name}";
        is_deeply %thash, $classified2,
          "additional classify in typed hash with {$classifier.^name}";
}
    }
} #4*10

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

# vim: ft=perl6
