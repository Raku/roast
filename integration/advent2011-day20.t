# http://perl6advent.wordpress.com/2011/12/20/paired-up-hashes/
use v6;
use Test;
plan 16;

my %song = Panacea => 'found a lover', Photek => 'ni ten ichi ryu';
is +%song.keys, 2, '+keys';
is_deeply (keys %song), %song.keys, 'Hash .keys';
is +%song.values, 2, '+values';
is_deeply (values %song), %song.values, 'Hash .values';

is %song{'Panacea'},%song<Panacea>, 'hash lookup syntax';
is_deeply %song{'Panacea', 'Photek'}, %song<Panacea Photek>, 'hash slice syntax';

my $song = paniq => 'Godshatter';
isa_ok $song, Pair;
is $song.key, 'paniq', 'Pair .key';
is $song.value, 'Godshatter', 'Pair .value';

is_deeply $song, (:paniq('Godshatter')), 'Pair alternate syntax';
{
    my @songs = %song; # same as @(%songs);
    is +@songs, 2, 'Hash to Array flattening';
    isa_ok @songs[0], Pair, 'Array flattening (gives pairs)'
}

{
    my @songs = %song.kv;
    is +@songs, 4, "Hash .kv flattening (flattens pairs)";
    isa_ok @songs[0], Str, "Hash .kv flattening (flattens pairs)";
}

%song.push( 'Panacea' => "state of extacy" );
is_deeply %song<Panacea>, ['found a lover', 'state of extacy'], 'Hash .push of Pair';

my %artist = 'modus operandi' => 'Photek',
    'dying civilization' => 'Panacea';

%song.push: %artist.invert;

is_deeply %song, {
    "Panacea" => ["found a lover", "state of extacy",
                  "dying civilization"],
    "Photek" => ["ni ten ichi ryu", "modus operandi"]
}, 'inversion push';
