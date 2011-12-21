use v6;

use Test;

plan 27;

# L<S04/The do-once loop/"can't" put "statement modifier">
# Note in accordance with STD, conditionals are OK, loops are not.
eval_dies_ok 'my $i = 1; do { $i++ } while $i < 5;',
    "'do' can't take the 'while' modifier";

eval_dies_ok 'my $i = 1; do { $i++ } until $i > 4;',
    "'do' can't take the 'until' modifier";

eval_dies_ok 'my $i; do { $i++ } for 1..3;',
    "'do' can't take the 'for' modifier";

eval_dies_ok 'my $i; do { $i++ } given $i;',
    "'do' can't take the 'given' modifier";

eval_lives_ok 'my $i; do { $i++ } unless $i;',
    "'do' can take the 'unless' modifier";

eval_lives_ok 'my $i = 1; do { $i++ } if $i;',
    "'do' can take the 'if' modifier";

# L<S04/The do-once loop/statement "prefixing with" do>
{
    my $x;
    my ($a, $b, $c) = 'a' .. 'c';

    $x = do if $a { $b } else { $c };
    is $x, 'b', "prefixing 'if' statement with 'do' (then)";

    $x = do if !$a { $b } else { $c };
    is $x, 'c', "prefixing 'if' statement with 'do' (else)";
}
	
=begin comment
	If the final statement is a conditional which does not execute 
	any branch, the return value is undefined in item context and () 
	in list context.
=end comment
{
	my $x = do if 0 { 1 } elsif 0 { 2 };
	ok !$x.defined, 'when if does not execute any branch, return undefined';
}

{
    my $ret = do given 3 {
        when 3 { 1 }
    };
    is($ret, 1, 'do STMT works');
}

{
    my $ret = do { given 3 {
        when 3 { 1 }
    } };
    is($ret, 1, 'do { STMT } works');
}

# L<S04/The do-once loop/"you may use" do "on an expression">
{
    my $ret = do 42;
    is($ret, 42, 'do EXPR should also work (single number)');

    $ret = do 3 + 2;
    is($ret, 5, 'do EXPR should also work (simple + expr)');

    $ret = do do 5;
    is($ret, 5, 'nested do (1)');

    $ret = do {do 5};
    is($ret, 5, 'nested do (2)');

    # precedence decisions do not cross a do boundary
    $ret = 2 * do 2 + 5;
    is($ret, 14, 'do affects precedence correctly');
}

# L<S04/The do-once loop/"can take" "loop control statements">
#?rakudo skip 'next() should also work on do blocks (?)'
{
    my $i;
    do {
        $i++;
        next;
        $i--;
    };
    is $i, 1, "'next' works in 'do' block";
}

#?rakudo 3 skip "labels"
is eval('my $i; A: do { $i++; last A; $i-- }; $i'), 1,
    "'last' works with label";
is eval('my $i; A: do { $i++; next A; $i-- }; $i'), 1,
    "'next' works with label";
is eval('my $i; A: do { $i++; redo A until $i == 5; $i-- }; $i'), 4,
    "'redo' works with label";

#?rakudo skip 'last not implemented'
{
    is eval('
        my $i;
        do {
            $i++;
            last;
            $i--;
        };
        $i;
    '), 1, "'last' works in 'do' block";
}

# IRC notes:
# <agentzh> audreyt: btw, can i use redo in the do-once loop?
# <audreyt> it can, and it will redo it
#?rakudo skip 'redo not implemented'
{
    is eval('
        my $i;
        do {
            $i++;
            redo if $i < 3;
            $i--;
        };
        $i;
    '), 2, "'redo' works in 'do' block";
}

# L<S04/The do-once loop/"bare block is not a do-once">
{
    eval_dies_ok 'my $i; { $i++; next; $i--; }',
        "bare block can't take 'next'";

    eval_dies_ok 'my $i; { $i++; last; $i--; }',
        "bare block can't take 'last'";
    
    eval_dies_ok 'my $i; { $i++; redo; $i--; }',
        "bare block can't take 'last'";
}

# L<S04/Statement parsing/"final closing curly on a line" 
#   reverts to semicolon>
{
    my $a = do {
        1 + 2;
    }  # no trailing `;'
    is $a, 3, "final `}' on a line reverted to `;'";
}

lives_ok { my $a = do given 5 {} }, 'empty do block lives (RT 61034)';

# vim: ft=perl6
