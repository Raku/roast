use v6;
use Test;

plan 14;

BEGIN { @*INC.push: 't/spec/packages' };

{
    # defined in t/spec/packages/Exportops.pm
    use Exportops;

    # note that eval_dies_ok executes in the context of
    # Test.pm, and Test.pm doesn't import or lift the operators

    ok eval('5!'), 'postfix:<!> was exported...';
    ok eval('5! == 120 or die'), '... and it works';
    eval_dies_ok '5!', 'Test.pm does not import the operators';

    ok eval('"a" yadayada "b"'), 'infix:<yadayada> was exported';
    ok eval('"a" yadayada "b" eq "a..b" or die'), '... and it works';

    ok eval('¢"foo"'), 'imported Unicode prefix operator';
    ok eval('¢4 eq "4 cent" or die '), '... and it works';

    ok eval('3 ± 4'), 'infix:<±> was exported';
    ok eval('(3 ± 4).isa(Range) or die'), '... and it works';

    is eval("(NotANumber.new(:number(4)) NAN+ NotANumber.new(:number(-1))).number"), 3, "infix:<NAN+> was exported";
    is eval("(NotANumber.new(:number(4)) + NotANumber.new(:number(-1))).number"), 3, "multi infix:<+> was exported and is visible";
    is 4 + 2, 6, "Normal infix:<+> still works";

    nok eval('3 notthere 4'), 'not-exported operator was not imported';
}

eval_dies_ok '5!', 'import of operators is lexical';

# vim: ft=perl6
