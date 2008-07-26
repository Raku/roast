use v6;

use Test;

plan 6;

# multi sub with signature
multi sub foo() { "empty" }
multi sub foo($a) { "one" }
is(foo(), "empty", "multi sub with empty signature");
is(foo(42), "one", "multi sub with parameter list");

# multi sub without signature
multi sub bar { "empty" }
multi sub bar($a) { "one" }
is(bar(), "empty", "multi sub with no signature");
is(bar(42), "one", "multi sub with parameter list");

# multi without a routine type
multi baz { "empty" }
multi baz($a) { "one" }
is(baz(), "empty", "multi with no signature");
is(baz(42), "one", "multi with parameter list");
