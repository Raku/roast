use v6;
use Test;

plan 1;

my $proc = run $*EXECUTABLE, '-I', 't/spec/packages/RT126904/lib', '-e',
  'use Woohoo::Foo::Bar; use Woohoo::Foo::Baz; my Woohoo::Foo::Bar $bar;',
  :err;

#?rakudo.jvm todo 'Missing serialize function for REPR ContextRef'
is($proc.err.slurp-rest, '', "compilation errors");

# vim: ft=perl6
