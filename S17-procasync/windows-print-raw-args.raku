#!/usr/bin/env raku

use NativeCall;

# The following blows up with:
# Malformed UTF-16; odd number of bytes (1)
#   in block GetCommandLineW
#sub GetCommandLineW() returns Str is encoded('utf16') is rw is native('Kernel32') { * }

sub GetCommandLineW() returns CArray[uint8] is rw is native('Kernel32') { * }
sub get-commandline() {
    my @nat-arr := GetCommandLineW();
    my @arr;
    for 0 .. * -> $i, $j {
        last if @nat-arr[$i] == @nat-arr[$j] == 0;
        @arr.push: @nat-arr[$i], @nat-arr[$j];
    }
    return Blob.new(@arr).decode('utf16');
}

say get-commandline();
