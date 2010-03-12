use v6;
use Test;

plan *;

# tests .parse and .parsefile methods on a grammar

grammar Foo {
    token TOP { \d+ };
};
grammar Bar {
    token untop { \d+ }
}

is(~Foo.parse("abc123xyz"), "123",  ".parse method invokes TOP rule");
dies_ok({ Bar.parse("abc123xyz") }, "dies if no TOP rule");

my $fh = open("parse_and_parsefile_test", :w);
$fh.say("abc\n123\nxyz");
$fh.close();
is(~Foo.parsefile("parse_and_parsefile_test"), "123",  ".parsefile method invokes TOP rule");
dies_ok({ Bar.parsefile("parse_and_parsefile_test") }, "dies if no TOP rule");
dies_ok({ Foo.parsefile("non_existent_file") },        "dies if file not found");
unlink("parse_and_parsefile_test");

grammar A::B {
    token TOP { \d+ }
}
is(~A::B.parse("zzz42zzz"), "42", ".parse works with namespaced grammars");

# TODO: Check for a good error message, not just the absence of a bad one.
dies_ok { ::No::Such::Grammar.parse() }, '.parse on missing grammar dies';

# RT #71062
{
    grammar Integer { rule TOP { x } };
    #?rakudo todo 'RT 71062: dies calling grammar named "Integer"'
    lives_ok { Integer.parse('x') }, 'can .parse grammar named "Integer"';
}

done_testing;

# vim: ft=perl6
