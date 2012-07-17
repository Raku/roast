use v6;
use Test;

plan 10;

# L<S09/Compact arrays/A compact array is for most purposes interchangeable with the corresponding buffer type>

#?rakudo skip "Scope not found for PAST::Var"
# compact array acting as a buffer
{
    my uint8 @buffer = ('A' .. 'Z').map({ .ord });
    is(@buffer[0],  ord('A'), 'basic sanity test (1)');
    is(@buffer[25], ord('Z'), 'basic sanity test (2)');
    #?pugs todo
    is(substr(@buffer,   0, 8), ord('A'), 'substr on compact array (1)');
    #?pugs todo
    is(substr(@buffer, 200, 8), ord('Z'), 'substr on compact array (2)');
    #?pugs skip 'sprintf hangs'
    is(
        substr(@buffer, 0, 16),
        sprintf('%08d%08d', ord('A'), ord('B')),
        'substr on compacy array (3)'
    );
}

#?rakudo skip "Scope not found for PAST::Var"
# buffer acting as a compact array
#?pugs skip 'sprintf hangs'
{
    my buf8 $buffer = ('A' .. 'Z').map({sprintf('%08d', .ord)}).cat;
    is($buffer[0],  ord('A'), 'array indexing on buffer (1)');
    is($buffer[25], ord('Z'), 'array indexing on buffer (2)');
    is(
        $buffer[0 .. 1],
        sprintf('%08d%08d', ord('A'), ord('B')),
        'array slice on buffer (3)'
    );
}

# L<S09/Compact arrays/The size of any buffer type in bytes may be found with the .bytes method>
#?rakudo skip "Scope not found for PAST::Var"
#?pugs skip 'sprintf hangs'
{
    my buf8  $buf8  = ('A' .. 'Z').map({sprintf('%08d', .ord)}).cat;
    my buf16 $buf16 = ('A' .. 'Z').map({sprintf('%08d', .ord)}).cat;
    is($buf8.bytes,  26, '.bytes works on a buf8');
    is($buf16.bytes, 26, '.bytes works on a buf16 (and returns the size in bytes)');
}

# vim: ft=perl6
