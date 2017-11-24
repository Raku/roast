use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

plan 28;

my $path = "io-handle-testfile";

##
# Test that we flush when we close
{
    my $fh = $path.IO.open(:w);
    $fh.print("42");
    $fh.close;
    is slurp($path), "42", "buffer is flushed when IO handle is closed";
}

# RT #123888
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

#?rakudo.jvm skip 'The spawned command (perl6-j) exited unsuccessfully (exit code: 1)'
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

is-deeply IO::Handle.new.encoding, 'utf8',
    'instantiated handle defaults to utf8 encoding';

subtest '.flush' => {
    # XXX TODO: it doesn't appear we're buffering anything at the moment;
    # when/if we start doing so, ensure these tests cover all the cases
    plan 2;
    my $file = make-temp-file;
    my $fh will leave {.close} = $file.open: :w;
    $fh.print: 'foo';
    $fh.flush;
    is-deeply $file.slurp, 'foo', 'content was flushed';
    fails-like { IO::Handle.new.flush }, X::IO::Flush,
        'fails with correct exception';
}

subtest '.t returns True for TTY' => {
    plan 1;
    my $tt = shell :out, :err, 'tty';
    if $tt and (my $path = $tt.out.slurp(:close).trim)
      and $path ne 'not a tty' {
        my $fh will leave {.close} = $path.IO.open;
        is-deeply $fh.t, True, '.t on a TTY handle'
    }
    else {
        skip 'could not figure out how to get a TTY handle'
    }
}

subtest '.nl-in attribute' => {
    plan 3;
    subtest 'unopened handle' => {
        plan 4;
        my $fh = IO::Handle.new;
        is-deeply ($fh.nl-in = '42'),    '42',    'return value (Str)';
        is-deeply  $fh.nl-in,            '42',    'attribute got set (Str)';
        is-deeply ($fh.nl-in = [<a b>]), [<a b>], 'return value (Array)';
        is-deeply  $fh.nl-in,            [<a b>], 'attribute got set (Array)';
    }

    subtest 'opened handle' => {
        plan 4;
        my $fh = make-temp-file(:content<foo>).open;
        is-deeply ($fh.nl-in = '42'),    '42',    'return value (Str)';
        is-deeply  $fh.nl-in,            '42',    'attribute got set (Str)';
        is-deeply ($fh.nl-in = [<a b>]), [<a b>], 'return value (Array)';
        is-deeply  $fh.nl-in,            [<a b>], 'attribute got set (Array)';
    }

    subtest 'opened, then closed handle' => {
        plan 4;
        my $fh = make-temp-file(:content<foo>).open;
        $fh.close;
        is-deeply ($fh.nl-in = '42'),    '42',    'return value (Str)';
        is-deeply  $fh.nl-in,            '42',    'attribute got set (Str)';
        is-deeply ($fh.nl-in = [<a b>]), [<a b>], 'return value (Array)';
        is-deeply  $fh.nl-in,            [<a b>], 'attribute got set (Array)';
    }
}

subtest '.encoding attribute' => {
    plan 3;
    subtest 'unopened handle' => {
        plan 4;
        my $fh = IO::Handle.new;
        is-deeply ($fh.encoding('ascii')), 'ascii', 'return value';
        is-deeply  $fh.encoding,           'ascii', 'attribute got set';
        is-deeply ($fh.encoding('bin')),   Nil,     'return value (bin)';
        is-deeply  $fh.encoding,           Nil,     'attribute got set (bin)';
    }

    subtest 'opened handle' => {
        plan 4;
        my $fh = make-temp-file(:content<foo>).open;
        #?rakudo.jvm 2 skip '[io grant] StackOverflowError'
        is-deeply ($fh.encoding('ascii')), 'ascii', 'return value';
        is-deeply  $fh.encoding,           'ascii', 'attribute got set';
        is-deeply ($fh.encoding('bin')),   Nil,     'return value (bin)';
        is-deeply  $fh.encoding,           Nil,     'attribute got set (bin)';
    }

    subtest 'opened, then closed handle' => {
        plan 4;
        my $fh = make-temp-file(:content<foo>).open;
        $fh.close;
        is-deeply ($fh.encoding('ascii')), 'ascii', 'return value';
        is-deeply  $fh.encoding,           'ascii', 'attribute got set';
        is-deeply ($fh.encoding('bin')),   Nil,     'return value (bin)';
        is-deeply  $fh.encoding,           Nil,     'attribute got set (Nil)';
    }
}

subtest '.perl.EVAL roundtrips' => {
    plan 7;

    my $orig = IO::Handle.new: :path("foo".IO), :!chomp, :nl-in[<I ♥ Perl 6>],
        :nl-out<foo>, :encoding<ascii>;

    is-deeply IO::Handle.perl.EVAL, IO::Handle, 'type object';
    given $orig.perl.EVAL -> $evaled {
        is-deeply $evaled, $orig, 'instance';
        is-deeply $evaled."$_"(), $orig."$_"(), $_
            for <path  chomp  nl-in  nl-out  encoding>;
    }
}

subtest '.say method' => {
    plan 5*5;

    my $file = make-temp-file;
    sub test-output (Capture \in, Str:D \out, Str :$nl-out) {
        with $nl-out {
            with $file.open(:w, :$nl-out) { .say: |in; .close }
            is-deeply $file.slurp, out ~ $nl-out,
                in.perl ~ ' :nl-out(' ~ $nl-out.perl ~ ')';
        }
        else {
            with $file.open(:w) { .say: |in; .close }
            is-deeply $file.slurp, out ~ "\n", in.perl;
        }
    }

    for Str, '', 'foos', '♥', "\n" -> $nl-out {
        test-output :$nl-out, \(       ), "";
        test-output :$nl-out, \('foo'  ), "foo";
        test-output :$nl-out, \(<a b c>), "(a b c)";
        test-output :$nl-out, \(1, 2, 3), "123";
        test-output :$nl-out, \(
          (
            Mu, my class Foo { }, my class { method gist { 'I ♥ Perl 6' } },
            1, 2, [3, 5, ('foos',).Seq], %(<meow bar>), :42bar.Pair
          )
        ), '((Mu) (Foo) I ♥ Perl 6 1 2 [3 5 (foos)] {meow => bar} bar => 42)';
    }
}

subtest '.print-nl method' => {
    plan 4;

    my $file = make-temp-file;
    with $file.open: :w { .print-nl; .close }
    is-deeply $file.slurp, "\n", 'defaults';

    with $file.open: :w, :nl-out<♥> { .print-nl; .close }
    is-deeply $file.slurp, "♥", ':nl-out set to ♥';

    with IO::Handle.new(:nl-out("foo\n\n\nbar"), :path($file)).open: :w {
        .print-nl; .close
    }
    is-deeply $file.slurp, "foo\n\n\nbar", ':nl-out set to a string (via .new)';

    with IO::Handle.new: :nl-out<foo>, :path($file) {
        .open: :w;                  .print-nl; .close;
        .open: :a, :nl-out<bar>;    .print-nl; .close;
        .open: :a; .nl-out = 'ber'; .print-nl; .close;
    }
    is-deeply $file.slurp, "foobarber",
        ':nl-out set via .new, then via .open, then via attribute assignment';
}

# RT #131384
{
    my $file = make-temp-file;
    given $file.IO {
        .spurt: "fo♥o";
        my $fh = .open(:enc<ascii>);
        #?rakudo.jvm todo 'does not die'
        dies-ok { $fh.slurp.encode }, 'ASCII decode/encode dies with a catchable exception';
        $fh.close;
    }
}

# RT #131961
{
    my $file = make-temp-file;
    given $file.IO {
        .spurt: "a" x (2**20 - 1) ~ "«";
        #?rakudo.jvm todo 'OutOfMemoryError: Java heap space'
        lives-ok { for .lines { } }, 'No spurious malformed UTF-8 error';
    }
}

# RT #132030
subtest 'opened filehandles get closed on exit automatically' => {
    plan 2;
    my $path = make-temp-file;
    is_run $path.perl ~ ｢.open(:w, :5000out-buffer).print: 'pass'; print 'pass'｣,
        {:out<pass>, :err(''), :0status}, 'written into a file without closing';

    is-deeply $path.slurp, 'pass', 'file has all the content we wrote into it';
}
