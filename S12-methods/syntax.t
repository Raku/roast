use v6;
use Test;

plan 13;

# L<S12/Methods/"no space between the method name and the left parenthesis">

class A {
    multi method doit () { 'empty' };
    multi method doit ($a, $b, *@rest) {
        "a:$a|b:$b!" ~ @rest.join('!');
    }
}

$_ = A.new();

is .doit,       'empty',        'plain call with no args';
is .doit(),     'empty',        'method call with parens and no args';
is .doit.(),    'empty',        'method call with dot-parens and no args';
eval_dies_ok '.doit ()',        '.doit () illegal';
is .doit\ (),   'empty',        'method call with unspace';
is .doit\ .(),  'empty',        'method call with dotty unspace';

is (.doit: 1, 2, 3),    'a:1|b:2!3',    'list op with colon';
is (.doit: 1, 2, 3, 4), 'a:1|b:2!3!4',  'list op with colon, slurpy';
#?rakudo 4 skip 'adverbial listop form'
is (.doit(1): 2, 3),    'a:1|b:2!3',    'list op with colon';
is (.doit(1, 2): 3),    'a:1|b:2!3',    'list op with colon';
is (.doit\  (1, 2): 3), 'a:1|b:2!3',    'list op with colon, unspace';
is (.doit\ .(1, 2): 3), 'a:1|b:2!3',    'list op with colon, dotty unspace';

# L<S12/Methods/"if any term in a list is a bare closure">
#?rakudo skip 'adverbial closures'
is (1..8).grep: { $_ % 2 }.map: { $_ - 1}.join('|'), '0|2|4|6', 
   'adverbial closure has right precedence and associativity';

# vim: ft=perl6
