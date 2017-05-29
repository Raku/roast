use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 4*2 + 4;

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
    subtest "no extra args $d" => { plan 5;
        subtest '.pull-one' => { plan 2;
            my $fh will leave {.close} = $file.open;
            my @res;
            for WORDS $fh { @res.push: $_ }
            is-deeply @res.Seq, $all-words, 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        subtest '.push-all' => { plan 2;
            my $fh will leave {.close} = $file.open;
            my @res = WORDS $fh;
            is-deeply @res.Seq, $all-words, 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        subtest '.push-exactly' => { plan 2;
            my $fh will leave {.close} = $file.open;
            my @res = WORDS($fh)[1,2];
            is-deeply @res.Seq, $all-words[1,2], 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        subtest '.count-only' => { plan 2;
            my $fh will leave {.close} = $file.open;
            is-deeply WORDS($fh).elems, $all-words.elems, 'right count';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        subtest 'Seq' => { plan 2;
            my $fh will leave {.close} = $file.open;
            is-deeply WORDS($fh), $all-words, 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
    }

    subtest ":close arg $d" => { plan 5;
        subtest '.pull-one' => { plan 2;
            my $fh = $file.open;
            my @res;
            for WORDS $fh, :close { @res.push: $_ }
            is-deeply @res.Seq, $all-words, 'right words';
            is-deeply $fh.opened, False, 'closed handle';
        }
        subtest '.push-all' => { plan 2;
            my $fh = $file.open;
            my @res = WORDS $fh, :close;
            is-deeply @res.Seq, $all-words, 'right words';
            is-deeply $fh.opened, False, 'closed handle';
        }
        subtest '.push-exactly' => { plan 1;
            my $fh will leave {.close} = $file.open;
            my @res = WORDS($fh, :close)[1,2];
            is-deeply @res.List, $all-words[1,2], 'right words';
            # we don't exhaust the iterator, so don't check if it closed
        }
        subtest '.count-only' => { plan 2;
            my $fh = $file.open;
            is-deeply WORDS($fh, :close).elems, $all-words.elems, 'right count';
            is-deeply $fh.opened, False, 'closed handle';
        }
        subtest 'Seq' => { plan 2;
            my $fh = $file.open;
            is-deeply WORDS($fh, :close), $all-words, 'right words';
            is-deeply $fh.opened, False, 'closed handle';
        }
    }

    subtest "\$limit arg $d" => { plan 5;
        subtest '.pull-one' => { plan 2;
            my $fh = $file.open;
            my @res;
            for WORDS $fh, 2 { @res.push: $_ }
            is-deeply @res.List, $all-words[^2], 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        subtest '.push-all' => { plan 2;
            my $fh = $file.open;
            my @res = WORDS $fh, 2;
            is-deeply @res.List, $all-words[^2], 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        subtest '.push-exactly' => { plan 2;
            my $fh will leave {.close} = $file.open;
            my @res = WORDS($fh, 2)[1,2];
            is-deeply @res.List, ($all-words[^2][1], Any), 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        subtest '.count-only' => { plan 2;
            my $fh will leave {.close} = $file.open;
            is-deeply WORDS($fh, 2).elems, 2, 'right count';
            is-deeply $fh.opened, True, 'did not close handle';
        }
        subtest 'Seq' => { plan 2;
            my $fh will leave {.close} = $file.open;
            is-deeply WORDS($fh, 2), $all-words[^2].Seq, 'right words';
            is-deeply $fh.opened, True, 'did not close handle';
        }
    }

    subtest "\$limit and :close args $d" => { plan 5;
        subtest '.pull-one' => { plan 2;
            my $fh = $file.open;
            my @res;
            for WORDS $fh, 2, :close { @res.push: $_ }
            is-deeply @res.Seq, $all-words[^2], 'right words';
            is-deeply $fh.opened, False, 'closed handle';
        }
        subtest '.push-all' => { plan 2;
            my $fh = $file.open;
            my @res = WORDS $fh, 2, :close;
            is-deeply @res.List, $all-words[^2], 'right words';
            is-deeply $fh.opened, False, 'closed handle';
        }
        subtest '.push-exactly' => { plan 1;
            my $fh will leave {.close} = $file.open;
            my @res = WORDS($fh, 2, :close)[1,2];
            is-deeply @res.List, ($all-words[^2][1], Any), 'right words';
            # we don't exhaust the iterator, so don't check if it closed
        }
        subtest '.count-only' => { plan 2;
            my $fh = $file.open;
            is-deeply WORDS($fh, 2, :close).elems, 2, 'right count';
            is-deeply $fh.opened, False, 'closed handle';
        }
        subtest 'Seq' => { plan 2;
            my $fh = $file.open;
            is-deeply WORDS($fh, 2, :close), $all-words[^2].Seq, 'right words';
            is-deeply $fh.opened, False, 'closed handle';
        }
    }
}


subtest "no extra args (IO::Path method)" => { plan 5;
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

subtest "\$limit arg (IO::Path method)" => { plan 5;
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

# we spin up another perl6 and do 1500 x 2 .words calls; if the handle
# isn't closed; we can expect some errors to show up in the output
is_run ｢my $i = 0; my @words; with ｣ ~ $file.perl ~ ｢ {
        loop {
            last if ++$i > 1500;
            @words.append: .words;
            @words.append: .words(2);
        }
    }; print "all ok $i"｣,
    {:err(''), :out('all ok 1501'), :0status},
'heuristic for testing whether handle is closed';

#?rakudo.jvm skip 'Type check failed in binding to parameter $bin; expected Bool but got Int (0)'
{
    $*ARGFILES = IO::ArgFiles.new:
        make-temp-file(:content<foo bar>), make-temp-file(:content<meow moo>),
        make-temp-file(:content<I ♥ Perl 6>);
    is-deeply words(), <foo bar meow moo I ♥ Perl 6>».Str.Seq,
        'words() without args uses $*ARGFILES';
}

# vim: ft=perl6
