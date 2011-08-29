use v6;
use Test;

# L<S32::Containers/"List"/"=item categorize">

plan 4;

{
    # Subroutine form, code block mapper
    my %got = categorize { $_ - ($_ % 10) }, 29, 7, 12, 9, 18, 23, 3, 7;
    my %expected = ('0'=>[7, 9, 3, 7], '10'=>[12, 18], '20'=>[29, 23]);
    is_deeply(%got, %expected, 'sub with code block mapper');  # test 1
}

{
    # Subroutine form, named sub mapper
    sub suit($card) { $card.comb.pop }
    my %got = categorize &suit, <A♣ 10♣ 6♥ 3♦ A♠ 3♣ K♠ J♥ 6♦ Q♠ K♥ 8♦ 5♠>;
    my %expected = ('♠' => ['A♠', 'K♠', 'Q♠', '5♠'],
                    '♣' => ['A♣', '10♣', '3♣'],
                    '♥' => ['6♥', 'J♥', 'K♥'],
                    '♦' => ['3♦', '6♦', '8♦']);
    is_deeply(%got, %expected, 'sub with named sub mapper');  # test 2
}

{
    # Method form, code block mapper
    my %got = (1...6).categorize: {
        my @categories = ( $_ % 2 ?? 'odd' !! 'even');
        unless $_ % 3 { push @categories, 'triple'}
        @categories;
    };
    my %expected = ('odd'=>[1,3,5], 'even'=>[2,4,6], 'triple'=>[3,6]);
    is_deeply(%got, %expected, 'method with code block mapper');  # test 3
}

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
    is_deeply(%got, %expected, 'method with named sub mapper');  # test 4
}

# vim: ft=perl6
