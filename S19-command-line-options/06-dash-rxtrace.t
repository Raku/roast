use v6;
use Test;

plan 1;

{
    # RT #128050
    is run($*EXECUTABLE, "--rxtrace", "-e", q/say "hello world"/, :err, :out).err.slurp-rest,
       "",
       '--rxtrace does not crash';
}
