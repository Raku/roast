use v6;

use Test;
plan 1;

sub foo() {
  return if 1;
  123;
}

my $ok = 1;
for foo() -> @foo {
    $ok = 0;
}

ok $ok, "condition in statement level respects context" :todo<bug>;
