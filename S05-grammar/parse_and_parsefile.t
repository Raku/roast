use v6;
use Test;

plan 15;

# tests .parse and .parsefile methods on a grammar

grammar Foo { token TOP { \d+ } }
grammar Bar { token untop { \d+ } }
grammar Baz { token TOP { \d+ \n } }

nok(~Foo.parse("abc123xyz"), ".parse method invokes TOP rule, no match");
is(~Foo.parse("123"), "123",  ".parse method invokes TOP rule, match");
nok(Foo.parse("123xyz"),  ".parse method requires match to end");
is(~Foo.subparse("123xyz"), "123",  ".subparse method doesn't require match to end");
dies_ok({ Bar.parse("abc123xyz") }, "dies if no TOP rule");

my $fh = open("parse_and_parsefile_test", :w);
$fh.say("abc\n123\nxyz");
$fh.close();
#?niecza skip 'Unable to resolve method parsefile in class Foo'
nok(Foo.parsefile("parse_and_parsefile_test"), ".parsefile method invokes TOP rule, no match");
unlink("parse_and_parsefile_test");

$fh = open("parse_and_parsefile_test", :w);
$fh.say("123");
$fh.close();
#?niecza skip 'Unable to resolve method parsefile in class Foo'
is(~Baz.parsefile("parse_and_parsefile_test"), "123\n",  ".parsefile method invokes TOP rule, match");
dies_ok({ Bar.parsefile("parse_and_parsefile_test") }, "dies if no TOP rule");
dies_ok({ Foo.parsefile("non_existent_file") },        "dies if file not found");

unlink("parse_and_parsefile_test");

grammar A::B {
    token TOP { \d+ }
}
nok(A::B.parse("zzz42zzz"), ".parse works with namespaced grammars, no match");
is(~A::B.parse("42"), "42", ".parse works with namespaced grammars, match");

# TODO: Check for a good error message, not just the absence of a bad one.
eval_dies_ok '::No::Such::Grammar.parse()', '.parse on missing grammar dies';

# RT #71062
{
    grammar Integer { rule TOP { x } };
    lives_ok { Integer.parse('x') }, 'can .parse grammar named "Integer"';
}

# RT #76884
{
    grammar grr {
        token TOP {
            <line>*
        }
        token line { .* \n }
    }

    my $match = grr.parse('foo bar asd');
    is $match[0].perl, "Any", 'empty match is Any, not Null PMC access';
}

# RT #116597
#?rakudo.parrot todo 'RT #116597'
{
    grammar RT116597 {
        token TOP() { <lit 'a'> };
        token lit($s) { $s };
    }
    lives_ok { RT116597.parse('a') },
        'can use <rule "param"> form of rule invocation in grammar';
}

done;

# vim: ft=perl6 expandtab sw=4
