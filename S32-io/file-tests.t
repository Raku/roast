use v6;
use Test;

# L<S32::IO/IO::FileTests>

plan 11;

my %tempfiles =
    existing => "tempfile-file-tests",
    non-existing => "non-existent-file-tests",
    zero => "tempfile-zero-length-file-tests",
    symlink-existing => "symlink-existing",
    symlink-non-existing => "symlink-nonexisting",
    r => "tempfile-perms-r",
    w => "tempfile-perms-w",
    x => "tempfile-perms-x",
    rw => "tempfile-perms-rw",
    rwx => "tempfile-perms-rwx",
    ;

{ # write the file first
    my $fh = open(%tempfiles<existing>, :w);
    $fh.print: "0123456789A";
    $fh.close();
}

{ # write the file first
    my $fh = open(%tempfiles<zero>, :w);
    $fh.close();
}

{ # Create a symlink to an existing file
    symlink(%tempfiles<existing>, %tempfiles<symlink-existing>);
}

{ # Create a symlink to a non-existent file
    symlink(%tempfiles<non-existing>, %tempfiles<symlink-non-existing>);
}

{ # Create a file with r--
    spurt(%tempfiles<r>, "");
    chmod(0o444, %tempfiles<r>);
}

{ # Create a file with -w-
    spurt(%tempfiles<w>, "");
    chmod(0o222, %tempfiles<w>);
}

{ # Create a file with --x
    spurt(%tempfiles<x>, "");
    chmod(0o111, %tempfiles<x>);
}

{ # Create a file with rw-
    spurt(%tempfiles<rw>, "");
    chmod(0o666, %tempfiles<rw>);
}

{ # Create a file with rwx
    spurt(%tempfiles<rwx>, "");
    chmod(0o777, %tempfiles<rwx>);
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
        throws-like { %tempfiles<non-existing>.IO.d }, X::IO::DoesNotExist;
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
    throws-like { %tempfiles<non-existing>.IO.f }, X::IO::DoesNotExist;
    nok %tempfiles<non-existing>.IO ~~ :f, 'Is not a normal file';
    isa-ok %tempfiles<non-existing>.IO ~~ :f, Bool, '~~ :!f returns Bool';
}

##is empty
subtest ".s" => {
    plan 17;

    nok %tempfiles<zero>.IO.s, 'Is empty';
    isa-ok %tempfiles<zero>.IO.s, Int, '.s returns Int';
    ok %tempfiles<zero>.IO ~~ :!s, 'Is empty';
    isa-ok %tempfiles<zero>.IO ~~ :!s, Bool, '~~ :!s returns Bool';
    ok %tempfiles<existing>.IO.s, 'Is not';
    isa-ok %tempfiles<existing>.IO.s, Int, '.s returns Int';
    ok %tempfiles<existing>.IO ~~ :s, 'Is not';
    isa-ok %tempfiles<existing>.IO ~~ :s, Bool, '~~ :s returns Bool';

    ##file size
    is %tempfiles<zero>.IO.s, 0, 'No size';
    isa-ok %tempfiles<zero>.IO.s, Int, '.s returns Int';
    is %tempfiles<existing>.IO.s, 11, 'size of file';
    isa-ok %tempfiles<existing>.IO.s, Int, '.s returns Int';

    nok %tempfiles<non-existing>.IO.s, 'Size on non-existent file';
    throws-like { %tempfiles<non-existing>.IO.s }, X::IO::DoesNotExist;
    nok %tempfiles<non-existing>.IO ~~ :s, 'Is not a normal file';
    isa-ok %tempfiles<non-existing>.IO ~~ :s, Bool, '~~ :!s returns Bool';

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
        throws-like { %tempfiles<non-existing>.IO.l }, X::IO::DoesNotExist;
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
        throws-like { %tempfiles<non-existing>.IO.r }, X::IO::DoesNotExist;
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
        throws-like { %tempfiles<non-existing>.IO.w }, X::IO::DoesNotExist;
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
        throws-like { %tempfiles<non-existing>.IO.rw }, X::IO::DoesNotExist;
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
        throws-like { %tempfiles<non-existing>.IO.x }, X::IO::DoesNotExist;
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
        throws-like { %tempfiles<non-existing>.IO.rwx }, X::IO::DoesNotExist;
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

# clean up
subtest "Cleanup" => {
    plan %tempfiles.elems;

    for %tempfiles.keys -> $file {
        ok unlink(%tempfiles{$file}), "Testfile $file has been removed";
    }
}

# vim: ft=perl6
