use v6;
use Test;

# L<S32::Containers/"List"/"=item categorize">

plan 48;

{ # basic classify with all possible mappers
    my @list      = 29, 7, 12, 9, 18, 23, 3, 7;
    my %expected1 =
      ('0'=>[7,9,3,7],         '10'=>[12,18],       '20'=>[29,23]);
    my %expected2 =
      ('0'=>[7,9,3,7,7,9,3,7], '10'=>[12,18,12,18], '20'=>[29,23,29,23]);
    my sub subber ($a) { $a - ($a % 10) };
    my $blocker = { $_ - ($_ % 10) };
    my $hasher  = { 3=>0, 7=>0, 9=>0, 12=>10, 18=>10, 23=>20, 29=>20 };
    my $arrayer = [ 0 xx 10, 10 xx 10, 20 xx 10 ];

    for &subber, $blocker, $hasher, $arrayer -> $mapper {
        is_deeply categorize( $mapper, @list ), %expected1,
          "simple sub call with {$mapper.^name}";
        is_deeply @list.categorize( $mapper ), %expected1,
          "method call on list with {$mapper.^name}";
        is_deeply {}.categorize( $mapper, @list ), %expected1,
          "method call on hash with {$mapper.^name}";

        my %hash;
        is_deeply %hash.categorize( $mapper, @list ), %expected1,
          "first method call on hash with {$mapper.^name}";
        is_deeply %hash, %expected1,
          "checking whether first hash is set with {$mapper.^name}";
        is_deeply %hash.categorize( $mapper, @list ), %expected2,
          "second method call on hash with {$mapper.^name}";
        is_deeply %hash, %expected2,
          "checking whether second hash is set with {$mapper.^name}";

#?niecza skip '%thash{Int} NYI'
{
        my List %thash{Int};
        is_deeply %thash.categorize( $mapper, @list ), %expected1,
          "first method call on hash with {$mapper.^name}";
        is_deeply %thash, %expected1,
          "checking whether first hash is set with {$mapper.^name}";
        is_deeply %thash.categorize( $mapper, @list ), %expected2,
          "second method call on hash with {$mapper.^name}";
        is_deeply %thash, %expected2,
          "checking whether second hash is set with {$mapper.^name}";
}
    }
} #4*11

{ # basic categorize
    my %got = categorize { .comb }, <A♣ 10♣ 6♥ 3♦ A♠ 3♣ K♠ J♥ 6♦ Q♠ K♥ 8♦ 5♠>;
    my %expected = (
      'A' => ['A♣', 'A♠'],
      '♣' => ['A♣', '10♣', '3♣'],
      '1' => ['10♣'],
      '0' => ['10♣'],
      '6' => ['6♥', '6♦'],
      '♥' => ['6♥', 'J♥', 'K♥'],
      '3' => ['3♦', '3♣'],
      '♦' => ['3♦', '6♦', '8♦'],
      '♠' => ['A♠', 'K♠', 'Q♠', '5♠'],
      'K' => ['K♠', 'K♥'],
      'J' => ['J♥'],
      'Q' => ['Q♠'],
      '8' => ['8♦'],
      '5' => ['5♠'],
    );
    is_deeply(%got, %expected, 'sub with named sub mapper');
} #1

{
    # Method form, code block mapper
    my %got = (1...6).categorize: {
        my @categories = ( $_ % 2 ?? 'odd' !! 'even');
        unless $_ % 3 { push @categories, 'triple'}
        @categories;
    };
    my %expected = ('odd'=>[1,3,5], 'even'=>[2,4,6], 'triple'=>[3,6]);
    is_deeply(%got, %expected, 'method with code block mapper');
} #1

{
    # Method form, named sub mapper
    sub charmapper($c) {
        my @categories;
        push @categories, 'perlish' if $c.lc ~~ /<[perl]>/;
        push @categories, 'vowel'   if $c.lc eq any <a e i o u>;
        push @categories, ($c ~~ .uc) ?? 'uppercase' !! 'lowercase';
        @categories;
    }
    my %got      = 'Padre'.comb.categorize(&charmapper);
    my %expected = ( 'perlish'   => ['P', 'r', 'e'],
                     'vowel'     => ['a', 'e'],
                     'uppercase' => ['P'],
                     'lowercase' => ['a', 'd', 'r', 'e'] );
    is_deeply(%got, %expected, 'method with named sub mapper');
}

#?pugs   todo 'feature'
#?niecza todo 'feature'
{
    is_deeply( categorize( { map { [$_, $_+10] }, .comb }, 100,104,112,119 ),
      ("1" => { "11" => [100, 104, 112, 112, 119, 119] },
       "0" => { "10" => [100, 100, 104] },
       "4" => { "14" => [104] },
       "2" => { "12" => [112] },
       "9" => { "19" => [119] },
      ).hash, 'multi-level categorize' );
}

# vim: ft=perl6
