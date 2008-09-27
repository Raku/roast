use v6;

use Test;

plan 30;

# L<S02/"Lexical Conventions"/"Perl is written in Unicode">

# Unicode variables
# english ;-)
ok(try {my $foo; sub foo {}; 1}, "ascii declaration");
is(try {my $bar = 2; sub id ($x) { $x }; id($bar)}, 2, "evaluation"); 

# umlauts
ok(try {my $übervar; sub fü {}; 1}, "umlauts declaration");
is(try {my $schloß = 2; sub öok ($x) { $x }; öok($schloß)}, 2, "evaluation");

# monty python
ok(try {my $møøse; sub bïte {}; 1}, "a møøse once bit my sister");
is(try {my $møøse = 2; sub såck ($x) { $x }; såck($møøse)}, 2,
    "møøse bites kan be preti nasti");

# french
ok(try {my $un_variable_français; sub blâ {}; 1}, "french declaration");
is(try {my $frénch = 2; sub bléch ($x) { $x }; bléch($frénch)}, 2, "evaluation");

# Some Chinese Characters
ok(try {my $一; 1}, "chinese declaration");
is(try {my $二 = 2; sub 恆等($x) {$x}; 恆等($二)}, 2, "evaluation");

# Tibetan Characters
ok(try {my $ཀ; 1}, "tibetan declaration");
is(try {my $ཁ = 2; $ཁ}, 2, "evaluation");

# Japanese
ok(try {my $い; 1}, "japanese declaration");
is(try {my $に = 2; $に}, 2, "evaluation");

# arabic
ok(try {my $الصفحة ; 1}, "arabic declaration");
is(try {my $الصفحة = 2; $الصفحة}, 2, "evaluation");

# hebrew
ok(try {my $פוו; sub לה {}; 1}, "hebrew declaration");
is(try {my $באר = 2; sub זהות ($x) { $x }; זהות($באר)}, 2, "evaluation");

# magyar
ok(try {my $aáeéiíoóöőuúüű ; 1}, "magyar declaration");
is(try {my $áéóőöúűüí = 42; sub űáéóőöúüí ($óőöú) { $óőöú }; űáéóőöúüí($áéóőöúűüí)}, 
       42, "evaluation");

# russian
ok(try {my $один; sub раз {}; 1}, "russian declaration");
is(
    try {my $два = 2; sub идентичный ($x) { $x }; идентичный($два)},
    2,
    "evaluation"
);

ok(try { my $पहला = 1; }, "hindi declaration");
is(try { my $दूसरा = 2; sub टोटल ($x) { $x + 2 }; टोटल($दूसरा) }, 4, "evaluation");

# Unicode subs
{
    my sub äöü () { 42 }
    is äöü, 42, "Unicode subs with no parameters";
}
{
    my sub äöü ($x) { 1000 + $x }
    is äöü 17, 1017, "Unicode subs with one parameter (parsed as prefix ops)";
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
        ~(< foostraße barstraße fakestraße >.map:{ ucfirst $^straßenname }),
        "Foostraße Barstraße Fakestraße",
        "Unicode placeholder variables";
}

# Unicode methods
{
    class Str is also { method äöü { self.ucfirst } };
    is "pugs".äöü(), "Pugs", "Unicode methods";
}
