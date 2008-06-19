use v6;
use Test;
plan 6;

#L<S05/New metacharacters/"As with the disjunctions | and ||">

{
    my $str = 'x' x 7;

    ok $str ~~ m/x||xx||xxxx/;
    is ~$/,  'x',  'first || alternative matches';
    ok $str ~~ m/xx||x||xxxx/;
    is ~$/,  'xx', 'first || alternative matches';
}

{
    my $str = 'x' x 3;
    ok $str ~~ m/xxxx||xx||x/;
    is ~$/, 'xx', 'second alternative || matches if first fails';
}
