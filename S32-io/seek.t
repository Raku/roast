use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 4;

my $fh = make-temp-file(:content<1234567890abcdefghijABCDEFGHIJ>).open: :bin;

group-of 5 => 'SeekFromBeginning' => {
    LEAVE $fh.seek: 0, SeekFromBeginning; $fh.seek: 0, SeekFromBeginning;

    $fh.seek: 0, SeekFromBeginning;
    is-deeply $fh.read(5).decode, '12345', 'seek 0';
    $fh.seek: 3, SeekFromBeginning;
    is-deeply $fh.read(5).decode, '45678', 'seek 3';

    $fh.seek: 10, SeekFromBeginning;
    $fh.seek: 20, SeekFromBeginning;
    is-deeply $fh.read(5).decode, 'ABCDE', 'two successive seeks';

    $fh.seek:  300, SeekFromBeginning;
    is $fh.tell, 300, 'seeking past end';

    throws-like { $fh.seek: -300, SeekFromBeginning }, Exception,
        'seeking past beginning throws';
}

group-of 8 => 'SeekFromCurrent' => {
    LEAVE $fh.seek: 0, SeekFromBeginning; $fh.seek: 0, SeekFromBeginning;

    $fh.seek:  10, SeekFromCurrent;
    is-deeply $fh.read(5).decode, 'abcde', 'seek 10';
    $fh.seek:  5, SeekFromCurrent;
    is-deeply $fh.read(5).decode, 'ABCDE', 'read 5, then seek 5';
    $fh.seek: -20, SeekFromCurrent;
    is-deeply $fh.read(5).decode, '67890', 'negative seek 20';

    $fh.seek:   5, SeekFromCurrent;
    $fh.seek:  10, SeekFromCurrent;
    is-deeply $fh.read(5).decode, 'FGHIJ', 'two successive seeks (pos, pos)';

    $fh.seek: -15, SeekFromCurrent;
    $fh.seek:   5, SeekFromCurrent;
    is-deeply $fh.read(5).decode, 'ABCDE', 'two successive seeks (neg, pos)';

    $fh.seek:  -5, SeekFromCurrent;
    $fh.seek: -10, SeekFromCurrent;
    is-deeply $fh.read(5).decode, 'abcde', 'two successive seeks (neg, neg)';

    $fh.seek:    0, SeekFromBeginning;
    $fh.seek:  300, SeekFromCurrent;
    is $fh.tell, 300, 'seeking past end';

    throws-like { $fh.seek: -3000, SeekFromCurrent }, Exception,
        'seeking past beginning throws';
}

group-of 5 => 'SeekFromEnd' => {
    LEAVE $fh.seek: 0, SeekFromBeginning; $fh.seek: 0, SeekFromBeginning;

    $fh.seek:  -5, SeekFromEnd;
    is-deeply $fh.read(5).decode, 'FGHIJ', 'seek -5';
    $fh.seek: -30, SeekFromEnd;
    is-deeply $fh.read(5).decode, '12345', 'seek -30';

    $fh.seek: -5, SeekFromEnd;
    $fh.seek: -10, SeekFromEnd;
    is-deeply $fh.read(5).decode, 'ABCDE', 'two successive seeks';

    $fh.seek:  300, SeekFromEnd;
    is $fh.tell, 330, 'seeking past end';

    throws-like { $fh.seek: -300, SeekFromEnd }, Exception,
        'seeking past beginning throws';
}

# https://github.com/Raku/old-issue-tracker/issues/6276
group-of 3 => '.seek on non-binary handle' => {
    group-of 4 => 'SeekFromCurrent' => {
        my $fh will leave {.close}
        = make-temp-file(content => [~] 'a'..'z').open;
        # https://github.com/Raku/old-issue-tracker/issues/5283
        #?rakudo.jvm 4 todo 'problem with equivalence of Buf objects'
        is-deeply $fh.read(4), Buf[uint8].new(97, 98, 99, 100), '1';
        $fh.seek: 1, SeekFromCurrent;
        is-deeply $fh.read(4), Buf[uint8].new(102, 103, 104, 105), '2';
        $fh.seek: -7, SeekFromCurrent;
        is-deeply $fh.read(5), Buf[uint8].new(99,100,101,102,103), '3';
        $fh.seek: 1000, SeekFromCurrent;
        is-deeply $fh.read(5), Buf[uint8].new(), '4';
    }

    group-of 3 => 'SeekFromBeginning' => {
        my $fh will leave {.close}
        = make-temp-file(content => [~] 'a'..'z').open;
        # https://github.com/Raku/old-issue-tracker/issues/5283
        #?rakudo.jvm 3 todo 'problem with equivalence of Buf objects'
        is-deeply $fh.read(4), Buf[uint8].new(97, 98, 99, 100), '1';
        $fh.seek: 1, SeekFromBeginning;
        is-deeply $fh.read(4), Buf[uint8].new(98, 99, 100, 101), '2';
        $fh.seek: 1000, SeekFromBeginning;
        is-deeply $fh.read(5), Buf[uint8].new(), '3';
    }

    group-of 3 => 'SeekFromEnd' => {
        my $fh will leave {.close}
        = make-temp-file(content => [~] 'a'..'z').open;
        # https://github.com/Raku/old-issue-tracker/issues/5283
        #?rakudo.jvm 3 todo 'problem with equivalence of Buf objects'
        is-deeply $fh.read(4), Buf[uint8].new(97, 98, 99, 100), '1';
        $fh.seek: -10, SeekFromEnd;
        is-deeply $fh.read(5), Buf[uint8].new(113,114,115,116,117), '2';
        $fh.seek: 1000, SeekFromEnd;
        is-deeply $fh.read(10), Buf[uint8].new(), '3';
    }
}

# vim: expandtab shiftwidth=4
