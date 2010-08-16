use v6;
use Test;

# L<S32::Str/Str/"=item pack">

plan 3;

{
    my $buf = pack('H*', "414243");
    is_deeply $buf.contents, [:16<41>, :16<42>, :16<43>], 'H* works';
}

{
    my $buf = pack("A11 A28 A8 A*",
                   "03/23/2001", "Totals", "1235.00", "   1172.98");
    is_deeply $buf.contents,
              "03/23/2001 Totals                      1235.00    1172.98"\
                .encode.contents,
              "A works";
}

{
    my $buf = pack("C S L n N v V",
                   0x130, 0x10030, 0x100000030,
                   0x1234, 0x12345678,
                   0x1234, 0x12345678);
    is_deeply $buf.contents,
              [0x30, 0x30, 0x00, 0x30, 0x00, 0x00, 0x00,
               0x12, 0x34, 0x12, 0x34, 0x56, 0x78,
               0x34, 0x12, 0x78, 0x56, 0x34, 0x12],
              "C S L n N v V work";
}

# vim: ft=perl6
