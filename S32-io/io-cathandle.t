use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 40;

# Tests for IO::CatHandle class

subtest '@.handles attribute' => {
    plan 42;
}

subtest '$.path attribute' => {
    plan 42;
}

subtest '$.chomp attribute' => {
    plan 42;
}

subtest '$.nl-in attribute' => {
    plan 42;
}

subtest '$.nl-out attribute' => {
    plan 42;
}

subtest '$.encoding attribute' => {
    plan 42;
}


subtest 'close method' => {
    plan 42;
}

subtest 'comb method' => {
    plan 42;
}

subtest 'DESTROY method' => {
    plan 42;
}

subtest 'encoding method' => {
    plan 42;
}

subtest 'eof method' => {
    plan 42;
}

subtest 'flush method' => {
    plan 42;
}

subtest 'get method' => {
    plan 42;
}

subtest 'getc method' => {
    plan 42;
}

subtest 'gist method' => {
    plan 42;
}

subtest 'IO method' => {
    plan 42;
}

subtest 'lines method' => {
    plan 42;
}

subtest 'lock method' => {
    plan 42;
}

subtest 'native-descriptor method' => {
    plan 42;
}

subtest 'new method' => {
    plan 3;
    isa-ok IO::CatHandle.new, IO::CatHandle, '.new';

    my $fh = my class Foo :: is IO::CatHandle {}.new;
    isa-ok $fh, Foo,           '.new of subclass returns subclass';
    isa-ok $fh, IO::CatHandle, 'instantiated subclass is a CatHandle';
}

subtest 'nl-in method' => {
    plan 42;
}

subtest 'open method' => {
    plan 42;
}

subtest 'opened method' => {
    plan 42;
}

subtest 'path method' => {
    plan 42;
}

subtest 'read method' => {
    plan 42;
}

subtest 'readchars method' => {
    plan 42;
}

subtest 'seek method' => {
    plan 42;
}

subtest 'slurp method' => {
    plan 42;
}

subtest 'slurp-rest method' => {
    plan 42;
}

subtest 'split method' => {
    plan 42;
}

subtest 'Str method' => {
    plan 42;
}

subtest 'Supply method' => {
    plan 42;
}

subtest 't method' => {
    plan 42;
}

subtest 'tell method' => {
    plan 42;
}

subtest 'unlock method' => {
    plan 42;
}

subtest 'words method' => {
    plan 42;
}

# vim: ft=perl6 expandtab sw=4
