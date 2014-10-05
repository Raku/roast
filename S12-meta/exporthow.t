use v6;

use Test;
plan 8;

use lib '.';

throws_like { EVAL 'use t::spec::S12-meta::InvalidDirective;' },
    X::EXPORTHOW::InvalidDirective, directive => 'BBQ';

{
    use t::spec::S12-meta::Supersede1;
    class Act { }
    is Act.^tryit(), 'pony', 'Can supersede meta-type for class';
}

class HopefullyUsual { }
dies_ok { HopefullyUsual.^tryit() }, 'EXPORTHOW::SUPERSEDE is lexical';

throws_like { EVAL 'use t::spec::S12-meta::SupersedeBad;' },
    X::EXPORTHOW::NothingToSupersede, declarator => 'nobody-will-add-this-declarator';

throws_like { EVAL 'use t::spec::S12-meta::Supersede1;
                    use t::spec::S12-meta::Supersede2;' },
    X::EXPORTHOW::Conflict, directive => 'SUPERSEDE', declarator => 'class';

{
    use t::spec::S12-meta::Declare;
    controller Home { }
    ok Home ~~ Controller, 'Type declared with new controller declarator got Controller role added';
}

dies_ok { EVAL 'controller Fat { }' }, 'Imported declarators do not leak out of lexical scope';

throws_like { EVAL 'use t::spec::S12-meta::DeclareBad;' },
    X::EXPORTHOW::Conflict, directive => 'DECLARE', declarator => 'class';
