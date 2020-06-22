use v6;
use Test;
plan 8;

# L<S04/The Relationship of Blocks and Declarations/"If you declare a lexical
#  twice in the same scope">

# https://github.com/Raku/old-issue-tracker/issues/2348
eval-lives-ok 'my $x; my $x',
              'it is legal to declare my $x twice in the same scope.';

eval-lives-ok 'state $x; state $x',
              'it is legal to declare state $x twice in the same scope.';

# https://github.com/rakudo/rakudo/issues/3102
# https://github.com/rakudo/rakudo/issues/2909
eval-lives-ok 'no worries; sub foo( :$input ) { my $input //= 1; }',
              'no error to declare a variable that is also a parameter';

{
    my $x = 2;
    my $y := $x;
    my $x = 3;
    is $y, 3, 'Two lexicals with the name in same scope are the same variable';
}

# this is not exactly S04 material
throws-like 'sub foo {1; }; sub foo($x) {1; };', X::Redeclaration,
    'multiple declarations need multi or proto';

throws-like 'only sub foo {1; }; sub foo($x) {1; };', X::Redeclaration,
    'multiple declarations need multi or proto';

# https://github.com/Raku/old-issue-tracker/issues/3175
throws-like 'sub foo {1; }; sub foo($x) {1; };', X::Redeclaration,
    :message{.contains: 'multi'}, 'suggest multi-sub for sub redeclaration';

throws-like 'role RR { }; class RR { };', X::Redeclaration,
    :message{not .contains: 'multi'},
    "don't suggest multi-sub for non-sub redeclaration";

# vim: expandtab shiftwidth=4
