use v6;
use Test;

# L<S32::Str/Str/"=item pack">

plan 12;

{
    my $hexstring = Buf.new(:16<41>, :16<42>, :16<43>).unpack("H*");
    is $hexstring, "414243", 'H* works';
}

{
    my $buf
        = "03/23/2001 Totals                      1235.00    1172.98".encode;
    my ($date, $totals, $tot_income, $tot_expend)
        = $buf.unpack("A10 x A6 x19 A10 x A*");

    is $date,       "03/23/2001",  'field 1 (A11) works';
    is $totals,     "Totals",      'field 2 (A28) works';
    is $tot_income, "   1235.00",  'field 3 (A8) works';
    is $tot_expend, "   1172.98",  'field 4 (A*) works';
}

{
    my $buf = Buf.new(0x30, 0x30, 0x00, 0x30, 0x00, 0x00, 0x00,
                      0x12, 0x34, 0x12, 0x34, 0x56, 0x78,
                      0x34, 0x12, 0x78, 0x56, 0x34, 0x12);
    my ($char, $short, $long,
        $bigend_short, $bigend_long, $lilend_short, $lilend_long)
        = $buf.unpack("C S L n N v V");

    is $char,         0x30,       'C works';
    is $short,        0x30,       'S works';
    is $long,         0x30,       'L works';
    is $bigend_short, 0x1234,     'n works';
    is $bigend_long,  0x12345678, 'N works';
    is $lilend_short, 0x1234,     'v works';
    is $lilend_long,  0x12345678, 'V works';
}
