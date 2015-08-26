use v6;
use Test;

plan 31;

# L<S04/The Relationship of Blocks and Declarations/"our $foo" introduces a lexically scoped alias>
our $a = 1;
{ # create a new lexical scope
    is($a, 1, '$a is still the outer $a');
    { # create another new lexical scope
        my $a = 2;
        is($a, 2, '$a is now the lexical (inner) $a');
    }
}
is($a, 1, '$a has not changed');

# should it be allowed to declare our-scoped vars more than once?
{
    our $a = 3;
    is($a, 3, '$a is now another lexical (inner) $a');
}
is($a, 3, '$a has changed'); # XXX is that right?

# test that our (@array, @otherarray) correctly declares
# and initializes both arrays
{
    our (@a, @b);
    lives-ok { @a.push(2) }, 'Can use @a';
    lives-ok { @b.push(3) }, 'Can use @b';
    is ~@a, '2', 'push actually worked on @a';
    is ~@b, '3', 'push actually worked on @b';
}

# check that our-scoped variables really belong to the package
{
    package D1 {
        our $d1 = 7;
        is($d1, 7, "we can of course see the variable from its own package");
        
        package D2 {
            our $d2 = 8;
            {
                our $d3 = 9;
            }
            {
                eval-dies-ok('$d3', "variables aren't seen within other lexical child blocks");
                is($D2::d3, 9, "variables are seen within other lexical child blocks via package");
                
                package D3 {
                    eval-dies-ok('$d3', " ... and not from within child packages");
                    is($D2::d3, 9, " ... and from within child packages via package");
                }
            }
            eval-dies-ok('d3', "variables do not leak from lexical blocks");
            is($D2::d3, 9, "variables are seen from lexical blocks via pacakage");
        }
        eval-dies-ok('$d2', 'our() variable not yet visible outside its package');
        eval-dies-ok('$d3', 'our() variable not yet visible outside its package');
        
    }
    eval-dies-ok('$d1', 'our() variable not yet visible outside its package');
}

# RT #100560, #102876
{
    lives-ok { our @e1 = 1..3 },   'we can declare and initialize an our-scoped array';
    lives-ok { our %e2 = a => 1 }, 'we can declare and initialize an our-scoped hash';
    is(@OUR::e1[1], 2, 'our-scoped array has correct value' );
    is(%OUR::e2<a>, 1, 'our-scoped hash has correct value' );
}

# RT #117083
{
    our @f1;
    our %f2;
    ok(@f1 ~~ Array, 'our-declared @-sigil var is an Array');
    ok(%f2 ~~ Hash,  'our-declared %-sigil var is a Hash');
}

# RT #117775
{
    package Gee {
        our $msg;
        our sub talk { $msg }
    }

    $Gee::msg = "hello";
    is(Gee::talk, "hello", 'our-var returned by our-sub gives previously set value');
}

# RT #115630
{
    sub foo() { our $foo = 3 };
    is foo(),    3, 'return value of sub call declaring our-scoped var';
    is our $foo, 3, 'redeclaration will make previous value available';
    is $foo,     3, '... and the value stays';
}

# RT #107270
{
    package Color { our ($red, $green, $blue) = 1..* };
    is $Color::blue, 3, 'declaring and initializing several vars at once';
}

{
    class PiClass { our $pi = 3 };
    is $PiClass::pi, 3, 'declaring/initializing our-scoped var in class';
}

# vim: ft=perl6
