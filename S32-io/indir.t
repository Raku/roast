use v6;
use lib <lib t/spec/packages/>;
use Test;
use Test::Util;

plan 74;

sub test-indir ($desc, $in-path, |args) {
    temp $*CWD = my $out-path = make-temp-dir;

    subtest "\&indir(\$path) {"with " ~ args.perl if args}, $desc" => {
        my @in-paths = $in-path ~~ Str ?? ($in-path, $in-path.IO)
            !! ( $in-path,
                |($in-path.is-relative
                        ?? $in-path.resolve.absolute.IO
                        !! $in-path.resolve.relative($*CWD).IO
                ), $in-path.Str
            );
        plan +@in-paths;

        for @in-paths -> $in-path {
            subtest "{$in-path.^name} {
                "[relative] " if $in-path.?is-relative
            }path" => {
                plan 3;
                is-deeply (
                    indir $in-path, |args, {
                        is $*CWD.resolve, $in-path.IO.resolve,
                            'right $*CWD inside &indir';
                        $*CWD = make-temp-dir; # deliberately mess with $*CWD
                        42;
                    }
                ), 42, 'return value is correct';
                is $*CWD, $out-path, '$*CWD is unchanged outside of &indir';
            }
        }
    }
}

sub test-indir-fails ($desc, $why, $in-path, |args) {
    subtest "\&indir(\$path, {args ?? args.perl !! '…'})" => {
        my @in-paths = $in-path ~~ Str ?? ($in-path, $in-path.IO)
            !! ($in-path.absolute, $in-path.relative, $in-path.Str);
        plan +@in-paths;

        for @in-paths {
            subtest "{$in-path.^name} {
                "[relative]" if $in-path.?relative
            } path fails because of $why" => {
                plan 2;
                temp $*CWD = my $out-path = make-temp-dir;
                my $res = indir $in-path, |args, {;};
                isa-ok $res, Failure, 'got Failure as return value';
                $res.so; # handle Failure to avoid spammage about unhandled
                         # Failures in DESTROY
                is $*CWD, $out-path, '$*CWD is unchanged outside of &indir';
            }
        }
    }
}

test-indir :!d, 'chmod 0o777', make-temp-file :chmod<0o777>;
test-indir :!d, 'chmod 0o666', make-temp-file :chmod<0o666>;
test-indir :!d, 'chmod 0o555', make-temp-file :chmod<0o555>;
test-indir :!d, 'chmod 0o444', make-temp-file :chmod<0o444>;
test-indir :!d, 'chmod 0o333', make-temp-file :chmod<0o333>;
test-indir :!d, 'chmod 0o222', make-temp-file :chmod<0o222>;
test-indir :!d, 'chmod 0o111', make-temp-file :chmod<0o111>;
test-indir :!d, 'chmod 0o000', make-temp-file :chmod<0o000>;

test-indir               'chmod 0o777',                make-temp-dir 0o777;
test-indir               'chmod 0o666',                make-temp-dir 0o666;
test-indir               'chmod 0o555',                make-temp-dir 0o555;
test-indir               'chmod 0o444',                make-temp-dir 0o444;
test-indir               'chmod 0o333',                make-temp-dir 0o333;
test-indir               'chmod 0o222',                make-temp-dir 0o222;
test-indir               'chmod 0o111',                make-temp-dir 0o111;
test-indir               'chmod 0o000',                make-temp-dir 0o000;

test-indir           :r, 'chmod 0o777',                make-temp-dir 0o777;
test-indir           :r, 'chmod 0o666',                make-temp-dir 0o666;
test-indir           :r, 'chmod 0o555',                make-temp-dir 0o555;
test-indir           :r, 'chmod 0o444',                make-temp-dir 0o444;
test-indir-fails     :r, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
test-indir-fails     :r, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
test-indir-fails     :r, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
test-indir-fails     :r, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

test-indir           :w, 'chmod 0o777',                make-temp-dir 0o777;
test-indir-fails     :w, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
test-indir           :w, 'chmod 0o666',                make-temp-dir 0o666;
test-indir           :w, 'chmod 0o333',                make-temp-dir 0o333;
test-indir-fails     :w, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
test-indir           :w, 'chmod 0o222',                make-temp-dir 0o222;
test-indir-fails     :w, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
test-indir-fails     :w, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

test-indir           :x, 'chmod 0o777',                make-temp-dir 0o777;
test-indir-fails     :x, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
test-indir           :x, 'chmod 0o555',                make-temp-dir 0o555;
test-indir-fails     :x, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
test-indir           :x, 'chmod 0o333',                make-temp-dir 0o333;
test-indir-fails     :x, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
test-indir           :x, 'chmod 0o111',                make-temp-dir 0o111;
test-indir-fails     :x, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

test-indir         :r:w, 'chmod 0o777',                make-temp-dir 0o777;
test-indir         :r:w, 'chmod 0o666',                make-temp-dir 0o666;
test-indir-fails   :r:w, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
test-indir-fails   :r:w, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
test-indir-fails   :r:w, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
test-indir-fails   :r:w, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
test-indir-fails   :r:w, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
test-indir-fails   :r:w, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

test-indir         :r:x, 'chmod 0o777',                make-temp-dir 0o777;
test-indir-fails   :r:x, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
test-indir         :r:x, 'chmod 0o555',                make-temp-dir 0o555;
test-indir-fails   :r:x, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
test-indir-fails   :r:x, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
test-indir-fails   :r:x, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
test-indir-fails   :r:x, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
test-indir-fails   :r:x, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

test-indir         :x:w, 'chmod 0o777',                make-temp-dir 0o777;
test-indir-fails   :x:w, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
test-indir-fails   :x:w, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
test-indir-fails   :x:w, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
test-indir         :x:w, 'chmod 0o333',                make-temp-dir 0o333;
test-indir-fails   :x:w, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
test-indir-fails   :x:w, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
test-indir-fails   :x:w, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

test-indir       :r:w:x, 'chmod 0o777',                make-temp-dir 0o777;
test-indir-fails :r:w:x, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
test-indir-fails :r:w:x, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
test-indir-fails :r:w:x, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
test-indir-fails :r:w:x, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
test-indir-fails :r:w:x, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
test-indir-fails :r:w:x, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
test-indir-fails :r:w:x, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

subtest '&indir does not affect $*CWD outside of its block' => {
    plan 3;
    temp $*CWD = my $out-path = make-temp-dir;
    my $in-path = make-temp-dir;
    my $prom = start { indir $in-path, {
        is $*CWD.resolve, $in-path.IO.resolve,
            'right $*CWD inside &indir';
        $*CWD = make-temp-dir; # deliberately mess with $*CWD
        sleep 1.5;
        42;
    }}
    is $*CWD.resolve, $out-path.IO.resolve, 'right $*CWD outside &indir';
    is-deeply (await $prom), 42, 'right return value from &indir';
}

{
    my int $failures = [+] await flat ^1000 .map: {
        (start indir :!d, 'foo',    { $*CWD ~~ 'foo'.IO ?? 1 !! 0 }),
         start indir :!d, 'foo'.IO, { $*CWD ~~ 'foo'.IO ?? 1 !! 0 }
    }
    cmp-ok $failures, '==', 0, 'number of failures due to race conditions';
}

# vim: expandtab shiftwidth=4 ft=perl6
