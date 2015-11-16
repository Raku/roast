use v6;
use Test;

plan 14;

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
throws-like '.doit ()', X::Syntax::Confused, '.doit () illegal';
is .doit\ (),   'empty',        'method call with unspace';

is (.doit: 1, 2, 3),    'a:1|b:2!3',    'list op with colon';
is (.doit: 1, 2, 3, 4), 'a:1|b:2!3!4',  'list op with colon, slurpy';
#?rakudo 3 skip 'switch-from-paren-to-listop form RT #124852'
#?niecza 3 skip 'Interaction between semiargs and args is not understood'
is (.doit(1): 2, 3),    'a:1|b:2!3',    'list op with colon';
is (.doit(1, 2): 3),    'a:1|b:2!3',    'list op with colon';
is (.doit\  (1, 2): 3), 'a:1|b:2!3',    'list op with colon, unspace';

# L<S12/Fancy method calls/"if any term in a list is a bare closure">
is (1..8).grep({ $_ % 2 }).map({ $_ - 1 }).join('|'), '0|2|4|6',
   'sanity check, should give same result as the next two tests';
#?niecza skip 'Excess arguments to Any.map, used 2 of 4 positionals'
# RT #67700
{
    is ((1..8).map:{ "$^x$^y" }.assuming: 'x').join('|'), 'x1|x2|x3|x4|x5|x6|x7|x8',
       'block as arg in methodcall is the invocant of a following methodcall';
    is ((1..8).map: { "$^x$^y" }.assuming: 'x').join('|'), 'x1|x2|x3|x4|x5|x6|x7|x8',
       'block as arg in methodcall is the invocant of a following methodcall';
}

# Used to be Rakudo RT #61988, $.foo form didn't accept arguments

{
    class B {
        method a ($a, $b) { $a + $b }
        method b { $.a(2, 3) }
    }

    is B.new.b, 5, '$.a can accept arguments';
}

# RT #69350
# test that you can't manipulate methods by writinig to the symbol table
{
    class Manip { method a { 1} };
    &Manip::a = anon method ($:) { 2 };
    is Manip.new.a, 1, 'Writing to a symbol table does not alter methods';
}


# vim: ft=perl6
