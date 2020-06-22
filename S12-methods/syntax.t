use v6;
use Test;

plan 15;

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
#?rakudo 3 skip 'switch-from-paren-to-listop form'
is (.doit(1): 2, 3),    'a:1|b:2!3',    'list op with colon';
is (.doit(1, 2): 3),    'a:1|b:2!3',    'list op with colon';
is (.doit\  (1, 2): 3), 'a:1|b:2!3',    'list op with colon, unspace';

# L<S12/Fancy method calls/"if any term in a list is a bare closure">
is (1..8).grep({ $_ % 2 }).map({ $_ - 1 }).join('|'), '0|2|4|6',
   'sanity check, should give same result as the next two tests';
# https://github.com/Raku/old-issue-tracker/issues/1148
{
    is ((1..8).map:{ "$^x$^y" }.assuming: 'x').join('|'), 'x1|x2|x3|x4|x5|x6|x7|x8',
       'block as arg in methodcall is the invocant of a following methodcall';
    is ((1..8).map: { "$^x$^y" }.assuming: 'x').join('|'), 'x1|x2|x3|x4|x5|x6|x7|x8',
       'block as arg in methodcall is the invocant of a following methodcall';
}

# https://github.com/Raku/old-issue-tracker/issues/580
# Used to be Rakudo RT #61988, $.foo form didn't accept arguments

{
    class B {
        method a ($a, $b) { $a + $b }
        method b { $.a(2, 3) }
        # GH rakudo/rakudo#3306
        method c { $.a: 40,2 }
    }

    is B.new.b, 5, '`$.a(<arguments>)` works';
    is B.new.c, 42, '`$.a: <arguments>` works';
}

# https://github.com/Raku/old-issue-tracker/issues/1316
# test that you can't manipulate methods by writinig to the symbol table
{
    class Manip { method a { 1} };
    &Manip::a = anon method ($:) { 2 };
    is Manip.new.a, 1, 'Writing to a symbol table does not alter methods';
}


# vim: expandtab shiftwidth=4
