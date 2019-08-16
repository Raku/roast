use Test;
plan 24;

my class Node {
    has $.value;
    has $.next;
}

# Basic sanity
{
    my Node $head;

    dies-ok { cas([].item, Any, 42) },
        'Cannot CAS value to a read-only Scalar container';

    my $next = Node.new(value => 10);
    ok cas($head, Node, $next) === Node,
        'CAS of a type object to an instance return type object originally there';
    ok $head ~~ Node:D, 'Head node is now a defined object';
    is $head.value, 10, 'Head node is object with correct value';

    my $nexter = Node.new(value => 20, next => $next);
    nok cas($head, Node, $nexter) === Node,
        'CAS fails when expected value is not there';

    ok cas($head, $next, $nexter) === $next,
        'CAS succeeds again when given next updated node';
    is $head.value, 20, 'Correct node was put in place';

    throws-like { cas($head, $head, Any.new) },
        X::TypeCheck::Assignment,
        'Cannot CAS value of the wrong type';
}

# Subset types, which require late-bound type checks.
{
    my subset LittleNodey of Node where .value < 20;

    my LittleNodey $head;
    throws-like { cas($head, $head, Node.new(value => 30)) },
        X::TypeCheck::Assignment,
        'Cannot CAS value that does not meet subset type';

    ok cas($head, LittleNodey, Node.new(value => 11)) === LittleNodey,
        'Can CAS when subset type is met';
    ok $head ~~ Node:D, 'Head node is now a defined object';
    is $head.value, 11, 'Head node is object with correct value';
}

# Make sure we really do it atomic.
for 1..4 -> $attempt {
    my $head = Node;
    await start {
        for 1..1000 -> $i {
            loop {
                my $orig = $head;
                my $next = Node.new(value => $i, next => $orig);
                last if cas($head, $orig, $next) === $orig;
            }
        }
    } xx 4;

    my $total = 0;
    my $cur = $head;
    while $cur {
        $total += $cur.value;
        $cur = $cur.next;
    }
    is $total, 4 * [+](1..1000),
        "CAS on linked list with lexical head works ($attempt)";
}

# Test it works for a Scalar array element.
for 1..4 -> $attempt {
    my @node-heads[1];
    @node-heads[0] = Node;
    await start {
        for 1..1000 -> $i {
            loop {
                my $orig = @node-heads[0];
                my $next = Node.new(value => $i, next => $orig);
                last if cas(@node-heads[0], $orig, $next) === $orig;
            }
        }
    } xx 4;

    my $total = 0;
    my $cur = @node-heads[0];
    while $cur {
        $total += $cur.value;
        $cur = $cur.next;
    }
    is $total, 4 * [+](1..1000),
        "CAS on linked list with Scalar array element head works ($attempt)";
}

# Test it works for a Scalar attribute.
for 1..4 -> $attempt {
    my class NodeHead {
        has $.head = Node;
        method add-a-thousand-nodes() {
            for 1..1000 -> $i {
                loop {
                    my $orig = $!head;
                    my $next = Node.new(value => $i, next => $orig);
                    last if cas($!head, $orig, $next) === $orig;
                }
            }
        }
    }

    my $head-obj = NodeHead.new;
    await start { $head-obj.add-a-thousand-nodes() } xx 4;

    my $total = 0;
    my $cur = $head-obj.head;
    while $cur {
        $total += $cur.value;
        $cur = $cur.next;
    }
    is $total, 4 * [+](1..1000),
        "CAS on linked list with Scalar attribute head works ($attempt)";
}
