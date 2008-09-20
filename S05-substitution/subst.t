use v6;

use Test;

plan 12;

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
#?rakudo skip "rakudo doesn't like dotty methods [perl #57740]"
is $str.=subst(/l/,'i'),      'heilo', '.. and with the .= modifier';
#?rakudo todo "(test dependency)"
is $str,                      'heilo', '.. it changes the receiver';

# not sure about this. Maybe '$1$0' should work.

#?rakudo 3 skip '$/ not involved in .subst yet (unspecced?)'
is 'a'.subst(/(.)/,"$1$0"), '',       '.. and it can not access captures from strings';
is 'a'.subst(/(.)/,{$0~$0}),'aa',     '.. you must wrap it in a closure';
is '12'.subst(/(.)(.)/,{$()*2}),'24', '.. and do nifty things in closures'; 


