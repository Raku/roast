# http://perl6advent.wordpress.com/2009/12/12/day-12-modules-and-exporting/

use v6;
use Test;

plan 9;

use lib 't/spec/packages';

{
    eval_lives_ok 'use Fancy::Utilities', 'Can use Fancy::Utilities';

    use Fancy::Utilities :greet;
    is Fancy::Utilities::lolgreet('Tene'), 'O HAI TENE', 'Referencing subs by fullname works';
    is lolgreet('Jnthn'), 'O HAI JNTHN', 'Exporting symbols works';
}

{
    eval_lives_ok 'use Fancy::Utilities :greet, :lolcat;', 'Can import symbols by name';

    use Fancy::Utilities :greet, :lolcat;
    is lolgreet('Tene'), 'O HAI TENE', 'Explicitly importing symbols by name works';
    is nicegreet('Jnthn'), 'Good morning, Jnthn!', 'Cannot use a sub not explicitly imported';
}

{
    eval_lives_ok 'use Fancy::Utilities :ALL;', 'Can import everything marked for export using :ALL';

    use Fancy::Utilities :ALL;
    is lolrequest("Cake"), 'I CAN HAZ A CAKE?', 'Can use a sub marked as exported and imported via :ALL';
}


{
    use Fancy::Utilities;
    is greet(), 'Hi!', "Multi subs are imported by default - is this to spec?";
}
