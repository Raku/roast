use v6;
use Test;

plan 16;

#L<S06/Operator overloading>

# Define operator, check it works.
sub infix:<wtf>($a, $b) { $a ~ "WTF" ~ $b };
is 'OMG' wtf 'BBQ', 'OMGWTFBBQ', 'basic sanity';

# Assignment meta-op.
my $a = 'OMG';
$a wtf= 'BBQ';
is $a, 'OMGWTFBBQ', 'assignment meta-op';

# Reduce meta-op.
is ([wtf] <OMG BBQ PONIES>), 'OMGWTFBBQWTFPONIES', 'reduce meta-op generated';

# Reverse meta-op.
is 'BBQ' Rwtf 'OMG', 'OMGWTFBBQ', 'reverse meta-op generated';

# Cross meta-op.
is ~('OMG','BBQ' Xwtf 'OMG','BBQ'), 'OMGWTFOMG OMGWTFBBQ BBQWTFOMG BBQWTFBBQ',
    'cross meta-op generated';

# Hyper meta-op (todo: unicode variants, check variants apply correct constraints)
is ~(('OMG','BBQ') >>wtf<< ('BBQ','OMG')), 'OMGWTFBBQ BBQWTFOMG', '>>...<< hyper generated';
is ~(('OMG','BBQ') <<wtf<< ('BBQ','OMG')), 'OMGWTFBBQ BBQWTFOMG', '<<...<< hyper generated';
is ~(('OMG','BBQ') >>wtf>> ('BBQ','OMG')), 'OMGWTFBBQ BBQWTFOMG', '>>...>> hyper generated';
is ~(('OMG','BBQ') <<wtf>> ('BBQ','OMG')), 'OMGWTFBBQ BBQWTFOMG', '<<...>> hyper generated';

# https://github.com/Raku/old-issue-tracker/issues/3370
{
    sub foo { $^a ~ $^b };
    is ([[&foo]] <a b c d e>), 'abcde', "can we use a sub as an reduce op between [[]]";
}

# https://github.com/Raku/old-issue-tracker/issues/3446
{
    sub foo ($a, $b) { $a * $b };
    is (2 [&foo] 3 [&foo] 4), 24, "can we use a sub as an infix op between []";
}

# https://github.com/Raku/old-issue-tracker/issues/6152
{
    is([+](^20 .grep: *.is-prime), 77, "can we use &infix:<.> as argument for []");
}

# https://github.com/Raku/old-issue-tracker/issues/6022
is ([\,] <a b>, <c d>, <e f>)».join('|').join('-'), "a b-a b|c d-a b|c d|e f",
    "Triangular reduce with &infix:<,> and a list of lists doesn't flatten";

# https://github.com/rakudo/rakudo/issues/2718
{
    my $a;
    $a<a b c> »=» 42;
    is( $a{$_}, 42, "is key $_ 42?" ) for <a b c>;
}

# vim: expandtab shiftwidth=4
