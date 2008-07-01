use v6;
use Test;
plan 35;

# L<S03/Changes to Perl 5 operators/"imposes a numeric">

# Per Larry: L<http://www.nntp.perl.org/group/perl.perl6.compiler/1134>
is(+'0012', 12, "+'0012' is 12");
is(+'0000',  0, "+'0000' is  0");
is(+'000a',  0, "+'000a' is  0 (illegal number)");

is(+'1.9e3', 1900, "+'1.9e3' is 1900");
#?rakudo todo "Inf"
is(+'Inf', Inf, "+'Inf' is Inf");
is(+'Info', 0, "+'Info' is 0");
is(+'-Inf', -Inf, "+'-Inf' is -Inf");
#?rakudo todo "Inf"
is(+'-Info', 0, "+'-Info' is 0");
#?rakudo todo "NaN"
is(+'NaN', NaN, "+'NaN' is NaN");
is(+'NaNa', 0, "+'NaNa' is 0");

#?rakudo skip 'Tests need specs first'
{
    # XXX Not sure whether the following tests are correct
    is(+'Inf ',      Inf, "numification of strings with whitspace (1)");
    is(+'Inf o',       0, "numification of strings with whitspace (2)");
    is(+'NaN ',      NaN, "numification of strings with whitspace (3)");
    is(+'NaN a',       0, "numification of strings with whitspace (4)");
    is(+"Inf\t",     Inf, "numification of strings with whitspace (5)");
    is(+"Inf\to",      0, "numification of strings with whitspace (6)");
    is(+"NaN\t",     NaN, "numification of strings with whitspace (7)");
    is(+"NaN\ta",      0, "numification of strings with whitspace (8)");
    is(+"Inf\n",     Inf, "numification of strings with whitspace (9)");
    is(+"Inf\no",      0, "numification of strings with whitspace (10)");
    is(+"NaN\n",     NaN, "numification of strings with whitspace (11)");
    is(+"NaN\na",      0, "numification of strings with whitspace (12)");
    is(+"Inf\n\t ",  Inf, "numification of strings with whitspace (13)");
    is(+"Inf\n\t o",   0, "numification of strings with whitspace (14)");
    is(+"NaN\n\t ",  NaN, "numification of strings with whitspace (15)");
    is(+"NaN\n\t a",   0, "numification of strings with whitspace (16)");
    is(+"3 ",          3, "numification of strings with whitspace (17)");
}

is(+'aInf',  0, "+'aInf'  is 0");
is(+'aInfo', 0, "+'aInfo' is 0");
is(+'aNaN',  0, "+'aNaN'  is 0");
is(+'aNaNa', 0, "+'aNaNa' is 0");

#?rakudo 3 todo 'Inf and NaN'
is( Inf,  'Inf', "'Inf' is Inf");
is(-Inf, '-Inf', "'-Inf' is -Inf");

is(+(~(+Inf)),  Inf, "'+Inf' is Inf");
is(+(~(-Inf)), -Inf, "'-Inf' is -Inf");


