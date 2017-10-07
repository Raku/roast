use v6;
use Test;

# L<S32::IO/IO::FileTests>

plan 5;

my $existing-file = "tempfile-file-tests";
my $non-existent-file = "non-existent-file-tests";
my $zero-length-file = "tempfile-zero-length-file-tests";

{ # write the file first
    my $fh = open($existing-file, :w);
    $fh.print: "0123456789A";
    $fh.close();
}

{ # write the file first
    my $fh = open($zero-length-file, :w);
    $fh.close();
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

# clean up
ok unlink($existing-file), 'file has been removed';
ok unlink($zero-length-file), 'file has been removed';

# vim: ft=perl6
