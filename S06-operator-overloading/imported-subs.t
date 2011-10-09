use v6;
use Test;

plan 17;

BEGIN { @*INC.push: 't/spec/packages' };

{
    # defined in t/spec/packages/Exportops.pm
    use Exportops;

    # note that eval_dies_ok executes in the context of
    # Test.pm, and Test.pm doesn't import or lift the operators

    #?rakudo skip 'nom regression'
    ok eval('5!'), 'postfix:<!> was exported...';
    #?rakudo skip 'nom regression'
    ok eval('5! == 120 or die'), '... and it works';
    eval_dies_ok '5!', 'Test.pm does not import the operators';

    #?rakudo skip 'nom regression'
    ok eval('"a" yadayada "b"'), 'infix:<yadayada> was exported';
    #?rakudo skip 'nom regression'
    ok eval('"a" yadayada "b" eq "a..b" or die'), '... and it works';
    #?rakudo todo "op= form doesn't work for imported operators?"
    ok eval('my $a = "a"; $a yadayada= "b"; $a eq "a..b" or die'), '... and yadayada= works too';

    #?rakudo todo 'nom regression'
    ok eval('¢"foo"'), 'imported Unicode prefix operator';
    #?rakudo todo 'nom regression'
    ok eval('¢4 eq "4 cent" or die '), '... and it works';

    #?rakudo todo 'nom regression'
    ok eval('3 ± 4'), 'infix:<±> was exported';
    #?rakudo todo 'nom regression'
    ok eval('(3 ± 4).isa(Range) or die'), '... and it works';

    #?rakudo todo 'nom regression'
    is eval("(NotANumber.new(:number(4)) NAN+ NotANumber.new(:number(-1))).number"), 3, "infix:<NAN+> was exported";
    #?rakudo todo 'nom regression'
    is eval("(NotANumber.new(:number(4)) + NotANumber.new(:number(-1))).number"), 3, "multi infix:<+> was exported and is visible";
    
    #?rakudo 2 todo "op= form doesn't work for imported operators?"
    is eval('my $a = NotANumber.new(:number(4)); $a NAN+= NotANumber.new(:number(-1)); $a.number;'), 3, "NAN+= works too";
    is eval('my $a = NotANumber.new(:number(4)); $a += NotANumber.new(:number(-1)); $a.number;'), 3, "+= works too";
    
    is 4 + 2, 6, "Normal infix:<+> still works";

    nok try { eval('3 notthere 4') }, 'not-exported operator was not imported';
}

eval_dies_ok '5!', 'import of operators is lexical';

# vim: ft=perl6
