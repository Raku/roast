use Test;

plan 24;

for (10, 100, 1000, 10000) -> $n {
    my @codes = (0x0044, 0x0307, 0x0323) xx $n;

    my $s = Uni.new(@codes).Str;
    is $s.chars, $n, 'long Uni -> Str works out';

    my $nfc = $s.NFC;
    is $nfc.codes, 2 * $n, 'long Str -> NFC works out';
    is $nfc[0], 0x1E0C, 'NFC buffer has correct first value';
    is $nfc[1], 0x307, 'NFC buffer has correct second value';
    is $nfc[* - 2], 0x1E0C, 'NFC buffer has correct second-to-last value';
    is $nfc[* - 1], 0x307, 'NFC buffer has correct last value';
}
