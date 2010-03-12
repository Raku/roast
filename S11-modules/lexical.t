use v6;
use Test;
plan 2;

{
    use t::spec::packages::S11-modules::Foo;
    eval_lives_ok 'foo()', 'imported sub from module';
}
eval_dies_ok 'foo()', 'sub is only imported into the inner lexical scope';
