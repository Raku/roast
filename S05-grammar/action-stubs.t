use v6;

use Test;

plan 11;

# L<S05/Grammars/"and optionally pass an action object">

grammar A::Test::Grammar {
    rule  TOP { <a> <b> }
    token a   { 'a' \w+ {*} }
    token b   { 'b' \w+ {*} }
}

class An::Action1 {
    has $.in-a = 0;
    has $.in-b = 0;
    has $.calls = '';
    method a($/) {
        $!in-a++;
        $!calls ~= 'a';
    }
    method b($x) {
        $!in-b++;
        $!calls ~= 'b';
    }
}

ok A::Test::Grammar.parse('alpha beta'), 'basic sanity: .parse works';
my $action = An::Action1.new();
lives_ok { A::Test::Grammar.parse('alpha beta', :action($action)) },
        'parse with :action (and no make) lives';
is $action.in-a, 1, 'first action has been called';
is $action.in-b, 1, 'second action has been called';
is $action.calls, 'ab', '... and in the right order';

# L<S05/Bracket rationalization/"An explicit reduction using the make function">

{
    grammar Grammar::More::Test {
        rule TOP { <a> <b><c> {*} }
        token a { \d+ {*} }
        token b { \w+ {*} }
        token c { '' }      # no action stub
    }
    class Grammar::More::Test::Actions {
        method TOP($/) {
            make [ $<a>.ast, $<b>.ast ];
        }
        method a($/) {
            make 3 + $/;
        }
        method b($/) {
            # the given/when is pretty pointless, but rakudo
            # used to segfault on it, so test it here
            # http://rt.perl.org/rt3/Ticket/Display.html?id=64208
            given 2 {
                when * {
                    make $/ x 3;
                }
            }
        }
        method c($/) {
            die "don't come here";
        }
    }

    # there's no reason why we can't use the actions as class methods
    ok Grammar::More::Test.parse('39 b', :action(Grammar::More::Test::Actions)),
    'grammar matches';
    isa_ok $/.ast, Array, '$/.ast is an Array';
    ok $/.ast.[0] == 42,  'make 3 + $/ worked';
    is $/.ast.[1], 'bbb',  'make $/ x 3 worked';
}

# used to be a Rakudo regression, RT #64104
{
    grammar Math {
        token TOP { ^ <value> $ {*} }
        token value { \d+ {*} }
    }
    class Actions {
        method value($/) { make 1..$/};
        method TOP($/)   { make 1 + $/<value>};
    }
    ok Math.parse('234', :action(Actions.new)),
       'can parse with action stubs that make() regexes';
    is $/.ast, 235, 'got the right .ast';

}
# vim: ft=perl6
