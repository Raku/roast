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
        #?rakudo.jvm todo 'IOException "no such file" RT 128594'
        is_run q{run("non-existent-program-RT128594", :merge).out.slurp},
            { status => 0 },
        ":merge with run on non-existent program does not crash [attempt $_]";
    }
}

# RT #128398
#?rakudo.jvm skip 'Type check failed in binding to parameter $!bin; expected Bool but got Int (0)'
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
subtest '&chdir changes the directory processes are spawned in' => {
    plan 2;

    my $cwd = $*CWD;
    LEAVE chdir $cwd;

    my $env = %*ENV andthen {
        .<PATH> = join(':', $*EXECUTABLE.parent, %*ENV<PATH>);
    }

    my $qqx-cmd = "{$*EXECUTABLE.basename} -e '{q|$*CWD.absolute.print|}'";
    my @run-cmd = $*EXECUTABLE.basename, '-e', '$*CWD.absolute.print';

    my $qqx-cwd-before = qqx{$qqx-cmd.split(' ')};
    my $run-dir-before = run(@run-cmd, :out).out.slurp(:close);

    chdir 't';

    my $qqx-cwd-after = qqx{$qqx-cmd.split(' ')};
    my $run-dir-after = run(@run-cmd, :out).out.slurp(:close);

    isnt $qqx-cwd-before, $qqx-cwd-after, 'qqx{} is affected by chdir()';
    isnt $run-dir-before, $run-dir-after, 'run() is affected by chdir()';
}

# https://irclog.perlgeek.de/perl6-dev/2017-06-13#i_14727506
subtest ':cwd(...) changes the directory processes are spawned in' => {
    plan 1;

    my $new-cwd = make-temp-dir;
    $new-cwd.add('blah').spurt: 'Testing';

    my $env = %*ENV andthen {
        .<FOOMEOW> = 42;
        .<PATH> = join(':', $*EXECUTABLE.parent, %*ENV<PATH>);
    }

    my $proc = run(:out, :!err, :cwd($new-cwd.absolute), :$env,
        $*EXECUTABLE.basename, '-e', 'q|blah|.IO.slurp.print; %*ENV<FOOMEOW>.print;'
    );

    my $output = $proc.out.slurp(:close).join;

    is $output, 'Testing42', 'run sets $cwd and $env';
}

subtest '.out/.err proc pipes on failed command' => {
    plan 4;

    throws-like { run(:out, "meooooooows").out.close }, X::Proc::Unsuccessful,
        '.out.close Proc explodes when sunk';
    throws-like { run(:err, "meooooooows").err.close }, X::Proc::Unsuccessful,
        '.err.close Proc explodes when sunk';
    is-deeply run(:out, "meooooooows").out.slurp(:close), '',
        '.out.slurp is empty';
    is-deeply run(:err, "meooooooows").err.slurp(:close), '',
        '.err.slurp is empty';
}

# vim: ft=perl6
