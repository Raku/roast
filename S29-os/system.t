use v6;
use Test;

# L<S29/"OS"/"=item run">
# system is renamed to run, so link there. 

plan 3;

if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}

my $pugs = ($*OS eq any(<MSWin32 mingw msys cygwin>))
         ?? 'pugs.exe'
         !! $*EXECUTABLE_NAME;

my $res;

$res = run($pugs,'-e1');
ok($res,"run() to an existing program does not die (and returns something true)");

$res = run("program_that_does_not_exist_ignore_this_error_please.exe");
ok(!$res, "run() to a nonexisting program does not die (and returns something false)");

$res = run("program_that_does_not_exist_ignore_errors_please.exe","a","b");
ok(!$res, "run() to a nonexisting program with an argument list does not die (and returns something false)");
