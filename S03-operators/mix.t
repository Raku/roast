use v6;
use Test;

plan 24;

sub showset($b) { $b.keys.sort.join(' ') }
sub showkv($x) { $x.sort.map({ .key ~ ':' ~ .value }).join(' ') }

# "We're more of the love, blood, and rhetoric school. Well, we can do you blood
# and love without the rhetoric, and we can do you blood and rhetoric without
# the love, and we can do you all three concurrent or consecutive. But we can't
# give you love and rhetoric without the blood. Blood is compulsory. They're all
# blood, you see." -- Tom Stoppard

my $b = bag <blood love>;
my $bh = BagHash.new(<blood rhetoric>);
my $m = ("blood" => 1.1, "rhetoric" => 1, "love" => 1.2).Mix;
my $mh = MixHash.new-from-pairs("blood" => 1.1, "love" => 1.3);

# Mix Union tests moved to set_union.t

# Mix Intersection tests moved to set_intersection.t

# symmetric difference tests moved to set_symmetric_difference.t

# Mix multiplication tests moved to set_multiply.t

# Mix addition tests moved to set_addition.t

# for https://rt.perl.org/Ticket/Display.html?id=122810
ok mix(my @large_arr = ("a"...*)[^50000]), "... a large array goes into a bar - I mean mix - with 50k elems and lives";

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

{

    my $b     = (e => 1.1).Mix;
    my $bub   = (n => 2.2, e => 2.2, d => 2.2).Mix;
    my $buper = (n => 2.2, e => 4.4, d => 2.2, y => 2.2).Mix;

    ok $b ⊂ $bub, "⊂ - {$b.gist} is a strict submix of {$bub.gist}";
    nok $bub ⊄ $buper, "⊄ - {$bub.gist} is a strict submix of {$buper.gist}";
    ok $bub ⊃ $b, "⊃ - {$bub.gist} is a strict supermix of {$b.gist}";
    ok $b (<) $bub, "(<) - {$b.gist} is a strict submix of {$bub.gist} (texas)";
    nok $bub !(<) $buper, "!(<) - {$bub.gist} is a strict submix of {$buper.gist} (texas)";
    ok $bub (>) $b, "(>) - {$bub.gist} is a strict supermix of {$b.gist} (texas)";
    nok $buper !(>) $bub, "!(>) - {$buper.gist} is a strict supermix of {$bub.gist}";
}

# vim: ft=perl6
