use v6;
use Test;

# L<S32::Str/Str/"=item pack">

plan 12;

is(unpack("%32B*", "\o001\o002\o004\o010\o020\o040\o100\o200\o377"), 16 );
is(unpack("%32b69", "\o001\o002\o004\o010\o020\o040\o100\o200\o017"), 12 );
is(unpack("%32B69", "\o001\o002\o004\o010\o020\o040\o100\o200\o017"), 9 );
is(unpack("I",pack("I", 0xFFFFFFFF)), 0xFFFFFFFF );

{
    # Testing @!
    is(pack('a* @3',  "abcde"), "abc", 'Test basic @');
    is(pack('a* @!3', "abcde"), "abc", 'Test basic @!');
    is(pack('a* @2', "\x[301,302,303,304,305]"), "\x[301,302]",
       'Test basic utf8 @');
    is(pack('a* @!2', "\x[301,302,303,304,305]"), "\x[301]",
       'Test basic utf8 @!');

    is(unpack('@4 a*',  "abcde"), "e", 'Test basic @');
    is(unpack('@!4 a*', "abcde"), "e", 'Test basic @!');
    is(unpack('@4 a*',  "\x[301,302,303,304,305]"), "\x[305]",
       'Test basic utf8 @');
    is(unpack('@!4 a*', "\x[301,302,303,304,305]"),
       "\x[303,304,305]", 'Test basic utf8 @!');
}

# vim: ft=perl6
