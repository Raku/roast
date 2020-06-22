use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S32::Str/Str/"=item indent">

plan 63;

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
    is  "\x[2001] !".indent($i).ords.raku,
        ("\x[2001] " ~ (' ' x $i) ~ '!').ords.raku,
        "New indent goes after existing - .indent($i)";
}


# Same-whitespace-character indent

for 1..4 -> $i {
    for (' ', "\x[2000]") -> $prefix {
        is  ($prefix ~ 'quack').indent($i).raku,
            ($prefix x ($i + 1) ~ 'quack').raku,
            "Same space - .indent($i) prefix={$prefix.ord.fmt('"\\x[%x]"')}";
    }
}

is  "\tquack".indent($tab),
    "\t\tquack",
    'Samespace indent should work for a full $?TABSTOP with \\t';

for 1..$tab -> $i {
    for (' ', "\t", "\x[2000]") -> $prefix {
        is  ($prefix ~ ' ' ~ 'quack').indent($i).raku,
            ($prefix ~ ' ' ~ (' ' x $i) ~ 'quack').raku,
            "Mixed space - .indent($i) prefix={$prefix.ord.fmt('"\\x[%x]"')}";
    }
}


# Simple outdentation

is  '   quack'.indent(-2),
    ' quack',
    'Simple outdent';

is  "\t quack".indent(-1),
    ' ' x $tab ~ "quack",
    'Simple outdent with tab (explodes because we delete from left)';

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
is ''.indent(*), '', 'indent(*) on empty string';

is  "  quack\n meow\n   helicopter fish".indent(*).raku,
    " quack\nmeow\n  helicopter fish".raku,
    'Whatever* outdent with at least 1 common indent';

is  " quack\nmeow\n  helicopter fish".indent(*).raku,
    " quack\nmeow\n  helicopter fish".raku,
    'Whatever* outdent with one line flush left already';

is "  quack\n\n    meow\n".indent(*),
   "quack\n\n  meow\n",
   ".indent(*) ignores empty lines";


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
    "\t" ~ ' ' x ($tab - 1) ~ '!',
    'Test that space-tab-tab outdent works as intended';

is  " \t \t quack".indent(-2),
    " \t" ~ (' ' x $tab - 1) ~ 'quack',
    'Check that mixed spaces and tabs outdent correctly';

is  "\tquack\n\t meow".indent($tab),
    "\t\tquack\n\t {' ' x $tab}meow",
    'Multiline indent test with tab-space indent';

is  "\ta\n b".indent(1).raku,
    "\ta\n b".lines».indent(1).join("\n").raku,
    'Multiline indent test with mixed line beginnings';

is  "\tquack\nmeow".indent($tab),
    "\t\tquack\n{' ' x $tab}meow",
    'Multiline $?TABSTOP-width indent with an unindented line and a tab-indented line';


# Misc
is  "\ta\n b".indent(0),
    "\ta\n b",
    '.indent(0) should be a no-op';

is "a\n\nb\n".indent(2).raku,
   "  a\n\n  b\n".raku,
   ".indent ignores empty lines";

is  "\ta\n b".indent(1).indent(16).indent(0).indent(*).raku,
    "\ta\n b".indent(True).indent('0x10').indent('0e0').indent(*).raku,
    '.indent accepts weird scalar input and coerces it to Int when necessary';

is  " \t a\n \t b\n".indent(1).raku,
    " \t  a\n \t  b\n".raku,
    'Indentation should not be appended after a trailing \n';

# https://github.com/rakudo/rakudo/issues/2409
group-of 6 => 'indent/dedent' => {
    # NOTE: whitespacing is important in this test. Don't modify
    #?rakudo todo 'https://github.com/rakudo/rakudo/issues/2409'
    is_run "my \$a = q:to/END/;\n    A\n  \n    B\n    END\nprint \$a",
        {:out("A\n\nB\n"), :err(''), :0status},
        'no warnings when blank lines have trailing whitespace';

    # Cover optimizations
    unless $?TABSTOP == 8 {
        skip 'These tests are designed around $?TABSTOP of 8 spaces '
          ~ "but it is $?TABSTOP", 5;
    }
    {
        my @cases := "A\nB\nC", "  A\n  B\n  C\n", "    A\n  B\n  C\n",
          "\tA\n\t  B\n\tC\n", "\t\tA\n\t        B\n\t\tC";

        CONTROL { default { .resume } }
        is-deeply @cases».indent(-4).List, (
            "A\nB\nC", "A\nB\nC\n", "A\nB\nC\n",
            "    A\n      B\n    C\n",
            "\t    A\n            B\n\t    C"
        ), '-4';

        is-deeply @cases».indent(-8).List, (
            "A\nB\nC", "A\nB\nC\n", "A\nB\nC\n", "A\n  B\nC\n",
            "\tA\n        B\n\tC"
        ), '-8';

        is-deeply @cases».indent(0).List, (
            "A\nB\nC", "  A\n  B\n  C\n", "    A\n  B\n  C\n",
            "\tA\n\t  B\n\tC\n", "\t\tA\n\t        B\n\t\tC"
        ), '0';

        is-deeply @cases».indent(4).List, (
            "    A\n    B\n    C", "      A\n      B\n      C\n",
            "        A\n      B\n      C\n",
            "\t    A\n\t      B\n\t    C\n",
            "\t\t    A\n\t            B\n\t\t    C"
        ), '4';

        is-deeply @cases».indent(8).List, (
            "        A\n        B\n        C",
            "          A\n          B\n          C\n",
            "            A\n          B\n          C\n",
            "\t\tA\n\t          B\n\t\tC\n",
            "\t\t\tA\n\t                B\n\t\t\tC"
        ), '8';
    }
}

# vim: expandtab shiftwidth=4
