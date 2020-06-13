use v6;
use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/4865
my $lib-path = $?FILE.IO.parent(2).add('packages/RT126904/lib').absolute;

my $proc = run $*EXECUTABLE, '-I', $lib-path, '-e',
  'use Woohoo::Foo::Bar; use Woohoo::Foo::Baz; my Woohoo::Foo::Bar $bar;',
  :err;

#?rakudo.jvm todo 'Missing serialize function for REPR ContextRef'
is($proc.err.slurp, '', "compilation errors");

# vim: expandtab shiftwidth=4
