use v6;
use Test;

# L<S32::IO/IO::FileTests>

plan 30;

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
ok $existing-file.IO.e, 'It exists';
isa_ok $existing-file.IO.e, Bool, '.e returns Bool';
ok $existing-file.IO ~~ :e, 'It exists';
isa_ok $existing-file.IO ~~ :e, Bool, '~~ :e returns Bool';
nok $non-existent-file.IO.e, "It doesn't";
isa_ok $non-existent-file.IO.e, Bool, '.e returns Bool';
nok $non-existent-file.IO ~~ :e, "It doesn't";
isa_ok $non-existent-file.IO ~~ :e, Bool, '~~ :e returns Bool';

##is normal file
ok $existing-file.IO.f, 'Is normal file';
isa_ok $existing-file.IO.f, Bool, '.f returns Bool';
ok $existing-file.IO ~~ :f, 'Is normal file';
isa_ok $existing-file.IO ~~ :f, Bool, '~~ :f returns Bool';
# what should happen when this is called on a non-existent file?
nok $non-existent-file.IO.f, 'Is not a normal file';
isa_ok $non-existent-file.IO.f, Bool, '.f returns Bool';
ok $non-existent-file.IO ~~ :!f, 'Is not a normal file';
isa_ok $non-existent-file.IO ~~ :!f, Bool, '~~ :!f returns Bool';

##is empty
#?niecza skip 'Unable to resolve method s in class IO'
{
    nok $zero-length-file.IO.s, 'Is empty';
    isa_ok $zero-length-file.IO.s, Int, '.s returns Int';
    ok $zero-length-file.IO ~~ :!s, 'Is empty';
    isa_ok $zero-length-file.IO ~~ :!s, Bool, '~~ :!s returns Bool';
    ok $existing-file.IO.s, 'Is not';
    isa_ok $existing-file.IO.s, Int, '.s returns Int';
    ok $existing-file.IO ~~ :s, 'Is not';
    isa_ok $existing-file.IO ~~ :s, Bool, '~~ :s returns Bool';

    ##file size
    is $zero-length-file.IO.s, 0, 'No size';
    isa_ok $zero-length-file.IO.s, Int, '.s returns Int';
    is $existing-file.IO.s, 11, 'size of file';
    isa_ok $existing-file.IO.s, Int, '.s returns Int';
}

# clean up
ok unlink($existing-file), 'file has been removed';
ok unlink($zero-length-file), 'file has been removed';

# vim: ft=perl6
