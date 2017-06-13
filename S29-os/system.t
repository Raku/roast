use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

# L<S29/"OS"/"=item run">
# system is renamed to run, so link there.

plan 36;

my $res;

$res = run($*EXECUTABLE,'-e', '');
ok($res,"run() to an existing program does not die (and returns something true)");
isa-ok($res, Proc, 'run() returns a Proc');
is($res.exitcode, 0, 'run() exit code when successful is zero');
is($res.signal, 0, 'run() signal after completion is zero');
is-deeply($res.command, [$*EXECUTABLE, '-e', ''], 'Proc returned from .run has correct command');

$res = shell("$*EXECUTABLE -e \"\"");
ok($res, "shell() to an existing program does not die (and returns something true)");
isa-ok($res, Proc, 'shell() returns a Proc');
is($res.exitcode, 0, 'shell() exit code when successful is zero');
is($res.signal, 0, 'shell() signal after completion is zero');
is($res.command, "$*EXECUTABLE -e \"\"", 'Proc returned from shell() has correct command');

$res = run("program_that_does_not_exist_ignore_this_error_please.exe");
ok(!$res, "run() to a nonexisting program does not die (and returns something false)");
isa-ok($res, Proc, 'run() returns a Proc even when not successful');
ok($res.exitcode != 0, 'run() exit code is not zero on failure');

$res = run("program_that_does_not_exist_ignore_errors_please.exe","a","b");
ok(!$res, "run() to a nonexisting program with an argument list does not die (and returns something false)");

$res = shell("program_that_does_not_exist_ignore_this_error_please.exe");
ok(!$res, "shell() to a nonexisting program does not die (and returns something false)");
isa-ok($res, Proc, 'shell() returns a Proc even when not successful');
ok($res.exitcode != 0, 'shell() exit code is not zero on failure');

# RT #117039
throws-like { run("program_that_does_not_exist_ignore_errors_please.exe") },
    X::Proc::Unsuccessful,
    'run in sink context throws on unsuccessful exit';
throws-like { shell("program_that_does_not_exist_ignore_errors_please.exe") },
    X::Proc::Unsuccessful,
    'shell in sink context throws on unsuccessful exit';

# RT #104794
{

    is_run 'my $a = qx{echo woot>&2}; say "___ $a ___"',
        {
            out => "___  ___\n",
            err => / ^ "woot" [\r]? \n $ /,
        },
        'qx{} does not capture stderr';
}

# RT #115390
{
    my $rt115390;
    for 1..100 -> $i {
        $rt115390 += $i.perl;
        run "$*EXECUTABLE", "-v";
        1;
    }
    is $rt115390, 5050, 'no crash with run() in loop; run() in sink context';
    $rt115390 = 0;
    for 1..100 -> $i {
        $rt115390 += $i.perl;
        my $var = run "$*EXECUTABLE", "-v";
        1;
    }
    is $rt115390, 5050, 'no crash with run() in loop; run() not in sink context';
}

# RT #128594
{
    for ^10 {
        # NOTE: THIS TEST HANGS ON OSX; double check before unfudging
        #?rakudo.moar skip 'RT 128594'
        #?rakudo.jvm todo 'IOException "no such file" RT 128594'
        is_run q{run("non-existent-program-RT128594", :merge).out.slurp},
            { status => 0 },
        ":merge with run on non-existent program does not crash [attempt $_]";
    }
}

# RT #128398
#?rakudo.jvm skip 'Proc::Async NYI RT #126524'
{
    my $p = Proc::Async.new: :w, $*EXECUTABLE, "-ne",
        Q!last if /2/; .say; LAST { say "test worked" }!;

    my $stdout = '';
    $p.stdout.tap: { $stdout ~= $^a };
    my $prom = $p.start;
    await $p.write: "1\n2\n3\n4\n".encode;
    await $prom;

    #?rakudo.moar todo 'RT 128398'
    is $stdout, "1\ntest worked\n",
        'LAST phaser gets triggered when using -n command line switch';
}

# all these tests feel like bogus, what are we testing here???
# note: is_run fails after these tests because we are no longer in the right dir
chdir "t";
my $cwd;
BEGIN { $cwd = $*DISTRO.is-win ?? 'cd' !! 'pwd' };
ok((qqx{$cwd} ne BEGIN qqx{$cwd}), 'qqx{} is affected by chdir()');
isnt run("dir", "t"), BEGIN { run("dir", "t") }, 'run() is affected by chdir()';

# https://irclog.perlgeek.de/perl6-dev/2017-06-13#i_14727506
{
    my $d = make-temp-dir;
    $d.add('blah').spurt: 'Testing';

    temp %*ENV<PATH> = $*CWD.absolute ~ "/install/bin:%*ENV<PATH>";
    my $res = do with run(
        :out, :err, :cwd($d.absolute), :env{ :42FOOMEOW, |%*ENV },
        $*EXECUTABLE.subst(/^"./"/, ""),
        '-e', ｢'blah'.IO.slurp.print; %*ENV<FOOMEOW>.print｣
    ) {
        .out.slurp(:close) ~ .err.slurp(:close)
    }

    is-deeply $res, 'Testing42', 'run sets $cwd and $env';
}

# vim: ft=perl6
