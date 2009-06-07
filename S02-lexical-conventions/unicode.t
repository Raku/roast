use v6;

use Test;

plan 31;

# L<S02/"Lexical Conventions"/"Perl is written in Unicode">

# Unicode variables
# english ;-)
lives_ok {my $foo; sub foo {}; 1}, "ascii declaration";
is (do {my $bar = 2; sub id ($x) { $x }; id($bar)}), 2, "evaluation";

# umlauts
lives_ok {my $übervar; sub fü {}; 1}, "umlauts declaration";
is (do {my $schloß = 2; sub öok ($x) { $x }; öok($schloß)}), 2, "evaluation";

# monty python
lives_ok {my $møøse; sub bïte {}; 1}, "a møøse once bit my sister";
is (do {my $møøse = 2; sub såck ($x) { $x }; såck($møøse)}), 2,
    "møøse bites kan be preti nasti";

# french
lives_ok {my $un_variable_français; sub blâ {}; 1}, "french declaration";
is (do {my $frénch = 2; sub bléch ($x) { $x }; bléch($frénch)}), 2, "evaluation";

# Some Chinese Characters
lives_ok {my $一; 1}, "chinese declaration";
is (do {my $二 = 2; sub 恆等($x) {$x}; 恆等($二)}), 2, "evaluation";

# Tibetan Characters
lives_ok {my $ཀ; 1}, "tibetan declaration";
is (do {my $ཁ = 2; $ཁ}), 2, "evaluation";

# Japanese
lives_ok {my $い; 1}, "japanese declaration";
is (do {my $に = 2; $に}), 2, "evaluation";

# arabic
lives_ok {my $الصفحة ; 1}, "arabic declaration";
is (do {my $الصفحة = 2; $الصفحة}), 2, "evaluation";

# hebrew
lives_ok {my $פוו; sub לה {}; 1}, "hebrew declaration";
is (do {my $באר = 2; sub זהות ($x) { $x }; זהות($באר)}), 2, "evaluation";

# magyar
lives_ok {my $aáeéiíoóöőuúüű ; 1}, "magyar declaration";
is (do {my $áéóőöúűüí = 42; sub űáéóőöúüí ($óőöú) { $óőöú }; űáéóőöúüí($áéóőöúűüí)}),
       42, "evaluation";

# russian
lives_ok {my $один; sub раз {}; 1}, "russian declaration";
is
    (do {my $два = 2; sub идентичный ($x) { $x }; идентичный($два)}),
    2,
    "evaluation";

#?rakudo 2 skip 'VOWEL SIGNs in identifiers'
lives_ok { my $पहला = 1; }, "hindi declaration";
is((try { my $दूसरा = 2; sub टोटल ($x) { $x + 2 }; टोटल($दूसरा) }), 4, "evaluation");

# Unicode subs
{
    my sub äöü () { 42 }
    is (äöü), 42, "Unicode subs with no parameters";
}
{
    my sub äöü ($x) { 1000 + $x }
    is (äöü 17), 1017, "Unicode subs with one parameter (parsed as prefix ops)";
}

# Unicode parameters
{
    my sub abc (:$äöü) { 1000 + $äöü }

    is abc(äöü => 42), 1042, "Unicode named params (1)";
    is abc(:äöü(42)),  1042, "Unicode named params (2)";
}

# Unicode placeholder variables
{
    is
        ~(< foostraße barstraße fakestraße >.map: { ucfirst $^straßenname }),
        "Foostraße Barstraße Fakestraße",
        "Unicode placeholder variables";
}

# Unicode methods and attributes
#?rakudo skip 'Unicode method names (Parrot TT #730)'
{
    class A {
        has $!möp = 'pugs';
        method äöü {
            $!möp.ucfirst();
        }
    }
    is A.new().äöü(), "Pugs", "Unicode methods and attributes";
}

{
    sub f(*%x) { %x<ä> };
    is f(ä => 3), 3, 'non-ASCII named arguments';
}

# vim: ft=perl6 fileencoding=utf-8
