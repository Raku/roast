#############################################################################
#####
##### WARNING: the first subtest in this file relies on the name of this file
#####          and the line number of the block it's testing. If changing
#####          any of those, please adjust the test accordingly.
#####
#############################################################################

use v6;

use Test;

plan 21;

=begin description

Test pointy sub behaviour described in S06

=end description


subtest 'if this test fails, check the block in test file was not moved' => {
    ### DO NOT MOVE the block of this test, because the line number will be wrong
    plan 3;
    my $block = -> { }
    #?rakudo.jvm 3 todo 'rakudo-j reports line -1 and file "unknown"'
    is $block.line, 25, 'correct .line';
    like $block.file.IO.basename, /^ 'pointy.'/,  'correct .file';
    is $block.file.IO.absolute(), $?FILE.IO.absolute(), '.file matches $?FILE';
}


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
lives-ok { @a = ("one", -> $x { $x**2 }, "three")} ,
        'pointy sub without preceding comma';
is @a[0], 'one', 'pointy sub in list previous argument';
isa-ok @a[1], Code, 'pointy sub in list';
is @a[2], 'three', 'pointy sub in list following argument';


# L<S06/""Pointy blocks""/behaves like a block with respect to control exceptions>
my $n = 1;
my $s = -> {
    last if $n == 10;
    $n++;
    redo if $n < 10;
};
dies-ok $s, 'pointy with block control exceptions';
#?rakudo todo 'pointy blocks and last/redo RT #124973'
is $n, 10, "pointy control exceptions ran";

# L<S06/""Pointy blocks""/will return from the innermost enclosing sub or method>
my $str = '';

sub outer {
    my $s = -> {
        is(&?ROUTINE.name, 'outer', 'pointy still sees outer\'s &?ROUTINE');

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
throws-like q{{ -> { $^a, $^b } }}, X::Signature::Placeholder,
    '-> { $^a, $^b } is illegal';

# RT #61034
lives-ok {my $x = -> {}; my $y = $x(); },
         'can define and execute empty pointy block';

# The default type of pointy blocks is Mu, not Any. See
# http://www.nntp.perl.org/group/perl.perl6.language/2009/03/msg31181.html
# L<S02/Undefined types/default block parameter type>
# this means that junctions don't autothread over pointy blocks

{
    my @a = any(3, 4);
    my $ok = 0;
    my $iterations = 0;
    for @a -> $x {
        $ok = 1 if $x ~~ Junction;
        $iterations++;
    }
    ok $ok, 'Blocks receive junctions without autothreading';
    is $iterations, 1, 'no autothreading happened';
    my $b = -> $x { ... };
    ok $b.signature.perl !~~ /Any/,
       'The .signature of a block does not contain Any';
}

# RT #115372
{
    throws-like q[say -> {YOU_ARE_HERE}], X::Syntax::Reserved,
        '{YOU_ARE_HERE} disallowed outside of a setting';
}

# RT #126232
{
    is (-> --> Int { 42 })(), 42, 'pointy with return type allows return if it matches';
    throws-like '(-> --> Int { |(1,2,3) })()', X::TypeCheck::Return;
}

# vim: ft=perl6
