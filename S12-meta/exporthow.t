use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

use lib $?FILE.IO.parent(2).add: 'packages/S12-meta/lib';

plan 12;

throws-like { EVAL 'use InvalidDirective;' },
    X::EXPORTHOW::InvalidDirective, directive => 'BBQ';

{
    use Supersede1;
    class Act { }
    is Act.^tryit(), 'pony', 'Can supersede meta-type for class';
}

# https://github.com/Raku/old-issue-tracker/issues/4797
#?rakudo skip 'RT #126759'
{
    use Supersede1;
    EVAL q|
       class ActEval { }
       is ActEval.^tryit,'pony','supersede works in EVAL';
    |;
}

class HopefullyUsual { }
dies-ok { HopefullyUsual.^tryit() }, 'EXPORTHOW::SUPERSEDE is lexical';

throws-like { EVAL 'use SupersedeBad;' },
    X::EXPORTHOW::NothingToSupersede, declarator => 'nobody-will-add-this-declarator';

throws-like { EVAL 'use Supersede1;
                    use Supersede2;' },
    X::EXPORTHOW::Conflict, directive => 'SUPERSEDE', declarator => 'class';

{
    use Declare;
    controller Home { }
    ok Home ~~ Controller, 'Type declared with new controller declarator got Controller role added';
}

# https://github.com/Raku/old-issue-tracker/issues/4797
#?rakudo skip 'RT #126759'
{
    use Declare;
    EVAL q|
       controller TestEval { }
       ok TestEval ~~ Controller,'declarator works inside EVAL';
    |;
}

dies-ok { EVAL 'controller Fat { }' }, 'Imported declarators do not leak out of lexical scope';

throws-like { EVAL 'use DeclareBad;' },
    X::EXPORTHOW::Conflict, directive => 'DECLARE', declarator => 'class';

{
    use MultiDeclare;
    lives-ok {
        pokemon pikachu { }
        digimon augmon  { }
    }, 'multiple DECLAREs work';
}

subtest 'export of SUPERSEDE::class' => {
    plan 1;
    with make-temp-dir() {
        .add("Suptest132236.pm6").spurt: ｢
            my package EXPORTHOW {
                class SUPERSEDE::class is Metamodel::ClassHOW {
                    has $.foo;
                }
            }
        ｣;
        is_run ｢use Suptest132236; class Bar {}; print "pass"｣,
            :compiler-args['-I', .absolute], {:out('pass'), :err(''), :0status},
        'import works';
    }
}


# vim: expandtab shiftwidth=4
