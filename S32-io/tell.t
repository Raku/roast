use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 4;
# Tests for IO::Handle.tell

subtest 'open(:w) handle' => {
    plan 3;
    my $fh = make-temp-file.open: :w;
    is-deeply $fh.tell, 0, '.tell at start';

    $fh.print: 'I ♥ Perl 6';
    is-deeply $fh.tell, 'I ♥ Perl 6'.encode.bytes, '.tell after writing';

    $fh.seek: 2, SeekFromBeginning;
    is-deeply $fh.tell, 2, '.tell after seeking';
    $fh.close;
}

subtest 'open(:w, :bin) handle' => {
    plan 3;
    my $fh = make-temp-file.open: :w, :bin;
    is-deeply $fh.tell, 0, '.tell at start';

    $fh.write: 'I ♥ Perl 6'.encode;
    is-deeply $fh.tell, 'I ♥ Perl 6'.encode.bytes, '.tell after writing';

    $fh.seek: 2, SeekFromBeginning;
    is-deeply $fh.tell, 2, '.tell after seeking';
    $fh.close;
}

subtest 'open(:a) handle' => {
    plan 4;
    my $fh = make-temp-file.open: :a;
    is-deeply $fh.tell, 0, '.tell at start';

    $fh.print: 'I ♥ Perl 6';
    is-deeply $fh.tell, 'I ♥ Perl 6'.encode.bytes, '.tell after writing (1)';

    $fh.print: 'I ♥ Perl 6';
    is-deeply $fh.tell, ('I ♥ Perl 6' x 2).encode.bytes,
      '.tell after writing (2)';

    $fh.seek: 2, SeekFromBeginning;
    #?rakudo.jvm todo 'got 24'
    is-deeply $fh.tell, 2, '.tell after seeking';
    $fh.close;
}

subtest 'open(:bin) handle' => {
    plan 4;
    my $fh = make-temp-file(content => 'I ♥ Perl 6').open: :bin;
    is-deeply $fh.tell, 0, '.tell at start';

    $fh.slurp;
    is-deeply $fh.tell, 'I ♥ Perl 6'.encode.bytes, '.tell after slurping';

    $fh.seek: 2, SeekFromBeginning;
    is-deeply $fh.tell, 2, '.tell after seeking';

    $fh.seek: 0, SeekFromBeginning;
    $ = $fh.read(3);
    is-deeply $fh.tell, 3, '.tell after reading 3 bytes';
    $fh.close;
}



# vim: ft=perl6
