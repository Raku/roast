use v6;
use Test;

plan 12;

# L<S12/Fancy method calls/"no space between the method name and the left parenthesis">

class A {
    multi method doit () { 'empty' };
    multi method doit ($a, $b, *@rest) {
        "a:$a|b:{$b}!" ~ @rest.join('!');
    }
}

$_ = A.new();

is .doit,       'empty',        'plain call with no args';
is .doit(),     'empty',        'method call with parens and no args';
eval_dies_ok '.doit ()',        '.doit () illegal';
is .doit\ (),   'empty',        'method call with unspace';

is (.doit: 1, 2, 3),    'a:1|b:2!3',    'list op with colon';
is (.doit: 1, 2, 3, 4), 'a:1|b:2!3!4',  'list op with colon, slurpy';
#?rakudo 3 skip 'switch-from-paren-to-listop form'
is (.doit(1): 2, 3),    'a:1|b:2!3',    'list op with colon';
is (.doit(1, 2): 3),    'a:1|b:2!3',    'list op with colon';
is (.doit\  (1, 2): 3), 'a:1|b:2!3',    'list op with colon, unspace';

# L<S12/Fancy method calls/"if any term in a list is a bare closure">
#?rakudo skip 'adverbial closures'
is (1..8).grep: { $_ % 2 }.map: { $_ - 1}.join('|'), '0|2|4|6', 
   'adverbial closure has right precedence and associativity';

# Used to be Rakudo RT #61988, $.foo form didn't accept arguments

class B {
    method a ($a, $b) { $a + $b }
    method b { $.a(2, 3) }
}

is B.new.b, 5, '$.a can accept arguments';

# RT #69350
# test that you can't manipulate methods by writinig to the symbol table
{
    class Manip { method a { 1} };
    &Manip::a = sub ($:) { 2 };
    is Manip.new.a, 1, 'Writing to a symbol table does not alter methods';
}


# vim: ft=perl6
