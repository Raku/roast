use v6;
use Test;

# L<S06/Optional parameters/>

plan 13;

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
eval_dies_ok 'sub wrong ($a?, $b)', 'options params before required ones are forbidden';

sub foo_53814($w, $x?, :$y = 2){ $w~"|"~$x~"|"~$y };
#?rakudo todo 'RT #53814'
{
isnt foo_53814(1,undef,'something_extra',:y(3)), '1||something_extra',
      'should not pass positional param to named';
dies_ok {foo_53814(1,undef,'something_extra',:y(3))},
      'according to ticket - answer should be no matching signature';
}
# vim: ft=perl6
