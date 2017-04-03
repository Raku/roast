use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

# Tests of &*chdir (the process-chdir-changing version)

plan 7;

unless $*TMPDIR ~~ :d & :r and $*HOME ~~ :d & :r {
    skip-rest 'Cannot test without $*TPMDIR and $*HOME set to readable dirs';
    exit;
}

my &sys-cwd = $*DISTRO.is-win ?? {qx`echo %cd%`.chomp.IO} !! {qx`pwd`.chomp.IO};

subtest '&*chdir to non-existent directory' => {
    plan 3;

    my $before = make-temp-dir;
    temp $*CWD = $before;
    my $res = &*chdir( make-temp-dir() ~ 'non-existent' );
    isa-ok $res, Failure, "call to chdir returned a Failure";
    throws-like { $res.sink }, X::IO::Chdir,
        'the Failure contains correct exception';
    cmp-ok $*CWD, '~~', $before, '$*CWD remains unchanged on failure';
}

{
    temp $*CWD;
    cmp-ok &*chdir($*TMPDIR), '~~', $*TMPDIR, '&*chdir returns new $*CWD';
    cmp-ok $*CWD,             '~~', $*TMPDIR, '&*chdir updates $*CWD';
    cmp-ok sys-cwd(),         '~~', $*TMPDIR, '&*chdir updates process dir';
    cmp-ok &*chdir($*HOME),   '~~', $*HOME,   '&*chdir returns new $*CWD [2]';
    cmp-ok $*CWD,             '~~', $*HOME,   '&*chdir updates $*CWD [2]';
    cmp-ok sys-cwd(),         '~~', $*HOME,   '&*chdir updates process dir [2]';
}

# vim: ft=perl6
