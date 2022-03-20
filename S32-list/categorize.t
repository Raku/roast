use v6.c;
use Test;

# L<S32::Containers/"List"/"=item categorize">

plan 28;

{ # basic categorize with all possible mappers
    my @list      = 29, 7, 12, 9, 18, 23, 3, 7;
    my %expected1{Mu} =
      (0=>[7,9,3,7],         10=>[12,18],       20=>[29,23]);
    my %expected2{Mu} =
      (0=>[7,9,3,7,7,9,3,7], 10=>[12,18,12,18], 20=>[29,23,29,23]);
    my sub subber ($a) { $a - ($a % 10) };
    my $blocker = { $_ - ($_ % 10) };
    my $hasher  = { 3=>0, 7=>0, 9=>0, 12=>10, 18=>10, 23=>20, 29=>20 };
    my $arrayer = [ flat 0 xx 10, 10 xx 10, 20 xx 10 ];

    for &subber, $blocker, $hasher, $arrayer -> $mapper {
        is-deeply categorize( $mapper, @list ), %expected1,
          "simple sub call with {$mapper.^name}";
        is-deeply @list.categorize( $mapper ), %expected1,
          "method call on list with {$mapper.^name}";

        categorize( $mapper, @list, :into(my %h{Mu}) );
        is-deeply %h, %expected1,
          "basic categorize as sub with {$mapper.^name} and new into";
        categorize( $mapper, @list, :into(%h) );
        is-deeply %h, %expected2,
          "basic categorize as sub with {$mapper.^name} and existing into";

        @list.categorize( $mapper, :into(my %i{Mu}) );
        is-deeply %i, %expected1,
          "basic categorize from list with {$mapper.^name} and new into";
        @list.categorize( $mapper, :into(%i) );
        is-deeply %i, %expected2,
          "basic categorize from list with {$mapper.^name} and existing into";
    }
} #4*6

{ # basic categorize
    sub mapper { $^a.comb };
    my %got = categorize &mapper, <A♣ 10♣ 6♥ 3♦ A♠ 3♣ K♠ J♥ 6♦ Q♠ K♥ 8♦ 5♠>;
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
    is-deeply(%got, %expected, 'sub with named sub mapper');
} #1

{
    # Method form, code block mapper, using :as
    my %got = (1...6).categorize: {
        my @categories = ($_ % 2) ?? 'odd' !! 'even';
        unless $_ % 3 { push @categories, 'triple'}
        @categories;
    }, :as(* * 10);
    my %expected = ('odd'=>[10,30,50], 'even'=>[20,40,60], 'triple'=>[30,60]);
    is-deeply(%got, %expected, 'method with code block mapper using :as');
} #1

{
    # Method form, named sub mapper
    sub charmapper($c) {
        gather {
            take 'perlish' if $c.lc ~~ /<[perl]>/;
            take 'vowel'   if $c.lc eq any <a e i o u>;
            take ($c ~~ .uc) ?? 'uppercase' !! 'lowercase';
        }
    }
    my %got      = 'Padre'.comb.categorize(&charmapper);
    my %expected = ( 'perlish'   => [< P     r e >],
                     'vowel'     => [<   a     e >],
                     'uppercase' => [< P         >],
                     'lowercase' => [<   a d r e >] );
    is-deeply(%got, %expected, 'method with named sub mapper using gather');
}

#?niecza todo 'feature'
{
    is-deeply( categorize( { map { [$_+0, $_+10] }, .comb }, 100,104,112,119 ),
      (my %{Mu} =
        1 => ( my %{Mu} = 11 => [100, 104, 112, 112, 119, 119] ),
        0 => ( my %{Mu} = 10 => [100, 100, 104] ),
        4 => ( my %{Mu} = 14 => [104] ),
        2 => ( my %{Mu} = 12 => [112] ),
        9 => ( my %{Mu} = 19 => [119] ),
      ), 'multi-level categorize' );
}

# vim: ft=perl6
