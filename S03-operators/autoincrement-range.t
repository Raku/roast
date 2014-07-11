use v6;
use Test;

plan 96;

# TODO: Check that "Failure" results are "Decrement out of range"
#       and not some other unrelated error.

my $x;

{
    diag( "Tests for 'A' .. 'Z'" );
    $x = "ZZ";
    is( ++$x, "AAA", "'ZZ'++ is 'AAA'" );
    $x = "AAA";
    #?niecza skip "Failure NYI"
    ok( --$x ~~ Failure, "'AAA'-- fails" );
    $x = "0A";
    is( ++$x, "0B", "'0A'++ is '0B'" );
    $x = "0B";
    is( --$x, "0A", "'0B'-- is '0A'" );
    $x = "0Z";
    is( ++$x, "1A", "'0Z'++ is '1A'" );
    $x = "1A";
    is( --$x, "0Z", "'1A'-- is '0Z'" );
    $x = "A99";
    is( ++$x, "B00", "'A99'++ is 'B00'" );
    $x = "B00";
    is( --$x, "A99", "'B00'-- is 'A99'" );
}
{
    diag( "Tests for 'a' .. 'z'" );
    $x = "zz";
    is( ++$x, "aaa", "'zz'++ is 'aaa'" );
    $x = "aaa";
    #?niecza skip "Failure NYI"
    ok( --$x ~~ Failure, "'aaa'-- fails" );
    $x = "0a";
    is( ++$x, "0b", "'0a'++ is '0b'" );
    $x = "0b";
    is( --$x, "0a", "'0b'-- is '0a'" );
    $x = "0z";
    is( ++$x, "1a", "'0z'++ is '1a'" );
    $x = "1a";
    is( --$x, "0z", "'1a'-- is '0z'" );
    $x = "a99";
    is( ++$x, "b00", "'a99'++ is 'b00'" );
    $x = "b00";
    is( --$x, "a99", "'b00'-- is 'a99'" );
}
{
    diag( "Tests for '\x[391]' .. '\x[3a9]' (Greek uppercase)" );
    $x = "\x[3a9]\x[3a9]";
    is( ++$x, "\x[391]\x[391]\x[391]",
        "'\x[3a9]\x[3a9]'++ is '\x[391]\x[391]\x[391]'" );
    $x = "\x[391]\x[391]\x[391]";
    #?niecza skip "Failure NYI"
    ok( --$x ~~ Failure, "'\x[391]\x[391]\x[391]'-- fails" );
    $x = "A\x[391]";
    is( ++$x, "A\x[392]", "'A\x[391]'++ is 'A\x[392]'" );
    $x = "A\x[392]";
    is( --$x, "A\x[391]", "'A\x[392]'-- is 'A\x[391]'" );
    $x = "A\x[3a9]";
    is( ++$x, "B\x[391]", "'A\x[3a9]'++ is 'B\x[391]'" );
    $x = "B\x[391]";
    is( --$x, "A\x[3a9]", "'B\x[391]'-- is 'A\x[3a9]'" );
    $x = "\x[391]ZZ";
    is( ++$x, "\x[392]AA", "'\x[391]ZZ'++ is '\x[392]AA'" );
    $x = "\x[392]AA";
    is( --$x, "\x[391]ZZ", "'\x[392]AA'-- is '\x[391]ZZ'" );
}
{
    diag( "Tests for '\x[3b1]' .. '\x[3c9]' (Greek lowercase)" );
    $x = "\x[3c9]\x[3c9]";
    is( ++$x, "\x[3b1]\x[3b1]\x[3b1]",
        "'\x[3c9]\x[3c9]'++ is '\x[3b1]\x[3b1]\x[3b1]'" );
    $x = "\x[3b1]\x[3b1]\x[3b1]";
    #?niecza skip "Failure NYI"
    ok( --$x ~~ Failure, "'\x[3b1]\x[3b1]\x[3b1]'-- fails" );
    $x = "A\x[3b1]";
    is( ++$x, "A\x[3b2]", "'A\x[3b1]'++ is 'A\x[3b2]'" );
    $x = "A\x[3b2]";
    is( --$x, "A\x[3b1]", "'A\x[3b2]'-- is 'A\x[3b1]'" );
    $x = "A\x[3c9]";
    is( ++$x, "B\x[3b1]", "'A\x[3c9]'++ is 'B\x[3b1]'" );
    $x = "B\x[3b1]";
    is( --$x, "A\x[3c9]", "'B\x[3b1]'-- is 'A\x[3c9]'" );
    $x = "\x[3b1]ZZ";
    is( ++$x, "\x[3b2]AA", "'\x[3b1]ZZ'++ is '\x[3b2]AA'" );
    $x = "\x[3b2]AA";
    is( --$x, "\x[3b1]ZZ", "'\x[3b2]AA'-- is '\x[3b1]ZZ'" );
}
{
    diag( "Tests for '\x[5d0]' .. '\x[5ea]' (Hebrew)" );
    $x = "\x[5ea]\x[5ea]";
    #?niecza todo 'Hebrew'
    is( ++$x, "\x[5d0]\x[5d0]\x[5d0]", "'\x[5ea]\x[5ea]'++ is '\x[5d0]\x[5d0]\x[5d0]'" );
    $x = "\x[5d0]\x[5d0]\x[5d0]";
    #?niecza skip "Failure NYI"
    ok( --$x ~~ Failure, "'\x[5d0]\x[5d0]\x[5d0]'-- fails" );
    $x = "A\x[5d0]";
    #?niecza todo 'Hebrew'
    is( ++$x, "A\x[5d1]", "'A\x[5d0]'++ is 'A\x[5d1]'" );
    $x = "A\x[5d1]";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "A\x[5d0]", "'A\x[5d1]'-- is 'A\x[5d0]'" );
    $x = "A\x[5ea]";
    #?niecza todo 'Hebrew'
    is( ++$x, "B\x[5d0]", "'A\x[5ea]'++ is 'B\x[5d0]'" );
    $x = "B\x[5d0]";
    #?niecza todo 'Hebrew'
    is( --$x, "A\x[5ea]", "'B\x[5d0]'-- is 'A\x[5ea]'" );
    $x = "\x[5d0]ZZ";
    #?niecza todo "Magical string decrement underflowed"
    is( ++$x, "\x[5d1]AA", "'\x[5d0]ZZ'++ is '\x[5d1]AA'" );
    $x = "\x[5d1]AA";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "\x[5d0]ZZ", "'\x[5d1]AA'-- is '\x[5d0]ZZ'" );
}

{
    diag( "Tests for '0' .. '9'" );
    $x = "99";
    is( ++$x, "100", "'99'++ is '100'" );
    $x = "100";
    is( --$x, "099", "'100'-- is '099'" );
    $x = "A0";
    is( ++$x, "A1", "'A0'++ is 'A1'" );
    $x = "A1";
    is( --$x, "A0", "'A1'-- is 'A0'" );
    $x = "A9";
    is( ++$x, "B0", "'A9'++ is 'B0'" );
    $x = "B0";
    is( --$x, "A9", "'B0'-- is 'A9'" );
    $x = "0ZZ";
    is( ++$x, "1AA", "'0ZZ'++ is '1AA'" );
    $x = "1AA";
    is( --$x, "0ZZ", "'1AA'-- is '0ZZ'" );
}
{
    diag( "Tests for '\x[660]' .. '\x[669]' (Arabic-Indic)" );
    $x = "\x[669]\x[669]";
    #?niecza 3 todo "Arabic-Indic NYI"
    is( ++$x, "\x[661]\x[660]\x[660]",
        "'\x[669]\x[669]'++ is '\x[661]\x[660]\x[660]'" );
    $x = "\x[661]\x[660]\x[660]";
    is( --$x, "\x[660]\x[669]\x[669]",
        "'\x[661]\x[660]\x[660]'-- is '\x[660]\x[669]\x[669]'" );
    $x = "A\x[660]";
    is( ++$x, "A\x[661]", "'A\x[660]'++ is 'A\x[661]'" );
    $x = "A\x[661]";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "A\x[660]", "'A\x[661]'-- is 'A\x[660]'" );
    $x = "A\x[669]";
    #?niecza 3 todo "Arabic-Indic NYI"
    is( ++$x, "B\x[660]", "'A\x[669]'++ is 'B\x[660]'" );
    $x = "B\x[660]";
    is( --$x, "A\x[669]", "'B\x[660]'-- is 'A\x[669]'" );
    $x = "\x[660]ZZ";
    is( ++$x, "\x[661]AA", "'\x[660]ZZ'++ is '\x[661]AA'" );
    $x = "\x[661]AA";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "\x[660]ZZ", "'\x[661]AA'-- is '\x[660]ZZ'" );
}
{
    diag( "Tests for '\x[966]' .. '\x[96f]' (Devangari)" );
    $x = "\x[96f]\x[96f]";
    #?niecza 3 todo "Devangari NYI"
    is( ++$x, "\x[967]\x[966]\x[966]",
        "'\x[96f]\x[96f]'++ is '\x[967]\x[966]\x[966]'" );
    $x = "\x[967]\x[966]\x[966]";
    is( --$x, "\x[966]\x[96f]\x[96f]",
        "'\x[967]\x[966]\x[966]'-- is '\x[966]\x[96f]\x[96f]'" );
    $x = "A\x[966]";
    is( ++$x, "A\x[967]", "'A\x[966]'++ is 'A\x[967]'" );
    $x = "A\x[967]";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "A\x[966]", "'A\x[967]'-- is 'A\x[966]'" );
    $x = "A\x[96f]";
    #?niecza 3 todo "Devangari NYI"
    is( ++$x, "B\x[966]", "'A\x[96f]'++ is 'B\x[966]'" );
    $x = "B\x[966]";
    is( --$x, "A\x[96f]", "'B\x[966]'-- is 'A\x[96f]'" );
    $x = "\x[966]ZZ";
    is( ++$x, "\x[967]AA", "'\x[966]ZZ'++ is '\x[967]AA'" );
    $x = "\x[967]AA";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "\x[966]ZZ", "'\x[967]AA'-- is '\x[966]ZZ'" );
}
{
    diag( "Tests for '\x[9e6]' .. '\x[9ef]' (Bengali)" );
    $x = "\x[9ef]\x[9ef]";
    #?niecza 3 todo "Bengali NYI"
    is( ++$x, "\x[9e7]\x[9e6]\x[9e6]",
        "'\x[9ef]\x[9ef]'++ is '\x[9e7]\x[9e6]\x[9e6]'" );
    $x = "\x[9e7]\x[9e6]\x[9e6]";
    is( --$x, "\x[9e6]\x[9ef]\x[9ef]",
        "'\x[9e7]\x[9e6]\x[9e6]'-- is '\x[9e6]\x[9ef]\x[9ef]'" );
    $x = "A\x[9e6]";
    is( ++$x, "A\x[9e7]", "'A\x[9e6]'++ is 'A\x[9e7]'" );
    $x = "A\x[9e7]";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "A\x[9e6]", "'A\x[9e7]'-- is 'A\x[9e6]'" );
    $x = "A\x[9ef]";
    #?niecza 3 todo "Bengali NYI"
    is( ++$x, "B\x[9e6]", "'A\x[9ef]'++ is 'B\x[9e6]'" );
    $x = "B\x[9e6]";
    is( --$x, "A\x[9ef]", "'B\x[9e6]'-- is 'A\x[9ef]'" );
    $x = "\x[9e6]ZZ";
    is( ++$x, "\x[9e7]AA", "'\x[9e6]ZZ'++ is '\x[9e7]AA'" );
    $x = "\x[9e7]AA";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "\x[9e6]ZZ", "'\x[9e7]AA'-- is '\x[9e6]ZZ'" );
}
{
    diag( "Tests for '\x[a66]' .. '\x[a6f]' (Gurmukhi)" );
    $x = "\x[a6f]\x[a6f]";
    #?niecza 3 todo "Gurmukhi NYI"
    is( ++$x, "\x[a67]\x[a66]\x[a66]",
        "'\x[a6f]\x[a6f]'++ is '\x[a67]\x[a66]\x[a66]'" );
    $x = "\x[a67]\x[a66]\x[a66]";
    is( --$x, "\x[a66]\x[a6f]\x[a6f]",
        "'\x[a67]\x[a66]\x[a66]'-- is '\x[a66]\x[a6f]\x[a6f]'" );
    $x = "A\x[a66]";
    is( ++$x, "A\x[a67]", "'A\x[a66]'++ is 'A\x[a67]'" );
    $x = "A\x[a67]";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "A\x[a66]", "'A\x[a67]'-- is 'A\x[a66]'" );
    $x = "A\x[a6f]";
    #?niecza 3 todo "Gurmukhi NYI"
    is( ++$x, "B\x[a66]", "'A\x[a6f]'++ is 'B\x[a66]'" );
    $x = "B\x[a66]";
    is( --$x, "A\x[a6f]", "'B\x[a66]'-- is 'A\x[a6f]'" );
    $x = "\x[a66]ZZ";
    is( ++$x, "\x[a67]AA", "'\x[a66]ZZ'++ is '\x[a67]AA'" );
    $x = "\x[a67]AA";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "\x[a66]ZZ", "'\x[a67]AA'-- is '\x[a66]ZZ'" );
}
{
    diag( "Tests for '\x[ae6]' .. '\x[aef]' (Gujarati)" );
    $x = "\x[aef]\x[aef]";
    #?niecza 3 todo "Gujarati NYI"
    is( ++$x, "\x[ae7]\x[ae6]\x[ae6]",
        "'\x[aef]\x[aef]'++ is '\x[ae7]\x[ae6]\x[ae6]'" );
    $x = "\x[ae7]\x[ae6]\x[ae6]";
    is( --$x, "\x[ae6]\x[aef]\x[aef]",
        "'\x[ae7]\x[ae6]\x[ae6]'-- is '\x[ae6]\x[aef]\x[aef]'" );
    $x = "A\x[ae6]";
    is( ++$x, "A\x[ae7]", "'A\x[ae6]'++ is 'A\x[ae7]'" );
    $x = "A\x[ae7]";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "A\x[ae6]", "'A\x[ae7]'-- is 'A\x[ae6]'" );
    $x = "A\x[aef]";
    #?niecza 3 todo "Gujarati NYI"
    is( ++$x, "B\x[ae6]", "'A\x[aef]'++ is 'B\x[ae6]'" );
    $x = "B\x[ae6]";
    is( --$x, "A\x[aef]", "'B\x[ae6]'-- is 'A\x[aef]'" );
    $x = "\x[ae6]ZZ";
    is( ++$x, "\x[ae7]AA", "'\x[ae6]ZZ'++ is '\x[ae7]AA'" );
    $x = "\x[ae7]AA";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "\x[ae6]ZZ", "'\x[ae7]AA'-- is '\x[ae6]ZZ'" );
}
{
    diag( "Tests for '\x[b66]' .. '\x[b6f]' (Oriya)" );
    $x = "\x[b6f]\x[b6f]";
    #?niecza 3 todo "Oriya NYI"
    is( ++$x, "\x[b67]\x[b66]\x[b66]",
        "'\x[b6f]\x[b6f]'++ is '\x[b67]\x[b66]\x[b66]'" );
    $x = "\x[b67]\x[b66]\x[b66]";
    is( --$x, "\x[b66]\x[b6f]\x[b6f]",
        "'\x[b67]\x[b66]\x[b66]'-- is '\x[b66]\x[b6f]\x[b6f]'" );
    $x = "A\x[b66]";
    is( ++$x, "A\x[b67]", "'A\x[b66]'++ is 'A\x[b67]'" );
    $x = "A\x[b67]";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "A\x[b66]", "'A\x[b67]'-- is 'A\x[b66]'" );
    $x = "A\x[b6f]";
    #?niecza 3 todo "Oriya NYI"
    is( ++$x, "B\x[b66]", "'A\x[b6f]'++ is 'B\x[b66]'" );
    $x = "B\x[b66]";
    is( --$x, "A\x[b6f]", "'B\x[b66]'-- is 'A\x[b6f]'" );
    $x = "\x[b66]ZZ";
    is( ++$x, "\x[b67]AA", "'\x[b66]ZZ'++ is '\x[b67]AA'" );
    $x = "\x[b67]AA";
    #?niecza skip "Magical string decrement underflowed"
    is( --$x, "\x[b66]ZZ", "'\x[b67]AA'-- is '\x[b66]ZZ'" );
}

# vim: ft=perl6
