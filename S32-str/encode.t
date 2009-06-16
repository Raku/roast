use v6;
use Test;
plan 3;

ok ('ab'.encode('ASCII') eqv Buf.new(97, 98)),  'encoding to ASCII';
ok ('ö'.encode('UTF-8') eqv Buf.new(195, 182)), 'encoding to UTF-8';

# verified with Perl 5:
# perl -CS -Mutf8 -MUnicode::Normalize -e 'print NFD("ä")' | hexdump -C
ok ('ä'.encode('UTF-8', 'D') eqv Buf.new(:16<61>, :16<cc>, :16<88>)),
                'encoding to UTF-8, with NFD';

# vim: ft=perl6
