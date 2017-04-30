use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 16;

my $path = "io-handle-testfile";

##
# Test that we flush when we go out of scope
{
    {
        my $fh = $path.IO.open(:w);
        $fh.print("42");
    }
    is slurp($path), "42", "buffer is flushed when IO goes out of scope";
}

# RT #78454
{
    $path.IO.open(:w).print("24");
    is slurp($path), "24", "buffer is flushed when IO goes out of scope";
}

# RT #123888
#?rakudo.jvm todo 'RT #123888'
{
    {
        $path.IO.open(:w).print("A+B+C+D+");
    }
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
    is-deeply .opened, False, '.DESTROY closes handles';
}
