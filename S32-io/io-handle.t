use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 30;

my $path = "io-handle-testfile";

##
# Test that we flush when we close
{
    my $fh = $path.IO.open(:w);
    $fh.print("42");
    $fh.close;
    is slurp($path), "42", "buffer is flushed when IO handle is closed";
}

# https://github.com/Raku/old-issue-tracker/issues/3693
{
    $path.IO.spurt("A+B+C+D+");
    my $RT123888 = $path.IO.open(:r);
    $RT123888.nl-in = "+";
    is $RT123888.lines, <A B C D>, "Changing input-line-separator works for .lines";
}

try { unlink $path }

CATCH {
    try { unlink $path; }
}

if $path.IO.e {
    say "Warn: '$path shouldn't exist";
    unlink $path;
}

with IO::Handle.new(:path('foo')) {
    isa-ok    .path,     IO::Path, '.path turns Str :path to IO::Path';
    is-deeply .path.Str, 'foo',    '.path has right value (Str :path)';
    isa-ok      .IO,     IO::Path, '.IO turns Str :path to IO::Path';
    is-deeply   .IO.Str, 'foo',    '.IO has right value (Str :path)';
    is-deeply      .Str, 'foo',    '.Str returns Str :path as Str';
}

with IO::Handle.new(:path('foo'.IO)) {
    isa-ok    .path,     IO::Path, '.path keeps IO::Path :path as IO::Path';
    is-deeply .path.Str, 'foo',    '.path has right value (IO::Path :path)';
    isa-ok      .IO,     IO::Path, '.IO keeps IO::Path :path as IO::Path';
    is-deeply   .IO.Str, 'foo',    '.IO has right value (IO::Path :path)';
    is-deeply      .Str, 'foo',    '.Str returns IO::Path :path as Str';
}

ok run(:err, $*EXECUTABLE, <blah blah blah>).err.slurp(:close),
    'can non-explosively .slurp(:close) a pipe with failed Proc';

with make-temp-file.IO.open(:w) {
    .close;
    lives-ok { .close }, 'can call .close an already-closed handle';
}

with make-temp-file.IO.open(:w) {
    .DESTROY;
    #?rakudo.jvm todo 'requires nqp::filenofh to work'
    is-deeply .opened, False, '.DESTROY closes handles';
}

{ # https://irclog.perlgeek.de/perl6-dev/2017-05-01#i_14512345
    my $fh := make-temp-file(:content("a\nb\nc")).IO.open;
    my @res;
    for $fh { @res.push: $_ }
    is-deeply @res, [$fh], '`for IO::Handle` {...} iterates over 1 handle';
}

# https://github.com/rakudo/rakudo/commit/973338a6b7
subtest 'iterator-producing read methods not affected by internal chunking' => {
    plan 10;
    my $n = 10 + ($*DEFAULT-READ-ELEMS // 65536);
    with make-temp-file :content("a" x $n) {
        is +.lines,                         1, '.lines on IO::Path';
        is +.words,                         1, '.words on IO::Path';
        is +.comb(/.+/),                    1, '.comb(Regex) on IO::Path';
        is +.comb($n),                      1, '.comb(Int) on IO::Path';
        is +.split(/.+/, :skip-empty),      0, '.split on IO::Path';

        is +.open.lines,                    1, '.lines on IO::Handle';
        is +.open.words,                    1, '.words on IO::Handle';
        is +.open.comb(/.+/),               1, '.comb(Regex) on IO::Handle';
        is +.open.comb($n),                 1, '.comb(Int) on IO::Handle';
        is +.open.split(/.+/, :skip-empty), 0, '.split on IO::Handle';
    }
}

subtest '.flush' => {
    plan 2;
    my $file = make-temp-file;
    my $fh will leave {.close} = $file.open: :w;
    # an implementation may choose to make the first write to a handle
    # unbuffered, to ensure that the handle is writable in the first place,
    # so we'll do two prints, to trigger buffering, if it's implemented
    $fh.print: 'foo';
    $fh.print: 'bar';
    $fh.flush;
    is-deeply $file.slurp, 'foobar', 'content was flushed';
    fails-like { IO::Handle.new.flush }, X::IO::Flush,
        'fails with correct exception';
}

subtest '.t returns True for TTY' => {
    plan 1;
    my $tt = shell :out, :err, 'tty';
    if $tt and (my $path = $tt.out.slurp(:close).trim)
      and $path ne 'not a tty' and my $fh = $path.IO.open {
        is-deeply $fh.t, True, '.t on a TTY handle';
        $fh.close;
    }
    else {
        skip 'could not figure out how to get a TTY handle'
    }
}

subtest '.nl-in attribute' => {
    plan 4;
    my $fh = make-temp-file(:content<foo>).open;
    is-deeply ($fh.nl-in = '42'),    '42',    'return value (Str)';
    is-deeply  $fh.nl-in,            '42',    'attribute got set (Str)';
    is-deeply ($fh.nl-in = [<a b>]), [<a b>], 'return value (Array)';
    is-deeply  $fh.nl-in,            [<a b>], 'attribute got set (Array)';
}

subtest '.encoding attribute' => {
    plan 4;
    my $fh = make-temp-file(:content<foo>).open;
    is-deeply ($fh.encoding('ascii')), 'ascii', 'return value';
    is-deeply  $fh.encoding,           'ascii', 'attribute got set';
    is-deeply ($fh.encoding('bin')),   Nil,     'return value (bin)';
    is-deeply  $fh.encoding,           Nil,     'attribute got set (bin)';
}

subtest '.say method' => {
    plan 5*5;

    my $file = make-temp-file;
    sub test-output (Capture \in, Str:D \out, Str :$nl-out) {
        with $nl-out {
            with $file.open(:w, :$nl-out) { .say: |in; .close }
            is-deeply $file.slurp, out ~ $nl-out,
                in.raku ~ ' :nl-out(' ~ $nl-out.raku ~ ')';
        }
        else {
            with $file.open(:w) { .say: |in; .close }
            is-deeply $file.slurp, out ~ "\n", in.raku;
        }
    }

    for Str, '', 'foos', '♥', "\n" -> $nl-out {
        test-output :$nl-out, \(       ), "";
        test-output :$nl-out, \('foo'  ), "foo";
        test-output :$nl-out, \(<a b c>), "(a b c)";
        test-output :$nl-out, \(1, 2, 3), "123";
        test-output :$nl-out, \(
          (
            Mu, my class Foo { }, my class { method gist { 'I ♥ Raku' } },
            1, 2, [3, 5, ('foos',).Seq], %(<meow bar>), :42bar.Pair
          )
        ), '((Mu) (Foo) I ♥ Raku 1 2 [3 5 (foos)] {meow => bar} bar => 42)';
    }
}

subtest '.print-nl method' => {
    plan 4;

    my $file = make-temp-file;
    with $file.open: :w { .print-nl; .close }
    is-deeply $file.slurp, "\n", 'defaults';

    with $file.open: :w, :nl-out<♥> { .print-nl; .close }
    is-deeply $file.slurp, "♥", ':nl-out set to ♥';

    with IO::Handle.new(:path($file)).open: :nl-out("foo\n\n\nbar"), :w {
        .print-nl; .close
    }
    is-deeply $file.slurp, "foo\n\n\nbar", ':nl-out set to a string';

    with IO::Handle.new: :path($file) {
        .open: :w, :nl-out<bar>;    .print-nl; .close;
        .open: :a; .nl-out = 'ber'; .print-nl; .close;
    }
    is-deeply $file.slurp, "barber",
        ':nl-out set via .open, then via attribute assignment';
}

# https://github.com/Raku/old-issue-tracker/issues/6282
{
    my $file = make-temp-file;
    given $file.IO {
        .spurt: "fo♥o";
        my $fh = .open(:enc<ascii>);
        dies-ok { $fh.slurp }, 'ASCII decode/encode dies with a catchable exception';
        # R#2272
        lives-ok { $fh.close }, 'closing after a decode error should work';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6466
given make-temp-file() {
    .spurt: "a" x (2**20 - 1) ~ "«";
    #?rakudo.jvm todo 'OutOfMemoryError: Java heap space'
    lives-ok { for .lines { } }, 'No spurious malformed UTF-8 error';
}

# https://github.com/Raku/old-issue-tracker/issues/6493
subtest 'opened filehandles get closed on exit automatically' => {
    plan 2;
    my $path = make-temp-file;
    is_run ｢my $fh := ｣ ~ $path.raku  ~ ｢.open: :w, :5000out-buffer;
      $fh.print: 'pass'; $fh.print: '-pass2';
      print 'pass'
    ｣, {:out<pass>, :err(''), :0status}, 'written into a file without closing';

    is-deeply $path.slurp, 'pass-pass2',
        'file has all the content we wrote into it';
}

# https://github.com/Raku/old-issue-tracker/issues/6434
{
    is-deeply my class Z is IO::Handle { }.new.nl-in, $[“\n”, “\r\n”],
        ‘.nl-in in subclasses has \n and \r\n’;
}

subtest '.WRITE method' => {
    plan 1;
    my $fh := my class MyHandle is IO::Handle {
        has Buf[uint8] $.data .= new;
        # NOTE: the requirement of manually setting .encoding should not
        # be considered part of the specification. This wart is mostly due
        # to possibility of having "unopened" handled. See R#2050
        # https://github.com/rakudo/rakudo/issues/2050
        submethod TWEAK { self.encoding: 'utf8' }
        method WRITE (Blob:D \data --> True) { $!data.append: data }
    }.new;

    $fh.print:  'print ';
    $fh.printf: 'pri%s', 'ntf ';
    $fh.put:    'put';
    $fh.say:    my class { method gist { 'say' } }.new;
    $fh.spurt:  'spurt text ';
    $fh.spurt:  'spurt bin '.encode;
    $fh.write:  'write'.encode;
    $fh.print-nl;

    is $fh.data.decode.lines, ('print printf put', 'say', 'spurt text spurt bin write'),
        'all writing methods work';
}

subtest '.EOF/.WRITE methods' => {
    plan 31;

    my $fh := my class MyHandle is IO::Handle {
        has Buf[uint8] $.data .= new: "I ♥ Raku\nprogramming".encode;
        # NOTE: the requirement of manually setting .encoding should not
        # be considered part of the specification. This wart is mostly due
        # to possibility of having "unopened" handled. See R#2050
        # https://github.com/rakudo/rakudo/issues/2050
        submethod TWEAK { self.encoding: 'utf8' }
        method READ(\bytes) { $!data.splice: 0, bytes }
        method EOF { ! $!data }
    }.new;

    is-deeply $fh.eof,   False, 'eof before .slurp';
    is-deeply $fh.slurp, "I ♥ Raku\nprogramming", '.slurp';
    is-deeply $fh.eof,   True,  'eof after .slurp';

    $fh := MyHandle.new;
    is-deeply $fh.lines, ('I ♥ Raku', 'programming').Seq, '.lines';
    is-deeply $fh.eof,   True, 'eof after .lines';

    $fh := MyHandle.new;
    $fh.nl-in = [<ak gra>];
    is-deeply $fh.lines, ('I ♥ R', "u\npro", 'mming').Seq,
        '.lines with custom nl-in';
    is-deeply $fh.eof,   True, 'eof after .lines with custom nl-in';

    $fh := MyHandle.new;
    is-deeply $fh.words, <I ♥ Raku programming>».Str.Seq, '.words';
    is-deeply $fh.eof,   True, 'eof after .words';

    $fh := MyHandle.new;
    is-deeply $fh.split(/ak/), ("I ♥ R", "u\nprogramming").Seq, '.split';
    is-deeply $fh.eof,   True, 'eof after .split';

    $fh := MyHandle.new;
    #?rakudo.jvm todo 'got: $("I", "P")'
    is-deeply $fh.comb(/:i <[A..Z]>/), <I R a k u p r o g r a m m i n g>.Seq,
        '.comb';
    is-deeply $fh.eof,   True, 'eof after .comb';

    $fh := MyHandle.new;
    is-deeply $fh.get, 'I ♥ Raku',  'first .get';
    is-deeply $fh.eof, False, 'eof after first .get';
    is-deeply $fh.get, 'programming', 'second .get';
    is-deeply $fh.eof, True, 'eof after second .get';
    is-deeply $fh.get, Nil, 'third .get';
    is-deeply $fh.eof, True, 'eof after third .get';

    $fh := MyHandle.new;
    is-deeply ($fh.getc xx 5), ('I', ' ', '♥', ' ', 'R').Seq,
        'data from five .getc calls';
    is-deeply $fh.eof, False, 'eof after five .getc calls';
    is-deeply ($fh.getc xx 1000).grep(*.defined).join, "aku\nprogramming",
        '"slurp" of rest of data with .getc calls';
    is-deeply $fh.eof, True,
        '.eof after "slurp" of rest of data with .getc calls';

    $fh := MyHandle.new;
    is-deeply $fh.readchars(5), "I ♥ R", 'data from .readchars call';
    is-deeply $fh.eof, False, 'eof after .readchars call';
    is-deeply $fh.readchars(1000), "aku\nprogramming",
        '"slurp" of rest of data with .readchars call';
    is-deeply $fh.eof, True,
        '.eof after "slurp" of rest of data with .readchars call';

    $fh := MyHandle.new;
    is-deeply $fh.read(7).decode, "I ♥ R", 'data from .read call';
    is-deeply $fh.eof, False, 'eof after .readchars call';
    is-deeply $fh.read(1000).decode, "aku\nprogramming",
        '"slurp" of rest of data with .read call';
    is-deeply $fh.eof, True,
        '.eof after "slurp" of rest of data with .read call';
}

# vim: expandtab shiftwidth=4
