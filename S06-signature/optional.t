use v6;
use Test;

# L<S06/Optional parameters/>

plan 28;

sub opt1($p?) { defined($p) ?? $p !! 'undef'; }

is opt1('abc'), 'abc',      'Can pass optional param';
is opt1(),      'undef',    'Can leave out optional param';

sub opt2($p?, $q?) {
      (defined($p) ?? $p !! 'undef')
    ~ '|'
    ~ (defined($q) ?? $q !! 'undef');
}

is opt2('a', 'b'), 'a|b',           'Can pass all two optional params';
is opt2('a'),      'a|undef',       'Can pass one of two optional params';
is opt2(),         'undef|undef',   'Can leave out all two optional params';

sub t_opt2(Str $p?, Str $q?) {
      (defined($p) ?? $p !! 'undef')
    ~ '|'
    ~ (defined($q) ?? $q !! 'undef');
}

is t_opt2('a', 'b'), 'a|b',           'Can pass all two optional params';
is t_opt2('a'),      'a|undef',       'Can pass one of two optional params';
is t_opt2(),         'undef|undef',   'Can leave out all two optional params';

sub opt_typed(Int $p?) { defined($p) ?? $p !! 'undef' };

is opt_typed(2), 2,        'can pass optional typed param';
is opt_typed() , 'undef',  'can leave out optional typed param';

# L<S06/Parameters and arguments/"required positional parameters must come
# before those bound to optional positional">
eval_dies_ok 'sub wrong1 ($a?, $b) {...}', 'optional params before required ones are forbidden';
# RT #76022
{
    eval_dies_ok 'sub wrong2 ($a = 1, $b) {...}', "...even if they're only optional by virtue of a default";
    eval_dies_ok 'sub wrong3 ($a = 0, $b) {...}', '...and the default is 0';
}

sub foo_53814($w, $x?, :$y = 2) { $w~"|"~$x~"|"~$y };
dies_ok {foo_53814(1,Mu,'something_extra',:y(3))},
      'die on too many parameters (was once bug RT 53814)';


{

    # old test is bogus, nullterm only allowed at the end of a list
    # is rt54804( 1, , 3, ), '1|undef|3|undef',
    #    'two commas parse as if undef is between them';
    eval_dies_ok q/sub rt54804( $v, $w?, $x?, $y? ) {
        (defined( $v ) ?? $v !! 'undef')
        ~ '|' ~
        (defined( $w ) ?? $w !! 'undef')
        ~ '|' ~
        (defined( $x ) ?? $x !! 'undef')
        ~ '|' ~
        (defined( $y ) ?? $y !! 'undef')
    }
    rt54804( 1, , 3, )/, "two commas in a row doesn't parse";
}

eval_dies_ok( 'sub rt66822($opt?, $req) { "$opt, $req" }',
              "Can't put required parameter after optional parameters" );

# Niecza bug#49
sub opt_array1(@x?) { @x.elems }
sub opt_array2(@x? is copy) { @x.elems }
sub opt_hash1(%x?) { %x.keys.elems }
sub opt_hash2(%x? is copy) { %x.keys.elems }
is opt_array1(), 0, "optional array not passed is empty";
is opt_array2(), 0, "optional array not passed is empty (copy)";
is opt_hash1(),  0, "optional hash not passed is empty";
is opt_hash2(),  0, "optional hash not passed is empty (copy)";

# RT #71110
eval_dies_ok 'sub opt($a = 1, $b) { }',
    'Cannot put required parameter after optional parameters';

# RT #74758
{
    sub opt-type1(Int $x?) { $x };
    ok opt-type1() === Int,
        'optional param with type constraints gets the right value';
    sub opt-type2(Int $x = 'str') { };  #OK not used
    dies_ok { EVAL('opt-type2()') }, 'default values are type-checked';
}

# RT # 76728
{
    sub opt-hash(%h?) {
        %h<a> = 'b';
        %h
    }
    is opt-hash().keys, 'a', 'can assign to optional parameter';

    # RT #79642
    sub opt-hash2(%h?) {
        %h;
    }
    ok opt-hash2() eqv ().hash, 'an optional-but-not-filled hash is just an empty Hash';
}

# RT #77338
{
    lives_ok { sub foo(::T $?) {} },
        'question mark for optional parameter is parsed correctly';
}

# RT #79288
## TODO: implement typed exception and check for that one instead of Exception
{
    throws_like { EVAL q[ sub foo($x? is rw) {} ] }, Exception,
        message => "Cannot use 'is rw' on an optional parameter",
        'making an "is rw" parameter optional dies with adequate error message';

    throws_like { EVAL q[ sub foo($x is rw = 42) {} ] }, Exception,
        message => "Cannot use 'is rw' on an optional parameter",
        'making an "is rw" parameter optional dies with adequate error message';
}

# vim: ft=perl6
