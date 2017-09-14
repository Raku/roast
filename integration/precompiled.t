use v6;
use lib 't/spec/packages', 'packages';

use Test;
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

plan 9;

loads_ok '42', "loads_ok is working";
precomp_loads_ok '42', "precomp_loads_ok is working";

# This was mysteriously broken with the previous CompUnit implementation.
# May have had something to do with dynamics. Maybe RT #82790 is relevant.
loads_is '42', 42, "loads_is is working";
precomp_loads_is '42', 42, "precomp_loads_is is working";

# RT #124162
precomp_loads_is '[ $(array[uint8].new(1)), $(array[uint8].new(1)) ]', [1,1],
                 "precompiled Array of native arrays (RT #124162)";

# RT #123679
precomp_loads_ok(['role Bar { has Str $.my-str handles <lines words> }','class Foo does Bar { }; my $io = Foo.new(:my-str<OHAI>);'], "precompiled role with handles trait on attribute");

precomp_loads_is 'BEGIN { EVAL "43" }', 43, "precompiled EVAL in BEGIN";

# RT #129856
loads_ok ['package Pod { class Ber {} }', 'Pod::Ber.new;'], 'a class in Pod namespace';
precomp_loads_ok ['package IO { class Ber {} }', 'IO::Ber.new;'], 'a class in IO namespace (precompiled)';

