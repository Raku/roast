use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 2;

# RT #131503
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

# vim: ft=perl6
