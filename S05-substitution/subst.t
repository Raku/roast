use v6;

use Test;

plan 30;

# L<S05/Substitution/>

my $str = 'hello';

is $str.subst(/h/,'f'),       'fello', 'We can use subst';
is $str,                      'hello', '.. withouth side effect';
#?rakudo skip "multiple adverbs not implemented"
is $str.subst(rx:g:i/L/,'p'), 'heppo', '.. with multiple adverbs';

is $str.subst('h','f'),       'fello', '.. or using Str as pattern';
is $str.subst('.','f'),       'hello', '.. with literal string matching';

my $i=0;
is $str.subst(/l/,{$i++}),    'he0lo', 'We can have a closure as replacement';
#?rakudo skip "multiple adverbs not implemented"
is $str.subst(rx:g/l/,{$i++}),'he12o', '.. which act like closure and can be called more then once';
is $str.=subst(/l/,'i'),      'heilo', '.. and with the .= modifier';
is $str,                      'heilo', '.. it changes the receiver';

# not sure about this. Maybe '$1$0' should work.

#?rakudo 3 skip '$/ not involved in .subst yet (unspecced?)'
is 'a'.subst(/(.)/,"$1$0"), '',       '.. and it can not access captures from strings';
is 'a'.subst(/(.)/,{$0~$0}),'aa',     '.. you must wrap it in a closure';
is '12'.subst(/(.)(.)/,{$()*2}),'24', '.. and do nifty things in closures'; 

{
    is 'a b c d'.subst(/\w/, 'x', :g),      'x x x x', '.subst and :g';
    is 'a b c d'.subst(/\w/, 'x', :x(0)),   'a b c d', '.subst and :x(0)';
    is 'a b c d'.subst(/\w/, 'x', :x(1)),   'x b c d', '.subst and :x(1)';
    is 'a b c d'.subst(/\w/, 'x', :x(2)),   'x x c d', '.subst and :x(2)';
    is 'a b c d'.subst(/\w/, 'x', :x(3)),   'x x x d', '.subst and :x(3)';
    is 'a b c d'.subst(/\w/, 'x', :x(4)),   'x x x x', '.subst and :x(4)';
    #?rakudo skip ':x(*) in .subst'
    is 'a b c d'.subst(/\w/, 'x', :x(*)),   'x x x x', '.subst and :x(*)';
}

{
    is 'a b c d'.subst(/\w/, 'x', :nth(1)), 'x b c d', '.subst and :nth(1)';
    is 'a b c d'.subst(/\w/, 'x', :nth(2)), 'a x c d', '.subst and :nth(2)';
    is 'a b c d'.subst(/\w/, 'x', :nth(3)), 'a b x d', '.subst and :nth(3)';
    is 'a b c d'.subst(/\w/, 'x', :nth(4)), 'a b c x', '.subst and :nth(4)';
    is 'a b c d'.subst(/\w/, 'x', :nth(5)), 'a b c d', '.subst and :nth(5)';
}

{
    # combining :g and :nth:
    #?rakudo 2 todo 'RT #61130'
    is 'a b c d'.subst(/\w/, 'x', :nth(1), :g), 'x x x x', '.subst and :g, :nth(1)';
    is 'a b c d'.subst(/\w/, 'x', :nth(2), :g), 'a x c x', '.subst and :g, :nth(2)';
    is 'a b c d'.subst(/\w/, 'x', :nth(3), :g), 'a b x d', '.subst and :g, :nth(3)';
}

#?rakudo todo 'RT #61130'
{
    # combining :nth with :x
    is 'a b c d e f g h'.subst(/\w/, 'x', :nth(1), :x(3)), 
       'x x x d e f g h',
       '.subst with :nth(1) and :x(3)';

    is 'a b c d e f g h'.subst(/\w/, 'x', :nth(2), :x(2)), 
       'a x c x e f g h',
       '.subst with :nth(2) and :x(2)';

    is 'a b c d e f g h'.subst(/\w/, 'x', :nth(2), :x(3)), 
       'a x c x e x g h',
       '.subst with :nth(2) and :x(2)';
}
