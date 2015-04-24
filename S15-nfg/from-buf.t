use Test;

plan 4;

{
    # UTF-8 of codepoints 0044 0307 0323
    my $utf8 = buf8.new(68, 204, 135, 204, 163);
    my $s = $utf8.decode('utf-8');
    is $s.chars, 1, 'Decoding a UTF-8 Buf gets us NFG (one codepoint)';
}

{
    # UTF-8 of codepoints 0044 0307 0323 0044 0307 0044 0323
    my $utf8 = buf8.new(68, 204, 135, 204, 163, 68, 204, 135, 68, 204, 163);
    my $s = $utf8.decode('utf-8');
    is $s.chars, 3, 'Decoding a UTF-8 Buf gets us NFG (a few codepoints)';
}

{
    # UTF-16 of codepoints 0044 0307 0323
    my $utf16 = buf16.new(68, 775, 803);
    my $s = $utf16.decode('utf-16');
    is $s.chars, 1, 'Decoding a UTF-16 Buf gets us NFG (one codepoint)';
}

{
    # UTF-16 of codepoints 0044 0307 0323 0044 0307 0044 0323
    my $utf16 = buf16.new(68, 775, 803, 68, 775, 68, 803);
    my $s = $utf16.decode('utf-16');
    is $s.chars, 3, 'Decoding a UTF-16 Buf gets us NFG (a few codepoints)';
}
