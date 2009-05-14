use v6;
use Test;

plan 10;

BEGIN { @*INC.push: 't/spec/packages' };

{
    # defined in t/spec/packages/Exportops.pm
    use Exportops;

    eval_lives_ok '5!', 'postfix:<!> was exported...';
    eval_lives_ok '5! == 120 or die', '... and it works';

    eval_lives_ok '"a" yadayada "b"', 'infix:<yadayada> was exported';
    eval_lives_ok '"a" yadayada "b" eq "a..b" or die',
                  '... and it works';

    #?rakudo 4 todo 'importing Unicode operators'
    eval_lives_ok '¢"foo"', 'imported Unicode prefix operator';
    eval_lives_ok '¢4 eq "4 cent" or die ', '... and it works';

    eval_lives_ok '3 ± 4', 'infix:<±> was exported';
    eval_lives_ok 'isa_ok(3 ± 4, Range)', '... and it works';

    eval_dies_ok '3 notthere 4', 'not-exported operator was not imported';
}

#?rakudo todo 'lexical import'
eval_dies_ok '5!', 'import of operators is lexical';

# vim: ft=perl6
