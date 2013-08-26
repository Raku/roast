use v6;

use Test;

plan 38;

# L<S02/"Lexical Conventions"/"Perl is written in Unicode">

# Unicode variables
# english ;-)
lives_ok {my $foo; sub foo {}; 1}, "ascii declaration"; #OK not used
is (do {my $bar = 2; sub id ($x) { $x }; id($bar)}), 2, "evaluation";

# umlauts
lives_ok {my $übervar; sub fü {}; 1}, "umlauts declaration"; #OK not used
is (do {my $schloß = 2; sub öok ($x) { $x }; öok($schloß)}), 2, "evaluation";

# monty python
lives_ok {my $møøse; sub bïte {}; 1}, "a møøse once bit my sister"; #OK not used
is (do {my $møøse = 2; sub såck ($x) { $x }; såck($møøse)}), 2,
    "møøse bites kan be preti nasti";

# french
lives_ok {my $une_variable_française; sub blâ {}; 1}, "french declaration"; #OK not used
is (do {my $frénch = 2; sub bléch ($x) { $x }; bléch($frénch)}), 2, "evaluation";

# Some Chinese Characters
lives_ok {my $一; 1}, "chinese declaration"; #OK not used
is (do {my $二 = 2; sub 恆等($x) {$x}; 恆等($二)}), 2, "evaluation";

# Tibetan Characters
lives_ok {my $ཀ; 1}, "tibetan declaration"; #OK not used
is (do {my $ཁ = 2; $ཁ}), 2, "evaluation";

# Japanese
lives_ok {my $い; 1}, "japanese declaration"; #OK not used
is (do {my $に = 2; $に}), 2, "evaluation";

# arabic
lives_ok {my $الصفحة ; 1}, "arabic declaration"; #OK not used
is (do {my $الصفحة = 2; $الصفحة}), 2, "evaluation";

# hebrew
lives_ok {my $פוו; sub לה {}; 1}, "hebrew declaration"; #OK not used
is (do {my $באר = 2; sub זהות ($x) { $x }; זהות($באר)}), 2, "evaluation";

# magyar
lives_ok {my $aáeéiíoóöőuúüű ; 1}, "magyar declaration"; #OK not used
is (do {my $áéóőöúűüí = 42; sub űáéóőöúüí ($óőöú) { $óőöú }; űáéóőöúüí($áéóőöúűüí)}),
       42, "evaluation";

# russian
lives_ok {my $один; sub раз {}; 1}, "russian declaration"; #OK not used
is
    (do {my $два = 2; sub идентичный ($x) { $x }; идентичный($два)}),
    2,
    "evaluation";

#?rakudo 2 skip 'VOWEL SIGNs in identifiers'
lives_ok { my $पहला = 1; }, "hindi declaration";
is((do { my $दूसरा = 2; sub टोटल ($x) { $x + 2 }; टोटल($दूसरा) }), 4, "evaluation");

# Unicode subs
{
    my sub äöü () { 42 }
    is (äöü), 42, "Unicode subs with no parameters";
}
{
    my sub äöü ($x) { 1000 + $x }
    is (äöü 17), 1017, "Unicode subs with one parameter (parsed as listop)";
}

# Unicode parameters
# RT #69959
{
    my sub abc (:$äöü) { 1000 + $äöü }

    is abc(äöü => 42), 1042, "Unicode named params (1)";
    is abc(:äöü(42)),  1042, "Unicode named params (2)";
}

# Unicode placeholder variables
#?mildew skip 'placeholders are NIY'
{
    is
        ~(< foostraße barstraße fakestraße >.map: { tc $^straßenname }),
        "Foostraße Barstraße Fakestraße",
        "Unicode placeholder variables";
}

# Unicode methods and attributes
#?mildew skip 'classes are NIY'
{
    class A {
        has $!möp = 'pugs';
        method äöü {
            $!möp.tc();
        }
    }
    is A.new().äöü(), "Pugs", "Unicode methods and attributes";
}

#?mildew skip 'slurpy named positionals are NIY'
{
    sub f(*%x) { %x<ä> };
    is f(ä => 3), 3, 'non-ASCII named arguments';
}

# L<S02/Unicode Semantics/Perl can count Unicode line and paragraph separators>

#?rakudo: todo 'PS does not work to separate lines'
#?pugs todo
eval_lives_ok "\{ 1 \} \x2029 \{ 1 \}", "Unicode 2029 can terminate lines";

# L<S02/Bracketing Characters/If a character is already used>

eval_lives_ok "q\x298d test \x298e", "Unicode open-298d maps to close-298e";
eval_lives_ok "q\x301d test \x301e", "Unicode open-301d maps to close-301e";
eval_dies_ok "q\x301d test \x301f", "Unicode open-301d does not map to close-301f";
#?pugs 6 todo "eval_lives_ok"
eval_lives_ok "q\x2018 test \x2019", "Unicode open-2018 maps to to close-2019";
eval_lives_ok "q\x201a test \x2019", "Unicode open-201a maps to to close-2019";
eval_lives_ok "q\x2018 \x201a test \x2019", "Alternative open-brakets treat their other alternates as non-special";

# vim: ft=perl6 fileencoding=utf-8

