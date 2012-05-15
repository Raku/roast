use v6;

use Test;

# L<S32::Str/Str/"=item indent">

plan 59;

# TODO: Rakudo doesn't have full support for constants, so we have to assume a
# hardcoded 8 instead of $?TABSTOP for now.
my $tab = 8;

# Basic indentation

for 1..4 -> $i {
    is  'quack'.indent($i),
        ' ' x $i ~ 'quack',
        "Simple .indent($i)";
}

for 1..4 -> $i {
    is  "\x[2001] !".indent($i).ords.perl,
        ("\x[2001] " ~ (' ' x $i) ~ '!').ords.perl,
        "New indent goes after existing - .indent($i)";
}


# Same-whitespace-character indent

for 1..4 -> $i {
    for (' ', "\x[2000]") -> $prefix {
        is  ($prefix ~ 'quack').indent($i).perl,
            ($prefix x ($i + 1) ~ 'quack').perl,
            "Same space - .indent($i) prefix={$prefix.ord.fmt('"\\x[%x]"')}";
    }
}

is  "\tquack".indent($tab),
    "\t\tquack",
    'Samespace indent should work for a full $?TABSTOP with \\t';

for 1..$tab -> $i {
    for (' ', "\t", "\x[2000]") -> $prefix {
        is  ($prefix ~ ' ' ~ 'quack').indent($i).perl,
            ($prefix ~ ' ' ~ (' ' x $i) ~ 'quack').perl,
            "Mixed space - .indent($i) prefix={$prefix.ord.fmt('"\\x[%x]"')}";
    }
}


# Simple outdentation

is  '   quack'.indent(-2),
    ' quack',
    'Simple outdent';

is  "\t quack".indent(-1),
    "\tquack",
    'Simple outdent with tab (no explosion)';

is  '   quack'.indent(-4),
    'quack',
    'Excess outdent test for correct output';

# TODO: need a better way of detecting warn() calls, also need a test that it
# should only warn once per .indent call
given 'Excess outdent test for warning' -> $test {
'   quack'.indent(-4);
    flunk $test;
    CONTROL { default { pass $test; } }
}

# Whatever-star

is  "  quack\n meow\n   helicopter fish".indent(*).perl,
    " quack\nmeow\n  helicopter fish".perl,
    'Whatever* outdent with at least 1 common indent';

is  " quack\nmeow\n  helicopter fish".indent(*).perl,
    " quack\nmeow\n  helicopter fish".perl,
    'Whatever* outdent with one line flush left already';


# Tab expansion

is  "\t!".indent(-1),
    ' ' x ($tab - 1) ~ '!',
    'Tab explosion on outdent';

is  "\t\t!".indent(-1),
    "\t" ~ ' ' x ($tab - 1) ~ '!',
    'Test that tabs explode from the right';

ok  ([eq] ((' ' Xx 0..$tab - 1) X~ "\t")».indent(-4)),
    'Check that varying amounts of space before a tabstop explode in a visually consistent way';

is  "  \t!".indent(-1),
    ' ' x ($tab - 1) ~ '!',
    'Spaces before a hard tab should be coalesced into the tabstop when exploding';

is  "  \t\t!".indent(-1),
    "  \t" ~ ' ' x ($tab - 1) ~ '!',
    'Test that space-tab-tab outdent works as intended';

is  " \t \t quack".indent(-2),
    " \t" ~ (' ' x $tab - 1) ~ 'quack',
    'Check that mixed spaces and tabs outdent correctly';

is  "\tquack\n\t meow".indent($tab),
    "\t\tquack\n\t {' ' x $tab}meow",
    'Multiline indent test with tab-space indent';

is  "\ta\n b".indent(1).perl,
    "\ta\n b".lines».indent(1).join("\n").perl,
    'Multiline indent test with mixed line beginnings';

is  "\tquack\nmeow".indent($tab),
    "\t\tquack\n{' ' x $tab}meow",
    'Multiline $?TABSTOP-width indent with an unindented line and a tab-indented line';


# Misc
is  "\ta\n b".indent(0),
    "\ta\n b",
    '.indent(0) should be a no-op';

#?niecza skip "weird scalar input"
#?rakudo skip 'unknown'
is  "\ta\n b".indent(1).indent(16).indent(0).indent(*).perl,
    "\ta\n b".indent(True).indent('0x10').indent('blah').indent(*).perl,
    '.indent accepts weird scalar input and coerces it to Int when necessary';

is  " \t a\n \t b\n".indent(1).perl,
    " \t  a\n \t  b\n".perl,
    'Indentation should not be appended after a trailing \n';
