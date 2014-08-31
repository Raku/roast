use v6;
use Test;

plan 20;

use lib 't/spec/packages';

{
    # defined in t/spec/packages/Exportops.pm
    use Exportops;

    # note that eval_dies_ok executes in the context of
    # Test.pm, and Test.pm doesn't import or lift the operators

    ok EVAL('5!'), 'postfix:<!> was exported...';
    ok EVAL('5! == 120 or die'), '... and it works';
    eval_dies_ok '5!', 'Test.pm does not import the operators';

    ok EVAL('"a" yadayada "b"'), 'infix:<yadayada> was exported';
    ok EVAL('"a" yadayada "b" eq "a..b" or die'), '... and it works';
    ok EVAL('my $a = "a"; $a yadayada= "b"; $a eq "a..b" or die'), '... and yadayada= works too';

    ok EVAL('¢"foo"'), 'imported Unicode prefix operator';
    ok EVAL('¢4 eq "4 cent" or die '), '... and it works';

    ok EVAL('3 ± 4'), 'infix:<±> was exported';
    ok EVAL('(3 ± 4).isa(Range) or die'), '... and it works';

    is EVAL("(NotANumber.new(:number(4)) NAN+ NotANumber.new(:number(-1))).number"), 3, "infix:<NAN+> was exported";
    is EVAL("(NotANumber.new(:number(4)) + NotANumber.new(:number(-1))).number"), 3, "multi infix:<+> was exported and is visible";
    
    is EVAL('my $a = NotANumber.new(:number(4)); $a NAN+= NotANumber.new(:number(-1)); $a.number;'), 3, "NAN+= works too";
    is EVAL('my $a = NotANumber.new(:number(4)); $a += NotANumber.new(:number(-1)); $a.number;'), 3, "+= works too";
    
    is 4 + 2, 6, "Normal infix:<+> still works";

    dies_ok { EVAL('3 notthere 4') }, 'not-exported operator was not imported';

    {
        my $fail = try EVAL q{3 notthere 4};
        ok $! ~~ X::Syntax::Confused, 'not imported operator fails with X::Syntax::Confused.';
        is $!.reason, "Two terms in a row", 'the reason is "Two terms in a row"';
    }

    is answer["Life, the Universe, and Everything"], 42, 'exporting circumfixes works';
}

eval_dies_ok '5!', 'import of operators is lexical';

# vim: ft=perl6
