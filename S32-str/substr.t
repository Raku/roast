use v6;

use Test;

plan 58;

# L<S32::Str/Str/=item substr>

{ # read only
    my $str = "foobar";

    is(substr($str, 0, 0), '', 'Empty string with 0 as thrid arg');
    is(substr($str, 3, 0), '', 'Empty string with 0 as thrid arg');
    is(substr($str, 0, 1), "f", "first char");
    is(substr($str, *-1), "r", "last char");
    is(substr($str, *-4, 2), "ob", "counted from the end");
    is(substr($str, 1, 2), "oo", "arbitrary middle");
    is(substr($str, 3), "bar", "length omitted");
    is(substr($str, 3, 10), "bar", "length goes past end");
    ok(!defined(substr($str, 20, 5)), "substr outside of string");
    ok(!defined(substr($str, *-100, 10)), "... on the negative side");

    is(substr($str, 0, *-2), "foob", "from beginning, with negative length");
    is(substr($str, 2, *-2), "ob", "in middle, with negative length");
    is(substr($str, 3, *-3), "", "negative length - gives empty string");
    is(substr($str, *-4, *-1), "oba", "start from the end and negative length");

    is($str, "foobar", "original string still not changed");
};

{ # misc
    my $str = "hello foo and bar";
    is(substr($str, 6, 3), "foo", "substr");
    is($str.substr(6, 3), "foo", ".substr");
    is(substr("hello foo bar", 6, 3), "foo", "substr on literal string");
    is("hello foo bar".substr(6, 3), "foo", ".substr on literal string");
    is("hello foo bar".substr(6, 3).uc, "FOO", ".substr.uc on literal string");
    is("hello foo bar and baz".substr(6, 10).wordcase, "Foo Bar An", ".substr.wordcase on literal string");
    is("hello »« foo".substr(6, 2), "»«", ".substr on unicode string");
    is("שיעבוד כבר".substr(4, 4), "וד כ", ".substr on Hebrew text");
}

{ # codepoints greater than 0xFFFF
    my $str = join '', 0x10426.chr, 0x10427.chr;
    #?rakudo.jvm todo 'codepoints greater than 0xFFFF RT #124692'
    is $str.codes, 2, "Sanity check string";
    #?niecza 2 todo "substr bug"
    #?rakudo.jvm 2 skip 'java.nio.charset.MalformedInputException RT #124692'
    is substr($str, 0, 1), 0x10426.chr, "Taking first char of Deseret string";
    is substr($str, 1, 1), 0x10427.chr, "Taking second char of Deseret string";
}

{ # misc
    my $str = "hello foo and bar";

    is(substr($str, 6, 3), "foo", "substr (substr(Int, Int)).");
    is($str.substr(6, 3), "foo", ".substr (substr(Int, Int)).");
    is(substr("hello foo bar", 6, 3), "foo", "substr on literal string (substr(Int, Int)).");
    is("hello foo bar".substr(6, 3), "foo", ".substr on literal string (substr(Int, Int)).");
    is("hello foo bar".substr(6, 3).uc, "FOO", ".substr.uc on literal string (substr(Int, Int)).");
    is("hello foo bar and baz".substr(6, 10).wordcase, "Foo Bar An", ".substr.wordcase on literal string (substr(Int, Int)).");
    is("hello »« foo".substr(6, 2), "»«", ".substr on unicode string (substr(Int, Int)).");
    is("שיעבוד כבר".substr(4, 4), "וד כ", ".substr on Hebrew text (substr(Int, Int)).");
}

{ # misc
    my $str = "hello foo and bar";
    is(substr($str, 6, 3), "foo", "substr (substr(Int, Int)).");
    is($str.substr(6, 3), "foo", ".substr (substr(Int, Int)).");
    is(substr("hello foo bar", 6, 3), "foo", "substr on literal string (substr(Int, Int)).");
    is("hello foo bar".substr(6, 3), "foo", ".substr on literal string (substr(Int, Int)).");
    is("hello foo bar".substr(6, 3).uc, "FOO", ".substr.uc on literal string (substr(Int, Int)).");
    is("hello foo bar and baz".substr(6, 10).wordcase, "Foo Bar An", ".substr.wordcase on literal string (substr(Int, Int)).");
    is("hello »« foo".substr(6, 2), "»«", ".substr on unicode string (substr(Int, Int)).");
    is("שיעבוד כבר".substr(4, 4), "וד כ", ".substr on Hebrew text (substr(Int, Int)).");
}

{ # ranges

    my $str = "hello foo and bar";

    is substr($str, 6..8), "foo", "substr (substr(Range))";
    is $str.substr(6..8),  "foo", "substr (substr(Range))";

    is substr($str, 6^..8), "oo", "substr (substr(^Range))";
    is $str.substr(6^..8),  "oo", "substr (substr(^Range))";

    is substr($str, 6..^8), "fo", "substr (substr(Range^))";
    is $str.substr(6..^8),  "fo", "substr (substr(Range^))";

    is substr($str, 6^..^8), "o", "substr (substr(^Range^))";
    is $str.substr(6^..^8),  "o", "substr (substr(^Range^))";

    is substr($str, 10..*), "and bar", "substr (substr(Range Inf))";
    is $str.substr(10..*),  "and bar", "substr (substr(Range Inf))";
}

# RT #76682
#?niecza skip "'Failure' used at line 244"
{
    isa-ok "foo".substr(4), Failure, 'substr with start beyond end of string is Failure';
}

# RT #115086
#?niecza todo
{
    is "abcd".substr(2, Inf), 'cd', 'substr to Inf';
}

{
    is 123456789.substr(*-3), '789', 'substr with Int and WhateverCode arg';

}

# RT #123602
#?rakudo.moar todo 'RT #123602'
{
    is ("0" x 3 ~ "1").substr(2), '01',
        'substr on a string built with infix:<x> works';
}

# RT #128039
{
    throws-like { 'foo'.substr(5) }, X::OutOfRange,
        :message(/'Start argument to substr' .+ 'should be in 0..3' .+ '*-5'/);
    throws-like { ''.substr(1000) }, X::OutOfRange,
        :message(/'should be in 0..0' .+ '*-1000'/);
}


# vim: ft=perl6
