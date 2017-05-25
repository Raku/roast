use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 35;

# Tests for IO::CatHandle class

sub make-files (*@content) {
    my @ret = @content.map: -> $content { make-temp-file :$content }

    # Create a random mix of IO::Paths and IO::Handles
    @ret[$_] .= open for @ret.keys.pick: */3;
    @ret
}

subtest '$.path attribute' => {
    plan 0;
}

subtest '$.chomp attribute' => {
    plan 0;
}

subtest '$.nl-in attribute' => {
    plan 0;
}

subtest '$.nl-out attribute' => {
    plan 0;
}

subtest '$.encoding attribute' => {
    plan 0;
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
    plan 0;
}

subtest 'DESTROY method' => {
    plan 0;
}

subtest 'encoding method' => {
    plan 0;
}

subtest 'eof method' => {
    plan 0;
}

subtest 'flush method' => {
    plan 0;
}

subtest 'get method' => {
    plan 3;
    {
        my $cat = IO::CatHandle.new:
            make-files ('a'..'z').rotor(6, :partial)».join: "\n";
        my @res; @res.push($_) while ($_ = $cat.get).DEFINITE;
        is-deeply @res,     ['a'..'z'], '.get with defaults';
        is-deeply $cat.get, Nil,        '.get on exhausted handle';
    }
    {
        my $fh1 = make-temp-file(content => "a\nb\nc").open: :!chomp;
        my $fh2 = make-temp-file(content => "a♥b♥c♥" ).open: :nl-in<♥>;
        my $cat = IO::CatHandle.new: $fh1, $fh2;
        my @res; @res.push($_) while ($_ = $cat.get).DEFINITE;
        is-deeply @res, ["a\n", "b\n", "c", "a", "b", "c"],
            '.get with handles set to different chomp/nl-in attributes';
    }
}

subtest 'getc method' => {
    plan 4;
    {
        my $cat = IO::CatHandle.new:
            make-files ('a'..'z').rotor(6, :partial)».join;
        my @res; @res.push($_) while ($_ = $cat.getc).DEFINITE;
        is-deeply @res,     ['a'..'z'], '.getc on handle-path mix';
        is-deeply $cat.getc, Nil,       '.getc on exhausted cat handle';
        is-deeply [$cat.getc xx 10], [Nil xx 10],
            '.getc on exhausted cat handle continues giving Nil';
    }
    {
        my $fh1 = make-temp-file
            content => "a\x[308]\x[308]\x[308]\n\x[308]\x[308]\n\x[308]c";
        # start file with a combiner to test it doesn't get combined with
        # previous file's content
        my $fh2 = make-temp-file content => "\x[308]a♥b\x[308]♥c♥";
        my $cat = IO::CatHandle.new: $fh1, $fh2;
        my @res; @res.push($_) while ($_ = $cat.getc).DEFINITE;
        #?rakudo.moar todo 'RT 131365'
        is-deeply @res, [
            "a\x[308]\x[308]\x[308]", "\n", "\x[308]\x[308]", "\n",
            "\x[308]", "c", "\x[308]", "a", "♥", "b\x[308]", "♥", "c", "♥"
        ], '.getc on text with combiners';
    }
}

subtest 'gist method' => {
    plan 0;
}

subtest 'IO method' => {
    plan 0;
}

subtest 'lines method' => {
    plan 13;
    my $exp = ('a'..'z').list.Seq;
    sub files { make-files ('a'..'z').rotor(6, :partial)».join: "\n" }

    is-deeply IO::CatHandle.new(files).lines,      $exp,         'no arg';
    is-deeply IO::CatHandle.new(files).lines(500), $exp,         '$limit 500';
    is-deeply IO::CatHandle.new(files).lines(5),   $exp.head(5), '$limit 5';

    my @files = files;
    is-deeply IO::CatHandle.new(@files).lines(0), $exp.head(0),
        '$limit 0 (return value)';
    is-deeply @files.grep(IO::Handle).grep(*.opened.not).elems, 0,
        '$limit 0 (all opened handles remained open)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).lines(:close), $exp,
        ':close arg (return value)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        ':close arg (all opened handles got closed)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).lines(500, :close), $exp,
        '$limit 500, :close arg (return value)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 500, :close arg (all opened handles got closed)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).lines(5, :close), $exp.head(5),
        '$limit 5, :close arg (return value)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 5, :close arg (all opened handles got closed)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).lines(0, :close), $exp.head(0),
        '$limit 0, :close arg (return value)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 0, :close arg (all opened handles got closed)';
}

subtest 'lock method' => {
    plan 0;
}

subtest 'native-descriptor method' => {
    plan 0;
}

subtest 'new method' => {
    plan 3;
    isa-ok IO::CatHandle.new(make-files 'foo'),
        IO::CatHandle, '.new';

    my $fh = my class Foo is IO::CatHandle {}.new: make-files 'foo';
    isa-ok $fh, Foo,           '.new of subclass returns subclass';
    isa-ok $fh, IO::CatHandle, 'instantiated subclass is a CatHandle';
}

subtest 'nl-in method' => {
    plan 0;
}

subtest 'open method' => {
    plan 0;
}

subtest 'opened method' => {
    plan 0;
}

subtest 'path method' => {
    plan 0;
}

subtest 'read method' => {
    plan 0;
}

subtest 'readchars method' => {
    plan 0;
}

subtest 'seek method' => {
    plan 0;
}

subtest 'slurp method' => {
    plan 0;
}

subtest 'slurp-rest method' => {
    plan 0;
}

subtest 'split method' => {
    plan 0;
}

subtest 'Str method' => {
    plan 0;
}

subtest 'Supply method' => {
    plan 0;
}

subtest 't method' => {
    plan 0;
}

subtest 'tell method' => {
    plan 0;
}

subtest 'unlock method' => {
    plan 0;
}

subtest 'words method' => {
    plan 13;
    my $exp = ('a'..'z').list.Seq;
    sub files { make-files ('a'..'z').rotor(6, :partial)».join: " " }

    is-deeply IO::CatHandle.new(files).words,      $exp,         'no arg';
    is-deeply IO::CatHandle.new(files).words(500), $exp,         '$limit 500';
    is-deeply IO::CatHandle.new(files).words(5),   $exp.head(5), '$limit 5';

    my @files = files;
    is-deeply IO::CatHandle.new(@files).words(0), $exp.head(0),
        '$limit 0 (return value)';
    is-deeply @files.grep(IO::Handle).grep(*.opened.not).elems, 0,
        '$limit 0 (all opened handles remained open)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).words(:close), $exp,
        ':close arg (return value)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        ':close arg (all opened handles got closed)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).words(500, :close), $exp,
        '$limit 500, :close arg (return value)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 500, :close arg (all opened handles got closed)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).words(5, :close), $exp.head(5),
        '$limit 5, :close arg (return value)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 5, :close arg (all opened handles got closed)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).words(0, :close), $exp.head(0),
        '$limit 0, :close arg (return value)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 0, :close arg (all opened handles got closed)';
}

# vim: ft=perl6 expandtab sw=4
