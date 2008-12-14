use v6;

use Test;

plan 4;

# Printing a big string caused a stack overflow in pugs.
#
# On my system, this happens with 2**20 length strings but
# not 2*19.
#
# We don't want to print this to stdout, so we use a temporary file.
# Luckily (and bizarrely) the exception is catchable, so cleanup should
# be possible.

my $filename = "tmpfile.txt";
my $fh = open $filename, :w;

ok $fh, "temp file created successfully";

lives_ok {
        $fh.say: "a" x (2**19);
    }, "2**19 char string prints"; # works, on my system

lives_ok {
        $fh.say: "a" x (2**20);
    }, "2**20 char string prints"; # dies, on my system

$fh.close;

ok unlink($filename), "temp file unlinked successfully";
