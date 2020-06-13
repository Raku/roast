use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 5;
# Tests for IO::Handle.tell

subtest 'open(:w) handle' => {
    plan 3;
    my $fh = make-temp-file.open: :w;
    is-deeply $fh.tell, 0, '.tell at start';

    $fh.print: 'I ♥ Raku';
    is-deeply $fh.tell, 'I ♥ Raku'.encode.bytes, '.tell after writing';

    $fh.seek: 2, SeekFromBeginning;
    is-deeply $fh.tell, 2, '.tell after seeking';
    $fh.close;
}

subtest 'open(:w, :bin) handle' => {
    plan 3;
    my $fh = make-temp-file.open: :w, :bin;
    is-deeply $fh.tell, 0, '.tell at start';

    $fh.write: 'I ♥ Raku'.encode;
    is-deeply $fh.tell, 'I ♥ Raku'.encode.bytes, '.tell after writing';

    $fh.seek: 2, SeekFromBeginning;
    is-deeply $fh.tell, 2, '.tell after seeking';
    $fh.close;
}

subtest 'open(:a) handle' => {
    plan 4;
    my $fh = make-temp-file.open: :a;
    is-deeply $fh.tell, 0, '.tell at start';

    $fh.print: 'I ♥ Raku';
    is-deeply $fh.tell, 'I ♥ Raku'.encode.bytes, '.tell after writing (1)';

    $fh.print: 'I ♥ Raku';
    is-deeply $fh.tell, ('I ♥ Raku' x 2).encode.bytes,
      '.tell after writing (2)';

    $fh.seek: 2, SeekFromBeginning;
    #?rakudo.jvm todo "got 24; :a is translated to Java's append mode where position is reset to end"
    is-deeply $fh.tell, 2, '.tell after seeking';
    $fh.close;
}

subtest 'open(:bin) handle' => {
    plan 4;
    my $fh = make-temp-file(content => 'I ♥ Raku').open: :bin;
    is-deeply $fh.tell, 0, '.tell at start';

    $fh.slurp;
    is-deeply $fh.tell, 'I ♥ Raku'.encode.bytes, '.tell after slurping';

    $fh.seek: 2, SeekFromBeginning;
    is-deeply $fh.tell, 2, '.tell after seeking';

    $fh.seek: 0, SeekFromBeginning;
    $ = $fh.read(3);
    is-deeply $fh.tell, 3, '.tell after reading 3 bytes';
    $fh.close;
}

# https://github.com/Raku/old-issue-tracker/issues/6590
# TTY handles like STDOUT keep track of how many bytes were sent to give faked
# out .tell results. The bug in #132254 existed due to .tell on TTY, so
# let's use $*OUT for the test and rely on previous TAP output to have shifted
# the .tell value by some bytes, due to previously printed content
cmp-ok $*OUT.tell, '!=', 0, '.tell gave us some non-zero value';

# vim: expandtab shiftwidth=4
