use v6;
use Test;

plan 6;

# RT #125248
my $test-str = "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋";
is $test-str.chars, 14, 'Correct value of .chars for string with many combiners';
is "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋".NFC.elems, 56, 'Can .NFC string with many combiners';
is "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋".NFD.elems, 57, 'Can .NFD string with many combiners';
is "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋".NFKC.elems, 56, 'Can .NFKC string with many combiners';
is "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋".NFKD.elems, 57, 'Can .NFKD string with many combiners';

# RT #129227
# We don't yet choose to set a maximum number of combiners, or a minimum that
# Perl 6 implementations must support. However, we should be sure that even if
# a ridiculously huge number is given, it either works or throws a catchable
# exception. This makes sure at the very least we do not SEGV in such cases,
# which is not acceptable behavior.
lives-ok { try 7 ~ "\x[308]" x 150_000 }, 'No VM crash on enormous number of combiners';
