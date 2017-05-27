use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 34;

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
    sub cat { IO::CatHandle.new: make-files 'fo♥', 'b♥r', 'meow' }
    my $str = 'fo♥b♥rmeow';
    my @tests = \(), \(''), \('♥'), \('♥', 2), \(0), \(1), \(5), \(1000),
        \(2, 3), \(/../), \(/../, 2), \(/<:alpha>/, 3);
    plan +@tests;

    is-deeply cat.comb(|$_), $str.comb(|$_), .perl for @tests;
}

subtest 'DESTROY method' => {
    plan 0;
}

subtest 'encoding method' => {
    plan 4;
    is-deeply IO::CatHandle.new.encoding, 'utf8', 'default';
    is-deeply IO::CatHandle.new(:encoding<utf8-c8>).encoding, 'utf8-c8',
      'can change via .new';

    subtest 'can change via .encoding while iterating through handles' => {
        plan 3;

        $_ = IO::CatHandle.new: make-files 'foo', '♥', Buf.new: 200;
        .encoding: 'ascii';
        is-deeply .readchars(3), 'foo', 'ascii';
        .encoding: 'utf8';
        is-deeply .readchars(1), '♥', 'utf8';
        .encoding: 'utf8-c8';
        is-deeply .readchars(1), Buf.new(200).decode('utf8-c8'), 'utf8-c8';
        .close;
    }

    with IO::CatHandle.new {
        .encoding: 'utf8-c8';
        is-deeply .encoding, 'utf8-c8',
            'can change via .encoding when no @handles are left';
    }
}

subtest 'eof method' => {
    plan 8;

    is-deeply IO::CatHandle.new      .eof, True, 'no handles from start';
    is-deeply IO::CatHandle.new(:bin).eof, True, 'no handles from start (bin)';

    subtest 'with 1 handle' => { plan 2;
        with IO::CatHandle.new(make-files 'foo') {
            is-deeply .eof, False, 'before exhausting handle';
            .readchars: 3;
            is-deeply .eof, True,  'after exhausting handle';
        }
    }
    subtest 'with 1 handle (bin)' => { plan 2;
        with IO::CatHandle.new(:bin, make-files 'foo') {
            is-deeply .eof, False, 'before exhausting handle';
            .read: 3;
            is-deeply .eof, True,  'after exhausting handle';
        }
    }
    subtest 'with 2 handles' => { plan 5;
        with IO::CatHandle.new(make-files <foo bar>) {
            is-deeply .eof, False, 'before exhausting handles';
            .readchars: 3;
            is-deeply .eof, False,  'after exhausting first handle';
            .readchars: 1;
            is-deeply .eof, False,  'read a bit of second handle';
            .readchars: 2;
            is-deeply .eof, True,   'after exhausting all handles';
            .readchars: 1000;
            is-deeply .eof, True,   'after read after exhaustion';
        }
    }
    subtest 'with 2 handles (bin)' => { plan 5;
        with IO::CatHandle.new(:bin, make-files <foo bar>) {
            is-deeply .eof, False, 'before exhausting handles';
            .read: 3;
            is-deeply .eof, False,  'after exhausting first handle';
            .read: 1;
            is-deeply .eof, False,  'read a bit of second handle';
            .read: 2;
            is-deeply .eof, True,   'after exhausting all handles';
            .read: 1000;
            is-deeply .eof, True,   'after read after exhaustion';
        }
    }

    # Note: in these tests we're are supposed to get True eof all the time,
    # since the files have no content in them:
    subtest 'with 3 handles to empty files' => { plan 2;
        with IO::CatHandle.new(make-files '', '', '') {
            is-deeply .eof, True, 'before reads';
            .slurp;
            is-deeply .eof, True, 'after reads';
        }
    }
    subtest 'with 3 handles to empty files (bin)' => { plan 2;
        with IO::CatHandle.new(:bin, make-files '', '', '') {
            is-deeply .eof, True, 'before reads';
            .slurp;
            is-deeply .eof, True, 'after reads';
        }
    }
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
        my $fh2 = make-temp-file(content => "a♥b♥c♥" ).open: :nl-in[<a b ♥>];
        my $cat = IO::CatHandle.new: $fh1, $fh2, :!chomp, :nl-in["\n", "♥"];
        my @res; @res.push($_) while ($_ = $cat.get).DEFINITE;
        is-deeply @res, ["a\n", "b\n", "c", "a♥", "b♥", "c♥"],
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
    plan 2;
    subtest 'binary cat' => { plan 4;
        my $cat = IO::CatHandle.new: :bin, make-files Blob.new(1, 2, 3),
            Blob.new(4, 5), Blob.new(6, 7, 8), Blob.new(9, 10, 11, 12, 13, 14);
        is-deeply $cat.read(4),    buf8.new(1, 2, 3, 4),         '1';
        is-deeply $cat.read(5),    buf8.new(5, 6, 7, 8, 9),      '2';
        is-deeply $cat.read(5000), buf8.new(10, 11, 12, 13, 14), '3';
        is-deeply $cat.read(500),  buf8.new,                     '4';
    }
    subtest 'non-binary cat' => { plan 4;
        my $cat = IO::CatHandle.new: make-files Blob.new(1, 2, 3),
            Blob.new(4, 5), Blob.new(6, 7, 8), Blob.new(9, 10, 11, 12, 13, 14);
        is-deeply $cat.read(4),    buf8.new(1, 2, 3, 4),         '1';
        is-deeply $cat.read(5),    buf8.new(5, 6, 7, 8, 9),      '2';
        is-deeply $cat.read(5000), buf8.new(10, 11, 12, 13, 14), '3';
        is-deeply $cat.read(500),  buf8.new,                     '4';
    }
}

subtest 'readchars method' => {
    plan 8;

    throws-like { IO::CatHandle.new(:bin, make-files 'foo').readchars },
        X::IO::BinaryMode, 'binary cat';

    my $cat = IO::CatHandle.new:
        make-files "a♥b\ncd♥\n", "I ♥ Perl 6", "", "foos";

    is-deeply $cat.readchars(4),   "a♥b\n",       '1';
    is-deeply $cat.readchars(10),  "cd♥\nI ♥ Pe", '2';
    is-deeply $cat.readchars(6),   'rl 6fo',      '3';
    is-deeply $cat.readchars,      'os',          '4';
    is-deeply $cat.readchars(100), '',            '5';
    is-deeply $cat.readchars(200), '',            '6';
    is-deeply $cat.readchars,      '',            '7';
}

subtest 'seek method' => {
    plan 0;
}

subtest 'slurp method' => {
    plan 4;
    my @data = "ab\ncd♥\n", "I ♥ Perl 6", "", "foos";
    sub files { make-files @data }

    is-deeply IO::CatHandle.new(files).slurp, @data.join, 'non-binary';
    is-deeply IO::CatHandle.new(files, :bin).slurp,
        Buf[uint8].new(@data.join.encode), 'binary';

    is-deeply IO::CatHandle.new(
        :encoding<utf8-c8>, files, make-temp-file content => Buf.new: 200, 200
    ).slurp,
          Blob[uint8].new(@data.join.encode).decode('utf8-c8')
        ~ Blob[uint8].new(200, 200         ).decode('utf8-c8'),
        ':enc parameter works';

    #?rakudo todo 'malformed 1-char slurp returns empty string RT#131379'
    # RT #131379
    throws-like {
      IO::CatHandle.new(files, make-temp-file content => Buf.new: 200).slurp
    }, Exception, 'file containing single non-valid-UTF8 byte throws in utf8 slurp';
}

subtest 'split method' => {
    sub cat { IO::CatHandle.new: make-files 'fo♥', 'b♥r', 'meow' }
    my $str = 'fo♥b♥rmeow';
    my @tests = \(''), \('♥'), \('♥', 2), \(0), \(1), \(5), \(1000),
        \(2, 3), \(/../), \(/../, 2), \(/<:alpha>/, 3),
        \('', :skip-empty), \('♥', :k), \('♥', :v), \(0, :kv), \(1, :p),
        \(5, :skip-empty, :k), \(1000, :skip-empty, :v),
        \(2, 3, :skip-empty, :kv), \(/../, :skip-empty, :p),
        \(/../, 2, :skip-empty, :p), \(/<:alpha>/, 3, :skip-empty, :kv);
    plan +@tests;

    is-deeply cat.split(|$_), $str.split(|$_), .perl for @tests;
}

subtest 'Str method' => {
    plan 0;
}

subtest 'Supply method' => {
    plan 5;
    my @pieces = 'fo♥', 'b♥r', '', 'meow';
    my $str = [~] @pieces;
    sub cat-supply (
        Capture \cat-args    = \(),
        Capture \supply-args = \(),
        @bits = @pieces,
    ) {
        my @res;
        my IO::CatHandle $cat .= new: |cat-args, make-files @bits;
        react whenever $cat.Supply: |supply-args { @res.push: $_ }
        @res;
    }

    subtest 'binary cat' => { plan 4;
        is-deeply cat-supply(\(:bin)), [buf8.new: $str.encode], 'no args';
        is-deeply cat-supply(\(:bin), \(:2size)), [
            $str.encode.batch(2).map: {buf8.new: $_}
        ], 'size 2';
        is-deeply cat-supply(\(:bin), \(:5size)), [
            $str.encode.batch(5).map: {buf8.new: $_}
        ], 'size 5';
        is-deeply cat-supply(\(:bin), \(:1000size)), [buf8.new: $str.encode],
          'size 1000';
    }
    subtest 'non-binary cat, utf8' => { plan 4;
        #?rakudo.moar 4 todo 'readchars reads wrong num of chars RT131383'
        is-deeply cat-supply,                    [$str],         'no args';
        is-deeply cat-supply(\(), \(:2size)),    [$str.comb: 2], 'size 2';
        is-deeply cat-supply(\(), \(:5size)),    [$str.comb: 5], 'size 5';
        is-deeply cat-supply(\(), \(:1000size)), [$str],         'size 1000';
    }
    subtest 'non-binary cat, utf8-c8' => { plan 4;
        my \c = \(:encoding<utf8-c8>);
        my @bits = buf8.new(200), buf8.new(200, 200), buf8.new(200, 42, 70);
        my $str = ([~] @bits).decode: 'utf8-c8';
        #?rakudo.moar 4 todo 'readchars reads wrong num of chars RT131383'
        is-deeply cat-supply(c, \(         ), @bits), [$str],        'no args';
        is-deeply cat-supply(c, \(:2size   ), @bits), [$str.comb: 2], 'size 2';
        is-deeply cat-supply(c, \(:5size   ), @bits), [$str.comb: 5], 'size 5';
        is-deeply cat-supply(c, \(:1000size), @bits), [$str],      'size 1000';
    }

    {
        my IO::CatHandle $cat .= new: make-files @pieces;
        $cat.slurp;
        my @res;
        react whenever $cat.Supply { @res.push: $_ }
        is-deeply @res, [], 'supply on exhausted cat is empty';
        react whenever $cat.Supply { @res.push: $_ }
        is-deeply @res, [], 'supply on exhausted cat is empty (second call)';
    }
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
