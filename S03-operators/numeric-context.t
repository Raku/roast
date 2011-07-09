use v6;
use Test;
plan 46;

# L<S03/Changes to Perl 5 operators/"imposes a numeric">

# Per Larry: L<http://www.nntp.perl.org/group/perl.perl6.compiler/1134>
is(+'0012', 12, "+'0012' is 12");
is(+'0000',  0, "+'0000' is  0");
is(+'000a',  0, "+'000a' is  0 (illegal number)");

is(+'1900', 1900, "+'1900' is 1900");
#?rakudo todo "+'1900' is a Num in Rakudo-ng"
isa_ok(+'1900', Int, "+'1900' is an Int");
#?rakudo 2 skip "Rat in string not supported yet in Rakudo-ng"
is(+'3/2', 3/2, "+'3/2' is 3/2");
isa_ok(+'3/2', Rat, "+'3/2' is a Rat");
is(+'1.9e3', 1900, "+'1.9e3' is 1900");
isa_ok(+'1.9e3', Num, "+'1.9e3' is a Num");

is(+'Inf', Inf, "+'Inf' is Inf");
is(+'Info', 0, "+'Info' is 0");
is(+'-Inf', -Inf, "+'-Inf' is -Inf");
#?rakudo todo 'nom regression'
is(+'-Info', 0, "+'-Info' is 0");
is(+'NaN', NaN, "+'NaN' is NaN");
is(+'NaNa', 0, "+'NaNa' is 0");

{
    # XXX Not sure whether the following tests are correct
    #?rakudo todo 'nom regression'
    is(+'Inf ',      Inf, "numification of strings with whitspace (1)");
    is(+'Inf o',       0, "numification of strings with whitspace (2)");
    #?rakudo todo 'nom regression'
    is(+'NaN ',      NaN, "numification of strings with whitspace (3)");
    is(+'NaN a',       0, "numification of strings with whitspace (4)");
    #?rakudo todo 'nom regression'
    is(+"Inf\t",     Inf, "numification of strings with whitspace (5)");
    is(+"Inf\to",      0, "numification of strings with whitspace (6)");
    #?rakudo todo 'nom regression'
    is(+"NaN\t",     NaN, "numification of strings with whitspace (7)");
    is(+"NaN\ta",      0, "numification of strings with whitspace (8)");
    #?rakudo todo 'nom regression'
    is(+"Inf\n",     Inf, "numification of strings with whitspace (9)");
    is(+"Inf\no",      0, "numification of strings with whitspace (10)");
    #?rakudo todo 'nom regression'
    is(+"NaN\n",     NaN, "numification of strings with whitspace (11)");
    is(+"NaN\na",      0, "numification of strings with whitspace (12)");
    #?rakudo todo 'nom regression'
    is(+"Inf\n\t ",  Inf, "numification of strings with whitspace (13)");
    is(+"Inf\n\t o",   0, "numification of strings with whitspace (14)");
    #?rakudo todo 'nom regression'
    is(+"NaN\n\t ",  NaN, "numification of strings with whitspace (15)");
    is(+"NaN\n\t a",   0, "numification of strings with whitspace (16)");
    is(+"3 ",          3, "numification of strings with whitspace (17)");
}

is(+'aInf',  0, "+'aInf'  is 0");
is(+'aInfo', 0, "+'aInfo' is 0");
is(+'aNaN',  0, "+'aNaN'  is 0");
is(+'aNaNa', 0, "+'aNaNa' is 0");

is( Inf,  'Inf', "'Inf' is Inf");
is(-Inf, '-Inf', "'-Inf' is -Inf");

is(+(~(+Inf)),  Inf, "'+Inf' is Inf");
is(+(~(-Inf)), -Inf, "'-Inf' is -Inf");


# RT #62622
#?rakudo skip '+"2" should return an Int'
{
    my Int $x;

    lives_ok { $x = +'2' }, 'can assign +"2" to Int variable';
    isa_ok( $x, Int, 'assign +"2" to Int creates an Int' );
    is( $x, 2, 'assign +"2" to Int variable works' );

    lives_ok { $x = "4" - 3 }, 'lives: Int $x = "4" - 3';
    isa_ok( $x, Int, 'Int $x = "4" - 3 creates an Int' );
    is( $x, 1, 'works: Int $x = "4" - 3' );
}

# vim: ft=perl6
