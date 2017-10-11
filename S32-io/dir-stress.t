use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

plan 1;

with make-temp-dir() -> $dir {
    $dir.add("$_$_$_").spurt("") for "a".."z";

    ## Read the folder from multiple threads, and sanity-check each IO::Path.
    ## The sanity check should never fail, but at some point it does.
    is_run q:to/♥/,
        await do for ^200 {
            start {
                for \qq[$dir.perl()].dir -> $path {
                    die "FAILED!" if $path.absolute ne $path.Str
                }
            }
        }
        print 'pass';
    ♥
    {:out<pass>, :err(''), :0status},
    'dir() does not produce wrong results under concurrent load';
}

# vim: ft=perl6
