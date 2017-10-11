use v6;
use lib <.  t/spec/packages/>;
use Test;
use Test::Util;

plan 12;

throws-like { EVAL 'use t::spec::S12-meta::InvalidDirective;' },
    X::EXPORTHOW::InvalidDirective, directive => 'BBQ';

{
    use t::spec::S12-meta::Supersede1;
    class Act { }
    is Act.^tryit(), 'pony', 'Can supersede meta-type for class';
}

#?rakudo skip 'RT #126759'
{
    use t::spec::S12-meta::Supersede1;
    EVAL q|
       class ActEval { }
       is ActEval.^tryit,'pony','supersede works in EVAL';
    |;
}

class HopefullyUsual { }
dies-ok { HopefullyUsual.^tryit() }, 'EXPORTHOW::SUPERSEDE is lexical';

throws-like { EVAL 'use t::spec::S12-meta::SupersedeBad;' },
    X::EXPORTHOW::NothingToSupersede, declarator => 'nobody-will-add-this-declarator';

throws-like { EVAL 'use t::spec::S12-meta::Supersede1;
                    use t::spec::S12-meta::Supersede2;' },
    X::EXPORTHOW::Conflict, directive => 'SUPERSEDE', declarator => 'class';

{
    use t::spec::S12-meta::Declare;
    controller Home { }
    ok Home ~~ Controller, 'Type declared with new controller declarator got Controller role added';
}

#?rakudo skip 'RT #126759'
{
    use t::spec::S12-meta::Declare;
    EVAL q|
       controller TestEval { }
       ok TestEval ~~ Controller,'declarator works inside EVAL';
    |;
}

dies-ok { EVAL 'controller Fat { }' }, 'Imported declarators do not leak out of lexical scope';

throws-like { EVAL 'use t::spec::S12-meta::DeclareBad;' },
    X::EXPORTHOW::Conflict, directive => 'DECLARE', declarator => 'class';

{
    use t::spec::S12-meta::MultiDeclare;
    lives-ok {
        pokemon pikachu { }
        digimon augmon  { }
    }, 'multiple DECLAREs work';
}

subtest 'export of SUPERSEDE::class' => {
    plan 1;
    with make-temp-dir() {
        .add("Suptest132236.pm").spurt: ｢
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

