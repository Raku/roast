use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

# L<S32::IO/Functions/chdir>

plan 82;

throws-like ' chdir() ', Exception, 'Cannot call chdir without an argument';

### You can use Unix style folder separator / to set folders on windows too.
my $sep = '/';

# change to t subfolder and see if cwd is updated
my $subdir = 't';
if $subdir.IO !~~ :d {
    skip "Directory, '$subdir', does not exist", 7;
}
else {
    my $cwd = $*CWD;
    ok chdir("$*CWD/$subdir"), 'chdir gave a true value';
    isnt $*CWD.cleanup, $cwd.cleanup, 'Directory has changed';
    is $*CWD.cleanup, "$cwd$sep$subdir".IO.cleanup,
       "Current directory is '$subdir' subfolder (absolute)";

    # relative change back up.
    ok chdir( ".." ), 'chdir gave a true value';
    is $*CWD.cleanup, $cwd.cleanup, 'Change back up to .. worked';

    # relative change to t
    ok chdir( "$subdir" ), 'chdir gave a true value';
    is $*CWD.cleanup, "$cwd$sep$subdir".IO.cleanup,
       "Current directory is '$subdir' subfolder (relative)";
}

sub test-chdir ($desc, $after, |args) {
    my $before = make-temp-dir;
    subtest "chdir with {args.perl}" => {
        temp $*CWD = $before;
        ok chdir($after, |args), "call to chdir succeeds";
        cmp-ok $*CWD, '~~', $after, 'new $*CWD is correct';
    }
}

sub test-chdir-fails ($desc, $why, $after, |args) {
    my $before = make-temp-dir;
    subtest "chdir with {args.perl} fails because of $why" => {
        temp $*CWD = $before;
        my $res = chdir($after, |args);
        isa-ok $res, Failure, "call to chdir returned a Failure";
        throws-like { $res.sink }, X::IO::Chdir,
            'the Failure contains correct exception';
        cmp-ok $*CWD, '~~', $before, '$*CWD remains untouched';
    }
}

test-chdir-fails 'non-existent path', 'path does not exist',
    (make-temp-dir() ~ '-non-existent').IO;

test-chdir :!d, 'chmod 0o777', make-temp-file :chmod<0o777>;
test-chdir :!d, 'chmod 0o666', make-temp-file :chmod<0o666>;
test-chdir :!d, 'chmod 0o555', make-temp-file :chmod<0o555>;
test-chdir :!d, 'chmod 0o444', make-temp-file :chmod<0o444>;
test-chdir :!d, 'chmod 0o333', make-temp-file :chmod<0o333>;
test-chdir :!d, 'chmod 0o222', make-temp-file :chmod<0o222>;
test-chdir :!d, 'chmod 0o111', make-temp-file :chmod<0o111>;
test-chdir :!d, 'chmod 0o000', make-temp-file :chmod<0o000>;

test-chdir               'chmod 0o777',                make-temp-dir 0o777;
test-chdir               'chmod 0o666',                make-temp-dir 0o666;
test-chdir               'chmod 0o555',                make-temp-dir 0o555;
test-chdir               'chmod 0o444',                make-temp-dir 0o444;
test-chdir               'chmod 0o333',                make-temp-dir 0o333;
test-chdir               'chmod 0o222',                make-temp-dir 0o222;
test-chdir               'chmod 0o111',                make-temp-dir 0o111;
test-chdir               'chmod 0o000',                make-temp-dir 0o000;

test-chdir           :r, 'chmod 0o777',                make-temp-dir 0o777;
test-chdir           :r, 'chmod 0o666',                make-temp-dir 0o666;
test-chdir           :r, 'chmod 0o555',                make-temp-dir 0o555;
test-chdir           :r, 'chmod 0o444',                make-temp-dir 0o444;
test-chdir-fails     :r, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
test-chdir-fails     :r, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
test-chdir-fails     :r, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
test-chdir-fails     :r, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

test-chdir           :w, 'chmod 0o777',                make-temp-dir 0o777;
test-chdir-fails     :w, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
test-chdir           :w, 'chmod 0o666',                make-temp-dir 0o666;
test-chdir           :w, 'chmod 0o333',                make-temp-dir 0o333;
test-chdir-fails     :w, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
test-chdir           :w, 'chmod 0o222',                make-temp-dir 0o222;
test-chdir-fails     :w, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
test-chdir-fails     :w, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

test-chdir           :x, 'chmod 0o777',                make-temp-dir 0o777;
test-chdir-fails     :x, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
test-chdir           :x, 'chmod 0o555',                make-temp-dir 0o555;
test-chdir-fails     :x, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
test-chdir           :x, 'chmod 0o333',                make-temp-dir 0o333;
test-chdir-fails     :x, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
test-chdir           :x, 'chmod 0o111',                make-temp-dir 0o111;
test-chdir-fails     :x, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

test-chdir         :r:w, 'chmod 0o777',                make-temp-dir 0o777;
test-chdir         :r:w, 'chmod 0o666',                make-temp-dir 0o666;
test-chdir-fails   :r:w, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
test-chdir-fails   :r:w, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
test-chdir-fails   :r:w, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
test-chdir-fails   :r:w, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
test-chdir-fails   :r:w, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
test-chdir-fails   :r:w, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

test-chdir         :r:x, 'chmod 0o777',                make-temp-dir 0o777;
test-chdir-fails   :r:x, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
test-chdir         :r:x, 'chmod 0o555',                make-temp-dir 0o555;
test-chdir-fails   :r:x, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
test-chdir-fails   :r:x, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
test-chdir-fails   :r:x, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
test-chdir-fails   :r:x, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
test-chdir-fails   :r:x, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

test-chdir         :x:w, 'chmod 0o777',                make-temp-dir 0o777;
test-chdir-fails   :x:w, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
test-chdir-fails   :x:w, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
test-chdir-fails   :x:w, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
test-chdir         :x:w, 'chmod 0o333',                make-temp-dir 0o333;
test-chdir-fails   :x:w, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
test-chdir-fails   :x:w, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
test-chdir-fails   :x:w, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

test-chdir       :r:w:x, 'chmod 0o777',                make-temp-dir 0o777;
test-chdir-fails :r:w:x, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
test-chdir-fails :r:w:x, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
test-chdir-fails :r:w:x, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
test-chdir-fails :r:w:x, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
test-chdir-fails :r:w:x, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
test-chdir-fails :r:w:x, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
test-chdir-fails :r:w:x, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

subtest 'chdir into IO::Path respects its :CWD attribute' => {
    plan 1;

    my $where = make-temp-dir;
    ($where.add('one').mkdir).add('pass1').spurt: 'pass1';
    my $to = IO::Path.new: ".", :CWD($where.add: 'one');

    temp $*CWD;
    chdir $where;
    {
        plan 1;
        temp $*CWD;
        chdir $to;
        ok dir.grep('pass1').so, 'found expected file';
    }
}

# vim: ft=perl6
