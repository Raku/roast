use v6.c;
use Test;
use lib $?FILE.IO.parent(3).add: 'packages/Test-Helpers';
use Test::Util;

plan 9;

# https://github.com/Raku/old-issue-tracker/issues/6320
#?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
#?DOES 1
{
  subtest '.open with "-" as path uses $*IN/$*OUT' => {
    plan 2;
    subtest 'STDOUT' => { plan 3;
        temp $*OUT = make-temp-file.open: :w;
        is-deeply '-'.IO.open(:bin, :w), $*OUT, 'returned handle is STDOUT';
        is-deeply $*OUT.encoding, Nil, 'set binary mode';
        '-'.IO.open: :enc<utf8-c8>, :w;
        is-deeply $*OUT.encoding, 'utf8-c8', 'changed encoding';
    }
    subtest 'STDIN' => { plan 3;
        temp $*IN = make-temp-file(:content<meows>).open;
        is-deeply '-'.IO.open(:bin), $*IN, 'returned handle is STDIN';
        is-deeply $*IN.encoding, Nil, 'set binary mode';
        '-'.IO.open: :enc<utf8-c8>;
        is-deeply $*IN.encoding, 'utf8-c8', 'changed encoding';
    }
  }
}

#?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
#?DOES 1
{
  subtest '.open with "-" as path can open closed $*IN/$*OUT' => {
    plan 3;
    subtest 'STDOUT' => { plan 4;
        temp $*OUT = IO::Handle.new: :path(make-temp-file);
        is-deeply '-'.IO.open(:bin, :w), $*OUT, 'returned handle is STDOUT';
        is-deeply $*OUT.opened,   True, '$*OUT is now opened';
        is-deeply $*OUT.encoding, Nil, 'set binary mode';
        '-'.IO.open: :enc<utf8-c8>, :w;
        is-deeply $*OUT.encoding, 'utf8-c8', 'changed encoding';
    }
    subtest 'STDIN' => { plan 4;
        temp $*IN = IO::Handle.new: :path(make-temp-file :content<meows>);
        is-deeply '-'.IO.open(:bin), $*IN, 'returned handle is STDIN';
        is-deeply $*IN.opened,   True, '$*IN is now opened';
        is-deeply $*IN.encoding, Nil,  'set binary mode';
        '-'.IO.open: :enc<utf8-c8>;
        is-deeply $*IN.encoding, 'utf8-c8', 'changed encoding';
    }

    is_run ｢
        $*IN  = IO::Handle.new: :path('-'.IO);
        $*OUT = IO::Handle.new: :path('-'.IO);
        my $w = '-'.IO.open: :w;
        my $r = '-'.IO.open;
        $r.get.say;
        $*IN.slurp(:close).say;
        $w.put: 'meow $w';
        $*OUT.put: 'meow $*OUT';
    ｣, "foo\nbar\nber", {
        :out("foo\nbar\nber\nmeow \$w\nmeow \$*OUT\n"), :err(''), :0status
    }, ｢can use unopened handle with path '-'.IO｣;
  }
}

# https://github.com/Raku/old-issue-tracker/issues/6320
is_run ｢'-'.IO.slurp.print｣, 'meows', {:out<meows>, :err(''), :0status},
    'can .slurp from "-".IO path';

#?rakudo.jvm skip 'at least one of the sub-tests leads to an UnwindException'
#?DOES 1
{
  group-of 7 => 'now-deprecated subst-mutate' => {
    # coverage; 2016-09-27
    subtest 'Cool.subst-mutate works same as on .Str' => {
        my @tests = # args | returned stringified Match objects | result
        [ \('', ''), '', "aabbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('', '', :g),    ('' xx 20), "aabbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('', '', :global), ('' xx 20), "aabbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('a', ''), 'a', "abbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('a', '', :g), ('a', 'a'), "bbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('a', '', :global), ('a', 'a'), "bbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('b', ''), 'b', "aabb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('b', '', :g), ('b', 'b'), "aab\x[308]b\x[308]cc \t  xz \t  y",  ],
        [ \('b', '', :global), ('b', 'b'), "aab\x[308]b\x[308]cc \t  xz \t  y",  ],
        [ \(/<[abc]>/, ''), 'a', "abbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :g), ('a', 'a', 'b', 'b', 'c', 'c' ), "b\x[308]b\x[308] \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :global), ('a', 'a', 'b', 'b', 'c', 'c' ), "b\x[308]b\x[308] \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :1st), 'a', "abbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :st{1;}), 'a', "abbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :2nd), 'a', "abbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :nd{2;}), 'a', "abbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :3rd), 'b', "aabb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :rd{3;}), 'b', "aabb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :4th), 'b', "aabb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :th{4;}), 'b', "aabb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :5nth), 'c', "aabbb\x[308]b\x[308]c \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :nth{5;}), 'c', "aabbb\x[308]b\x[308]c \t  xz \t  y", ],
        # https://github.com/Raku/old-issue-tracker/issues/5702
        [ \(/<[abc]>/, '', :5x), ('a', 'a', 'b', 'b', 'c'), "b\x[308]b\x[308]c \t  xz \t  y", ],      
        # https://github.com/Raku/old-issue-tracker/issues/5702
        [ \(/<[abc]>/, '', :x(1..5)), ('a', 'a', 'b', 'b', 'c'), "b\x[308]b\x[308]c \t  xz \t  y", ], 
        [ \(/<[cz]> \s+ <[xy]>/, 'Z P', :ss), "c \t  x", "aabbb\x[308]b\x[308]cZ \t  Pz \t  y", ],
        [ \(/<[cz]> \s+ <[xy]>/, 'Z P', :ss, :global), ( "c \t  x", "z \t  y" ), "aabbb\x[308]b\x[308]cZ \t  PZ \t  P", ],
        [ \('a', 'Z', :ii), 'a', "zabbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('a', 'Z', :ii, :global), ( 'a', 'a' ), "zzbbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[b]+[b\x[308]]>/, 'Z', :mm), 'b', "aaZbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[b]+[b\x[308]]>/, 'Z', :mm, :global), ( 'b', 'b', "b\x[308]", "b\x[308]" ), "aaZZZ\x[308]Z\x[308]cc \t  xz \t  y", ],
        [ \(/<[b]+[b\x[308]]>/, 'Z', :ii, :mm), 'b', "aazbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[b]+[b\x[308]]>/, 'Z', :ii, :mm, :global), ( 'b', 'b', "b\x[308]", "b\x[308]" ), "aazzz\x[308]z\x[308]cc \t  xz \t  y", ],
        ;

        plan 2*@tests;
        for @tests -> $t {
            # use IO::Path as our Cool object
            my $obj = "aabbb\x[308]b\x[308]cc \t  xz \t  y".IO;
            my $ret = $obj.subst-mutate(|$t[0]);
            is-deeply ( $ret ~~ Iterable ?? $ret».Str !! $ret.Str ), $t[1],
                "correct return value when using $t[0].gist()";
            is-deeply $obj, $t[2], "correct modification when using $t[0].gist()";
        }
    }

    subtest '.subst-mutate returns a List for things .match return a List for' => {
        plan 17 × 2 × my @matchers := /b/, 'b';
        for @matchers -> \mt {
            for "a", 123 -> $s is copy {
                isa-ok $s.subst-mutate(:g, mt, ''), List,
                    ":g with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:x(3), mt, ''), List,
                    ":x with {mt.^name} matcher on {$s.^name}";

                isa-ok $s.subst-mutate(:nth(1, 2, 3), mt, ''), List,
                    ":nth(List) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:nth(1…3), mt, ''), List,
                    ":nth(Seq) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:nth(1..3), mt, ''), List,
                    ":nth(Range) with {mt.^name} matcher on {$s.^name}";

                isa-ok $s.subst-mutate(:th(1, 2, 3), mt, ''), List,
                    ":th(List) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:th(1…3), mt, ''), List,
                    ":th(Seq) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:th(1..3), mt, ''), List,
                    ":th(Range) with {mt.^name} matcher on {$s.^name}";

                isa-ok $s.subst-mutate(:st(1, 2, 3), mt, ''), List,
                    ":st(List) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:st(1…3), mt, ''), List,
                    ":st(Seq) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:st(1..3), mt, ''), List,
                    ":st(Range) with {mt.^name} matcher on {$s.^name}";

                isa-ok $s.subst-mutate(:nd(1, 2, 3), mt, ''), List,
                    ":nd(List) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:nd(1…3), mt, ''), List,
                    ":nd(Seq) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:nd(1..3), mt, ''), List,
                    ":nd(Range) with {mt.^name} matcher on {$s.^name}";

                isa-ok $s.subst-mutate(:rd(1, 2, 3), mt, ''), List,
                    ":rd(List) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:rd(1…3), mt, ''), List,
                    ":rd(Seq) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:rd(1..3), mt, ''), List,
                    ":rd(Range) with {mt.^name} matcher on {$s.^name}";
            }
        }
    }

    # https://github.com/rakudo/rakudo/issues/1523#issuecomment-365447388
    subtest 'no-matches .subst-mutate: with multi-match opts = empty List' => {
        plan 17 × 2 × my @matchers := /b/, 'b';
        for @matchers -> \mt {
            for "a", 123 -> $s is copy {
                is-deeply $s.subst-mutate(:g, mt, ''), (),
                    ":g with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:x(3), mt, ''), (),
                    ":x with {mt.^name} matcher on {$s.^name}";

                is-deeply $s.subst-mutate(:nth(1, 2, 3), mt, ''), (),
                    ":nth(List) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:nth(1…3), mt, ''), (),
                    ":nth(Seq) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:nth(1..3), mt, ''), (),
                    ":nth(Range) with {mt.^name} matcher on {$s.^name}";

                is-deeply $s.subst-mutate(:th(1, 2, 3), mt, ''), (),
                    ":th(List) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:th(1…3), mt, ''), (),
                    ":th(Seq) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:th(1..3), mt, ''), (),
                    ":th(Range) with {mt.^name} matcher on {$s.^name}";

                is-deeply $s.subst-mutate(:st(1, 2, 3), mt, ''), (),
                    ":st(List) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:st(1…3), mt, ''), (),
                    ":st(Seq) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:st(1..3), mt, ''), (),
                    ":st(Range) with {mt.^name} matcher on {$s.^name}";

                is-deeply $s.subst-mutate(:nd(1, 2, 3), mt, ''), (),
                    ":nd(List) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:nd(1…3), mt, ''), (),
                    ":nd(Seq) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:nd(1..3), mt, ''), (),
                    ":nd(Range) with {mt.^name} matcher on {$s.^name}";

                is-deeply $s.subst-mutate(:rd(1, 2, 3), mt, ''), (),
                    ":rd(List) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:rd(1…3), mt, ''), (),
                    ":rd(Seq) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:rd(1..3), mt, ''), (),
                    ":rd(Range) with {mt.^name} matcher on {$s.^name}";
            }
        }
    }

    # https://github.com/Raku/old-issue-tracker/issues/6043
    subtest '.subst-mutate with multi-match args set $/ to a List of matches' => {
        plan 2*(2+5);
        for 1234567, '1234567' -> $type {
            group-of 4 => "$type.^name().subst-mutate: :g" => {
              ($ = $type).subst-mutate(:g, /../, 'XX');
              isa-ok $/, List, '$/ is a List…';
              cmp-ok +$/, '==', 3, '…with 3 items…';
              is-deeply $/.map({.WHAT}).unique, (Match,).Seq, '…all are Match…';
              is-deeply $/.map(~*), <12 34 56>.map(*.Str), '…all have right values';
            }
            group-of 4 => ".subst-mutate: :x" => {
              ($ = $type).subst-mutate(:2x, /../, 'XX');
              isa-ok $/, List, '$/ is a List…';
              cmp-ok +$/, '==', 2, '…with 2 items…';
              is-deeply $/.map({.WHAT}).unique, (Match,).Seq, '…all are Match…';
              is-deeply $/.map(~*), <12 34>.map(*.Str), '…all have right values';
            }
            for <nth st nd rd th> -> $suffix {
              group-of 4 => ".subst-mutate: :$suffix" => {
                  ($ = $type).subst-mutate(|($suffix => 1..3), /../, 'XX');
                  isa-ok $/, List, '$/ is a List…';
                  cmp-ok +$/, '==', 3, '…with 3 items…';
                  is-deeply $/.map({.WHAT}).unique, (Match,).Seq, '…all are Match…';
                  is-deeply $/.map(~*), <12 34 56>.map(*.Str),
                      '…all have right values';
              }
            }
        }
    }

    throws-like { ($ = "").subst-mutate: /\w/, "",
        :x(my class SomeInvalidXParam {}.new) },
    X::Str::Match::x, 'giving .subst-mutate invalid args throws';

    # https://github.com/Raku/old-issue-tracker/issues/4984
    try { ($ = 42).subst-mutate: Str, Str }; pass "Cool.subst-mutate with wrong args does not hang";

    group-of 2 => '$/ is set when matching in a loop' => {
        for $="a" { if .subst-mutate: /./, 'x' { is ~$/, 'a', 'Str.subst-mutate'  }}
        for $=4   { if .subst-mutate: /./, 'x' { is ~$/, '4', 'Cool.subst-mutate' }}
    }
  }
}

group-of 7 => 'Pair.freeze' => {
    {
        my $p = Pair.new("foo",my Int $);
        isa-ok $p.value, Int;
        is ($p.value = 42), 42, 'can assign integer value and return that';
        is $p.value, 42, 'the expected Int value was set';
        throws-like { $p.value = "bar" },
          X::TypeCheck::Assignment,
          'cannot assign a Str to an Int';

        $p.freeze;
        throws-like { $p.value = 666 },
          X::Assignment::RO,
          'cannot assign an Int to a frozen';
        is $p.value, 42, 'did not change integer value';
    }

    # https://github.com/Raku/old-issue-tracker/issues/6442
    {
        my $value = 17;
        my $pair = number => $value;
        my $obj-at1 = $pair.WHICH;
        $pair.freeze;
        is-deeply $obj-at1, $pair.WHICH,
            "Pair.freeze doesn't change object identity";
    }
}

group-of 2 => ':count arg on &lines/Str.lines' => {
    is lines("a\nb\nc\n",:count), 3, 'lines(Str, :count)';
    is "a\nb\nc\n".lines(:count), 3, 'Str.lines(:count)';
}

# https://github.com/rakudo/rakudo/issues/2433
group-of 5 => 'language switching' => {
    group-of 4 => 'version as first thing' => {
        sub versify ($ver?) {
            ("use v6.$ver; " with $ver) ~ 'print $*PERL.version'
        }

        is_run versify(),            {:err(''), :0status, :out<6.d> },
            'no version pragma';
        is_run versify('c'),         {:err(''), :0status, :out<6.c> },
            '6.c version pragma';
        is_run versify('d'),         {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
        is_run versify('d'), {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
    }

    group-of 4 => 'version after comments' => {
        sub versify ($ver?) {
            "# meow meow\n"
              ~ ("use v6.$ver; " with $ver) ~ 'print $*PERL.version'
        }

        is_run versify(),            {:err(''), :0status, :out<6.d> },
            'no version pragma';
        is_run versify('c'),         {:err(''), :0status, :out<6.c> },
            '6.c version pragma';
        is_run versify('d'),         {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
        is_run versify('d'), {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
    }

    group-of 4 => 'version after POD' => {
        sub versify ($ver?) {
            "=begin pod\n\nZE POD\n\n=end pod\n\n"
              ~ ("use v6.$ver; " with $ver) ~ 'print $*PERL.version'
        }

        is_run versify(),            {:err(''), :0status, :out<6.d> },
            'no version pragma';
        is_run versify('c'),         {:err(''), :0status, :out<6.c> },
            '6.c version pragma';
        is_run versify('d'),         {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
        is_run versify('d'), {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
    }

    group-of 3 => 'error out when trying to switch version too late' => {
        my %args = :out(''), :1exitcode,
            :err{ $^v.contains: 'Too late to switch language version' };
        is_run "use Test; use v6.c;", %args, '6.c version pragma';
        is_run "use Test; use v6.d;", %args, '6.d version pragma';
        is_run "use Test; use v6.d;", %args,
            '6.d version pragma';
    }

    group-of 4 => 'versions without dot' => {
        sub versify ($ver?) { ("use v6$ver; " with $ver) ~ 'print $*PERL.version' }

        is_run versify(),            {:err(''), :0status, :out<6.d> },
            'no version pragma';
        is_run versify('c'),         {:err(''), :0status, :out<6.c> },
            '6.c version pragma';
        is_run versify('d'),         {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
        is_run versify('d'), {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
    }
}

group-of 1 => 'IO::Handle.new can take a bunch of options' => {
    # No final decision has been rendered yet, but it's likely we'll want
    # to limit what IO::Handle.new can take, so keep those tests here
    # https://github.com/rakudo/rakudo/issues/2039
    # https://colabti.org/irclogger/irclogger_log/perl6-dev?date=2018-07-11#l201
    group-of 4 => '.print-nl method' => {
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
}

group-of 12 => '$CALLER::_' => {
    sub callerunderscore ($foo = $CALLER::_) {
        return "-" ~ $foo ~ "-"
    }

    # These tests all work when using CALLER::CALLER but we should
    # not need to do that.  Minus that fact, 123660 has actually been
    # fixed since it was reported.

    is(callerunderscore("foo"), "-foo-", 'CALLER:: string arg');
    is(callerunderscore(1), "-1-", 'CALLER:: number arg');
    $_ = "foo";
    #?rakudo todo "NYI"
    is(callerunderscore(), "-foo-", 'CALLER:: $_ set once');
    $_ = "bar";
    #?rakudo todo "NYI"
    is(callerunderscore(), "-bar-", 'CALLER:: $_ set twice');
    for ("quux") {
        # https://github.com/Raku/old-issue-tracker/issues/3651
        #?rakudo todo "NYI"
        is(callerunderscore(), '-quux-', 'CALLER:: $_ set by for');
    }
    given 'hirgel' {
        # https://github.com/Raku/old-issue-tracker/issues/3651
        #?rakudo todo "NYI"
        is callerunderscore, '-hirgel-', '$CALLER::_ set by given';
    }
    #?rakudo todo "NYI"
    is(callerunderscore(), '-bar-', 'CALLER:: $_ reset after for');


    # L<S02/Names/The CALLER package refers to the lexical scope>
    {
      # $_ is always implicitly declared "is dynamic".
      my sub foo () { $CALLER::_ }
      my sub bar () {
        $_ = 42;
        foo();
      }

      $_ = 23;
      is bar(), 42, '$_ is implicitly declared "is dynamic" (1)';
    } #1

    {
      # $_ is always implicitly declared "is dynamic".
      # (And, BTW, $_ is lexical.)
      my sub foo () { $_ = 17; $CALLER::_ }
      my sub bar () {
        $_ = 42;
        foo();
      }

      $_ = 23;
      is bar(), 42, '$_ is implicitly declared "is dynamic" (2)';
    } #1

    {
      my sub modify { $CALLER::_++ }
      $_ = 42;
      modify();
      is $_, 43,             '$_ is implicitly rw (2)';
    } #1

    # R#2058
    {
        multi sub a($a) { $a + $a }
        multi sub a() { a CALLERS::<$_> }

        is a(42), 84, 'can we call the sub with a parameter';
        given 42 {
            is a(), 84, 'can we call the sub without a parameter';
        }
    }
}

# vim: expandtab shiftwidth=4
