use v6;
use Test;
use lib 't/spec/packages';
use lib 'packages';
use Test::Compile;

# Test::Compile is new and untested.  It is for simple precompilation
# bugs that do not involve the module loader itself, e.g. serialization
# difficulties.  For now, keep all tests that use it in here.

# It should theoretically autoskip tests for compilers that do not have
# full S10/S11 implementations, we'll see

# Please doublecheck after adding tests that no files that look like
# /tmp/p6testmod2CF3839E/p6testmod1406E1E1.pm6 (or windowish equiv)
# are left in $*TMPDIR.

# Note that S10-packages/precompilation.t exists for things that involve
# CompUnit or CompUnitRepo or are just too complex for Test::Compile
# A few of the tests in there could eventually be moved here, probably.

plan 5;

loads_ok '42', "loads_ok is working";
precomp_loads_ok '42', "precomp_loads_ok is working";

# This works if you delete the previous test.  Mysterious problem with
# dynamics.  Maybe look at RT #82790 as well, may be relevant.
#?rakudo todo "Something wrong with dynamic variables."
loads_is '42', 42, "loads_is is working";
precomp_loads_is '42', 42, "precomp_loads_is is working";

# RT #124162
precomp_loads_is '[ $(array[uint8].new(1)), $(array[uint8].new(1)) ]', [1,1],
                 "precompiled Array of native arrays (RT #124162)";
