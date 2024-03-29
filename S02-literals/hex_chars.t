use Test;

plan 4;

#L<S02/Radix interpolation/"Characters indexed by hex numbers">
{
    my @unicode =
	    'a',  "\x61",
	    'æ',  "\xE6",
	    '喃', "\x5583",
	    '𨮁', "\x28B81",
    ;

    for @unicode -> $literal, $codepoint {
	    is(
		    $codepoint,
		    $literal,
		    'Does a character codepoint (\x..) evaluate to the same thing as its literal?'
	    );
    }
}


# vim: expandtab shiftwidth=4
