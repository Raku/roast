use v6;
use Test;
plan 8;

# L<S04/The Relationship of Blocks and Declarations/"If you declare a lexical 
#  twice in the same scope">

# RT #83430
eval-lives-ok 'my $x; my $x', 
              'it is legal to declare my $x twice in the same scope.';

eval-lives-ok 'state $x; state $x', 
              'it is legal to declare state $x twice in the same scope.';

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

#?niecza todo "MMD"
#?rakudo todo 'nom regression RT #125053'
eval-lives-ok 'proto foo {1; }; sub foo {1; }; sub foo($x) {1; };',
             'multiple declarations need multi or proto';

# RT #118607
throws-like 'sub foo {1; }; sub foo($x) {1; };', X::Redeclaration,
    'suggest multi-sub for sub redeclaration', message => /'did you mean to declare a multi-sub'/;

throws-like 'role RR { }; class RR { };', X::Redeclaration,
    "don't suggest multi-sub for non-sub redeclaration", message => /^ [<!before 'multi-sub'> . ] * $/;

# vim: ft=perl6
