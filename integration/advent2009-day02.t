# http://perl6advent.wordpress.com/2009/12/02/day-2-the-beauty-of-formatting/

use v6;
use Test;
plan 10;

#?niecza skip 'invalid format specifier'
is(42.fmt('%+d'),           '+42'     );
is(42.fmt('%4d'),           '  42'    );
is(42.fmt('%04d'),          '0042'    );
is(:16<1337f00d>.fmt('%X'), '1337F00D');

is(<huey dewey louie>.fmt,    'huey dewey louie');
is(<10 11 12>.fmt('%x'),      'a b c');
is(<1 2 3>.fmt('%02d', '; '), '01; 02; 03');

#?niecza 2 todo "junction match fails"
is {foo => 1, bar => 2}.fmt, "foo\t1\nbar\t2"|"bar\t2\nfoo\t1", 'Hash.fmt';

is { Apples => 5, Oranges => 10 }.fmt('%s cost %d euros'),
    "Apples cost 5 euros\nOranges cost 10 euros"|"Oranges cost 10 euros\nApples cost 5 euros";
is { huey => 1, dewey => 2, louie => 3 }.fmt('%s', ' -- ').split(' -- ').sort.join(' -- '),
    'dewey -- huey -- louie', 'Hash with two-arg fmt';


done;
