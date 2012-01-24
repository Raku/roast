use v6;

use Test;

plan 17;

=begin description

Test pointy sub behaviour described in S06

=end description

# L<S06/""Pointy blocks""/"parameter list of a pointy block does not require
# parentheses">
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
lives_ok { @a = ("one", -> $x { $x**2 }, "three")} , 
        'pointy sub without preceding comma';
is @a[0], 'one', 'pointy sub in list previous argument';
isa_ok @a[1], Code, 'pointy sub in list';
is @a[2], 'three', 'pointy sub in list following argument';


# L<S06/""Pointy blocks""/behaves like a block with respect to control exceptions>
my $n = 1;
my $s = -> { 
    last if $n == 10;
    $n++;
    redo if $n < 10;
};
dies_ok $s, 'pointy with block control exceptions';
#?rakudo todo 'pointy blocks and last/redo'
#?niecza todo
is $n, 10, "pointy control exceptions ran";

# L<S06/""Pointy blocks""/will return from the innermost enclosing sub or method>
my $str = '';

sub outer {  
    my $s = -> { 
        #?rakudo skip '&?ROUTINE'
        #?niecza todo 'Unable to resolve method name in class Sub'
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
eval_dies_ok(q{{ -> { $^a, $^b } }}, '-> { $^a, $^b } is illegal');

# RT #61034

lives_ok {my $x = -> {}; my $y = $x(); }, 
         'can define and execute empty pointy block';

# The default type of pointy blocks is Mu, not Any. See 
# http://www.nntp.perl.org/group/perl.perl6.language/2009/03/msg31181.html
# L<S02/Undefined types/default block parameter type>
# this means that junctions don't autothread over pointy blocks

#?rakudo skip 'Could not find non-existent sub junction'
#?niecza skip 'Could not find non-existent sub junction'
{
    my @a = any(3, 4);
    my $ok = 0;
    my $iterations = 0;
    for @a -> $x {
        $ok = 1 if $x ~~ junction;
        $iterations++;
    }
    ok $ok, 'Blocks receive junctions without autothreading';
    is $iterations, 1, 'no autothreading happened';
    my $b = -> $x { ... };
    ok $b.signature.perl !~~ /Any/, 
       'The .signature of a block does not contain Any';
}

# vim: ft=perl6

