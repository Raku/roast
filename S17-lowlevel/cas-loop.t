use Test;
plan 10;

my class Node {
    has $.value;
    has $.next;
}

# Basic sanity
{
    my Node $head;

    dies-ok { cas([].item, { 42 }) },
        'Cannot use CAS block form on a read-only Scalar container';
    throws-like { cas($head, { Any.new }) },
        X::TypeCheck::Assignment,
        'Cannot use CAS block form with value of the wrong type';

    my $next = Node.new(value => 10);
    my $was = 'WRONG';
    ok cas($head, { $was = $_; $next }) === $next,
        'Looping form of CAS returns what was installed';
    ok $was === Node, 'The block was called with the original value';
    ok $head ~~ Node:D, 'Head node is now a defined object';
    is $head.value, 10, 'Head node is object with correct value';
}

# Make sure we really do it atomic.
for 1..4 -> $attempt {
    my $head = Node;
    await start {
        for 1..1000 -> $i {
            cas $head, -> $orig { Node.new(value => $i, next => $orig) }
        }
    } xx 4;

    my $total = 0;
    my $cur = $head;
    while $cur {
        $total += $cur.value;
        $cur = $cur.next;
    }
    is $total, 4 * [+](1..1000),
        "Block form of CAS on linked list with lexical head works ($attempt)";
}
