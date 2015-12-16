use v6;
use Test;

plan 1;

my $proc = run 'perl6', '-I', 't/spec/packages/RT126904/lib', '-e',
  'use Woohoo::Foo::Bar; use Woohoo::Foo::Baz; my Woohoo::Foo::Bar $bar;',
  :err;

is($proc.err.slurp-rest, '', "compilation errors");

# vim: ft=perl6
