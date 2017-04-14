use v6;
use Test;

plan 1;

# XXX TODO 6.d  move this test to Rakudo's test suite. The roast should not spec --rxtrace and this test file is not part of 6.c

{
    # RT #128050
    is run($*EXECUTABLE, "--rxtrace", "-e", q/say "hello world"/, :err, :out).err.slurp,
       "",
       '--rxtrace does not crash';
}
