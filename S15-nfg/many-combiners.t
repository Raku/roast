use v6;
use Test;

plan 5;

# RT #125248
my $test-str = "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋";
is $test-str.chars, 14, 'Correct value of .chars for string with many combiners';
is "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋".NFC.elems, 56, 'Can .NFC string with many combiners';
is "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋".NFD.elems, 57, 'Can .NFD string with many combiners';
is "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋".NFKC.elems, 56, 'Can .NFKC string with many combiners';
is "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋".NFKD.elems, 57, 'Can .NFKD string with many combiners';
