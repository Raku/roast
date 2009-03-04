use v6;

use Test;
plan 5;

# TODO: needs specs and smartlinks

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


# vim: ft=perl6
