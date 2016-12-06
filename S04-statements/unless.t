use v6;

use Test;

=begin kwid

Basic "unless" tests

=end kwid

plan 10;

# L<S04/Conditional statements/unless statements 
#   work as in Perl 5>

my $x = 'test';
{
    my $found = 0;
    unless $x ne $x { $found = 1; };
    ok($found, 'unless $x ne $x works');
}

{
    my $found = 1;
    unless $x eq $x { $found = 0; }
    ok($found, 'unless $x eq $x is not executed');
}

{
    my $found = 0;
    unless 0 { $found = 1; }
    ok($found, 'unless 0 is executed');
}

{
    my $found = 1;
    unless 1 { $found = 0; }
    ok($found, 'unless 1 is not executed');
}

{
    my $found = 0;
    unless Mu { $found = 1; }
    ok($found, 'unless undefined is executed');
}

# with parentheses
{
    my $found = 0;
    unless ($x ne $x) { $found = 1; };
    ok($found, 'unless ($x ne $x) works');
}

{
    my $found = 1;
    unless (5+2) { $found = 0; }
    ok($found, 'unless (5+2) is not executer');
}

# die called in the condition part of an if statement should die immediately
# rather than being evaluated as a boolean
my $foo = 1;
try { unless (die "should die") { $foo = 3 }};
#say '# $foo = ' ~ $foo;
is $foo, 1, "die should stop execution immediately.";

# L<S04/Conditional statements/"The unless statement does not allow an elsif">
# RT #130279
subtest '`else` and kin with `unless` errors out' => {
    plan 3;
    throws-like 'unless 1 {} else     {}', X::Syntax::UnlessElse,
        keyword => 'else',   'using `else`';
    throws-like 'unless 1 {} elsif 1  {}', X::Syntax::UnlessElse,
        keyword => 'elsif',  'using `elsif`';
    throws-like 'unless 1 {} orwith 1 {}', X::Syntax::UnlessElse,
        keyword => 'orwith', 'using `orwith`';
}

ok (unless 1 { 2 }) ~~ Slip, "unless returns Slip when not taken";

# vim: ft=perl6
