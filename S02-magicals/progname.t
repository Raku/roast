use v6;

use Test;

plan 4;

ok(PROCESS::<$PROGRAM_NAME> ~~ / t['/'|'\\']spec['/'|'\\']S02'-'magicals['/'|'\\']progname'.'\w+$/, "progname var matches test file path");
ok($*PROGRAM_NAME ~~ / t['/'|'\\']spec['/'|'\\']S02'-'magicals['/'|'\\']progname'.'\w+$/, "progname var accessible as context var");

# NOTE:
# above is a junction hack for Unix and Win32 file
# paths until the FileSpec hack is working - Stevan
# changed junction hack in test 2 to regex for Rakudo fudged filename - mberends

#?niecza todo
lives_ok { $*PROGRAM_NAME = "coldfusion" }, '$*PROGRAM_NAME is assignable';

# RT #116164
{
    use lib 't/spec/packages';
    use Test::Util;
    is_run 'print $*PROGRAM_NAME', {
        out => -> $x { $x !~~ /IGNOREME/ },
    },
    :compiler-args['-IGNOREME'],
    :args['IGNOREME'],
    '$*PROGRAM_NAME is not confused by compiler options';
}


# vim: ft=perl6
