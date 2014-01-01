use v6;
use Test;

plan 10;

{
    sub f(:a(:$b)) { $b }
    sub g(:a( $b)) { $b }

    is f( a => 1), 1, 'can use the alias name (1)';
    is g( a => 1), 1, 'can use the alias name (1)';
    is f( b => 1), 1, 'can use the var name';
    dies_ok { EVAL 'g(  b => 1)' },
            'cannot use the var name if there is no : in front of it';
}

{
    sub mandatory(:x(:$y)!) { $y }
    is mandatory( y => 2), 2, 'mandatory named';
    is mandatory( x => 3), 3, 'mandatory renamed';
    dies_ok { EVAL 'mandatory()' }, 'and it really is mandatory';
}

{
    sub typed(:i(:%j)) { %j.keys.[0] };
    is typed(i => { a => 1 }), 'a', 'typed renames -- sanity';
    dies_ok { EVAL 'typed(:j)' }, 'type constraint on var';
    dies_ok { EVAL 'typed(:i)' }, 'type constraint on var propagates to alias';
}
