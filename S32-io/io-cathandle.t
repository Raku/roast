use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

plan 28;

# Tests for IO::CatHandle class

sub make-files (*@content) {
    my @ret = @content.map: {
        when IO::Handle { $_ }
        make-temp-file content => $_
    }

    # Create a random mix of IO::Paths and IO::Handles
    @ret[$_] .= open for @ret.keys.pick: [max] 1, @ret/3;

    # Make some of the items Str objects
    @ret[$_] .= IO .= absolute for @ret.keys.pick: [max] 1, @ret/3;
    @ret
}

subtest 'chomp method and nl-in method' => {
    plan 4;

    my $cat = IO::CatHandle.new:
        make-files "0\n1\r\n2Z\n3V4", '', "5\nZ6\r\n♥7♥";
    (my $lines = $cat.lines).cache;

    is-deeply $lines[^2], ("0", "1"), 'default';

    $cat.chomp = False;
    $cat.nl-in = [<Z V>];
    is-deeply $lines[2, 3], ("2Z", "\n3V"), 'changed';

    is-deeply $lines[4, 5], ("4", "5\nZ"), 'attributes get set on next handles';

    $cat.chomp = True;
    $cat.nl-in = '♥';
    #?rakudo.jvm todo 'got: $("6\r\n", "7")'
    is-deeply $lines[6, 7], ("6\n", "7"), 'can set .nl-in to a string';

    $cat.close;
}

subtest 'close method' => {
    plan 4;

    my @files = make-files 'a'..'z';
    my $cat = IO::CatHandle.new: @files;
    cmp-ok @files.grep(IO::Handle).grep(*.opened).elems, '>', 0,
        'we have some IO::Handles that are open before calling .close';
    is-deeply $cat.close, True, '.close returns True';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        'all of original IO::Handles got closed';

    is-deeply $cat.slurp, Nil,
        'all the handles get removed and active handle is niled';
}

subtest 'comb method' => {
    sub cat { IO::CatHandle.new: make-files 'fo♥', 'b♥r', 'meow' }
    my $str = 'fo♥b♥rmeow';
    my @tests = \(), \(''), \('♥'), \('♥', 2), \(0), \(1), \(5), \(1000),
        \(2, 3), \(/../), \(/../, 2), \(/<:alpha>/, 3);
    plan +@tests;

    #?rakudo.jvm skip 'Type check failed in binding to parameter $size; expected Int but got Str ("")'
    #?DOES 12
    is-deeply cat.comb(|$_), $str.comb(|$_), .perl for @tests;
}

subtest 'DESTROY method' => {
    plan 3;

    my @files = make-files 'a'..'z';
    my $cat = IO::CatHandle.new: @files;
    cmp-ok @files.grep(IO::Handle).grep(*.opened).elems, '>', 0,
        'we have some IO::Handles that are open before calling .DESTROY';

    $cat.DESTROY;
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        'all of original IO::Handles got closed';

    is-deeply $cat.slurp, Nil,
        'all the handles get removed and active handle is niled';
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
        #?rakudo.jvm emit ## Unsupported VM encoding 'utf8-c8'
        .encoding: 'utf8-c8';
        #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
        is-deeply .readchars(1), Buf.new(200).decode('utf8-c8'), 'utf8-c8';
        .close;
    }

    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
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
        #?rakudo todo 'RT 131365'
        is-deeply @res, [
            "a\x[308]\x[308]\x[308]", "\n", "\x[308]\x[308]", "\n",
            "\x[308]", "c", "\x[308]", "a", "♥", "b\x[308]", "♥", "c", "♥"
        ], '.getc on text with combiners';
    }
}

subtest 'gist method' => {
    plan 5;
    is-deeply IO::CatHandle    .gist, '(CatHandle)', 'type object';
    is-deeply IO::CatHandle.new.gist,  'IO::CatHandle(closed)',
        'instantiated with no handles';

    my @files = make-files <foo bar>;
    my @paths = map *.IO, @files;
    my $cat = IO::CatHandle.new: @files;
    is-deeply $cat.gist, "IO::CatHandle(opened on @paths[0].gist())",
        'opened, first handle';
    $cat.read: 4;
    is-deeply $cat.gist, "IO::CatHandle(opened on @paths[1].gist())",
        'opened, second handle';
    $cat.read: 4;
    is-deeply $cat.gist, 'IO::CatHandle(closed)', 'after exhausting handles';
}

subtest 'IO method' => {
    plan 4;

    my @files = make-files <foo bar ber>;
    my @paths = map *.IO, @files;
    my $cat = IO::CatHandle.new: @files;
    is-deeply $cat.IO, @paths[0], '1';
    $cat.read: 4;
    is-deeply $cat.IO, @paths[1], '2';
    $cat.read: 4;
    is-deeply $cat.IO, @paths[2], '3';
    $cat.read: 1000;
    is-deeply $cat.IO, Nil, '4';
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

# subtest 'lock method' => {
#
#    This method is tested in S32-io/lock.t
#
# }

subtest 'native-descriptor method' => {
    plan 5;
    my @handles = map { make-temp-file(:content($_)).open }, <foo bar ber>;
    my $cat = IO::CatHandle.new: @handles, make-temp-file :content<meow>;
    is-deeply $cat.native-descriptor, @handles[0].native-descriptor, '1';
    $cat.read: 4;
    is-deeply $cat.native-descriptor, @handles[1].native-descriptor, '2';
    $cat.read: 4;
    is-deeply $cat.native-descriptor, @handles[2].native-descriptor, '3';
    $cat.read: 4;
    isa-ok $cat.native-descriptor, Int;
    $cat.read: 10000;
    is-deeply $cat.native-descriptor, Nil, 'after exhausting handles';
}

subtest 'new method' => {
    plan 3;
    isa-ok IO::CatHandle.new(make-files 'foo'),
        IO::CatHandle, '.new';

    my $fh = my class Foo is IO::CatHandle {}.new: make-files 'foo';
    isa-ok $fh, Foo,           '.new of subclass returns subclass';
    isa-ok $fh, IO::CatHandle, 'instantiated subclass is a CatHandle';
}

subtest 'next-handle method' => {
    plan 11;

    my $i = 0;
    my $cat = IO::CatHandle.new: :on-switch{ $i++ }, make-files <a b c d e f g>;

    # note .readchars below does not switch to next handle. Even though we
    # reached eof on a currrent handle, we didn't yet ask for more stuff to
    # cause the a handle to switch.
    isa-ok    $cat.next-handle,  IO::Handle, '1';
    is-deeply $cat.readchars(1), 'b',        '2';
    isa-ok    $cat.next-handle,  IO::Handle, '3';
    isa-ok    $cat.next-handle,  IO::Handle, '4';
    is-deeply $cat.readchars(1), 'd',        '5';
    isa-ok    $cat.next-handle,  IO::Handle, '6';
    isa-ok    $cat.next-handle,  IO::Handle, '7';
    isa-ok    $cat.next-handle,  IO::Handle, '8';
    is-deeply $cat.next-handle,  Nil,        '9';
    is-deeply $cat.next-handle,  Nil,        '10';

    # 8 explicit calls above + 1 more during .new
    is-deeply $i, 9, '.next-handle causes .on-switch callable to be called';
}

## please note: I had to add an block around subtest in order to fudge for jvm
#?rakudo.jvm skip "Method 'sink' not found for invocant of class 'BOOTIO'"
#?DOES 1
{
 subtest 'on-switch method' => {
    plan 11;

    {
        my $ln;
        my $dir = make-temp-dir;
        (my $f1 = $dir.add: 'f1').spurt: "a\nb\nc";
        (my $f2 = $dir.add: 'f2').spurt: "d\ne\n";
        (my $f3 = $dir.add: 'f3').spurt: "f\ng\nh\ni";
        my $cat = IO::CatHandle.new: :on-switch(-> { $ln = 1 }), $f1, $f2, $f3;

        my $res = gather for $cat.lines {
            take $_ => [$ln++, $cat.path.basename]
        }
        is-deeply $res, (
            "a" => [1, 'f1'], "b" => [2, 'f1'], "c" => [3, 'f1'],
            "d" => [1, 'f2'], "e" => [2, 'f2'],
            "f" => [1, 'f3'], "g" => [2, 'f3'], "h" => [3, 'f3'],
            "i" => [4, 'f3'],
        ).Seq, "can count files' line numbers (.count 0)"
    }

    {
        my $cat = IO::CatHandle.new: :on-switch{
            $_ and .seek: 1, SeekFromBeginning;
        }, make-files <foo bar ber>;
        is-deeply $cat.lines, <oo ar er>.Seq, '.count 1';
    }

    {
        my @stuff;
        my $cat = IO::CatHandle.new: :on-switch(-> $new, $old {
            $new and $new.seek: 1, SeekFromBeginning;
            $old and @stuff.push: $old.open.slurp: :close;
        }), make-files <foo bar ber>;
        is-deeply $cat.lines, < oo  ar  er>.Seq, '.count 2 (first arg)';
        is-deeply @stuff,    [<foo bar ber>],    '.count 2 (second arg)';
    }

    {
        my @stuff;
        my $cat = IO::CatHandle.new: :on-switch({
            my ($new, $old) := @_; # bind to unpack and check we only got 2 args
            $new and $new.seek: 1, SeekFromBeginning;
            $old and @stuff.push: $old.open.slurp: :close;
        }), make-files <foo bar ber>;
        is-deeply $cat.lines, < oo  ar  er>.Seq, '.count Inf (first arg)';
        is-deeply @stuff,    [<foo bar ber>],    '.count Inf (second arg)';
    }

    subtest 'can change .on-switch by assigning to attribute' => {
        plan 5;

        my $cat = IO::CatHandle.new: make-files <foo bar ber moo>;
        my @res;
        $cat.on-switch = { @res.push: 'here' };
        $cat.read: 4;
        is-deeply @res, ['here'], 'first change';

        $cat.on-switch = -> $ { @res.push: 'there' };
        $cat.read: 4;
        is-deeply @res, [<here there>], 'second change';

        $cat.on-switch = -> $, $ { @res.push: 'meows' };
        $cat.read: 4;
        is-deeply @res, [<here there meows>], 'third change';

        $cat.on-switch = { $ = @_; @res.push: 'moos' };
        $cat.read: 4;
        is-deeply @res, [<here there meows moos>], 'fourth change';
        $cat.close;

        @res = ();
        $cat = IO::CatHandle.new: :on-switch{ @res.push: 'bars' },
            make-files <foo bar>;
        $cat.on-switch = { @res.push: '♥' }
        $cat.read: 4;
        is-deeply @res, [<bars ♥>],
            'can change attribute after setting it via .new';
    }

    {
        my $i = 0;
        my $first;
        my $last;
        IO::CatHandle.new(on-switch => -> \active, \old {
              $first := old unless $++;
              $last  := active if ++$ == 6;
              $i++;
          }, make-files <a b c d e>).slurp;
        is-deeply $i, 6, 'on-switch gets called $handles + 1 number of times';
        is-deeply $first, Nil, 'second arg on first iteration is Nil';
        is-deeply $last,  Nil, 'first arg on last iteration is Nil';
    }

    {
        my $args;
        my $cat = IO::CatHandle.new: on-switch => -> \a, \b { $args = (a, b) },
            make-files <a b c>;
        $cat.slurp;
        $cat.next-handle;
        is-deeply $args, (Nil, Nil),
            '.on-switch an iteration after handle exhaustion has Nil args'
    }
 }
}

subtest 'open method' => {
    plan 4;

    my $cat = IO::CatHandle.new;
    is-deeply $cat.open, $cat, 'after instantiation (no handles)';

    $cat = IO::CatHandle.new: make-files <foo bar>;
    is-deeply $cat.open, $cat, 'after instantiation';

    $cat.read: 4;
    is-deeply $cat.open, $cat, 'second handle';

    $cat.read: 4000;
    is-deeply $cat.open, $cat, 'after exhausting all handles';
}

subtest 'opened method' => {
    plan 4;

    my $cat = IO::CatHandle.new;
    is-deeply $cat.opened, False, 'after instantiation (no handles)';

    $cat = IO::CatHandle.new: make-files <foo bar>;
    is-deeply $cat.opened, True, 'after instantiation';

    $cat.read: 4;
    is-deeply $cat.opened, True, 'second handle';

    $cat.read: 4000;
    is-deeply $cat.opened, False, 'after exhausting all handles';
}

subtest 'path method' => {
    plan 4;

    my @files = make-files <foo bar ber>;
    my @paths = map *.IO, @files;
    my $cat = IO::CatHandle.new: @files;
    is-deeply $cat.IO, @paths[0], '1';
    $cat.read: 4;
    is-deeply $cat.IO, @paths[1], '2';
    $cat.read: 4;
    is-deeply $cat.IO, @paths[2], '3';
    $cat.read: 1000;
    is-deeply $cat.IO, Nil, '4';
}

subtest 'perl method' => {
    plan 8;

    is-deeply IO::CatHandle    .perl.EVAL, IO::CatHandle,     'type object';
    is-deeply IO::CatHandle.new.perl.EVAL, IO::CatHandle.new, 'no args';

    my $cat = IO::CatHandle.new: make-files <a b c>;
    is-deeply $cat.perl.EVAL, $cat, 'just handles';

    $cat = IO::CatHandle.new: :bin, make-files <a b c>;
    is-deeply $cat.perl.EVAL, $cat, ':bin';

    #?rakudo.jvm emit # Unsupported VM encoding 'utf8-c8'
    $cat = IO::CatHandle.new: :encoding<utf8-c8>, make-files <a b c>;
    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
    is-deeply $cat.perl.EVAL, $cat, ':encoding';

    #?rakudo.jvm emit # Unsupported VM encoding 'utf8-c8'
    $cat = IO::CatHandle.new: :encoding<utf8-c8>, :nl-in<foo bar>, make-files <a b c>;
    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
    is-deeply $cat.perl.EVAL, $cat, ':encoding + :nl-in';

    #?rakudo.jvm emit # Unsupported VM encoding 'utf8-c8'
    $cat = IO::CatHandle.new: :encoding<utf8-c8>, :nl-in<foo bar>, :!chomp, make-files <a b c>;
    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
    is-deeply $cat.perl.EVAL, $cat, ':encoding + :nl-in + :!chomp';

    #?rakudo.jvm emit # Unsupported VM encoding 'utf8-c8'
    $cat = IO::CatHandle.new: :encoding<utf8-c8>, :nl-in<foo bar>, :!chomp;
    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
    is-deeply $cat.perl.EVAL, $cat, ':encoding, :nl-in, :!chomp and no handles';
}

subtest 'read method' => {
    plan 3;
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

    # https://irclog.perlgeek.de/perl6-dev/2017-06-13#i_14728193
    is-deeply IO::CatHandle.new(make-temp-file(:content<foo>)).read,
        buf8.new('foo'.encode),
    'IO::CatHandle.read has some reasonable size default value';
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

subtest 'seek method and tell method' => {
    plan 5;

    is-deeply IO::CatHandle.new.seek, Nil, '.seek on zero-handle cat';
    is-deeply IO::CatHandle.new.tell, Nil, '.tell on zero-handle cat';

    subtest 'SeekFromBeginning' => { plan 3;
        my $cat = IO::CatHandle.new: :bin, make-files <foo bar ber meow>;

        $cat.seek: 1, SeekFromBeginning;
        is-deeply $cat.read(3).decode, 'oob', 'first handle';

        $cat.seek: 1000, SeekFromBeginning;
        is-deeply $cat.read(4).decode, 'berm',
            "seeking past handle's end does not switch handles";

        throws-like { $cat.seek: -3, SeekFromBeginning }, Exception,
            'seeking earlier than beginning of active handle throws';
    }

    subtest 'SeekFromCurrent' => { plan 4;
        my $cat = IO::CatHandle.new: :bin, make-files <foo bar ber meow>;

        $cat.seek: 1, SeekFromCurrent;
        is-deeply $cat.read(3).decode, 'oob', 'first handle';

        $cat.seek: -1, SeekFromCurrent;
        is-deeply $cat.read(4).decode, 'barb', 'first handle';

        $cat.seek: 1000, SeekFromCurrent;
        is-deeply $cat.read(3).decode, 'meo',
            "seeking past handle's end does not switch handles";

        throws-like { $cat.seek: -5, SeekFromCurrent }, Exception,
            'seeking earlier than beginning of active handle throws';
    }

    subtest 'SeekFromEnd' => { plan 3;
        my $cat = IO::CatHandle.new: :bin, make-files <foo bar ber meow>;

        $cat.seek: -1, SeekFromEnd;
        is-deeply $cat.read(3).decode, 'oba', 'first handle';

        $cat.seek: 1000, SeekFromEnd;
        is-deeply $cat.read(4).decode, 'berm',
            "seeking past handle's end does not switch handles";

        throws-like { $cat.seek: -5, SeekFromEnd }, Exception,
            'seeking earlier than beginning of active handle throws';
    }
}

subtest 'slurp method' => {
    plan 4;
    my @data = "ab\ncd♥\n", "I ♥ Perl 6", "", "foos";
    sub files { make-files @data }

    is-deeply IO::CatHandle.new(files).slurp, @data.join, 'non-binary';
    #?rakudo.jvm todo 'problem with equivalence of Buf objects, RT #128041'
    is-deeply IO::CatHandle.new(files, :bin).slurp,
        Buf[uint8].new(@data.join.encode), 'binary';

    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
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
    plan 4;

    my @files = make-files <foo bar ber>;
    my @paths = map *.IO, @files;
    my $cat = IO::CatHandle.new: @files;
    is-deeply $cat.Str, @paths[0].Str, '1';
    $cat.read: 4;
    is-deeply $cat.Str, @paths[1].Str, '2';
    $cat.read: 4;
    is-deeply $cat.Str, @paths[2].Str, '3';

    # Don't spec the exact content of .Str on closed handle
    # (Rakudo tests in own test suite):
    $cat.read: 1000;
    isa-ok $cat.Str, Str, '4';
}

#?rakudo.jvm skip 'UnwindException'
#?DOES 1
{
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
        #?rakudo.jvm emit # Unsupported VM encoding 'utf8-c8'
        my $str = ([~] @bits).decode: 'utf8-c8';
        #?rakudo.moar 4 todo 'readchars reads wrong num of chars RT131383'
        #?rakudo.jvm 4 skip "Unsupported VM encoding 'utf8-c8'"
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
}

subtest 't method' => {
    plan 4;
    my $tty = do {
        my $tt = shell :out, :err, 'tty';
        if $tt and (my $path = $tt.out.slurp(:close).trim)
          and $path ne 'not a tty' {
            $path.IO.open;
        }
        else {
            make-temp-file(:content<foo>).open
        }
    }

    my $cat = IO::CatHandle.new: make-files 'foo', $tty, 'bar';
    is-deeply $cat.t, False,  '1';
    $cat.next-handle;
    is-deeply $cat.t, $tty.t, '2';
    $cat.next-handle;
    is-deeply $cat.t, False,  '3';
    $cat.next-handle;
    is-deeply $cat.t, False,  'after exhausting handles';
    $cat.close;
}

# subtest 'lock method' => {
#
#    This method is tested in S32-io/lock.t
#
# }

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
