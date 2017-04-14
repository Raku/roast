use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

# Tests of IO::Path.symlink and &symlink

if $*DISTRO.is-win {
    # XXX TODO: perhaps we should have some sort of "sudo tests" category in roast
    # for tests expected to be run with elevated privileges
    make-temp-file(:content<foo>).symlink(make-temp-file)
        or plan skip-all => '.symlink on Windows requires escalated privileges';
}

plan 2 * 6; # $n tests run for method and sub forms

for IO::Path.^lookup('symlink'), &symlink -> &sl {
    my $target = make-temp-file;
    my $link   = make-temp-file;
    is-deeply sl($target, $link), True, 'can create dangling symlinks';
    is-deeply ($link ~~ :l), True, 'created dangling link filetests for .l';
    $link.unlink;

    $target.spurt: 'foo';
    is-deeply sl($target, $link), True, 'can create symlinks';
    is-deeply ($link ~~ :e & :l), True, 'created link filetests for .e and .l';
    is-deeply $link.slurp, 'foo', 'slurping from a link gives right data';

    throws-like { sl($target, $link) }, X::IO::Symlink, :$target, :name($link),
        'fail when link already exists';
}

# vim: ft=perl6
