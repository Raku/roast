use v6;
use Test;

# L<S32::Containers/"List"/"=item classify">

plan 40;

{
    my @list = 1, 2, 3, 4;
    my %classified1{Any} = even => [2,4],     odd => [1,3];
    my %classified2{Any} = even => [2,4,2,4], odd => [1,3,1,3];
    my sub subber ($a) { $a % 2 ?? 'odd' !! 'even' };
    my $blocker = { $_ % 2 ?? 'odd' !! 'even' };
    my $hasher  = { 1 => 'odd', 2 => 'even', 3 => 'odd', 4 => 'even' };
    my $arrayer = <huh odd even odd even>.list;

    for &subber, $blocker, $hasher, $arrayer -> $classifier {
        is-deeply @list.classify( $classifier ), %classified1,
          "basic classify from list with {$classifier.^name}";
        is-deeply classify( $classifier, @list ), %classified1,
          "basic classify as subroutine with {$classifier.^name}";

        classify( $classifier, @list, :into(my %h{Any}) );
        is-deeply %h, %classified1,
          "basic classify as sub with {$classifier.^name} and new into";
        classify( $classifier, @list, :into(%h) );
        is-deeply %h, %classified2,
          "basic classify as sub with {$classifier.^name} and existing into";

        @list.classify( $classifier, :into(my %i{Any}) );
        is-deeply %i, %classified1,
          "basic classify from list with {$classifier.^name} and new into";
        @list.classify( $classifier, :into(%i) );
        is-deeply %i, %classified2,
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
{
    my @list = (1, 2, 3, 4);
    my (@even,@odd);
    lives-ok { (:@even, :@odd) := classify { $_ % 2 ?? 'odd' !! 'even' }, 1,2,3,4}, 'Can bind result list of classify';
    is-deeply(@even, [2,4], "got expected evens");
    is-deeply(@odd,  [1,3], "got expected odds");
} #3

{
    my %result{Any} = 5 => [1], 10 => [2], 15 => [3], 20 => [4];
    is-deeply classify( { $_ * 5 }, 1, 2, 3, 4 ), %result,
      'can classify by numbers';
    classify( { $_ * 5 }, 1, 2, 3, 4, :into(my %by_five{Any}) );
    is-deeply %by_five, %result,
      'can classify by numbers into an existing empty hash';
    classify( { $_ * 5 }, 1, 2, 3, 4, :into(%by_five) );
    $_[1] = $_[0] for %result.values;
    is-deeply %by_five, %result,
      'can classify by numbers into an existing filled hash';
    classify( { $_ * 5 }, 1, 2, 3, 4, :into(%by_five), :as(* * 2) );
    $_[2] = 2 * $_[1] for %result.values;
    is-deeply %by_five, %result,
      'can classify by numbers into an existing filled hash with an :as';
} #4

# .classify should work on non-arrays
{
    is-deeply 42.classify(  {$_} ), (my %{Any} = 42 => [42]), "classify single num";
    is-deeply "A".classify( {$_} ), (my %{Any} = A => ["A"]), "classify single string";
} #2

{
    is-deeply( classify( {.comb}, flat 100 .. 119, 104, 119 ),
      (my %{Any} =
        "1" => (my %{Any} =
          "0" => (my %{Any} =
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
          ),
          "1" => (my %{Any} =
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
          )
        )
      ), 'multi-level classify' );
}

is classify( { "foo" }, () ).elems, 0, 'classify an empty list';

# RT #126032
{
    is-deeply
        <a b c>.classify({ ~($ ~= $_); }),
        (my %{Any} = 'a' => ['a'], 'ab' => ['b'], 'abc' => ['c']),
        '&test only run once for each item';
}

# RT #127803
subtest 'classify works with Junctions' => {
    plan 4;
    # Since we're returning a Junction from the mapper, it'll thread, sticking
    # the values multiple times under the keys. Due to possible
    # short-curcuiting of the Junctions, the number of inserted values may
    # differ depending on the implementation, so we'll only test which values
    # are present and absent under each key
    my @l := <abc abcdef xyz>;
    my $m := @l.classify: *.contains: any 'a'..'f';
    my $s :=    classify  *.contains( any 'a'..'f'), @l;
    for 'method', $m,  'sub', $s -> $form, $v {
        cmp-ok $v.{True }, '~~', {$_ ∋ all 'abc', 'abcdef', none 'xyz'   },
            "$form form (True  key)";
        cmp-ok $v.{False}, '~~', {$_ ∋ all 'abc', 'xyz',    none 'abcdef'},
            "$form form (False key)";
    }
}

# vim: ft=perl6
