use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 40;

# Tests for IO::CatHandle class

sub make-files (*@content) {
    my @ret = @content.map: -> $content { make-temp-file :$content }

    # Create a random mix of IO::Paths and IO::Handles
    @ret[$_] .= open for @ret.keys.pick: */3;
    @ret
}

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
    plan 3;

    my @files = make-files 'a'..'z';
    my $cat = IO::CatHandle.new: @files;
    cmp-ok @files.grep(IO::Handle).grep(*.opened).elems, '>', 0,
        'we have some IO::Handles that are open before calling .close';
    is-deeply $cat.close, True, '.close returns True';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        'all of original IO::Handles got closed';
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
    plan 3;
    my $exp = ('a'..'z').list.Seq;
    sub files { make-files ('a'..'z').rotor(6, :partial)».join: "\n" }

    is-deeply IO::CatHandle.new(files).lines,      $exp,         'no arg';
    is-deeply IO::CatHandle.new(files).lines(500), $exp,         '$limit 500';
    is-deeply IO::CatHandle.new(files).lines(5),   $exp.head(5), '$limit 5';
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

    my $fh = my class Foo is IO::CatHandle {}.new;
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
