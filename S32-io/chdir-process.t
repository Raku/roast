use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# Tests of &*chdir (the process-chdir-changing version)

plan :skip-all<Cannot test without $*TMPDIR and $*HOME set to readable dirs>
    unless $*TMPDIR ~~ :d & :r and $*HOME ~~ :d & :r;

plan 8;

# XXX TODO: `&*chdir` changes process dir, however `qx` respects `$*CWD`,
# so these tests do not currently manage to prove the process directory changes
# along with the value of `$*CWD` as well:
# https://github.com/perl6/roast/issues/471
my &sys-cwd = $*DISTRO.is-win ?? {qx`echo %cd%`.chomp.IO} !! {qx`pwd`.chomp.IO};

subtest '&*chdir into IO::Path respects its :CWD attribute' => {
    plan 1;

    my $where = make-temp-dir;
    ($where.add('one').mkdir).add('pass1').spurt: 'pass1';
    my $to = IO::Path.new: ".", :CWD($where.add: 'one');

    is_run '&*chdir(\qq[$to.raku()]); .say for dir',
        {:out(/pass1/), :err(''), :0status},
    'found expected file';
}

subtest '&*chdir to non-existent directory' => {
    plan 2;

    my $before = make-temp-dir;
    temp $*CWD = $before;
    throws-like { &*chdir( make-temp-dir().absolute ~ 'non-existent' ) },
        X::IO::Chdir, 'call to chdir returned a Failure';
    cmp-ok $*CWD, '===', $before, '$*CWD remains unchanged on failure';
}

{
    temp $*CWD;
    is-path &*chdir($*TMPDIR), $*TMPDIR, '&*chdir returns new $*CWD';
    is-path $*CWD,             $*TMPDIR, '&*chdir updates $*CWD';
    is-path sys-cwd(),         $*TMPDIR, '&*chdir updates process dir';
    is-path &*chdir($*HOME),   $*HOME,   '&*chdir returns new $*CWD [2]';
    is-path $*CWD,             $*HOME,   '&*chdir updates $*CWD [2]';
    is-path sys-cwd(),         $*HOME,   '&*chdir updates process dir [2]';
}

# vim: expandtab shiftwidth=4
