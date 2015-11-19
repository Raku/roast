use Test;

plan 10;

#?rakudo.jvm todo 'UTF-8 BOM stripping RT #124024'
{
    my $starts_with_bom = Buf.new(0xEF, 0xBB, 0xBF, 0x70, 0x69, 0x76, 0x6F);
    my $decoded = $starts_with_bom.decode('utf-8');
    is $decoded.chars, 4, '.chars reflects stripping of UTF-8 BOM (BOM + 4 chars)';
    is $decoded, 'pivo', 'got correct string with UTF-8 BOM stripped';
}

#?rakudo.jvm todo 'UTF-8 BOM stripping RT #124024'
{
    my $only_bom = Buf.new(0xEF, 0xBB, 0xBF);
    my $decoded = $only_bom.decode('utf-8');
    is $decoded.chars, 0, 'when we decode only BOM, get empty string';
}

{
    my $temp-file = "bom-test-1-$*PID";
    given open($temp-file, :w) {
        .write(Buf.new(0xEF, 0xBB, 0xBF, 0x70, 0x69, 0x76, 0x6F));
        .close;
    }

    my $slurped = slurp($temp-file);
    #?rakudo.jvm 2 todo 'UTF-8 BOM stripping RT #124024'
    is $slurped.chars, 4, 'BOM stripped when reading from file';
    is $slurped, 'pivo', 'Got correct BOM-stripped string reading form file';

    my @lines = $temp-file.IO.lines;
    is @lines.elems, 1, 'lines sanity with BOM stripping';
    #?rakudo.jvm 2 todo 'UTF-8 BOM stripping RT #124024'
    is @lines[0].chars, 4, 'BOM stripped first line has correct chars';
    is @lines[0], 'pivo', 'BOM stripped first line is correct';

    LEAVE unlink $temp-file;
}

#?rakudo.jvm todo 'UTF-8 BOM stripping RT #124024'
{
    my $temp-file = "bom-test-2-$*PID";
    given open($temp-file, :w) {
        .write(Buf.new(0xEF, 0xBB, 0xBF));
        .close;
    }

    my $slurped = slurp($temp-file);
    is $slurped.chars, 0, 'BOM-only file slurps to empty string';

    my @lines = $temp-file.IO.lines;
    is @lines.elems, 0, 'BOM-only file reports 0 lines like empty file';

    LEAVE unlink $temp-file;
}
