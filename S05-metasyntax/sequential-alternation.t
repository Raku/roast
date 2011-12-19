use v6;
use Test;
plan 10;

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

#L<S05/"Variable (non-)interpolation"/"An interpolated array:">

#?rakudo todo 'sequential alternation NYI'
{
    my $str = 'x' x 7;
    my @list = <x xx xxxx>;

    ok $str ~~ m/ ||@list /;
    #?niecza todo
    is ~$/,  'x',  'first ||@list alternative matches';

    @list = <xx x xxxx>;

    ok $str ~~ m/ ||@list /;
    #?niecza todo
    is ~$/,  'xx', 'first ||@list alternative matches';
}

# vim: ft=perl6
