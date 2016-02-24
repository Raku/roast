use v6.c;
use Test;

plan 25;

{
    sub simple { 'simple' }
    my @params = &simple.signature.params;
    is +@params, 0, 'no parameters to check';
} #1

{
    sub positional { @_[0] }
    my @params = &positional.signature.params;
    is +@params, 1, 'one autogenerated positional slurpy';
    # RT #125486
    ok @params[0].multi-invocant, 'is autogenned positional a multi-invocant';
} #2

{
    sub named { %_<bravo> }
    my @params = &named.signature.params;
    is +@params, 1, 'one autogenerated named slurpy';
    ok @params[0].multi-invocant, 'is autogenned named a multi-invocant';
} #2

{
    sub both { @_[1] ~ %_<delta> }
    my @params = &both.signature.params;
    is +@params, 2, 'autogenerated positional and named slurpy';
    ok @params[0].multi-invocant, 'is autogenned positional a multi-invocant';
    ok @params[1].multi-invocant, 'is autogenned named a multi-invocant';
} #3

{
    sub curried { $^a }
    my @params = &curried.signature.params;
    is +@params, 1, 'one curried positional';
    ok @params[0].multi-invocant, 'is curried positional a multi-invocant';
} #2

{
    sub curried2 { $^a, $^b }
    my @params = &curried2.signature.params;
    is +@params, 2, 'two curried positionals';
    ok @params[0].multi-invocant, 'first curried positional a multi-invocant';
    ok @params[1].multi-invocant, 'second curried positional a multi-invocant';
} #3

{
    sub positional($a) { }
    my @params = &positional.signature.params;
    is +@params, 1, 'one positional';
    ok @params[0].multi-invocant, 'is positional a multi-invocant';
} #2

{
    sub mixed($a,$b,:$c) { }
    my @params = &mixed.signature.params;
    is +@params, 3, 'two positionals, one named';
    ok @params[0].multi-invocant, 'first positional a multi-invocant';
    ok @params[1].multi-invocant, 'second positional a multi-invocant';
    ok @params[2].multi-invocant, 'first named a multi-invocant';
} #4

{
    sub none(;; $a) { }
    my @params = &none.signature.params;
    is +@params, 1, 'one non-multi positional';
    # RT #125502
    nok @params[0].multi-invocant, 'is positional *not* a multi-invocant';
} #2

{
    sub exclude($a;; $b, :$c) { }
    my @params = &exclude.signature.params;
    is +@params, 3, 'one positional multi, one positional and one named not';
    ok @params[0].multi-invocant, 'first positional a multi-invocant';
    nok @params[1].multi-invocant, 'second positional *not* a multi-invocant';
    nok @params[2].multi-invocant, 'first named *not* a multi-invocant';
} #4


# vim: ft=perl6
