use v6;
use Test;

# This test file tests the following set operators:
#   (<+)    precedes (Texas)
#   ≼       precedes
#   (>+)    succeeds (Texas)
#   ≽       succeeds

plan 32;

# "We're more of the love, blood, and rhetoric school. Well, we can do you blood
# and love without the rhetoric, and we can do you blood and rhetoric without
# the love, and we can do you all three concurrent or consecutive. But we can't
# give you love and rhetoric without the blood. Blood is compulsory. They're all
# blood, you see." -- Tom Stoppard

my $b = bag <blood blood rhetoric love love>;
my $kb = BagHash.new(<blood love love>);

# msubset
{
    ok $kb ≼ $b, "Our keybag is a msubset of our bag";
    nok $b ≼ $kb, "Our bag is not a msubset of our keybag";
    ok $b ≼ $b, "Our bag is a msubset of itself";
    ok $kb ≼ $kb, "Our keybag is a msubset of itself";
    ok $kb (<+) $b, "Our keybag is a msubset of our bag (texas)";
    nok $b (<+) $kb, "Our bag is not a msubset of our keybag (texas)";
    ok $b (<+) $b, "Our bag is a msubset of itself (texas)";
    ok $kb (<+) $kb, "Our keybag is a msubset of itself (texas)";
}

# msuperset
{
    nok $kb ≽ $b, "Our keybag is not a msuperset of our bag";
    ok $b ≽ $kb, "Our keybag is not a msuperset of our bag";
    ok $b ≽ $b, "Our bag is a msuperset of itself";
    ok $kb ≽ $kb, "Our keybag is a msuperset of itself";
    nok $kb (>+) $b, "Our keybag is not a msuperset of our bag";
    ok $b (>+) $kb, "Our bag is a msuperset of our keybag";
    ok $b (>+) $b, "Our bag is a msuperset of itself";
    ok $kb (>+) $kb, "Our keybag is a msuperset of itself";
}

my $m = ("blood" => 1.1, "rhetoric" => 1, "love" => 1.2).Mix;
my $mh = MixHash.new-from-pairs("blood" => 1.1, "love" => 1.3);

# msubset
{
    # adding a local MixHash here to avoid redoing all of the multiplication/addition return values
    my $mh = MixHash.new-from-pairs("blood" => 1.1, "love" => 1.3, "rhetoric" => 2.2);

    nok $mh ≼ $m, "Our MixHash is not a msubset of our Mix";
    ok $m ≼ $mh, "Our Mix is a msubset of our MixHash";
    ok $m ≼ $m, "Our Mix is a msubset of itself";
    ok $mh ≼ $mh, "Our MixHash is a msubset of itself";
    nok $mh (<+) $m, "Our MixHash is not a msubset of our Mix (texas)";
    ok $m (<+) $mh, "Our Mix is a msubset of our MixHash (texas)";
    ok $m (<+) $m, "Our Mix is a msubset of itself (texas)";
    ok $mh (<+) $mh, "Our MixHash is a msubset of itself (texas)";
}

# msuperset
{
    # adding a local MixHash here to avoid redoing all of the multiplication/addition return values
    my $mh = MixHash.new-from-pairs("blood" => 1.1, "love" => 1.3, "rhetoric" => 2.2);

    ok $mh ≽ $m, "Our MixHash is a msuperset of our Mix";
    nok $m ≽ $mh, "Our Mix is not a msuperset of our MixHash";
    ok $m ≽ $m, "Our mix is a msuperset of itself";
    ok $mh ≽ $mh, "Our keymix is a msuperset of itself";
    ok $mh (>+) $m, "Our MixHash is a msuperset of our Mix (Texas)";
    nok $m (>+) $mh, "Our Mix is not a msuperset of our MixHash (Texas)";
    ok $m (>+) $m, "Our Mix is a msuperset of itself (Texas)";
    ok $mh (>+) $mh, "Our MixHash is a msuperset of itself (Texas)";
}

# vim: ft=perl6
