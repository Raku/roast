use v6;

use Test;

plan 31;

# L<S04/The do-once loop/"can't" put "statement modifier">
# Note in accordance with STD, conditionals are OK, loops are not.
throws-like 'my $i = 1; do { $i++ } while $i < 5;', X::Obsolete,
    "'do' can't take the 'while' modifier";

throws-like 'my $i = 1; do { $i++ } until $i > 4;', X::Obsolete,
    "'do' can't take the 'until' modifier";

throws-like 'my $i; do { $i++ } for 1..3;', X::Obsolete,
    "'do' can't take the 'for' modifier";

throws-like 'my $i; do { $i++ } given $i;', X::Obsolete,
    "'do' can't take the 'given' modifier";

eval-lives-ok 'my $i; do { $i++ } unless $i;',
    "'do' can take the 'unless' modifier";

eval-lives-ok 'my $i = 1; do { $i++ } if $i;',
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
	any branch, the return value is undefined in item context and
	and an empty Slip in list context.
=end comment
{
	my $x = do if 0 { 1 } elsif 0 { 2 };
	ok !$x.defined, 'when if does not execute any branch, return undefined';
	# Use now() as something that is reliably not constant-folded
	$x = do if +now == +now + 15 { 1 } elsif +now == +now + 15 { 2 };
	ok !$x.defined, 'when if does not execute any branch, return undefined (unfolded)';
	$x = (42, do if 0 { 1 } elsif 0 { 2 }, 43);
	is $x[1], 43, 'when if does not execute any branch, returns empty Slip';
	$x = (44, do if +now == +now + 15 { 1 } elsif +now == +now + 15 { 2 }, 45);
	is-deeply $x, $(44,45), 'when if does not execute any branch, returns empty Slip (unfolded)';
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
#?rakudo skip 'next without loop construct RT #124573'
{
    my $i;
    my $ret = do {
        $i++;
        next;
        $i--;
    };
    is $i, 1, "'next' works in 'do' block";
    is $ret, (), "'next' in 'do' block drives return value";
}

#?rakudo 3 skip "Undeclared name A RT #124574"
is EVAL('my $i; A: do { $i++; last A; $i-- }; $i'), 1,
    "'last' works with label";
is EVAL('my $i; A: do { $i++; next A; $i-- }; $i'), 1,
    "'next' works with label";
is EVAL('my $i; A: do { $i++; redo A until $i == 5; $i-- }; $i'), 4,
    "'redo' works with label";

#?rakudo skip 'last without loop construct RT #124575'
{
    is EVAL('
        my $i;
        (
         do {
            $i++;
            last;
            $i--;
        }),
        $i;
    '), ((),1), "'last' works in 'do' block and drives return value";
}

# IRC notes:
# <agentzh> audreyt: btw, can i use redo in the do-once loop?
# <audreyt> it can, and it will redo it
#?rakudo skip 'redo without loop construct RT #124576'
{
    is EVAL('
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
    throws-like 'my $i; { $i++; next; $i--; }', X::ControlFlow,
        "bare block can't take 'next'";

    throws-like 'my $i; { $i++; last; $i--; }', X::ControlFlow,
        "bare block can't take 'last'";

    throws-like 'my $i; { $i++; redo; $i--; }', X::ControlFlow,
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

lives-ok { my $a = do given 5 {} }, 'empty do block lives (RT #61034)';

# vim: ft=perl6
