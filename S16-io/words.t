use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 4*2 + 3;

my $file = make-temp-file content => qq:to/END/;
                    word0 word1 word2 word3
      word4\tword5     \n\t\nword6
      \c[SPACE]   word7
    \c[NO-BREAK SPACE]    word8
    \c[OGHAM SPACE MARK] word9
    \c[EN QUAD] \c[EM QUAD] \c[EN SPACE] \c[EM SPACE] word10
    \c[THREE-PER-EM SPACE] \c[FOUR-PER-EM SPACE] \c[SIX-PER-EM SPACE] word11
    \c[FIGURE SPACE] \c[PUNCTUATION SPACE] \c[THIN SPACE]  word12
    \c[HAIR SPACE] \c[NARROW NO-BREAK SPACE] \c[MEDIUM MATHEMATICAL SPACE]
    \c[IDEOGRAPHIC SPACE] word13   word14 \c[IDEOGRAPHIC SPACE]
    END

(my $all-words = map "word" ~ *, ^15).cache;

for IO::Handle.^lookup('words'), &words -> &WORDS {
    my $d = &WORDS.WHAT === Sub ?? '(sub form)' !! '(IO::Handle method form)';
    group-of 5 => "no extra args $d" => {
        group-of 2 => '.pull-one' => {
            my $fh will leave {.close} = $file.open;
            my @res;
            for WORDS $fh { @res.push: $_ }
            is-deeply @res.Seq, $all-words, 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        group-of 2 => '.push-all' => {
            my $fh will leave {.close} = $file.open;
            my @res = WORDS $fh;
            is-deeply @res.Seq, $all-words, 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        group-of 2 => '.push-exactly' => {
            my $fh will leave {.close} = $file.open;
            my @res = WORDS($fh)[1,2];
            is-deeply @res.Seq, $all-words[1,2], 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        group-of 2 => '.count-only' => {
            my $fh will leave {.close} = $file.open;
            is-deeply WORDS($fh).elems, $all-words.elems, 'right count';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        group-of 2 => 'Seq' => {
            my $fh will leave {.close} = $file.open;
            is-deeply WORDS($fh), $all-words, 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
    }

    group-of 5 => ":close arg $d" => {
        group-of 2 => '.pull-one' => {
            my $fh = $file.open;
            my @res;
            for WORDS $fh, :close { @res.push: $_ }
            is-deeply @res.Seq, $all-words, 'right words';
            is-deeply $fh.opened, False, 'closed handle';
        }
        group-of 2 => '.push-all' => {
            my $fh = $file.open;
            my @res = WORDS $fh, :close;
            is-deeply @res.Seq, $all-words, 'right words';
            is-deeply $fh.opened, False, 'closed handle';
        }
        group-of 2 => '.push-exactly' => {
            my $fh will leave {.close} = $file.open;
            my @res = WORDS($fh, :close)[1,2];
            is-deeply @res.List, $all-words[1,2], 'right words';
            # we didn't exhaust the iterator, so handle should still be opened
            is-deeply $fh.opened, True, 'still-open handle';
        }
        group-of 2 => '.count-only' => {
            my $fh = $file.open;
            is-deeply WORDS($fh, :close).elems, $all-words.elems, 'right count';
            is-deeply $fh.opened, False, 'closed handle';
        }
        group-of 2 => 'Seq' => {
            my $fh = $file.open;
            is-deeply WORDS($fh, :close), $all-words, 'right words';
            is-deeply $fh.opened, False, 'closed handle';
        }
    }

    group-of 5 => "\$limit arg $d" => {
        group-of 2 => '.pull-one' => {
            my $fh = $file.open;
            my @res;
            for WORDS $fh, 2 { @res.push: $_ }
            is-deeply @res.List, $all-words[^2], 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        group-of 2 => '.push-all' => {
            my $fh = $file.open;
            my @res = WORDS $fh, 2;
            is-deeply @res.List, $all-words[^2], 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        group-of 2 => '.push-exactly' => {
            my $fh will leave {.close} = $file.open;
            my @res = WORDS($fh, 2)[1,2];
            is-deeply @res.List, ($all-words[^2][1], Any), 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        group-of 2 => '.count-only' => {
            my $fh will leave {.close} = $file.open;
            is-deeply WORDS($fh, 2).elems, 2, 'right count';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        group-of 2 => 'Seq' => {
            my $fh will leave {.close} = $file.open;
            is-deeply WORDS($fh, 2), $all-words[^2].Seq, 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
    }

    group-of 5 => "\$limit and :close args $d" => {
        group-of 2 => '.pull-one' => {
            my $fh = $file.open;
            my @res;
            for WORDS $fh, 2, :close { @res.push: $_ }
            is-deeply @res.Seq, $all-words[^2], 'right words';
            is-deeply $fh.opened, False, 'closed handle';
        }
        group-of 2 => '.push-all' => {
            my $fh = $file.open;
            my @res = WORDS $fh, 2, :close;
            is-deeply @res.List, $all-words[^2], 'right words';
            is-deeply $fh.opened, False, 'closed handle';
        }
        group-of 2 => '.push-exactly' => {
            my $fh will leave {.close} = $file.open;
            my @res = WORDS($fh, 2, :close)[^2];
            is-deeply @res.List, $all-words[^2], 'right words';
            # we didn't exhaust the iterator, but did $limit items from it
            # already, so we'd expect the handle to be closed now
            is-deeply $fh.opened, False, 'closed handle';
        }
        group-of 2 => '.count-only' => {
            my $fh = $file.open;
            is-deeply WORDS($fh, 2, :close).elems, 2, 'right count';
            is-deeply $fh.opened, False, 'closed handle';
        }
        group-of 2 => 'Seq' => {
            my $fh = $file.open;
            is-deeply WORDS($fh, 2, :close), $all-words[^2].Seq, 'right words';
            is-deeply $fh.opened, False, 'closed handle';
        }
    }
}


group-of 5 => "no extra args (IO::Path method)" => {
    my @res;

    for $file.words { @res.push: $_ }
    is-deeply @res.Seq, $all-words, 'right words (.pull-one)';

    @res = $file.words;
    is-deeply @res.Seq, $all-words, 'right words (.push-all)';

    # Note: this is not exactly the right way to use this method since
    # this leaves behind an opened handle until it gets GCed
    @res = $file.words[1,2];
    is-deeply @res.List, $all-words[1,2], 'right words (.push-exactly)';
    is-deeply $file.words.elems, $all-words.elems, 'right count (.count-only)';
    is-deeply $file.words, $all-words, 'right words (Seq)';
}

group-of 5 => "\$limit arg (IO::Path method)" => {
    my @res;

    for $file.words(3) { @res.push: $_ }
    is-deeply @res.Seq, $all-words[^3], 'right words (.pull-one)';

    @res = $file.words(3);
    is-deeply @res.Seq, $all-words[^3], 'right words (.push-all)';

    @res = $file.words(2)[1,2];
    is-deeply @res.List, ($all-words[^2][1], Any),
      'right words (.push-exactly)';
    is-deeply $file.words(2).elems, 2, 'right count (.count-only)';
    is-deeply $file.words(2), $all-words[^2].Seq, 'right words (Seq)';
}

{
    $*ARGFILES = IO::ArgFiles.new:
        make-temp-file(:content<foo bar>), make-temp-file(:content<meow moo>),
        make-temp-file(:content<I ♥ Raku>);
    is-eqv words(), <foo bar meow moo I ♥ Raku>».Str.Seq,
        'words() without args uses $*ARGFILES';
}

# vim: expandtab shiftwidth=4
