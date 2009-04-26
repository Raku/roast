use v6;
use Test;

plan 2;

# L<S32::IO/IO::Writeable::Encoded/"it is a compiler error"

eval_dies_ok('say', 'bare say is a compiler error');
eval_dies_ok('print', 'bare print is a compiler error');

# TODO: to test that 'say ()', 'say()' etc work
# we have to redirect their output
