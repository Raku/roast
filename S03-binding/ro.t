use v6;
use Test;

plan 9;

# L<S03/Item assignment precedence/bind and make readonly>

{
    my $x = 5;
    my $y = 3;
    $x ::= $y;
    is $x, 3, '::= on scalars took the value from the RHS';
    #?rakudo todo 'nom regression'
    #?pugs todo
    dies_ok { $x = 5 }; '... and made the LHS RO';
    #?rakudo todo 'nom regression'
    #?pugs todo
    is $x, 3, 'variable is still 3';
}

#?pugs todo
{
    my Int $a = 4;
    my Str $b;
    dies_ok { $b ::= $a },
        'Cannot ro-bind variables with incompatible type constraints';
}

{
    my @x = <a b c>;
    my @y = <d e>;

    @x ::= @y;
    is @x.join('|'), 'd|e', '::= on arrays';
    #?rakudo 4 todo '::= on arrays'
    #?niecza todo
    #?pugs 4 todo
    dies_ok { @x := <3 4 foo> }, '... make RO';
    #?niecza todo
    is @x.join('|'), 'd|e', 'value unchanged';
    #?niecza todo
    lives_ok { @x[2] = 'k' }, 'can still assign to items of RO array';
    #?niecza todo
    is @x.join(''), 'd|e|k', 'assignment relly worked';
}

# vim: ft=perl6
