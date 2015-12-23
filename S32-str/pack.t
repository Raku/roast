use v6;
use Test;
use experimental :pack;

# L<S32::Str/Str/"=item pack">

plan 14;

{
    for 'H*', ('H*',) -> $t {
        my $buf = pack($t, "414243");
        is-deeply $buf.contents, (:16<41>, :16<42>, :16<43>), "$t works";
    }
}

{
    for 'H', ('H',) -> $t {
        my $buf = pack($t, 'a');
        is-deeply $buf.contents, ( 0xA0, ), "$t works on odd-length strings";
    }
}

{
    for "A11 A28 A8 A*", <A11 A28 A8 A*> -> $t {
        my $buf = pack($t, "03/23/2001", "Totals", "1235.00", "   1172.98");
        is-deeply $buf.contents,
          "03/23/2001 Totals                      1235.00    1172.98"
          .encode.contents,
          "$t works";
    }
}

{
    for "C S L n N v V", <C S L n N v V> -> $t {
        my $buf = pack($t,
          0x130, 0x10030, 0x100000030,
          0x1234, 0x12345678,
          0x1234, 0x12345678);
        is-deeply $buf.contents,
          (0x30, 0x30, 0x00, 0x30, 0x00, 0x00, 0x00,
          0x12, 0x34, 0x12, 0x34, 0x56, 0x78,
          0x34, 0x12, 0x78, 0x56, 0x34, 0x12),
          "$t work";
    }
}

{
    for 'x', ('x',) -> $t {
        my $buf = pack($t);
        is-deeply $buf.contents, (0x00,), "$t by itself works";
    }
}

{
    for 'x4', ('x4',) -> $t {
        my $buf = pack($t);
        is-deeply $buf.contents, (0x00, 0x00, 0x00, 0x00), "$t & amount works";
    }
}

{
    for 'x*', ('x*',) -> $t {
        my $buf = pack($t);
        is-deeply $buf.contents, (), "$t & amount works: does nothing";
    }
}

# vim: ft=perl6
