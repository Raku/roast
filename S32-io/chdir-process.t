use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

# Tests of &*chdir (the process-chdir-changing version)

plan :skip-all<Cannot test without $*TMPDIR and $*HOME set to readable dirs>
    unless $*TMPDIR ~~ :d & :r and $*HOME ~~ :d & :r;

plan 7;
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

sub same-paths ($expected, $given, $desc) {
    cmp-ok $expected.resolve, '~~', $given.resolve, $desc;
}

{
    temp $*CWD;
    same-paths &*chdir($*TMPDIR), $*TMPDIR, '&*chdir returns new $*CWD';
    same-paths $*CWD,             $*TMPDIR, '&*chdir updates $*CWD';
    same-paths sys-cwd(),         $*TMPDIR, '&*chdir updates process dir';
    same-paths &*chdir($*HOME),   $*HOME,   '&*chdir returns new $*CWD [2]';
    same-paths $*CWD,             $*HOME,   '&*chdir updates $*CWD [2]';
    same-paths sys-cwd(),         $*HOME,   '&*chdir updates process dir [2]';
}

# vim: ft=perl6
