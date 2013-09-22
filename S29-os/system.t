use v6;
use Test;

# L<S29/"OS"/"=item run">
# system is renamed to run, so link there. 

plan 5;

if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}

my $res;

$res = run($*EXECUTABLE_NAME,'-e1');
#?rakudo.jvm todo "nigh"
ok($res,"run() to an existing program does not die (and returns something true)");

$res = run("program_that_does_not_exist_ignore_this_error_please.exe");
ok(!$res, "run() to a nonexisting program does not die (and returns something false)");

$res = run("program_that_does_not_exist_ignore_errors_please.exe","a","b");
ok(!$res, "run() to a nonexisting program with an argument list does not die (and returns something false)");

chdir "t";
BEGIN { my $cwd = $*OS eq 'MSWin32' ?? 'cd' !! 'pwd' };
#?pugs skip 'qqx'
ok((qqx{$cwd} ne BEGIN qqx{$cwd}), 'qqx{} is affected by chdir()');
ok((run("dir", "t") != BEGIN { run("dir", "t") } ), 'run() is affected by chdir()');

# vim: ft=perl6
