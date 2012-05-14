use v6;
use Test;

plan 16;

# L<S12/Lvalue methods/may be declared as lvalues with is rw.>

class T {
    has $.a;
    has $.b;
    method l1 is rw { 
        return-rw $!a;
    }

    method l2 is rw { 
        $!b;
    }
}

my $o = T.new(:a<x>, :b<y>);

is $o.l1,       'x',    'lvalue method as rvalue with explicit return';
is $o.l2,       'y',    'lvalue method as rvalue with implicit return';

lives_ok { $o.l1 = 3 }, 'can assign to the lvalue method (explicit return)';
is $o.l1,       3,      '... and the assignment worked';
is $o.a,        3,      '...also to the attribute';

lives_ok { $o.l2 = 4 }, 'can assign to the lvalue method (implicit return)';
is $o.l2,       4,      '... and the assignment worked';
is $o.b,        4,      '...also to the attribute';

my ($a, $b);
#?pugs todo
lives_ok { temp $o.l1 = 8; $a = $o.a },
         'can use lvalue method in temp() statement (explicit return)';
is $o.l1,       3,      '... and the value was reset';
is $o.a,        3,      '... also on the attribute';
#?pugs todo
is $a,          8,      'but the temp assignment had worked';

#?pugs todo
lives_ok { temp $o.l2 = 9; $b = $o.b },
         'can use lvalue method in temp() statement (explicit return)';
is $o.l2,       4,      '... and the value was reset';
#?niecza todo
#?pugs todo
is $o.b,        4,      '... also on the attribute';
#?niecza todo
#?pugs todo
is $b,          9,      'but the temp assignment had worked';

# vim: ft=perl6
