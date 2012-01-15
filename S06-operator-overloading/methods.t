use Test;
BEGIN { @*INC.push: 't/spec/packages' };
use Test::Util;
plan 3;

# tests related to postcircumfix:<{ }> and other stuff

class A {
    has %!attrs;
    method postcircumfix:<{ }>($key) { %!attrs{$key} }
};

# RT #69612
#?rakudo todo 'nom regression'
#?niecza todo
is A.new(:attrs({ foo => "bar" }))<foo>,
    'bar', 'custom postcircumfix{ } is tied to the right class';

# RT #70922
#?niecza todo "I think niecza may be doing this correctly, but it's hidden in other warnings"
is_run 'class A { method postcircumfix:<{ }>() {} }; my &r = {
my $a }; if 0 { if 0 { my $a } }',
   {status => 0, err => '' },
   'custom postcircumfix{ } does not lead to warnings';

# RT #69438
eval_lives_ok q[
class B {
method postcircumfix:<{ }>($table) {
}
}

{
1;
}
], 'custom postcircumfix{ } with weird whitespacing does not require ;';
