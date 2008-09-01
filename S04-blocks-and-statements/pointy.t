use v6;

use Test;

plan 12;

=begin description

Test pointy sub behaviour described in S06

L<S06/""Pointy blocks"">

=end description

# L<S06/""Pointy blocks""/the parameter list of a pointy block does not
# allow parentheses>
my ($sub, $got);

$got = '';
$sub = -> $x { $got = "x $x" };
$sub.(123);
is $got, 'x 123', 'pointy sub without param parens';

$got = '';
-> $x { $got = "x $x" }.(123);
is $got, 'x 123', 'called pointy immediately: -> $x { ... }.(...)';

$got = '';
-> $x { $got = "x $x" }(123); 
is $got, 'x 123', 'called pointy immediately: -> $x { ... }(...)';


# L<S04/Statement-ending blocks/End-of-statement cannot occur within a bracketed expression>
my @a;
ok eval('@a = ("one", -> $x { $x**2 }, "three")'), 
        'pointy sub without preceding comma';
is @a[0], 'one', 'pointy sub in list previous argument';
isa_ok @a[1], 'Code', 'pointy sub in list';
is @a[2], 'three', 'pointy sub in list following argument';


# L<S06/""Pointy blocks""/behaves like a block with respect to control exceptions>
my $n = 1;
my $s = -> { 
    last if $n == 10;
    $n++;
    redo if $n < 10;
};
try { $s.() };
is($!, undef, 'pointy with block control exceptions', :todo<feature>);
is $n, 10, "pointy control exceptions ran", :todo<feature>;

# L<S06/""Pointy blocks""/will return from the innermost enclosing sub or method>
my $str = '';

sub outer {  
    my $s = -> { 
        is(&?ROUTINE.name, '&Main::outer', 'pointy still sees outer\'s &?ROUTINE'); 

        $str ~= 'inner'; 
        return 'inner ret'; 
    };
    $s.(); 
    $str ~= 'outer';
    return 'outer ret';
}

is outer(), 'inner ret', 'return in pointy returns from enclosing sub';
is $str, 'inner', 'return in pointy returns from enclosing sub';

# What about nested pointies -> { ... -> {} }?


# L<S06/""Pointy blocks""/It is referenced>
# Coming soon...


# -> { $^a, $^b } is illegal; you can't mix real sigs with placeholders,
# and the -> introduces a sig of ().  TimToady #perl6 2008-May-24
eval_dies_ok(q{ -> { $^a, $^b } }, '-> { $^a, $^b } is illegal');


# vim: ft=perl6
