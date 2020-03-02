use v6;

use Test;

constant $level = 2;

use lib $?FILE.IO.parent($level).add("packages/Test-Helpers");
use Test::Util;

plan 1;

my $path-to-dist = $?FILE.IO.parent($level).add("packages/Example/lib").absolute;

subtest 'RAKULIB' => {
    plan 1;
    my $env = %*ENV;
    $env<RAKULIB> = $path-to-dist;
    ok run($*EXECUTABLE.absolute, "-e", "use Example::A", :$env, :!err, :!out).so;
}
