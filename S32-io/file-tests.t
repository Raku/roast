use v6;
use Test;

# L<S32::IO/IO::FileTests>

plan 7;

my $existing-file = "tempfile-file-tests";
my $non-existent-file = "non-existent-file-tests";
my $zero-length-file = "tempfile-zero-length-file-tests";
my $symlink-to-existing-file = "symlink-existing";
my $symlink-to-non-existent-file = "symlink-nonexisting";

{ # write the file first
    my $fh = open($existing-file, :w);
    $fh.print: "0123456789A";
    $fh.close();
}

{ # write the file first
    my $fh = open($zero-length-file, :w);
    $fh.close();
}

{ # Create a symlink to an existing file
    symlink($existing-file, $symlink-to-existing-file);
}

{ # Create a symlink to a non-existent file
    symlink($non-existent-file, $symlink-to-non-existent-file);
}

#Str methods
##existence
subtest ".e" => {
    plan 8;

    ok $existing-file.IO.e, 'It exists';
    isa-ok $existing-file.IO.e, Bool, '.e returns Bool';
    ok $existing-file.IO ~~ :e, 'It exists';
    isa-ok $existing-file.IO ~~ :e, Bool, '~~ :e returns Bool';
    nok $non-existent-file.IO.e, "It doesn't";
    isa-ok $non-existent-file.IO.e, Bool, '.e returns Bool';
    nok $non-existent-file.IO ~~ :e, "It doesn't";
    isa-ok $non-existent-file.IO ~~ :e, Bool, '~~ :e returns Bool';
}

subtest ".d" => {
    plan 2;

    subtest "Existing file" => {
        plan 4;

        nok $existing-file.IO.d, 'Existing file is not a directory';
        isa-ok $existing-file.IO.d, Bool, '.d returns Bool';
        nok $existing-file.IO ~~ :d, 'Existing file is not a directory';
        isa-ok $existing-file.IO ~~ :d, Bool, '~~ :d returns Bool';
    }

    subtest "Non-existent file" => {
        plan 4;

        nok $non-existent-file.IO.d, 'Non-existant file is also not a directory';
        isa-ok $non-existent-file.IO.d, Bool, '.d returns Bool';
        nok $non-existent-file.IO ~~ :d, 'Non-existant file is also not a directory';
        isa-ok $non-existent-file.IO ~~ :d, Bool, '~~ :d returns Bool';
    }
}

##is normal file
subtest ".f" => {
    plan 8;

    ok $existing-file.IO.f, 'Is normal file';
    isa-ok $existing-file.IO.f, Bool, '.f returns Bool';
    ok $existing-file.IO ~~ :f, 'Is normal file';
    isa-ok $existing-file.IO ~~ :f, Bool, '~~ :f returns Bool';
    nok $non-existent-file.IO.f, 'Is not a normal file';
    throws-like { $non-existent-file.IO.f }, X::IO::DoesNotExist;
    nok $non-existent-file.IO ~~ :f, 'Is not a normal file';
    isa-ok $non-existent-file.IO ~~ :f, Bool, '~~ :!f returns Bool';
}

##is empty
subtest ".s" => {
    plan 17;

    nok $zero-length-file.IO.s, 'Is empty';
    isa-ok $zero-length-file.IO.s, Int, '.s returns Int';
    ok $zero-length-file.IO ~~ :!s, 'Is empty';
    isa-ok $zero-length-file.IO ~~ :!s, Bool, '~~ :!s returns Bool';
    ok $existing-file.IO.s, 'Is not';
    isa-ok $existing-file.IO.s, Int, '.s returns Int';
    ok $existing-file.IO ~~ :s, 'Is not';
    isa-ok $existing-file.IO ~~ :s, Bool, '~~ :s returns Bool';

    ##file size
    is $zero-length-file.IO.s, 0, 'No size';
    isa-ok $zero-length-file.IO.s, Int, '.s returns Int';
    is $existing-file.IO.s, 11, 'size of file';
    isa-ok $existing-file.IO.s, Int, '.s returns Int';

    nok $non-existent-file.IO.s, 'Size on non-existent file';
    throws-like { $non-existent-file.IO.s }, X::IO::DoesNotExist;
    nok $non-existent-file.IO ~~ :s, 'Is not a normal file';
    isa-ok $non-existent-file.IO ~~ :s, Bool, '~~ :!s returns Bool';

    ##folder size
    lives-ok { ".".IO.s }, "Can get the size of a directory without dying";
}

subtest ".l" => {
    plan 4;

    subtest "Existing file" => {
        plan 4;

        nok $existing-file.IO.l, 'Existing file is not a symlink';
        isa-ok $existing-file.IO.l, Bool, '.l returns Bool';
        nok $existing-file.IO ~~ :l, 'Existing file is not a symlink';
        isa-ok $existing-file.IO ~~ :l, Bool, '~~ :l returns Bool';
    }

    subtest "Non-existent file" => {
        plan 4;

        nok $non-existent-file.IO.l, 'Non-existant file is also not a symlink';
        isa-ok $non-existent-file.IO.l, Bool, '.l returns Bool';
        nok $non-existent-file.IO ~~ :l, 'Non-existant file is also not a symlink';
        isa-ok $non-existent-file.IO ~~ :l, Bool, '~~ :l returns Bool';
    }

    subtest "Symlink to existing file" => {
        plan 4;

        ok $symlink-to-existing-file.IO.l, 'Existing file is a symlink';
        isa-ok $symlink-to-existing-file.IO.l, Bool, '.l returns Bool';
        ok $symlink-to-existing-file.IO ~~ :l, 'Existing file is a symlink';
        isa-ok $symlink-to-existing-file.IO ~~ :l, Bool, '~~ :l returns Bool';
    }

    subtest "Symlink to non-existant file" => {
        plan 4;

        ok $symlink-to-non-existent-file.IO.l, 'Symlink to non-existant file';
        isa-ok $symlink-to-non-existent-file.IO.l, Bool, '.l returns Bool';
        ok $symlink-to-non-existent-file.IO ~~ :l, 'Symlink to non-existant file';
        isa-ok $symlink-to-non-existent-file.IO ~~ :l, Bool, '~~ :l returns Bool';
    }
}

# clean up
ok unlink($existing-file), 'file has been removed';
ok unlink($zero-length-file), 'file has been removed';
ok unlink($symlink-to-existing-file), 'symlink has been removed';
ok unlink($symlink-to-non-existent-file), 'symlink has been removed';

# vim: ft=perl6
