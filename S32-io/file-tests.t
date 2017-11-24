#! /usr/bin/env perl6

use v6.c;
use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;

# L<S32::IO/IO::FileTests>

plan 16;

my %tempfiles =
    existing => make-temp-file(:content("0123456789A")),
    non-existing => "non-existent-file-tests",
    zero => make-temp-file(:content()),
    symlink-existing => "symlink-existing",
    symlink-non-existing => "symlink-nonexisting",
    r => make-temp-file(:chmod(0o444)),
    w => make-temp-file(:chmod(0o222)),
    x => make-temp-file(:chmod(0o111)),
    rw => make-temp-file(:chmod(0o666)),
    rwx => make-temp-file(:chmod(0o777)),
    ;

{ # Create a symlink to an existing file
    symlink(%tempfiles<existing>, %tempfiles<symlink-existing>);
}

{ # Create a symlink to a non-existent file
    symlink(%tempfiles<non-existing>, %tempfiles<symlink-non-existing>);
}

#Str methods
##existence
subtest ".e" => {
    plan 8;

    ok %tempfiles<existing>.IO.e, 'It exists';
    isa-ok %tempfiles<existing>.IO.e, Bool, '.e returns Bool';
    ok %tempfiles<existing>.IO ~~ :e, 'It exists';
    isa-ok %tempfiles<existing>.IO ~~ :e, Bool, '~~ :e returns Bool';
    nok %tempfiles<non-existing>.IO.e, "It doesn't";
    isa-ok %tempfiles<non-existing>.IO.e, Bool, '.e returns Bool';
    nok %tempfiles<non-existing>.IO ~~ :e, "It doesn't";
    isa-ok %tempfiles<non-existing>.IO ~~ :e, Bool, '~~ :e returns Bool';
}

subtest ".d" => {
    plan 2;

    subtest "Existing file" => {
        plan 4;

        nok %tempfiles<existing>.IO.d, 'Existing file is not a directory';
        isa-ok %tempfiles<existing>.IO.d, Bool, '.d returns Bool';
        nok %tempfiles<existing>.IO ~~ :d, 'Existing file is not a directory';
        isa-ok %tempfiles<existing>.IO ~~ :d, Bool, '~~ :d returns Bool';
    }

    subtest "Non-existent file" => {
        plan 4;

        nok %tempfiles<non-existing>.IO.d, 'Non-existant file is also not a directory';
        fails-like { %tempfiles<non-existing>.IO.d }, X::IO::DoesNotExist;
        nok %tempfiles<non-existing>.IO ~~ :d, 'Non-existant file is also not a directory';
        isa-ok %tempfiles<non-existing>.IO ~~ :d, Bool, '~~ :d returns Bool';
    }
}

##is normal file
subtest ".f" => {
    plan 8;

    ok %tempfiles<existing>.IO.f, 'Is normal file';
    isa-ok %tempfiles<existing>.IO.f, Bool, '.f returns Bool';
    ok %tempfiles<existing>.IO ~~ :f, 'Is normal file';
    isa-ok %tempfiles<existing>.IO ~~ :f, Bool, '~~ :f returns Bool';
    nok %tempfiles<non-existing>.IO.f, 'Is not a normal file';
    fails-like { %tempfiles<non-existing>.IO.f }, X::IO::DoesNotExist;
    nok %tempfiles<non-existing>.IO ~~ :f, 'Is not a normal file';
    isa-ok %tempfiles<non-existing>.IO ~~ :f, Bool, '~~ :!f returns Bool';
}

##is empty
subtest ".s" => {
    plan 5;

    subtest "Non-existing file" => {
        plan 4;

        nok %tempfiles<non-existing>.IO.s, 'Size on non-existent file';
        fails-like { %tempfiles<non-existing>.IO.s }, X::IO::DoesNotExist;
        nok %tempfiles<non-existing>.IO ~~ :s, 'Is not a normal file';
        isa-ok %tempfiles<non-existing>.IO ~~ :s, Bool, '~~ :!s returns Bool';
    }

    subtest "Existing file with content" => {
        plan 4;

        ok %tempfiles<existing>.IO.s, 'Is not';
        isa-ok %tempfiles<existing>.IO.s, Int, '.s returns Int';
        ok %tempfiles<existing>.IO ~~ :s, 'Is not';
        isa-ok %tempfiles<existing>.IO ~~ :s, Bool, '~~ :s returns Bool';
    }

    subtest "Existing file with zero-length" => {
        plan 4;

        nok %tempfiles<zero>.IO.s, 'Is empty';
        isa-ok %tempfiles<zero>.IO.s, Int, '.s returns Int';
        ok %tempfiles<zero>.IO ~~ :!s, 'Is empty';
        isa-ok %tempfiles<zero>.IO ~~ :!s, Bool, '~~ :!s returns Bool';
    }

    subtest "Get filesize" => {
        plan 4;

        is %tempfiles<zero>.IO.s, 0, 'No size';
        isa-ok %tempfiles<zero>.IO.s, Int, '.s returns Int';

        is %tempfiles<existing>.IO.s, 11, 'size of file';
        isa-ok %tempfiles<existing>.IO.s, Int, '.s returns Int';
    }

    ##folder size
    lives-ok { ".".IO.s }, "Can get the size of a directory without dying";
}

subtest ".l" => {
    plan 4;

    subtest "Existing file" => {
        plan 4;

        nok %tempfiles<existing>.IO.l, 'Existing file is not a symlink';
        isa-ok %tempfiles<existing>.IO.l, Bool, '.l returns Bool';
        nok %tempfiles<existing>.IO ~~ :l, 'Existing file is not a symlink';
        isa-ok %tempfiles<existing>.IO ~~ :l, Bool, '~~ :l returns Bool';
    }

    subtest "Non-existent file" => {
        plan 4;

        nok %tempfiles<non-existing>.IO.l, 'Non-existant file is also not a symlink';
        fails-like { %tempfiles<non-existing>.IO.l }, X::IO::DoesNotExist;
        nok %tempfiles<non-existing>.IO ~~ :l, 'Non-existant file is also not a symlink';
        isa-ok %tempfiles<non-existing>.IO ~~ :l, Bool, '~~ :l returns Bool';
    }

    subtest "Symlink to existing file" => {
        plan 4;

        ok %tempfiles<symlink-existing>.IO.l, 'Existing file is a symlink';
        isa-ok %tempfiles<symlink-existing>.IO.l, Bool, '.l returns Bool';
        ok %tempfiles<symlink-existing>.IO ~~ :l, 'Existing file is a symlink';
        isa-ok %tempfiles<symlink-existing>.IO ~~ :l, Bool, '~~ :l returns Bool';
    }

    subtest "Symlink to non-existant file" => {
        plan 4;

        ok %tempfiles<symlink-non-existing>.IO.l, 'Symlink to non-existant file';
        isa-ok %tempfiles<symlink-non-existing>.IO.l, Bool, '.l returns Bool';
        ok %tempfiles<symlink-non-existing>.IO ~~ :l, 'Symlink to non-existant file';
        isa-ok %tempfiles<symlink-non-existing>.IO ~~ :l, Bool, '~~ :l returns Bool';
    }
}

subtest ".r" => {
    plan 6;

    subtest "Non-existing file" => {
        plan 4;

        nok %tempfiles<non-existing>.IO.r, 'Non-existing file is not readable';
        fails-like { %tempfiles<non-existing>.IO.r }, X::IO::DoesNotExist;
        nok %tempfiles<non-existing>.IO ~~ :r, 'Non-existing file is not readable';
        isa-ok %tempfiles<non-existing>.IO ~~ :r, Bool, '~~ :r returns Bool';
    }

    subtest "File with r--" => {
        plan 4;

        ok %tempfiles<r>.IO.r, 'File with r-- is readable';
        isa-ok %tempfiles<r>.IO.r, Bool, '.r returns Bool';
        ok %tempfiles<r>.IO ~~ :r, 'File with r-- is readable';
        isa-ok %tempfiles<r>.IO ~~ :r, Bool, '~~ :r returns Bool';
    }

    subtest "File with -w-" => {
        plan 4;

        nok %tempfiles<w>.IO.r, 'File with -w- is not readable';
        isa-ok %tempfiles<w>.IO.r, Bool, '.r returns Bool';
        nok %tempfiles<w>.IO ~~ :r, 'File with -w- is not readable';
        isa-ok %tempfiles<w>.IO ~~ :r, Bool, '~~ :r returns Bool';
    }

    subtest "File with --x" => {
        plan 4;

        nok %tempfiles<x>.IO.r, 'File with --x is not readable';
        isa-ok %tempfiles<x>.IO.r, Bool, '.r returns Bool';
        nok %tempfiles<x>.IO ~~ :r, 'File with --x is not readable';
        isa-ok %tempfiles<x>.IO ~~ :r, Bool, '~~ :r returns Bool';
    }

    subtest "File with rw-" => {
        plan 4;

        ok %tempfiles<rw>.IO.r, 'File with rw- is readable';
        isa-ok %tempfiles<rw>.IO.r, Bool, '.r returns Bool';
        ok %tempfiles<rw>.IO ~~ :r, 'File with rw- is readable';
        isa-ok %tempfiles<rw>.IO ~~ :r, Bool, '~~ :r returns Bool';
    }

    subtest "File with rwx" => {
        plan 4;

        ok %tempfiles<rwx>.IO.r, 'File with rwx is readable';
        isa-ok %tempfiles<rwx>.IO.r, Bool, '.r returns Bool';
        ok %tempfiles<rwx>.IO ~~ :r, 'File with rwx is readable';
        isa-ok %tempfiles<rwx>.IO ~~ :r, Bool, '~~ :r returns Bool';
    }
}

subtest ".w" => {
    plan 6;

    subtest "Non-existing file" => {
        plan 4;

        nok %tempfiles<non-existing>.IO.w, 'Non-existing file is not writable';
        fails-like { %tempfiles<non-existing>.IO.w }, X::IO::DoesNotExist;
        nok %tempfiles<non-existing>.IO ~~ :w, 'Non-existing file is not writable';
        isa-ok %tempfiles<non-existing>.IO ~~ :w, Bool, '~~ :r returns Bool';
    }

    subtest "File with r--" => {
        plan 4;

        nok %tempfiles<r>.IO.w, 'File with r-- is not writable';
        isa-ok %tempfiles<r>.IO.w, Bool, '.w returns Bool';
        nok %tempfiles<r>.IO ~~ :w, 'File with r-- is not writable';
        isa-ok %tempfiles<r>.IO ~~ :w, Bool, '~~ :r returns Bool';
    }

    subtest "File with -w-" => {
        plan 4;

        ok %tempfiles<w>.IO.w, 'File with -w- is writable';
        isa-ok %tempfiles<w>.IO.w, Bool, '.w returns Bool';
        ok %tempfiles<w>.IO ~~ :w, 'File with -w- is writable';
        isa-ok %tempfiles<w>.IO ~~ :w, Bool, '~~ :r returns Bool';
    }

    subtest "File with --x" => {
        plan 4;

        nok %tempfiles<x>.IO.w, 'File with --x is not writable';
        isa-ok %tempfiles<x>.IO.w, Bool, '.w returns Bool';
        nok %tempfiles<x>.IO ~~ :w, 'File with --x is not writable';
        isa-ok %tempfiles<x>.IO ~~ :w, Bool, '~~ :r returns Bool';
    }

    subtest "File with rw-" => {
        plan 4;

        ok %tempfiles<rw>.IO.w, 'File with rw- is writable';
        isa-ok %tempfiles<rw>.IO.w, Bool, '.w returns Bool';
        ok %tempfiles<rw>.IO ~~ :w, 'File with rw- is writable';
        isa-ok %tempfiles<rw>.IO ~~ :w, Bool, '~~ :r returns Bool';
    }

    subtest "File with rwx" => {
        plan 4;

        ok %tempfiles<rwx>.IO.w, 'File with rwx is writable';
        isa-ok %tempfiles<rwx>.IO.w, Bool, '.w returns Bool';
        ok %tempfiles<rwx>.IO ~~ :w, 'File with rwx is writable';
        isa-ok %tempfiles<rwx>.IO ~~ :w, Bool, '~~ :r returns Bool';
    }
}

subtest ".rw" => {
    plan 6;

    subtest "Non-existing file" => {
        plan 4;

        nok %tempfiles<non-existing>.IO.rw, 'Non-existing file is not readable and writable';
        fails-like { %tempfiles<non-existing>.IO.rw }, X::IO::DoesNotExist;
        nok %tempfiles<non-existing>.IO ~~ :rw, 'Non-existing file is not readbale and writable';
        isa-ok %tempfiles<non-existing>.IO ~~ :rw, Bool, '~~ :r returns Bool';
    }

    subtest "File with r--" => {
        plan 4;

        nok %tempfiles<r>.IO.rw, 'File with r-- is not readable and writable';
        isa-ok %tempfiles<r>.IO.rw, Bool, '.rw returns Bool';
        nok %tempfiles<r>.IO ~~ :rw, 'File with r-- is not readable and writable';
        isa-ok %tempfiles<r>.IO ~~ :rw, Bool, '~~ :r returns Bool';
    }

    subtest "File with -w-" => {
        plan 4;

        nok %tempfiles<w>.IO.rw, 'File with -w- is not readable and writable';
        isa-ok %tempfiles<w>.IO.rw, Bool, '.rw returns Bool';
        nok %tempfiles<w>.IO ~~ :rw, 'File with -w- is not readable and writable';
        isa-ok %tempfiles<w>.IO ~~ :rw, Bool, '~~ :r returns Bool';
    }

    subtest "File with --x" => {
        plan 4;

        nok %tempfiles<x>.IO.rw, 'File with --x is not readable and writable';
        isa-ok %tempfiles<x>.IO.rw, Bool, '.rw returns Bool';
        nok %tempfiles<x>.IO ~~ :rw, 'File with --x is not readable and writable';
        isa-ok %tempfiles<x>.IO ~~ :rw, Bool, '~~ :r returns Bool';
    }

    subtest "File with rw-" => {
        plan 4;

        ok %tempfiles<rw>.IO.rw, 'File with rw- is readable and writable';
        isa-ok %tempfiles<rw>.IO.rw, Bool, '.rw returns Bool';
        ok %tempfiles<rw>.IO ~~ :rw, 'File with rw- is readable and writable';
        isa-ok %tempfiles<rw>.IO ~~ :rw, Bool, '~~ :r returns Bool';
    }

    subtest "File with rwx" => {
        plan 4;

        ok %tempfiles<rwx>.IO.rw, 'File with rwx is readable and writable';
        isa-ok %tempfiles<rwx>.IO.rw, Bool, '.rw returns Bool';
        ok %tempfiles<rwx>.IO ~~ :rw, 'File with rwx is readable and writable';
        isa-ok %tempfiles<rwx>.IO ~~ :rw, Bool, '~~ :r returns Bool';
    }
}

subtest ".x" => {
    plan 6;

    subtest "Non-existing file" => {
        plan 4;

        nok %tempfiles<non-existing>.IO.x, 'Non-existing file is not executable';
        fails-like { %tempfiles<non-existing>.IO.x }, X::IO::DoesNotExist;
        nok %tempfiles<non-existing>.IO ~~ :x, 'Non-existing file is not executable';
        isa-ok %tempfiles<non-existing>.IO ~~ :x, Bool, '~~ :r returns Bool';
    }

    subtest "File with r--" => {
        plan 4;

        nok %tempfiles<r>.IO.x, 'File with r-- is not executable';
        isa-ok %tempfiles<r>.IO.x, Bool, '.w returns Bool';
        nok %tempfiles<r>.IO ~~ :x, 'File with r-- is not executable';
        isa-ok %tempfiles<r>.IO ~~ :x, Bool, '~~ :r returns Bool';
    }

    subtest "File with -w-" => {
        plan 4;

        nok %tempfiles<w>.IO.x, 'File with -w- is not executable';
        isa-ok %tempfiles<w>.IO.x, Bool, '.w returns Bool';
        nok %tempfiles<w>.IO ~~ :x, 'File with -w- is not executable';
        isa-ok %tempfiles<w>.IO ~~ :x, Bool, '~~ :r returns Bool';
    }

    subtest "File with --x" => {
        plan 4;

        ok %tempfiles<x>.IO.x, 'File with --x is executable';
        isa-ok %tempfiles<x>.IO.x, Bool, '.w returns Bool';
        ok %tempfiles<x>.IO ~~ :x, 'File with --x is executable';
        isa-ok %tempfiles<x>.IO ~~ :x, Bool, '~~ :r returns Bool';
    }

    subtest "File with rw-" => {
        plan 4;

        nok %tempfiles<rw>.IO.x, 'File with rw- is not executable';
        isa-ok %tempfiles<rw>.IO.x, Bool, '.w returns Bool';
        nok %tempfiles<rw>.IO ~~ :x, 'File with rw- is not executable';
        isa-ok %tempfiles<rw>.IO ~~ :x, Bool, '~~ :r returns Bool';
    }

    subtest "File with rwx" => {
        plan 4;

        ok %tempfiles<rwx>.IO.x, 'File with rwx is executable';
        isa-ok %tempfiles<rwx>.IO.x, Bool, '.w returns Bool';
        ok %tempfiles<rwx>.IO ~~ :x, 'File with rwx is executable';
        isa-ok %tempfiles<rwx>.IO ~~ :x, Bool, '~~ :r returns Bool';
    }
}

subtest ".rwx" => {
    plan 6;

    subtest "Non-existing file" => {
        plan 4;

        nok %tempfiles<non-existing>.IO.rwx, 'Non-existing file is not readable, writable and executable';
        fails-like { %tempfiles<non-existing>.IO.rwx }, X::IO::DoesNotExist;
        nok %tempfiles<non-existing>.IO ~~ :rwx, 'Non-existing file is not readable, writable and executable';
        isa-ok %tempfiles<non-existing>.IO ~~ :rwx, Bool, '~~ :rwx returns Bool';
    }

    subtest "File with r--" => {
        plan 4;

        nok %tempfiles<r>.IO.rwx, 'File with r-- is not readable, writable and executable';
        isa-ok %tempfiles<r>.IO.rwx, Bool, '.rwx returns Bool';
        nok %tempfiles<r>.IO ~~ :rwx, 'File with r-- is not readable, writable and executable';
        isa-ok %tempfiles<r>.IO ~~ :rwx, Bool, '~~ :rwx returns Bool';
    }

    subtest "File with -w-" => {
        plan 4;

        nok %tempfiles<w>.IO.rwx, 'File with -w- is not readable, writable and executable';
        isa-ok %tempfiles<w>.IO.rwx, Bool, '.rwx returns Bool';
        nok %tempfiles<w>.IO ~~ :rwx, 'File with -w- is not readable, writable and executable';
        isa-ok %tempfiles<w>.IO ~~ :rwx, Bool, '~~ :rwx returns Bool';
    }

    subtest "File with --x" => {
        plan 4;

        nok %tempfiles<x>.IO.rwx, 'File with --x is not readable, writable and executable';
        isa-ok %tempfiles<x>.IO.rwx, Bool, '.rwx returns Bool';
        nok %tempfiles<x>.IO ~~ :rwx, 'File with --x is not readable, writable and executable';
        isa-ok %tempfiles<x>.IO ~~ :rwx, Bool, '~~ :rwx returns Bool';
    }

    subtest "File with rw-" => {
        plan 4;

        nok %tempfiles<rw>.IO.rwx, 'File with rw- is not readable, writable and executable';
        isa-ok %tempfiles<rw>.IO.rwx, Bool, '.rwx returns Bool';
        nok %tempfiles<rw>.IO ~~ :rwx, 'File with rw- is not readable, writable and executable';
        isa-ok %tempfiles<rw>.IO ~~ :rwx, Bool, '~~ :rwx returns Bool';
    }

    subtest "File with rwx" => {
        plan 4;

        ok %tempfiles<rwx>.IO.rwx, 'File with rwx is readable, writable and executable';
        isa-ok %tempfiles<rwx>.IO.rwx, Bool, '.rwx returns Bool';
        ok %tempfiles<rwx>.IO ~~ :rwx, 'File with rwx is readable, writable and executable';
        isa-ok %tempfiles<rwx>.IO ~~ :rwx, Bool, '~~ :rwx returns Bool';
    }
}

subtest ".z" => {
    plan 3;

    subtest "Non-existing file" => {
        plan 4;

        nok %tempfiles<non-existing>.IO.z, 'Non-existing file returns false on .z';
        fails-like { %tempfiles<non-existing>.IO.z }, X::IO::DoesNotExist;
        nok %tempfiles<non-existing>.IO ~~ :z, 'Non-existing file returns false on :z';
        isa-ok %tempfiles<non-existing>.IO ~~ :z, Bool, '~~ :z returns Bool';
    }

    subtest "Existing file with zero-length content" => {
        plan 4;

        nok %tempfiles<existing>.IO.z, 'Existing file with non-zero-length content returns false on .z';
        isa-ok %tempfiles<existing>.IO.z, Bool, '.z returns Bool';
        nok %tempfiles<existing>.IO ~~ :z, 'Existing file with non-zero-length content returns false on :z';
        isa-ok %tempfiles<existing>.IO ~~ :z, Bool, '~~ :z returns Bool';
    }

    subtest "Existing file with none-zero-length content" => {
        plan 4;

        ok %tempfiles<zero>.IO.z, 'Existing file with zero-length content returns true on .z';
        isa-ok %tempfiles<zero>.IO.z, Bool, '.z returns Bool';
        ok %tempfiles<zero>.IO ~~ :z, 'Existing file with zero-length content returns true on :z';
        isa-ok %tempfiles<zero>.IO ~~ :z, Bool, '~~ :z returns Bool';
    }
}

subtest ".modified" => {
    plan 2;

    subtest "Non-existing file" => {
        plan 1;

        fails-like { %tempfiles<non-existing>.IO.modified }, X::IO::DoesNotExist;
    }

    subtest "Existing file" => {
        plan 1;

        isa-ok %tempfiles<existing>.IO.modified, (Instant), '.modified returns Instant';
    }
}

subtest ".accessed" => {
    plan 2;

    subtest "Non-existing file" => {
        plan 1;

        fails-like { %tempfiles<non-existing>.IO.accessed}, X::IO::DoesNotExist;
    }

    subtest "Existing file" => {
        plan 1;

        isa-ok %tempfiles<existing>.IO.accessed, (Instant), '.accessed returns Instant';
    }
}

subtest ".changed" => {
    plan 2;

    subtest "Non-existing file" => {
        plan 1;

        fails-like { %tempfiles<non-existing>.IO.changed}, X::IO::DoesNotExist;
    }

    subtest "Existing file" => {
        plan 1;

        isa-ok %tempfiles<existing>.IO.changed, (Instant), '.changed returns Instant';
    }
}

subtest ".mode" => {
    my %tests =
        r => 0o444,
        w => 0o222,
        x => 0o111,
        rw => 0o666,
        rwx => 0o777,
        ;

    plan (1 + %tests.elems);

    subtest "Non-existing file" => {
        plan 1;
        fails-like { %tempfiles<non-existing>.IO.mode}, X::IO::DoesNotExist;
    }

    for %tests.keys -> $mode {
        subtest $mode => {
            plan 3;

            isa-ok %tempfiles{$mode}.IO.mode, IntStr, ".mode returns IntStr";

            is %tempfiles{$mode}.IO.mode, "0%o".sprintf(%tests{$mode}), ".mode returns correct value";
            is %tempfiles{$mode}.IO.mode.Int, %tests{$mode}, ".mode.Int returns correct value";
        }
    }
}

# clean up
subtest "Cleanup" => {
    my @cleanup = (
        "symlink-existing",
        "symlink-non-existing",
    );

    plan @cleanup.elems;

    for @cleanup -> $file {
        ok unlink(%tempfiles{$file}), "Testfile $file has been removed";
    }
}

# vim: ft=perl6
