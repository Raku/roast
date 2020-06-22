use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S29/"OS"/"=item run">
# system is renamed to run, so link there.

plan 41;

my $res;

$res = run($*EXECUTABLE.absolute,'-e', '');
ok($res,"run() to an existing program does not die (and returns something true)");
isa-ok($res, Proc, 'run() returns a Proc');
is($res.exitcode, 0, 'run() exit code when successful is zero');
is($res.signal, 0, 'run() signal after completion is zero');
is-deeply($res.command, ($*EXECUTABLE.absolute, '-e', ''),
    'Proc returned from .run has correct command');

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

# https://github.com/Raku/old-issue-tracker/issues/3062
throws-like { run("program_that_does_not_exist_ignore_errors_please.exe") },
    X::Proc::Unsuccessful,
    'run in sink context throws on unsuccessful exit';
throws-like { shell("program_that_does_not_exist_ignore_errors_please.exe") },
    X::Proc::Unsuccessful,
    'shell in sink context throws on unsuccessful exit';

# https://github.com/Raku/old-issue-tracker/issues/2564
{

    is_run 'my $a = qx{echo woot>&2}; say "___ $a ___"',
        {
            out => "___  ___\n",
            err => / ^ "woot" [\r]? \n $ /,
        },
        'qx{} does not capture stderr';
}

# https://github.com/Raku/old-issue-tracker/issues/2943
{
    my $rt115390;
    for 1..100 -> $i {
        $rt115390 += $i.raku;
        run "$*EXECUTABLE", "-v";
        1;
    }
    is $rt115390, 5050, 'no crash with run() in loop; run() in sink context';
    $rt115390 = 0;
    for 1..100 -> $i {
        $rt115390 += $i.raku;
        my $var = run "$*EXECUTABLE", "-v";
        1;
    }
    is $rt115390, 5050, 'no crash with run() in loop; run() not in sink context';
}

# https://github.com/Raku/old-issue-tracker/issues/5443
{
    for ^10 {
        is_run q{run("non-existent-program-RT128594", :merge).out.slurp},
            { status => 0 },
        ":merge with run on non-existent program does not crash [attempt $_]";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5374
#?rakudo.jvm skip 'hangs'
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

subtest "run and shell's :cwd" => {
    plan 4;
    my @run-cmd   = $*DISTRO.is-win ?? ('cmd.exe', '/C', 'echo %CD%')
                                    !! ('/bin/sh', '-c', 'echo $PWD');
    my $shell-cmd = $*DISTRO.is-win ?? 'echo %CD%'
                                    !! 'echo $PWD';

    indir (my $cwd = make-temp-dir.absolute), {
        (my $p = run @run-cmd, :!err, :out)
            ?? is $p.out.slurp(:close).trim, $cwd, 'run() defaults to $*CWD'
            !! skip "could not run @run-cmd[]";

        (my $s = shell $shell-cmd, :!err, :out)
            ?? is $s.out.slurp(:close).trim, $cwd, 'shell() defaults to $*CWD'
            !! skip "could not shell $shell-cmd";
    }

    (my $p = run @run-cmd, :!err, :out, :$cwd)
        ?? is $p.out.slurp(:close).trim, $cwd, 'run() accepts :cwd'
        !! skip "could not run :cwd, @run-cmd[]";

    (my $s = shell $shell-cmd, :!err, :out, :$cwd)
        ?? is $s.out.slurp(:close).trim, $cwd, 'shell() accepts :cwd'
        !! skip "could not shell :cwd, $shell-cmd";
}

subtest "run and shell's :env" => {
    plan 4;

    my $script    = (make-temp-file :content('%*ENV<PERL6_RUN_SHELL_ENV_TEST>.print')).absolute;
    my @run-cmd   = $*EXECUTABLE, $script;
    my $shell-cmd = ~@run-cmd;
    my $test-str  = 'meows';

    {
        (my $env := %*ENV.clone)<PERL6_RUN_SHELL_ENV_TEST> = $test-str;
        (my $p = run @run-cmd, :!err, :out, :$env)
            ?? is $p.out.slurp(:close).trim, $test-str, 'run() accepts :env'
            !! skip "could not run :env, @run-cmd[]";

        (my $s = shell $shell-cmd, :!err, :out, :$env)
            ?? is $s.out.slurp(:close).trim, $test-str, 'shell() accepts :env'
            !! skip "could not shell :env, $shell-cmd";
    }

    {
        temp %*ENV<PERL6_RUN_SHELL_ENV_TEST> = $test-str;
        (my $p = run @run-cmd, :!err, :out)
            ?? is $p.out.slurp(:close).trim, $test-str, 'run() defaults to %*ENV'
            !! skip "could not run @run-cmd[]";

        (my $s = shell $shell-cmd, :!err, :out)
            ?? is $s.out.slurp(:close).trim, $test-str, 'shell() defaults to %*ENV'
            !! skip "could not shell $shell-cmd";
    }
}

subtest '.out/.err proc pipes on failed command' => {
    plan 4;

    throws-like { run(:out, "meooooooows").out.close; Nil },
        X::Proc::Unsuccessful, '.out.close Proc explodes when sunk';
    throws-like { run(:err, "meooooooows").err.close; Nil },
        X::Proc::Unsuccessful, '.err.close Proc explodes when sunk';
    is-deeply run(:out, "meooooooows").out.slurp(:close), '',
        '.out.slurp is empty';
    is-deeply run(:err, "meooooooows").err.slurp(:close), '',
        '.err.slurp is empty';
}

subtest 'all Proc pipes return Proc on .close' => {
    plan 3;
    my $p = run :in, :out, :err, «$*EXECUTABLE -e 'exit 42'»;
    cmp-ok $p.in .close, '===', $p, 'in';
    cmp-ok $p.out.close, '===', $p, 'out';
    cmp-ok $p.err.close, '===', $p, 'err';
}

# https://github.com/Raku/old-issue-tracker/issues/5679
subtest 'Proc.encoding is set correctly' => {
    plan 2;
    my $p = run :out, $*EXECUTABLE, '-e', 'print 42';
    is $p.out.encoding, 'utf8', '.encoding set correctly to utf8';
    is $p.out.split(0.chr, :skip-empty), (“42”,), '.out is read correctly';
}

# https://github.com/Raku/old-issue-tracker/issues/4654
subtest 'Proc.pid is set correctly' => {
    plan 4;
    my $p = run $*EXECUTABLE, '-e', "print 42", :out;
    my $pid = $p.pid;
    cmp-ok $p.pid, '~~', Int:D, '.pid property exists with run()';
    $p.shell: qq/$*EXECUTABLE -e "print 42"/;
    cmp-ok $p.pid, '~~', Int:D, '.pid property exists with shell()';

    $pid = $p.pid;
    $p.spawn: 'meooooooows', :err;
    is $pid, $p.pid, '.pid property does not update on failed run()';
    $pid = $p.pid;
    $p.shell: 'meooooooows', :err;
    isnt $pid, $p.pid, ".pid property updates with shell's PID on failed shell()";
}

# https://github.com/rakudo/rakudo/issues/3149
{
    my $proc = run $*EXECUTABLE, ‘-e’,
        ‘use NativeCall; sub strdup(int64) is native(Str) {*}; strdup(0)’;
    throws-like { sink $proc },
        X::Proc::Unsuccessful,
        'Exit with a segfault makes the Proc throw in sink context';
    nok $proc, 'Exit with a segfault makes the Proc false';
}

# vim: expandtab shiftwidth=4
