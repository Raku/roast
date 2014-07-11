use v6;
# vim: filetype=perl6 :

# NOTES ON PORTING quotemeta.t FROM Perl 5.9.3
#
# 1. The original test suite did include may tests to exercise the
#    behaviour in double-quotes interpolation with \Q and \E, and their
#    interaction with other modification like \L and \U. These
#    interpolating sequences no longer exist.
#
# 2. The original test suite did not exercise the quotemeta function
#    for the whole 0-255 Unicode character set. Extending that test
#    suite to include all of these characters basically yields the
#    modified tests included here FOR THE ASCII VARIANT ONLY.
#    Tests for EBCDIC have not been (yet) extended, this is most
#    due to the fact that the Config.pm mechanism is not available
#    to date.
#
# 3. The original test suite used tr/// to count backslashes, here
#    we use a combination of split and grep to count non-backslashes,
#    which should be more intuitive.

use Test;


plan 11;

# For the moment I don't know how to handle the lack of Config.pm...
# Sorry for ebcdic users!
my %Config; # Empty means there's no 'ebcdic' key defined...

is('Config.pm', 'available', 'Config.pm availability');

# L<S32::Str/Str/quotemeta>

is(quotemeta("HeLLo World-72_1"), "HeLLo\\ World\\-72_1", "simple quotemeta test");
is(quotemeta(""), "", "empty string");

$_ = "HeLLo World-72_1";
my $x = .quotemeta;
is($x, "HeLLo\\ World\\-72_1", 'quotemeta uses $_ as default');

{ # test invocant syntax for quotemeta
    my $x = "HeLLo World-72_1";
    is($x.quotemeta, "HeLLo\\ World\\-72_1", '$x.quotemeta works');
    is("HeLLo World-72_1".quotemeta, "HeLLo\\ World\\-72_1", '"HeLLo World-72_1".quotemeta works');
}


if (%Config<ebcdic> eq 'define') {
    $_ = (129 .. 233).map({ chr($_); }).join;
    is($_.chars, 96, "quotemeta starting string");

    # 105 characters - 52 letters = 53 backslashes
    # 105 characters + 53 backslashes = 158 characters
    $_ = quotemeta $_;
    is($_.chars, 158, "quotemeta string");
    # 53 backslashed characters + 1 "original" backslash
    is($_.split('').grep({ $_ eq "\x5c" }).elems, 54, "count backslashes");
}
else {
    $_ = (0 .. 255).map({ chr($_); }).join;
    is($_.chars, 256, "quotemeta starting string");

    # Original test in Perl 5.9.3:
    # 96 characters - 52 letters - 10 digits - 1 underscore = 33 backslashes
    # 96 characters + 33 backslashes = 129 characters
    #
    # Then added remaining 32 + 128, all escaped:
    # 129 + (32 + 128) * 2 = 449
    #
    # Total backslashed chars are 33 + 32 + 128 = 193
    # Total backslashes are 1 + 193 = 194
    $_ = quotemeta $_;
    is($_.chars, 449, "quotemeta string");
    # 33 backslashed characters + 1 "original" backslash
    is($_.split('').grep({ $_ eq "\x5c" }).elems, 194, "count backslashes");
}

# Current quotemeta implementation mimics that for Perl 5, avoiding
# to escape Unicode characters beyond 256th
is(quotemeta("\x[263a]"), "\x[263a]", "quotemeta Unicode");
is(quotemeta("\x[263a]").chars, 1, "quotemeta Unicode length");

=begin from_perl5


plan tests => 22;

if ($Config{ebcdic} eq 'define') {
    $_ = join "", map chr($_), 129..233;

    # 105 characters - 52 letters = 53 backslashes
    # 105 characters + 53 backslashes = 158 characters
    $_ = quotemeta $_;
    is(length($_), 158, "quotemeta string");
    # 104 non-backslash characters
    is(tr/\\//cd, 104, "tr count non-backslashed");
} else { # some ASCII descendant, then.
    $_ = join "", map chr($_), 32..127;

    # 96 characters - 52 letters - 10 digits - 1 underscore = 33 backslashes
    # 96 characters + 33 backslashes = 129 characters
    $_ = quotemeta $_;
    is(length($_), 129, "quotemeta string");
    # 95 non-backslash characters
    is(tr/\\//cd, 95, "tr count non-backslashed");
}

is(length(quotemeta ""), 0, "quotemeta empty string");

is("aA\UbB\LcC\EdD", "aABBccdD", 'aA\UbB\LcC\EdD');
is("aA\LbB\UcC\EdD", "aAbbCCdD", 'aA\LbB\UcC\EdD');
is("\L\upERL", "Perl", '\L\upERL');
is("\u\LpERL", "Perl", '\u\LpERL');
is("\U\lPerl", "pERL", '\U\lPerl');
is("\l\UPerl", "pERL", '\l\UPerl');
is("\u\LpE\Q#X#\ER\EL", "Pe\\#x\\#rL", '\u\LpE\Q#X#\ER\EL');
is("\l\UPe\Q!x!\Er\El", "pE\\!X\\!Rl", '\l\UPe\Q!x!\Er\El');
is("\Q\u\LpE.X.R\EL\E.", "Pe\\.x\\.rL.", '\Q\u\LpE.X.R\EL\E.');
is("\Q\l\UPe*x*r\El\E*", "pE\\*X\\*Rl*", '\Q\l\UPe*x*r\El\E*');
is("\U\lPerl\E\E\E\E", "pERL", '\U\lPerl\E\E\E\E');
is("\l\UPerl\E\E\E\E", "pERL", '\l\UPerl\E\E\E\E');

is(quotemeta("\x{263a}"), "\x{263a}", "quotemeta Unicode");
is(length(quotemeta("\x{263a}")), 1, "quotemeta Unicode length");

$a = "foo|bar";
is("a\Q\Ec$a", "acfoo|bar", '\Q\E');
is("a\L\Ec$a", "acfoo|bar", '\L\E');
is("a\l\Ec$a", "acfoo|bar", '\l\E');
is("a\U\Ec$a", "acfoo|bar", '\U\E');
is("a\u\Ec$a", "acfoo|bar", '\u\E');

=end from_perl5
