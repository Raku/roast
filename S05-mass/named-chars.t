use v6;
use Test;

=begin pod

This file was originally derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/named_chars.t.

# L<S02/Unicode codepoints/"(Within a regex you may also use \C to match a character
# that is not the specified character.)">

=end pod

plan 431;


ok("abc\x[a]def" ~~ m/\c[LINE FEED]/, 'Unanchored named LINE FEED');
ok("abc\c[LINE FEED]def" ~~ m/\x[A]/, 'Unanchored \x[A]');
ok("abc\c[LINE FEED]def" ~~ m/\o[12]/, 'Unanchored \o[12]');
ok("abc\x[a]def" ~~ m/^ abc \c[LINE FEED] def $/, 'Anchored LINE FEED');
ok("abc\x[c]def" ~~ m/\c[FORM FEED]/, 'Unanchored named FORM FEED');
ok("abc\c[FORM FEED]def" ~~ m/\x[C]/, 'Unanchored \x[C]');
ok("abc\c[FORM FEED]def" ~~ m/\o[14]/, 'Unanchored \o[14]');
ok("abc\x[c]def" ~~ m/^ abc \c[FORM FEED] def $/, 'Anchored FORM FEED');
ok("abc\x[c]\x[a]def" ~~ m/\c[FORM FEED, LINE FEED]/, 'Multiple FORM FEED, LINE FEED');
ok("\x[c]\x[a]" ~~ m/<[\c[FORM FEED, LINE FEED]]>/, 'Charclass multiple FORM FEED, LINE FEED');
ok(!( "\x[c]\x[a]" ~~ m/^ <-[\c[FORM FEED, LINE FEED]]>/ ), 'Negative charclass FORM FEED, LINE FEED');
ok(!( "\x[c]" ~~ m/^ \C[FORM FEED]/ ), 'Negative named FORM FEED nomatch');
ok("\x[a]" ~~ m/^ \C[FORM FEED]/, 'Negative named FORM FEED match');
ok(!( "\x[c]" ~~ m/^ <[\C[FORM FEED]]>/ ), 'Negative charclass named FORM FEED nomatch');
ok("\x[a]" ~~ m/^ <[\C[FORM FEED]]>/, 'Negative charclass named FORM FEED match');
ok(!( "\x[c]" ~~ m/^ \X[C]/ ), 'Negative hex \X[C] nomatch');
ok(!( "\x[c]" ~~ m/^ <[\X[C]]>/ ), 'Negative charclass hex \X[C] nomatch');
ok("\x[c]" ~~ m/^ \X[A]/, 'Negative hex \X[A] match');
ok("\x[c]" ~~ m/^ <[\X[A]]>/, 'Negative charclass hex \X[A] match');
ok("abc\x[d]def" ~~ m/\c[CARRIAGE RETURN]/, 'Unanchored named CARRIAGE RETURN');
ok("abc\c[CARRIAGE RETURN]def" ~~ m/\x[d]/, 'Unanchored \x[d]');
ok("abc\c[CARRIAGE RETURN]def" ~~ m/\o[15]/, 'Unanchored \o[15]');
ok("abc\x[d]def" ~~ m/^ abc \c[CARRIAGE RETURN] def $/, 'Anchored CARRIAGE RETURN');
ok("abc\x[d]\x[c]def" ~~ m/\c[CARRIAGE RETURN, FORM FEED]/, 'Multiple CARRIAGE RETURN, FORM FEED');

ok("\x[d]\x[c]" ~~ m/<[\c[CARRIAGE RETURN, FORM FEED]]>/, 'Charclass multiple CARRIAGE RETURN, FORM FEED');
ok(!( "\x[d]\x[c]" ~~ m/^ <-[\c[CARRIAGE RETURN, FORM FEED]]>/ ), 'Negative charclass CARRIAGE RETURN, FORM FEED');
ok(!( "\x[d]" ~~ m/^ \C[CARRIAGE RETURN]/ ), 'Negative named CARRIAGE RETURN nomatch');
ok("\x[c]" ~~ m/^ \C[CARRIAGE RETURN]/, 'Negative named CARRIAGE RETURN match');
ok(!( "\x[d]" ~~ m/^ <[\C[CARRIAGE RETURN]]>/ ), 'Negative charclass named CARRIAGE RETURN nomatch');
ok("\x[c]" ~~ m/^ <[\C[CARRIAGE RETURN]]>/, 'Negative charclass named CARRIAGE RETURN match');
ok(!( "\x[d]" ~~ m/^ \X[D]/ ), 'Negative hex \X[D] nomatch');
ok(!( "\x[d]" ~~ m/^ <[\X[D]]>/ ), 'Negative charclass hex \X[D] nomatch');
ok("\x[d]" ~~ m/^ \X[C]/, 'Negative hex \X[C] match');
ok("\x[d]" ~~ m/^ <[\X[C]]>/, 'Negative charclass hex \X[C] match');
ok("abc\x[85]def" ~~ m/\c[NEXT LINE]/, 'Unanchored named NEXT LINE');
ok("abc\c[NEXT LINE]def" ~~ m/\x[85]/, 'Unanchored \x[85]');
ok("abc\c[NEXT LINE]def" ~~ m/\o[205]/, 'Unanchored \o[205]');
ok("abc\x[85]def" ~~ m/^ abc \c[NEXT LINE] def $/, 'Anchored NEXT LINE');
ok("abc\x[85]\x[d]def" ~~ m/\c[NEXT LINE, CARRIAGE RETURN]/, 'Multiple NEXT LINE, CARRIAGE RETURN');
ok("\x[85]\x[d]" ~~ m/<[\c[NEXT LINE, CARRIAGE RETURN]]>/, 'Charclass multiple NEXT LINE, CARRIAGE RETURN');
ok(!( "\x[85]\x[d]" ~~ m/^ <-[\c[NEXT LINE, CARRIAGE RETURN]]>/ ), 'Negative charclass NEXT LINE, CARRIAGE RETURN');
ok(!( "\x[85]" ~~ m/^ \C[NEXT LINE]/ ), 'Negative named NEXT LINE nomatch');
ok("\x[d]" ~~ m/^ \C[NEXT LINE]/, 'Negative named NEXT LINE match');
ok(!( "\x[85]" ~~ m/^ <[\C[NEXT LINE]]>/ ), 'Negative charclass named NEXT LINE nomatch');
ok("\x[d]" ~~ m/^ <[\C[NEXT LINE]]>/, 'Negative charclass named NEXT LINE match');
ok(!( "\x[85]" ~~ m/^ \X[85]/ ), 'Negative hex \X[85] nomatch');
ok(!( "\x[85]" ~~ m/^ <[\X[85]]>/ ), 'Negative charclass hex \X[85] nomatch');
ok("\x[85]" ~~ m/^ \X[D]/, 'Negative hex \X[D] match');
ok("\x[85]" ~~ m/^ <[\X[D]]>/, 'Negative charclass hex \X[D] match');

ok("abc\c[LINE FEED]def" ~~ m/\c[LINE FEED]/, 'Unanchored named LINE FEED');
ok("abc\c[LINE FEED]def" ~~ m/^ abc \c[LINE FEED] def $/, 'Anchored LINE FEED');
ok("abc\c[LINE FEED]\x[85]def" ~~ m/\c[LINE FEED, NEXT LINE]/, 'Multiple LINE FEED, NEXT LINE');
ok("\c[LINE FEED]\x[85]" ~~ m/<[\c[LINE FEED, NEXT LINE]]>/, 'Charclass multiple LINE FEED, NEXT LINE');
ok(!( "\c[LINE FEED]\x[85]" ~~ m/^ <-[\c[LINE FEED, NEXT LINE]]>/ ), 'Negative charclass LINE FEED, NEXT LINE');
ok(!( "\c[LINE FEED]" ~~ m/^ \C[LINE FEED]/ ), 'Negative named LINE FEED nomatch');
ok("\x[85]" ~~ m/^ \C[LINE FEED]/, 'Negative named LINE FEED match');
ok(!( "\c[LINE FEED]" ~~ m/^ <[\C[LINE FEED]]>/ ), 'Negative charclass named LINE FEED nomatch');
ok("\x[85]" ~~ m/^ <[\C[LINE FEED]]>/, 'Negative charclass named LINE FEED match');
ok("abc\c[FORM FEED]def" ~~ m/\c[FORM FEED]/, 'Unanchored named FORM FEED');
ok("abc\c[FORM FEED]def" ~~ m/^ abc \c[FORM FEED] def $/, 'Anchored FORM FEED');
ok("abc\c[FORM FEED]\c[LINE FEED]def" ~~ m/\c[FORM FEED, LINE FEED]/, 'Multiple FORM FEED, LINE FEED');
ok("\c[FORM FEED]\c[LINE FEED]" ~~ m/<[\c[FORM FEED, LINE FEED]]>/, 'Charclass multiple FORM FEED, LINE FEED');
ok(!( "\c[FORM FEED]\c[LINE FEED]" ~~ m/^ <-[\c[FORM FEED, LINE FEED]]>/ ), 'Negative charclass FORM FEED, LINE FEED');
ok(!( "\c[FORM FEED]" ~~ m/^ \C[FORM FEED]/ ), 'Negative named FORM FEED nomatch');
ok("\c[LINE FEED]" ~~ m/^ \C[FORM FEED]/, 'Negative named FORM FEED match');
ok(!( "\c[FORM FEED]" ~~ m/^ <[\C[FORM FEED]]>/ ), 'Negative charclass named FORM FEED nomatch');
ok("\c[LINE FEED]" ~~ m/^ <[\C[FORM FEED]]>/, 'Negative charclass named FORM FEED match');
ok("abc\c[CARRIAGE RETURN]def" ~~ m/\c[CARRIAGE RETURN]/, 'Unanchored named CARRIAGE RETURN');
ok("abc\c[CARRIAGE RETURN]def" ~~ m/^ abc \c[CARRIAGE RETURN] def $/, 'Anchored CARRIAGE RETURN');
ok("abc\c[CARRIAGE RETURN]\c[FORM FEED]def" ~~ m/\c[CARRIAGE RETURN,FORM FEED]/, 'Multiple CARRIAGE RETURN,FORM FEED');

ok("\c[CARRIAGE RETURN]\c[FORM FEED]" ~~ m/<[\c[CARRIAGE RETURN,FORM FEED]]>/, 'Charclass multiple CARRIAGE RETURN,FORM FEED');
ok(!( "\c[CARRIAGE RETURN]\c[FORM FEED]" ~~ m/^ <-[\c[CARRIAGE RETURN,FORM FEED]]>/ ), 'Negative charclass CARRIAGE RETURN,FORM FEED');
ok(!( "\c[CARRIAGE RETURN]" ~~ m/^ \C[CARRIAGE RETURN]/ ), 'Negative named CARRIAGE RETURN nomatch');
ok("\c[FORM FEED]" ~~ m/^ \C[CARRIAGE RETURN]/, 'Negative named CARRIAGE RETURN match');
ok(!( "\c[CARRIAGE RETURN]" ~~ m/^ <[\C[CARRIAGE RETURN]]>/ ), 'Negative charclass named CARRIAGE RETURN nomatch');
ok("\c[FORM FEED]" ~~ m/^ <[\C[CARRIAGE RETURN]]>/, 'Negative charclass named CARRIAGE RETURN match');
ok("abc\c[NEXT LINE]def" ~~ m/\c[NEXT LINE]/, 'Unanchored named NEXT LINE');
ok("abc\c[NEXT LINE]def" ~~ m/^ abc \c[NEXT LINE] def $/, 'Anchored NEXT LINE');
ok("abc\c[NEXT LINE]\c[CARRIAGE RETURN]def" ~~ m/\c[NEXT LINE,CARRIAGE RETURN]/, 'Multiple NEXT LINE,CARRIAGE RETURN');
ok("\c[NEXT LINE]\c[CARRIAGE RETURN]" ~~ m/<[\c[NEXT LINE,CARRIAGE RETURN]]>/, 'Charclass multiple NEXT LINE,CARRIAGE RETURN');
ok(!( "\c[NEXT LINE]\c[CARRIAGE RETURN]" ~~ m/^ <-[\c[NEXT LINE,CARRIAGE RETURN]]>/ ), 'Negative charclass NEXT LINE,CARRIAGE RETURN');
ok(!( "\c[NEXT LINE]" ~~ m/^ \C[NEXT LINE]/ ), 'Negative named NEXT LINE nomatch');
ok("\c[CARRIAGE RETURN]" ~~ m/^ \C[NEXT LINE]/, 'Negative named NEXT LINE match');
ok(!( "\c[NEXT LINE]" ~~ m/^ <[\C[NEXT LINE]]>/ ), 'Negative charclass named NEXT LINE nomatch');
ok("\c[CARRIAGE RETURN]" ~~ m/^ <[\C[NEXT LINE]]>/, 'Negative charclass named NEXT LINE match');
ok("abc\c[LF]def" ~~ m/\c[LF]/, 'Unanchored named LF');
ok("abc\c[LF]def" ~~ m/^ abc \c[LF] def $/, 'Anchored LF');
ok("abc\c[LF]\c[NEXT LINE]def" ~~ m/\c[LF, NEXT LINE]/, 'Multiple LF, NEXT LINE');
ok("\c[LF]\c[NEXT LINE]" ~~ m/<[\c[LF, NEXT LINE]]>/, 'Charclass multiple LF, NEXT LINE');
ok(!( "\c[LF]\c[NEXT LINE]" ~~ m/^ <-[\c[LF, NEXT LINE]]>/ ), 'Negative charclass LF, NEXT LINE');
ok(!( "\c[LF]" ~~ m/^ \C[LF]/ ), 'Negative named LF nomatch');
ok("\c[NEXT LINE]" ~~ m/^ \C[LF]/, 'Negative named LF match');
ok(!( "\c[LF]" ~~ m/^ <[\C[LF]]>/ ), 'Negative charclass named LF nomatch');
ok("\c[NEXT LINE]" ~~ m/^ <[\C[LF]]>/, 'Negative charclass named LF match');
ok("abc\c[FF]def" ~~ m/\c[FF]/, 'Unanchored named FF');
ok("abc\c[FF]def" ~~ m/^ abc \c[FF] def $/, 'Anchored FF');
ok("abc\c[FF]\c[LF]def" ~~ m/\c[FF,LF]/, 'Multiple FF,LF');
ok("\c[FF]\c[LF]" ~~ m/<[\c[FF,LF]]>/, 'Charclass multiple FF,LF');
ok(!( "\c[FF]\c[LF]" ~~ m/^ <-[\c[FF,LF]]>/ ), 'Negative charclass FF,LF');

ok(!( "\c[FF]" ~~ m/^ \C[FF]/ ), 'Negative named FF nomatch');
ok("\c[LF]" ~~ m/^ \C[FF]/, 'Negative named FF match');
ok(!( "\c[FF]" ~~ m/^ <[\C[FF]]>/ ), 'Negative charclass named FF nomatch');
ok("\c[LF]" ~~ m/^ <[\C[FF]]>/, 'Negative charclass named FF match');
ok("abc\c[CR]def" ~~ m/\c[CR]/, 'Unanchored named CR');
ok("abc\c[CR]def" ~~ m/^ abc \c[CR] def $/, 'Anchored CR');
ok("abc\c[CR]\c[FF]def" ~~ m/\c[CR,FF]/, 'Multiple CR,FF');
ok("\c[CR]\c[FF]" ~~ m/<[\c[CR,FF]]>/, 'Charclass multiple CR,FF');
ok(!( "\c[CR]\c[FF]" ~~ m/^ <-[\c[CR,FF]]>/ ), 'Negative charclass CR,FF');
ok(!( "\c[CR]" ~~ m/^ \C[CR]/ ), 'Negative named CR nomatch');
ok("\c[FF]" ~~ m/^ \C[CR]/, 'Negative named CR match');
ok(!( "\c[CR]" ~~ m/^ <[\C[CR]]>/ ), 'Negative charclass named CR nomatch');
ok("\c[FF]" ~~ m/^ <[\C[CR]]>/, 'Negative charclass named CR match');
ok("abc\c[NEL]def" ~~ m/\c[NEL]/, 'Unanchored named NEL');
ok("abc\c[NEL]def" ~~ m/^ abc \c[NEL] def $/, 'Anchored NEL');
ok("abc\c[NEL]\c[CR]def" ~~ m/\c[NEL,CR]/, 'Multiple NEL,CR');
ok("\c[NEL]\c[CR]" ~~ m/<[\c[NEL,CR]]>/, 'Charclass multiple NEL,CR');
ok(!( "\c[NEL]\c[CR]" ~~ m/^ <-[\c[NEL,CR]]>/ ), 'Negative charclass NEL,CR');
ok(!( "\c[NEL]" ~~ m/^ \C[NEL]/ ), 'Negative named NEL nomatch');
ok("\c[CR]" ~~ m/^ \C[NEL]/, 'Negative named NEL match');
ok(!( "\c[NEL]" ~~ m/^ <[\C[NEL]]>/ ), 'Negative charclass named NEL nomatch');
ok("\c[CR]" ~~ m/^ <[\C[NEL]]>/, 'Negative charclass named NEL match');
ok("abc\x[fd55]def" ~~ m/\c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]/, 'Unanchored named ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM');
ok("abc\c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]def" ~~ m/\x[fd55]/, 'Unanchored \x[fd55]');
ok("abc\c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]def" ~~ m/\o[176525]/, 'Unanchored \o[176525]');
ok("abc\x[fd55]def" ~~ m/^ abc \c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM] def $/, 'Anchored ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM');
ok("abc\x[fd55]\c[NEL]def" ~~ m/\c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM,NEL]/, 'Multiple ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM,NEL');
ok("\x[fd55]\c[NEL]" ~~ m/<[\c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM,NEL]]>/, 'Charclass multiple ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM,NEL');
ok(!( "\x[fd55]\c[NEL]" ~~ m/^ <-[\c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM,NEL]]>/ ), 'Negative charclass ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM,NEL');
ok(!( "\x[fd55]" ~~ m/^ \C[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]/ ), 'Negative named ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM nomatch');
ok("\c[NEL]" ~~ m/^ \C[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]/, 'Negative named ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM match');
ok(!( "\x[fd55]" ~~ m/^ <[\C[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]]>/ ), 'Negative charclass named ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM nomatch');
ok("\c[NEL]" ~~ m/^ <[\C[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]]>/, 'Negative charclass named ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM match');

ok(!( "\x[fd55]" ~~ m/^ \X[FD55]/ ), 'Negative hex \X[FD55] nomatch');
ok(!( "\x[fd55]" ~~ m/^ <[\X[FD55]]>/ ), 'Negative charclass hex \X[FD55] nomatch');
ok("\x[5b4]def" ~~ m/\c[HEBREW POINT HIRIQ]/, 'Solitary named HEBREW POINT HIRIQ');
ok("\c[HEBREW POINT HIRIQ]def" ~~ m/\x[5B4]/, 'Solitary \x[5B4]');
ok("\c[HEBREW POINT HIRIQ]def" ~~ m/\o[2664]/, 'Solitary \o[2664]');
ok("abc\x[5b4]def" ~~ m/^ abc \c[HEBREW POINT HIRIQ] def $/, 'Anchored HEBREW POINT HIRIQ');
ok("\x[5b4]\x[fd55]def" ~~ m/\c[HEBREW POINT HIRIQ,ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]/, 'Solitary multiple HEBREW POINT HIRIQ,ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM');
ok("\x[5b4]\x[fd55]" ~~ m/<[\c[HEBREW POINT HIRIQ,ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]]>/, 'Charclass multiple HEBREW POINT HIRIQ,ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM');
ok(!( "\x[5b4]\x[fd55]" ~~ m/^ <-[\c[HEBREW POINT HIRIQ,ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]]>/ ), 'Negative charclass HEBREW POINT HIRIQ,ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM');
ok(!( "\x[5b4]" ~~ m/^ \C[HEBREW POINT HIRIQ]/ ), 'Negative named HEBREW POINT HIRIQ nomatch');
ok("\x[fd55]" ~~ m/^ \C[HEBREW POINT HIRIQ]/, 'Negative named HEBREW POINT HIRIQ match');
ok(!( "\x[5b4]" ~~ m/^ <[\C[HEBREW POINT HIRIQ]]>/ ), 'Negative charclass named HEBREW POINT HIRIQ nomatch');
ok("\x[fd55]" ~~ m/^ <[\C[HEBREW POINT HIRIQ]]>/, 'Negative charclass named HEBREW POINT HIRIQ match');
ok(!( "\x[5b4]" ~~ m/^ \X[5B4]/ ), 'Negative hex \X[5B4] nomatch');
ok(!( "\x[5b4]" ~~ m/^ <[\X[5B4]]>/ ), 'Negative charclass hex \X[5B4] nomatch');
ok("\x[5b4]" ~~ m/^ \X[FD55]/, 'Negative hex \X[FD55] match');
ok("\x[5b4]" ~~ m/^ <[\X[FD55]]>/, 'Negative charclass hex \X[FD55] match');
ok("abc\x[1ea2]def" ~~ m/\c[LATIN CAPITAL LETTER A WITH HOOK ABOVE]/, 'Unanchored named LATIN CAPITAL LETTER A WITH HOOK ABOVE');
ok("abc\c[LATIN CAPITAL LETTER A WITH HOOK ABOVE]def" ~~ m/\x[1EA2]/, 'Unanchored \x[1EA2]');
ok("abc\c[LATIN CAPITAL LETTER A WITH HOOK ABOVE]def" ~~ m/\o[17242]/, 'Unanchored \o[17242]');
ok("abc\x[1ea2]def" ~~ m/^ abc \c[LATIN CAPITAL LETTER A WITH HOOK ABOVE] def $/, 'Anchored LATIN CAPITAL LETTER A WITH HOOK ABOVE');
ok("\x[1ea2]\x[5b4]def" ~~ m/\c[LATIN CAPITAL LETTER A WITH HOOK ABOVE,HEBREW POINT HIRIQ]/, 'Solitary multiple LATIN CAPITAL LETTER A WITH HOOK ABOVE,HEBREW POINT HIRIQ');
ok("\x[1ea2]\x[5b4]" ~~ m/<[\c[LATIN CAPITAL LETTER A WITH HOOK ABOVE,HEBREW POINT HIRIQ]]>/, 'Charclass multiple LATIN CAPITAL LETTER A WITH HOOK ABOVE,HEBREW POINT HIRIQ');
ok(!( "\x[1ea2]\x[5b4]" ~~ m/^ <-[\c[LATIN CAPITAL LETTER A WITH HOOK ABOVE,HEBREW POINT HIRIQ]]>/ ), 'Negative charclass LATIN CAPITAL LETTER A WITH HOOK ABOVE,HEBREW POINT HIRIQ');
ok(!( "\x[1ea2]" ~~ m/^ \C[LATIN CAPITAL LETTER A WITH HOOK ABOVE]/ ), 'Negative named LATIN CAPITAL LETTER A WITH HOOK ABOVE nomatch');
ok("\x[5b4]" ~~ m/^ \C[LATIN CAPITAL LETTER A WITH HOOK ABOVE]/, 'Negative named LATIN CAPITAL LETTER A WITH HOOK ABOVE match');
ok(!( "\x[1ea2]" ~~ m/^ <[\C[LATIN CAPITAL LETTER A WITH HOOK ABOVE]]>/ ), 'Negative charclass named LATIN CAPITAL LETTER A WITH HOOK ABOVE nomatch');
ok("\x[5b4]" ~~ m/^ <[\C[LATIN CAPITAL LETTER A WITH HOOK ABOVE]]>/, 'Negative charclass named LATIN CAPITAL LETTER A WITH HOOK ABOVE match');
ok(!( "\x[1ea2]" ~~ m/^ \X[1EA2]/ ), 'Negative hex \X[1EA2] nomatch');
ok(!( "\x[1ea2]" ~~ m/^ <[\X[1EA2]]>/ ), 'Negative charclass hex \X[1EA2] nomatch');
ok("\x[1ea2]" ~~ m/^ \X[5B4]/, 'Negative hex \X[5B4] match');
ok("\x[1ea2]" ~~ m/^ <[\X[5B4]]>/, 'Negative charclass hex \X[5B4] match');
ok("abc\x[565]def" ~~ m/\c[ARMENIAN SMALL LETTER ECH]/, 'Unanchored named ARMENIAN SMALL LETTER ECH');
ok("abc\c[ARMENIAN SMALL LETTER ECH]def" ~~ m/\x[565]/, 'Unanchored \x[565]');
ok("abc\c[ARMENIAN SMALL LETTER ECH]def" ~~ m/\o[2545]/, 'Unanchored \o[2545]');
ok("abc\x[565]def" ~~ m/^ abc \c[ARMENIAN SMALL LETTER ECH] def $/, 'Anchored ARMENIAN SMALL LETTER ECH');
ok("abc\x[565]\x[1ea2]def" ~~ m/\c[ARMENIAN SMALL LETTER ECH,LATIN CAPITAL LETTER A WITH HOOK ABOVE]/, 'Multiple ARMENIAN SMALL LETTER ECH,LATIN CAPITAL LETTER A WITH HOOK ABOVE');
ok("\x[565]\x[1ea2]" ~~ m/<[\c[ARMENIAN SMALL LETTER ECH,LATIN CAPITAL LETTER A WITH HOOK ABOVE]]>/, 'Charclass multiple ARMENIAN SMALL LETTER ECH,LATIN CAPITAL LETTER A WITH HOOK ABOVE');
ok(!( "\x[565]\x[1ea2]" ~~ m/^ <-[\c[ARMENIAN SMALL LETTER ECH,LATIN CAPITAL LETTER A WITH HOOK ABOVE]]>/ ), 'Negative charclass ARMENIAN SMALL LETTER ECH,LATIN CAPITAL LETTER A WITH HOOK ABOVE');
ok(!( "\x[565]" ~~ m/^ \C[ARMENIAN SMALL LETTER ECH]/ ), 'Negative named ARMENIAN SMALL LETTER ECH nomatch');
ok("\x[1ea2]" ~~ m/^ \C[ARMENIAN SMALL LETTER ECH]/, 'Negative named ARMENIAN SMALL LETTER ECH match');
ok(!( "\x[565]" ~~ m/^ <[\C[ARMENIAN SMALL LETTER ECH]]>/ ), 'Negative charclass named ARMENIAN SMALL LETTER ECH nomatch');
ok("\x[1ea2]" ~~ m/^ <[\C[ARMENIAN SMALL LETTER ECH]]>/, 'Negative charclass named ARMENIAN SMALL LETTER ECH match');
ok(!( "\x[565]" ~~ m/^ \X[565]/ ), 'Negative hex \X[565] nomatch');
ok(!( "\x[565]" ~~ m/^ <[\X[565]]>/ ), 'Negative charclass hex \X[565] nomatch');
ok("\x[565]" ~~ m/^ \X[1EA2]/, 'Negative hex \X[1EA2] match');
ok("\x[565]" ~~ m/^ <[\X[1EA2]]>/, 'Negative charclass hex \X[1EA2] match');
ok("abc\x[25db]def" ~~ m/\c[LOWER HALF INVERSE WHITE CIRCLE]/, 'Unanchored named LOWER HALF INVERSE WHITE CIRCLE');
ok("abc\c[LOWER HALF INVERSE WHITE CIRCLE]def" ~~ m/\x[25DB]/, 'Unanchored \x[25DB]');
ok("abc\c[LOWER HALF INVERSE WHITE CIRCLE]def" ~~ m/\o[22733]/, 'Unanchored \o[22733]');
ok("abc\x[25db]def" ~~ m/^ abc \c[LOWER HALF INVERSE WHITE CIRCLE] def $/, 'Anchored LOWER HALF INVERSE WHITE CIRCLE');
ok("abc\x[25db]\x[565]def" ~~ m/\c[LOWER HALF INVERSE WHITE CIRCLE,ARMENIAN SMALL LETTER ECH]/, 'Multiple LOWER HALF INVERSE WHITE CIRCLE,ARMENIAN SMALL LETTER ECH');
ok("\x[25db]\x[565]" ~~ m/<[\c[LOWER HALF INVERSE WHITE CIRCLE,ARMENIAN SMALL LETTER ECH]]>/, 'Charclass multiple LOWER HALF INVERSE WHITE CIRCLE,ARMENIAN SMALL LETTER ECH');
ok(!( "\x[25db]\x[565]" ~~ m/^ <-[\c[LOWER HALF INVERSE WHITE CIRCLE,ARMENIAN SMALL LETTER ECH]]>/ ), 'Negative charclass LOWER HALF INVERSE WHITE CIRCLE,ARMENIAN SMALL LETTER ECH');
ok(!( "\x[25db]" ~~ m/^ \C[LOWER HALF INVERSE WHITE CIRCLE]/ ), 'Negative named LOWER HALF INVERSE WHITE CIRCLE nomatch');
ok("\x[565]" ~~ m/^ \C[LOWER HALF INVERSE WHITE CIRCLE]/, 'Negative named LOWER HALF INVERSE WHITE CIRCLE match');
ok(!( "\x[25db]" ~~ m/^ <[\C[LOWER HALF INVERSE WHITE CIRCLE]]>/ ), 'Negative charclass named LOWER HALF INVERSE WHITE CIRCLE nomatch');
ok("\x[565]" ~~ m/^ <[\C[LOWER HALF INVERSE WHITE CIRCLE]]>/, 'Negative charclass named LOWER HALF INVERSE WHITE CIRCLE match');
ok(!( "\x[25db]" ~~ m/^ \X[25DB]/ ), 'Negative hex \X[25DB] nomatch');
ok(!( "\x[25db]" ~~ m/^ <[\X[25DB]]>/ ), 'Negative charclass hex \X[25DB] nomatch');
ok("\x[25db]" ~~ m/^ \X[565]/, 'Negative hex \X[565] match');
ok("\x[25db]" ~~ m/^ <[\X[565]]>/, 'Negative charclass hex \X[565] match');
ok("abc\x[fe7d]def" ~~ m/\c[ARABIC SHADDA MEDIAL FORM]/, 'Unanchored named ARABIC SHADDA MEDIAL FORM');
ok("abc\c[ARABIC SHADDA MEDIAL FORM]def" ~~ m/\x[fe7d]/, 'Unanchored \x[fe7d]');
ok("abc\c[ARABIC SHADDA MEDIAL FORM]def" ~~ m/\o[177175]/, 'Unanchored \o[177175]');
ok("abc\x[fe7d]def" ~~ m/^ abc \c[ARABIC SHADDA MEDIAL FORM] def $/, 'Anchored ARABIC SHADDA MEDIAL FORM');
ok("abc\x[fe7d]\x[25db]def" ~~ m/\c[ARABIC SHADDA MEDIAL FORM,LOWER HALF INVERSE WHITE CIRCLE]/, 'Multiple ARABIC SHADDA MEDIAL FORM,LOWER HALF INVERSE WHITE CIRCLE');
ok("\x[fe7d]\x[25db]" ~~ m/<[\c[ARABIC SHADDA MEDIAL FORM,LOWER HALF INVERSE WHITE CIRCLE]]>/, 'Charclass multiple ARABIC SHADDA MEDIAL FORM,LOWER HALF INVERSE WHITE CIRCLE');
ok(!( "\x[fe7d]\x[25db]" ~~ m/^ <-[\c[ARABIC SHADDA MEDIAL FORM,LOWER HALF INVERSE WHITE CIRCLE]]>/ ), 'Negative charclass ARABIC SHADDA MEDIAL FORM,LOWER HALF INVERSE WHITE CIRCLE');
ok(!( "\x[fe7d]" ~~ m/^ \C[ARABIC SHADDA MEDIAL FORM]/ ), 'Negative named ARABIC SHADDA MEDIAL FORM nomatch');
ok("\x[25db]" ~~ m/^ \C[ARABIC SHADDA MEDIAL FORM]/, 'Negative named ARABIC SHADDA MEDIAL FORM match');
ok(!( "\x[fe7d]" ~~ m/^ <[\C[ARABIC SHADDA MEDIAL FORM]]>/ ), 'Negative charclass named ARABIC SHADDA MEDIAL FORM nomatch');
ok("\x[25db]" ~~ m/^ <[\C[ARABIC SHADDA MEDIAL FORM]]>/, 'Negative charclass named ARABIC SHADDA MEDIAL FORM match');
ok(!( "\x[fe7d]" ~~ m/^ \X[FE7D]/ ), 'Negative hex \X[FE7D] nomatch');
ok(!( "\x[fe7d]" ~~ m/^ <[\X[FE7D]]>/ ), 'Negative charclass hex \X[FE7D] nomatch');
ok("\x[fe7d]" ~~ m/^ \X[25DB]/, 'Negative hex \X[25DB] match');
ok("\x[fe7d]" ~~ m/^ <[\X[25DB]]>/, 'Negative charclass hex \X[25DB] match');
ok("abc\x[a15d]def" ~~ m/\c[YI SYLLABLE NDO]/, 'Unanchored named YI SYLLABLE NDO');
ok("abc\c[YI SYLLABLE NDO]def" ~~ m/\x[A15D]/, 'Unanchored \x[A15D]');
ok("abc\c[YI SYLLABLE NDO]def" ~~ m/\o[120535]/, 'Unanchored \o[120535]');
ok("abc\x[a15d]def" ~~ m/^ abc \c[YI SYLLABLE NDO] def $/, 'Anchored YI SYLLABLE NDO');
ok("abc\x[a15d]\x[fe7d]def" ~~ m/\c[YI SYLLABLE NDO, ARABIC SHADDA MEDIAL FORM]/, 'Multiple YI SYLLABLE NDO, ARABIC SHADDA MEDIAL FORM');
ok("\x[a15d]\x[fe7d]" ~~ m/<[\c[YI SYLLABLE NDO, ARABIC SHADDA MEDIAL FORM]]>/, 'Charclass multiple YI SYLLABLE NDO, ARABIC SHADDA MEDIAL FORM');
ok(!( "\x[a15d]\x[fe7d]" ~~ m/^ <-[\c[YI SYLLABLE NDO, ARABIC SHADDA MEDIAL FORM]]>/ ), 'Negative charclass YI SYLLABLE NDO, ARABIC SHADDA MEDIAL FORM');
ok(!( "\x[a15d]" ~~ m/^ \C[YI SYLLABLE NDO]/ ), 'Negative named YI SYLLABLE NDO nomatch');
ok("\x[fe7d]" ~~ m/^ \C[YI SYLLABLE NDO]/, 'Negative named YI SYLLABLE NDO match');
ok(!( "\x[a15d]" ~~ m/^ <[\C[YI SYLLABLE NDO]]>/ ), 'Negative charclass named YI SYLLABLE NDO nomatch');
ok("\x[fe7d]" ~~ m/^ <[\C[YI SYLLABLE NDO]]>/, 'Negative charclass named YI SYLLABLE NDO match');
ok(!( "\x[a15d]" ~~ m/^ \X[A15D]/ ), 'Negative hex \X[A15D] nomatch');
ok(!( "\x[a15d]" ~~ m/^ <[\X[A15D]]>/ ), 'Negative charclass hex \X[A15D] nomatch');
ok("\x[a15d]" ~~ m/^ \X[FE7D]/, 'Negative hex \X[FE7D] match');
ok("\x[a15d]" ~~ m/^ <[\X[FE7D]]>/, 'Negative charclass hex \X[FE7D] match');
ok("abc\x[2964]def" ~~ m/\c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]/, 'Unanchored named RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN');
ok("abc\c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]def" ~~ m/\x[2964]/, 'Unanchored \x[2964]');
ok("abc\c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]def" ~~ m/\o[24544]/, 'Unanchored \o[24544]');
ok("abc\x[2964]def" ~~ m/^ abc \c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN] def $/, 'Anchored RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN');
ok("abc\x[2964]\x[a15d]def" ~~ m/\c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN,YI SYLLABLE NDO]/, 'Multiple RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN,YI SYLLABLE NDO');
ok("\x[2964]\x[a15d]" ~~ m/<[\c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN,YI SYLLABLE NDO]]>/, 'Charclass multiple RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN,YI SYLLABLE NDO');
ok(!( "\x[2964]\x[a15d]" ~~ m/^ <-[\c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN,YI SYLLABLE NDO]]>/ ), 'Negative charclass RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN,YI SYLLABLE NDO');
ok(!( "\x[2964]" ~~ m/^ \C[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]/ ), 'Negative named RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN nomatch');
ok("\x[a15d]" ~~ m/^ \C[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]/, 'Negative named RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN match');
ok(!( "\x[2964]" ~~ m/^ <[\C[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]]>/ ), 'Negative charclass named RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN nomatch');
ok("\x[a15d]" ~~ m/^ <[\C[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]]>/, 'Negative charclass named RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN match');
ok(!( "\x[2964]" ~~ m/^ \X[2964]/ ), 'Negative hex \X[2964] nomatch');
ok(!( "\x[2964]" ~~ m/^ <[\X[2964]]>/ ), 'Negative charclass hex \X[2964] nomatch');
ok("\x[2964]" ~~ m/^ \X[A15D]/, 'Negative hex \X[A15D] match');
ok("\x[2964]" ~~ m/^ <[\X[A15D]]>/, 'Negative charclass hex \X[A15D] match');
ok("abc\x[ff6d]def" ~~ m/\c[HALFWIDTH KATAKANA LETTER SMALL YU]/, 'Unanchored named HALFWIDTH KATAKANA LETTER SMALL YU');
ok("abc\c[HALFWIDTH KATAKANA LETTER SMALL YU]def" ~~ m/\x[FF6D]/, 'Unanchored \x[FF6D]');
ok("abc\c[HALFWIDTH KATAKANA LETTER SMALL YU]def" ~~ m/\o[177555]/, 'Unanchored \o[177555]');
ok("abc\x[ff6d]def" ~~ m/^ abc \c[HALFWIDTH KATAKANA LETTER SMALL YU] def $/, 'Anchored HALFWIDTH KATAKANA LETTER SMALL YU');
ok("abc\x[ff6d]\x[2964]def" ~~ m/\c[HALFWIDTH KATAKANA LETTER SMALL YU, RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]/, 'Multiple HALFWIDTH KATAKANA LETTER SMALL YU, RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN');
ok("\x[ff6d]\x[2964]" ~~ m/<[\c[HALFWIDTH KATAKANA LETTER SMALL YU, RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]]>/, 'Charclass multiple HALFWIDTH KATAKANA LETTER SMALL YU, RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN');
ok(!( "\x[ff6d]\x[2964]" ~~ m/^ <-[\c[HALFWIDTH KATAKANA LETTER SMALL YU, RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]]>/ ), 'Negative charclass HALFWIDTH KATAKANA LETTER SMALL YU, RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN');
ok(!( "\x[ff6d]" ~~ m/^ \C[HALFWIDTH KATAKANA LETTER SMALL YU]/ ), 'Negative named HALFWIDTH KATAKANA LETTER SMALL YU nomatch');
ok("\x[2964]" ~~ m/^ \C[HALFWIDTH KATAKANA LETTER SMALL YU]/, 'Negative named HALFWIDTH KATAKANA LETTER SMALL YU match');
ok(!( "\x[ff6d]" ~~ m/^ <[\C[HALFWIDTH KATAKANA LETTER SMALL YU]]>/ ), 'Negative charclass named HALFWIDTH KATAKANA LETTER SMALL YU nomatch');
ok("\x[2964]" ~~ m/^ <[\C[HALFWIDTH KATAKANA LETTER SMALL YU]]>/, 'Negative charclass named HALFWIDTH KATAKANA LETTER SMALL YU match');
ok(!( "\x[ff6d]" ~~ m/^ \X[FF6D]/ ), 'Negative hex \X[FF6D] nomatch');
ok(!( "\x[ff6d]" ~~ m/^ <[\X[FF6D]]>/ ), 'Negative charclass hex \X[FF6D] nomatch');
ok("\x[ff6d]" ~~ m/^ \X[2964]/, 'Negative hex \X[2964] match');
ok("\x[ff6d]" ~~ m/^ <[\X[2964]]>/, 'Negative charclass hex \X[2964] match');
ok("abc\x[36]def" ~~ m/\c[DIGIT SIX]/, 'Unanchored named DIGIT SIX');
ok("abc\c[DIGIT SIX]def" ~~ m/\x[36]/, 'Unanchored \x[36]');
ok("abc\c[DIGIT SIX]def" ~~ m/\o[66]/, 'Unanchored \o[66]');
ok("abc\x[36]def" ~~ m/^ abc \c[DIGIT SIX] def $/, 'Anchored DIGIT SIX');
ok("abc\x[36]\x[ff6d]def" ~~ m/\c[DIGIT SIX,HALFWIDTH KATAKANA LETTER SMALL YU]/, 'Multiple DIGIT SIX,HALFWIDTH KATAKANA LETTER SMALL YU');
ok("\x[36]\x[ff6d]" ~~ m/<[\c[DIGIT SIX,HALFWIDTH KATAKANA LETTER SMALL YU]]>/, 'Charclass multiple DIGIT SIX,HALFWIDTH KATAKANA LETTER SMALL YU');
ok(!( "\x[36]\x[ff6d]" ~~ m/^ <-[\c[DIGIT SIX,HALFWIDTH KATAKANA LETTER SMALL YU]]>/ ), 'Negative charclass DIGIT SIX,HALFWIDTH KATAKANA LETTER SMALL YU');
ok(!( "\x[36]" ~~ m/^ \C[DIGIT SIX]/ ), 'Negative named DIGIT SIX nomatch');
ok("\x[ff6d]" ~~ m/^ \C[DIGIT SIX]/, 'Negative named DIGIT SIX match');
ok(!( "\x[36]" ~~ m/^ <[\C[DIGIT SIX]]>/ ), 'Negative charclass named DIGIT SIX nomatch');
ok("\x[ff6d]" ~~ m/^ <[\C[DIGIT SIX]]>/, 'Negative charclass named DIGIT SIX match');
ok(!( "\x[36]" ~~ m/^ \X[36]/ ), 'Negative hex \X[36] nomatch');
ok(!( "\x[36]" ~~ m/^ <[\X[36]]>/ ), 'Negative charclass hex \X[36] nomatch');
ok("\x[36]" ~~ m/^ \X[FF6D]/, 'Negative hex \X[FF6D] match');
ok("\x[36]" ~~ m/^ <[\X[FF6D]]>/, 'Negative charclass hex \X[FF6D] match');
ok("abc\x[1323]def" ~~ m/\c[ETHIOPIC SYLLABLE THAA]/, 'Unanchored named ETHIOPIC SYLLABLE THAA');
ok("abc\c[ETHIOPIC SYLLABLE THAA]def" ~~ m/\x[1323]/, 'Unanchored \x[1323]');
ok("abc\c[ETHIOPIC SYLLABLE THAA]def" ~~ m/\o[11443]/, 'Unanchored \o[11443]');
ok("abc\x[1323]def" ~~ m/^ abc \c[ETHIOPIC SYLLABLE THAA] def $/, 'Anchored ETHIOPIC SYLLABLE THAA');
ok("abc\x[1323]\x[36]def" ~~ m/\c[ETHIOPIC SYLLABLE THAA, DIGIT SIX]/, 'Multiple ETHIOPIC SYLLABLE THAA, DIGIT SIX');
ok("\x[1323]\x[36]" ~~ m/<[\c[ETHIOPIC SYLLABLE THAA, DIGIT SIX]]>/, 'Charclass multiple ETHIOPIC SYLLABLE THAA, DIGIT SIX');
ok(!( "\x[1323]\x[36]" ~~ m/^ <-[\c[ETHIOPIC SYLLABLE THAA, DIGIT SIX]]>/ ), 'Negative charclass ETHIOPIC SYLLABLE THAA, DIGIT SIX');
ok(!( "\x[1323]" ~~ m/^ \C[ETHIOPIC SYLLABLE THAA]/ ), 'Negative named ETHIOPIC SYLLABLE THAA nomatch');
ok("\x[36]" ~~ m/^ \C[ETHIOPIC SYLLABLE THAA]/, 'Negative named ETHIOPIC SYLLABLE THAA match');
ok(!( "\x[1323]" ~~ m/^ <[\C[ETHIOPIC SYLLABLE THAA]]>/ ), 'Negative charclass named ETHIOPIC SYLLABLE THAA nomatch');
ok("\x[36]" ~~ m/^ <[\C[ETHIOPIC SYLLABLE THAA]]>/, 'Negative charclass named ETHIOPIC SYLLABLE THAA match');
ok(!( "\x[1323]" ~~ m/^ \X[1323]/ ), 'Negative hex \X[1323] nomatch');
ok(!( "\x[1323]" ~~ m/^ <[\X[1323]]>/ ), 'Negative charclass hex \X[1323] nomatch');
ok("\x[1323]" ~~ m/^ \X[36]/, 'Negative hex \X[36] match');
ok("\x[1323]" ~~ m/^ <[\X[36]]>/, 'Negative charclass hex \X[36] match');
ok("abc\x[1697]def" ~~ m/\c[OGHAM LETTER UILLEANN]/, 'Unanchored named OGHAM LETTER UILLEANN');
ok("abc\c[OGHAM LETTER UILLEANN]def" ~~ m/\x[1697]/, 'Unanchored \x[1697]');
ok("abc\c[OGHAM LETTER UILLEANN]def" ~~ m/\o[13227]/, 'Unanchored \o[13227]');
ok("abc\x[1697]def" ~~ m/^ abc \c[OGHAM LETTER UILLEANN] def $/, 'Anchored OGHAM LETTER UILLEANN');
ok("abc\x[1697]\x[1323]def" ~~ m/\c[OGHAM LETTER UILLEANN,ETHIOPIC SYLLABLE THAA]/, 'Multiple OGHAM LETTER UILLEANN,ETHIOPIC SYLLABLE THAA');
ok("\x[1697]\x[1323]" ~~ m/<[\c[OGHAM LETTER UILLEANN,ETHIOPIC SYLLABLE THAA]]>/, 'Charclass multiple OGHAM LETTER UILLEANN,ETHIOPIC SYLLABLE THAA');
ok(!( "\x[1697]\x[1323]" ~~ m/^ <-[\c[OGHAM LETTER UILLEANN,ETHIOPIC SYLLABLE THAA]]>/ ), 'Negative charclass OGHAM LETTER UILLEANN,ETHIOPIC SYLLABLE THAA');
ok(!( "\x[1697]" ~~ m/^ \C[OGHAM LETTER UILLEANN]/ ), 'Negative named OGHAM LETTER UILLEANN nomatch');
ok("\x[1323]" ~~ m/^ \C[OGHAM LETTER UILLEANN]/, 'Negative named OGHAM LETTER UILLEANN match');
ok(!( "\x[1697]" ~~ m/^ <[\C[OGHAM LETTER UILLEANN]]>/ ), 'Negative charclass named OGHAM LETTER UILLEANN nomatch');
ok("\x[1323]" ~~ m/^ <[\C[OGHAM LETTER UILLEANN]]>/, 'Negative charclass named OGHAM LETTER UILLEANN match');
ok(!( "\x[1697]" ~~ m/^ \X[1697]/ ), 'Negative hex \X[1697] nomatch');
ok(!( "\x[1697]" ~~ m/^ <[\X[1697]]>/ ), 'Negative charclass hex \X[1697] nomatch');
ok("\x[1697]" ~~ m/^ \X[1323]/, 'Negative hex \X[1323] match');
ok("\x[1697]" ~~ m/^ <[\X[1323]]>/, 'Negative charclass hex \X[1323] match');
ok("abc\x[fe8b]def" ~~ m/\c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]/, 'Unanchored named ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM');
ok("abc\c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]def" ~~ m/\x[fe8b]/, 'Unanchored \x[fe8b]');
ok("abc\c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]def" ~~ m/\o[177213]/, 'Unanchored \o[177213]');
ok("abc\x[fe8b]def" ~~ m/^ abc \c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM] def $/, 'Anchored ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM');
ok("abc\x[fe8b]\x[1697]def" ~~ m/\c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM,OGHAM LETTER UILLEANN]/, 'Multiple ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM,OGHAM LETTER UILLEANN');
ok("\x[fe8b]\x[1697]" ~~ m/<[\c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM,OGHAM LETTER UILLEANN]]>/, 'Charclass multiple ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM,OGHAM LETTER UILLEANN');
ok(!( "\x[fe8b]\x[1697]" ~~ m/^ <-[\c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM,OGHAM LETTER UILLEANN]]>/ ), 'Negative charclass ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM,OGHAM LETTER UILLEANN');
ok(!( "\x[fe8b]" ~~ m/^ \C[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]/ ), 'Negative named ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM nomatch');
ok("\x[1697]" ~~ m/^ \C[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]/, 'Negative named ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM match');
ok(!( "\x[fe8b]" ~~ m/^ <[\C[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]]>/ ), 'Negative charclass named ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM nomatch');
ok("\x[1697]" ~~ m/^ <[\C[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]]>/, 'Negative charclass named ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM match');
ok(!( "\x[fe8b]" ~~ m/^ \X[FE8B]/ ), 'Negative hex \X[FE8B] nomatch');
ok(!( "\x[fe8b]" ~~ m/^ <[\X[FE8B]]>/ ), 'Negative charclass hex \X[FE8B] nomatch');
ok("\x[fe8b]" ~~ m/^ \X[1697]/, 'Negative hex \X[1697] match');
ok("\x[fe8b]" ~~ m/^ <[\X[1697]]>/, 'Negative charclass hex \X[1697] match');
ok("abc\x[16de]def" ~~ m/\c[RUNIC LETTER DAGAZ DAEG D]/, 'Unanchored named RUNIC LETTER DAGAZ DAEG D');
ok("abc\c[RUNIC LETTER DAGAZ DAEG D]def" ~~ m/\x[16DE]/, 'Unanchored \x[16DE]');
ok("abc\c[RUNIC LETTER DAGAZ DAEG D]def" ~~ m/\o[13336]/, 'Unanchored \o[13336]');
ok("abc\x[16de]def" ~~ m/^ abc \c[RUNIC LETTER DAGAZ DAEG D] def $/, 'Anchored RUNIC LETTER DAGAZ DAEG D');
ok("abc\x[16de]\x[fe8b]def" ~~ m/\c[RUNIC LETTER DAGAZ DAEG D,ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]/, 'Multiple RUNIC LETTER DAGAZ DAEG D,ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM');
ok("\x[16de]\x[fe8b]" ~~ m/<[\c[RUNIC LETTER DAGAZ DAEG D,ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]]>/, 'Charclass multiple RUNIC LETTER DAGAZ DAEG D,ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM');
ok(!( "\x[16de]\x[fe8b]" ~~ m/^ <-[\c[RUNIC LETTER DAGAZ DAEG D,ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]]>/ ), 'Negative charclass RUNIC LETTER DAGAZ DAEG D,ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM');
ok(!( "\x[16de]" ~~ m/^ \C[RUNIC LETTER DAGAZ DAEG D]/ ), 'Negative named RUNIC LETTER DAGAZ DAEG D nomatch');
ok("\x[fe8b]" ~~ m/^ \C[RUNIC LETTER DAGAZ DAEG D]/, 'Negative named RUNIC LETTER DAGAZ DAEG D match');
ok(!( "\x[16de]" ~~ m/^ <[\C[RUNIC LETTER DAGAZ DAEG D]]>/ ), 'Negative charclass named RUNIC LETTER DAGAZ DAEG D nomatch');
ok("\x[fe8b]" ~~ m/^ <[\C[RUNIC LETTER DAGAZ DAEG D]]>/, 'Negative charclass named RUNIC LETTER DAGAZ DAEG D match');
ok(!( "\x[16de]" ~~ m/^ \X[16DE]/ ), 'Negative hex \X[16DE] nomatch');
ok(!( "\x[16de]" ~~ m/^ <[\X[16DE]]>/ ), 'Negative charclass hex \X[16DE] nomatch');
ok("\x[16de]" ~~ m/^ \X[FE8B]/, 'Negative hex \X[FE8B] match');
ok("\x[16de]" ~~ m/^ <[\X[FE8B]]>/, 'Negative charclass hex \X[FE8B] match');
ok("abc\x[64]def" ~~ m/\c[LATIN SMALL LETTER D]/, 'Unanchored named LATIN SMALL LETTER D');
ok("abc\c[LATIN SMALL LETTER D]def" ~~ m/\x[64]/, 'Unanchored \x[64]');
ok("abc\c[LATIN SMALL LETTER D]def" ~~ m/\o[144]/, 'Unanchored \o[144]');
ok("abc\x[64]def" ~~ m/^ abc \c[LATIN SMALL LETTER D] def $/, 'Anchored LATIN SMALL LETTER D');
ok("abc\x[64]\x[16de]def" ~~ m/\c[LATIN SMALL LETTER D,RUNIC LETTER DAGAZ DAEG D]/, 'Multiple LATIN SMALL LETTER D,RUNIC LETTER DAGAZ DAEG D');
ok("\x[64]\x[16de]" ~~ m/<[\c[LATIN SMALL LETTER D,RUNIC LETTER DAGAZ DAEG D]]>/, 'Charclass multiple LATIN SMALL LETTER D,RUNIC LETTER DAGAZ DAEG D');
ok(!( "\x[64]\x[16de]" ~~ m/^ <-[\c[LATIN SMALL LETTER D,RUNIC LETTER DAGAZ DAEG D]]>/ ), 'Negative charclass LATIN SMALL LETTER D,RUNIC LETTER DAGAZ DAEG D');
ok(!( "\x[64]" ~~ m/^ \C[LATIN SMALL LETTER D]/ ), 'Negative named LATIN SMALL LETTER D nomatch');
ok("\x[16de]" ~~ m/^ \C[LATIN SMALL LETTER D]/, 'Negative named LATIN SMALL LETTER D match');
ok(!( "\x[64]" ~~ m/^ <[\C[LATIN SMALL LETTER D]]>/ ), 'Negative charclass named LATIN SMALL LETTER D nomatch');
ok("\x[16de]" ~~ m/^ <[\C[LATIN SMALL LETTER D]]>/, 'Negative charclass named LATIN SMALL LETTER D match');
ok(!( "\x[64]" ~~ m/^ \X[64]/ ), 'Negative hex \X[64] nomatch');
ok(!( "\x[64]" ~~ m/^ <[\X[64]]>/ ), 'Negative charclass hex \X[64] nomatch');
ok("\x[64]" ~~ m/^ \X[16DE]/, 'Negative hex \X[16DE] match');
ok("\x[64]" ~~ m/^ <[\X[16DE]]>/, 'Negative charclass hex \X[16DE] match');
ok("abc\x[2724]def" ~~ m/\c[HEAVY FOUR BALLOON-SPOKED ASTERISK]/, 'Unanchored named HEAVY FOUR BALLOON-SPOKED ASTERISK');
ok("abc\c[HEAVY FOUR BALLOON-SPOKED ASTERISK]def" ~~ m/\x[2724]/, 'Unanchored \x[2724]');
ok("abc\c[HEAVY FOUR BALLOON-SPOKED ASTERISK]def" ~~ m/\o[23444]/, 'Unanchored \o[23444]');
ok("abc\x[2724]def" ~~ m/^ abc \c[HEAVY FOUR BALLOON-SPOKED ASTERISK] def $/, 'Anchored HEAVY FOUR BALLOON-SPOKED ASTERISK');
ok("abc\x[2724]\x[64]def" ~~ m/\c[HEAVY FOUR BALLOON-SPOKED ASTERISK,LATIN SMALL LETTER D]/, 'Multiple HEAVY FOUR BALLOON-SPOKED ASTERISK,LATIN SMALL LETTER D');
ok("\x[2724]\x[64]" ~~ m/<[\c[HEAVY FOUR BALLOON-SPOKED ASTERISK,LATIN SMALL LETTER D]]>/, 'Charclass multiple HEAVY FOUR BALLOON-SPOKED ASTERISK,LATIN SMALL LETTER D');
ok(!( "\x[2724]\x[64]" ~~ m/^ <-[\c[HEAVY FOUR BALLOON-SPOKED ASTERISK,LATIN SMALL LETTER D]]>/ ), 'Negative charclass HEAVY FOUR BALLOON-SPOKED ASTERISK,LATIN SMALL LETTER D');
ok(!( "\x[2724]" ~~ m/^ \C[HEAVY FOUR BALLOON-SPOKED ASTERISK]/ ), 'Negative named HEAVY FOUR BALLOON-SPOKED ASTERISK nomatch');
ok("\x[64]" ~~ m/^ \C[HEAVY FOUR BALLOON-SPOKED ASTERISK]/, 'Negative named HEAVY FOUR BALLOON-SPOKED ASTERISK match');
ok(!( "\x[2724]" ~~ m/^ <[\C[HEAVY FOUR BALLOON-SPOKED ASTERISK]]>/ ), 'Negative charclass named HEAVY FOUR BALLOON-SPOKED ASTERISK nomatch');
ok("\x[64]" ~~ m/^ <[\C[HEAVY FOUR BALLOON-SPOKED ASTERISK]]>/, 'Negative charclass named HEAVY FOUR BALLOON-SPOKED ASTERISK match');
ok(!( "\x[2724]" ~~ m/^ \X[2724]/ ), 'Negative hex \X[2724] nomatch');
ok(!( "\x[2724]" ~~ m/^ <[\X[2724]]>/ ), 'Negative charclass hex \X[2724] nomatch');
ok("\x[2724]" ~~ m/^ \X[64]/, 'Negative hex \X[64] match');
ok("\x[2724]" ~~ m/^ <[\X[64]]>/, 'Negative charclass hex \X[64] match');
ok("abc\x[2719]def" ~~ m/\c[OUTLINED GREEK CROSS]/, 'Unanchored named OUTLINED GREEK CROSS');
ok("abc\c[OUTLINED GREEK CROSS]def" ~~ m/\x[2719]/, 'Unanchored \x[2719]');
ok("abc\c[OUTLINED GREEK CROSS]def" ~~ m/\o[23431]/, 'Unanchored \o[23431]');
ok("abc\x[2719]def" ~~ m/^ abc \c[OUTLINED GREEK CROSS] def $/, 'Anchored OUTLINED GREEK CROSS');
ok("abc\x[2719]\x[2724]def" ~~ m/\c[OUTLINED GREEK CROSS,HEAVY FOUR BALLOON-SPOKED ASTERISK]/, 'Multiple OUTLINED GREEK CROSS,HEAVY FOUR BALLOON-SPOKED ASTERISK');
ok("\x[2719]\x[2724]" ~~ m/<[\c[OUTLINED GREEK CROSS,HEAVY FOUR BALLOON-SPOKED ASTERISK]]>/, 'Charclass multiple OUTLINED GREEK CROSS,HEAVY FOUR BALLOON-SPOKED ASTERISK');
ok(!( "\x[2719]\x[2724]" ~~ m/^ <-[\c[OUTLINED GREEK CROSS,HEAVY FOUR BALLOON-SPOKED ASTERISK]]>/ ), 'Negative charclass OUTLINED GREEK CROSS,HEAVY FOUR BALLOON-SPOKED ASTERISK');
ok(!( "\x[2719]" ~~ m/^ \C[OUTLINED GREEK CROSS]/ ), 'Negative named OUTLINED GREEK CROSS nomatch');
ok("\x[2724]" ~~ m/^ \C[OUTLINED GREEK CROSS]/, 'Negative named OUTLINED GREEK CROSS match');
ok(!( "\x[2719]" ~~ m/^ <[\C[OUTLINED GREEK CROSS]]>/ ), 'Negative charclass named OUTLINED GREEK CROSS nomatch');
ok("\x[2724]" ~~ m/^ <[\C[OUTLINED GREEK CROSS]]>/, 'Negative charclass named OUTLINED GREEK CROSS match');
ok(!( "\x[2719]" ~~ m/^ \X[2719]/ ), 'Negative hex \X[2719] nomatch');
ok(!( "\x[2719]" ~~ m/^ <[\X[2719]]>/ ), 'Negative charclass hex \X[2719] nomatch');
ok("\x[2719]" ~~ m/^ \X[2724]/, 'Negative hex \X[2724] match');
ok("\x[2719]" ~~ m/^ <[\X[2724]]>/, 'Negative charclass hex \X[2724] match');
ok("abc\x[e97]def" ~~ m/\c[LAO LETTER THO TAM]/, 'Unanchored named LAO LETTER THO TAM');
ok("abc\c[LAO LETTER THO TAM]def" ~~ m/\x[e97]/, 'Unanchored \x[e97]');
ok("abc\c[LAO LETTER THO TAM]def" ~~ m/\o[7227]/, 'Unanchored \o[7227]');
ok("abc\x[e97]def" ~~ m/^ abc \c[LAO LETTER THO TAM] def $/, 'Anchored LAO LETTER THO TAM');
ok("abc\x[e97]\x[2719]def" ~~ m/\c[LAO LETTER THO TAM, OUTLINED GREEK CROSS]/, 'Multiple LAO LETTER THO TAM, OUTLINED GREEK CROSS');
ok("\x[e97]\x[2719]" ~~ m/<[\c[LAO LETTER THO TAM, OUTLINED GREEK CROSS]]>/, 'Charclass multiple LAO LETTER THO TAM, OUTLINED GREEK CROSS');
ok(!( "\x[e97]\x[2719]" ~~ m/^ <-[\c[LAO LETTER THO TAM, OUTLINED GREEK CROSS]]>/ ), 'Negative charclass LAO LETTER THO TAM, OUTLINED GREEK CROSS');
ok(!( "\x[e97]" ~~ m/^ \C[LAO LETTER THO TAM]/ ), 'Negative named LAO LETTER THO TAM nomatch');
ok("\x[2719]" ~~ m/^ \C[LAO LETTER THO TAM]/, 'Negative named LAO LETTER THO TAM match');
ok(!( "\x[e97]" ~~ m/^ <[\C[LAO LETTER THO TAM]]>/ ), 'Negative charclass named LAO LETTER THO TAM nomatch');
ok("\x[2719]" ~~ m/^ <[\C[LAO LETTER THO TAM]]>/, 'Negative charclass named LAO LETTER THO TAM match');
ok(!( "\x[e97]" ~~ m/^ \X[E97]/ ), 'Negative hex \X[E97] nomatch');
ok(!( "\x[e97]" ~~ m/^ <[\X[E97]]>/ ), 'Negative charclass hex \X[E97] nomatch');
ok("\x[e97]" ~~ m/^ \X[2719]/, 'Negative hex \X[2719] match');
ok("\x[e97]" ~~ m/^ <[\X[2719]]>/, 'Negative charclass hex \X[2719] match');
ok("abc\x[a42d]def" ~~ m/\c[YI SYLLABLE JJYT]/, 'Unanchored named YI SYLLABLE JJYT');
ok("abc\c[YI SYLLABLE JJYT]def" ~~ m/\x[a42d]/, 'Unanchored \x[a42d]');
ok("abc\c[YI SYLLABLE JJYT]def" ~~ m/\o[122055]/, 'Unanchored \o[122055]');
ok("abc\x[a42d]def" ~~ m/^ abc \c[YI SYLLABLE JJYT] def $/, 'Anchored YI SYLLABLE JJYT');
ok("abc\x[a42d]\x[e97]def" ~~ m/\c[YI SYLLABLE JJYT,LAO LETTER THO TAM]/, 'Multiple YI SYLLABLE JJYT,LAO LETTER THO TAM');
ok("\x[a42d]\x[e97]" ~~ m/<[\c[YI SYLLABLE JJYT,LAO LETTER THO TAM]]>/, 'Charclass multiple YI SYLLABLE JJYT,LAO LETTER THO TAM');
ok(!( "\x[a42d]\x[e97]" ~~ m/^ <-[\c[YI SYLLABLE JJYT,LAO LETTER THO TAM]]>/ ), 'Negative charclass YI SYLLABLE JJYT,LAO LETTER THO TAM');
ok(!( "\x[a42d]" ~~ m/^ \C[YI SYLLABLE JJYT]/ ), 'Negative named YI SYLLABLE JJYT nomatch');
ok("\x[e97]" ~~ m/^ \C[YI SYLLABLE JJYT]/, 'Negative named YI SYLLABLE JJYT match');
ok(!( "\x[a42d]" ~~ m/^ <[\C[YI SYLLABLE JJYT]]>/ ), 'Negative charclass named YI SYLLABLE JJYT nomatch');
ok("\x[e97]" ~~ m/^ <[\C[YI SYLLABLE JJYT]]>/, 'Negative charclass named YI SYLLABLE JJYT match');
ok(!( "\x[a42d]" ~~ m/^ \X[A42D]/ ), 'Negative hex \X[A42D] nomatch');
ok(!( "\x[a42d]" ~~ m/^ <[\X[A42D]]>/ ), 'Negative charclass hex \X[A42D] nomatch');
ok("\x[a42d]" ~~ m/^ \X[E97]/, 'Negative hex \X[E97] match');
ok("\x[a42d]" ~~ m/^ <[\X[E97]]>/, 'Negative charclass hex \X[E97] match');
ok("abc\x[ff6e]def" ~~ m/\c[HALFWIDTH KATAKANA LETTER SMALL YO]/, 'Unanchored named HALFWIDTH KATAKANA LETTER SMALL YO');
ok("abc\c[HALFWIDTH KATAKANA LETTER SMALL YO]def" ~~ m/\x[FF6E]/, 'Unanchored \x[FF6E]');
ok("abc\c[HALFWIDTH KATAKANA LETTER SMALL YO]def" ~~ m/\o[177556]/, 'Unanchored \o[177556]');
ok("abc\x[ff6e]def" ~~ m/^ abc \c[HALFWIDTH KATAKANA LETTER SMALL YO] def $/, 'Anchored HALFWIDTH KATAKANA LETTER SMALL YO');
ok("abc\x[ff6e]\x[a42d]def" ~~ m/\c[HALFWIDTH KATAKANA LETTER SMALL YO,YI SYLLABLE JJYT]/, 'Multiple HALFWIDTH KATAKANA LETTER SMALL YO,YI SYLLABLE JJYT');
ok("\x[ff6e]\x[a42d]" ~~ m/<[\c[HALFWIDTH KATAKANA LETTER SMALL YO,YI SYLLABLE JJYT]]>/, 'Charclass multiple HALFWIDTH KATAKANA LETTER SMALL YO,YI SYLLABLE JJYT');
ok(!( "\x[ff6e]\x[a42d]" ~~ m/^ <-[\c[HALFWIDTH KATAKANA LETTER SMALL YO,YI SYLLABLE JJYT]]>/ ), 'Negative charclass HALFWIDTH KATAKANA LETTER SMALL YO,YI SYLLABLE JJYT');
ok(!( "\x[ff6e]" ~~ m/^ \C[HALFWIDTH KATAKANA LETTER SMALL YO]/ ), 'Negative named HALFWIDTH KATAKANA LETTER SMALL YO nomatch');
ok("\x[a42d]" ~~ m/^ \C[HALFWIDTH KATAKANA LETTER SMALL YO]/, 'Negative named HALFWIDTH KATAKANA LETTER SMALL YO match');
ok(!( "\x[ff6e]" ~~ m/^ <[\C[HALFWIDTH KATAKANA LETTER SMALL YO]]>/ ), 'Negative charclass named HALFWIDTH KATAKANA LETTER SMALL YO nomatch');
ok("\x[a42d]" ~~ m/^ <[\C[HALFWIDTH KATAKANA LETTER SMALL YO]]>/, 'Negative charclass named HALFWIDTH KATAKANA LETTER SMALL YO match');
ok(!( "\x[ff6e]" ~~ m/^ \X[FF6E]/ ), 'Negative hex \X[FF6E] nomatch');
ok(!( "\x[ff6e]" ~~ m/^ <[\X[FF6E]]>/ ), 'Negative charclass hex \X[FF6E] nomatch');
ok("\x[ff6e]" ~~ m/^ \X[A42D]/, 'Negative hex \X[A42D] match');
ok("\x[ff6e]" ~~ m/^ <[\X[A42D]]>/, 'Negative charclass hex \X[A42D] match');


# names special cases (see http://www.unicode.org/reports/tr18/#Name_Properties) "... that require special-casing ..."

ok("\x[0F68]" ~~ m/\c[TIBETAN LETTER A]/, 'match named TIBETAN LETTER A');
ok("\x[0F60]" ~~ m/\c[TIBETAN LETTER -A]/, 'match named TIBETAN LETTER -A');
ok(!("\c[TIBETAN LETTER A]" ~~ m/\c[TIBETAN LETTER -A]/), 'nomatch named TIBETAN LETTER A versus -A');
ok(!("\c[TIBETAN LETTER -A]" ~~ m/\c[TIBETAN LETTER A]/), 'nomatch named TIBETAN LETTER -A versus A');

ok("\x[0FB8]" ~~ m/\c[TIBETAN SUBJOINED LETTER A]/, 'match named TIBETAN SUBJOINED LETTER A');
ok("\x[0FB0]" ~~ m/\c[TIBETAN SUBJOINED LETTER -A]/, 'match named TIBETAN SUBJOINED LETTER -A');
ok(!("\c[TIBETAN SUBJOINED LETTER A]" ~~ m/\c[TIBETAN SUBJOINED LETTER -A]/), 'nomatch named TIBETAN SUBJOINED LETTER A versus -A');
ok(!("\c[TIBETAN SUBJOINED LETTER -A]" ~~ m/\c[TIBETAN SUBJOINED LETTER A]/), 'nomatch named TIBETAN SUBJOINED LETTER -A versus A');

ok("\x[116C]" ~~ m/\c[HANGUL JUNGSEONG OE]/, 'match named HANGUL JUNGSEONG OE');
ok("\x[1180]" ~~ m/\c[HANGUL JUNGSEONG O-E]/, 'match named HANGUL JUNGSEONG O-E');
ok(!("\c[HANGUL JUNGSEONG OE]" ~~ m/\c[HANGUL JUNGSEONG O-E]/), 'nomatch named HANGUL JUNGSEONG OE versus O-E');
ok(!("\c[HANGUL JUNGSEONG O-E]" ~~ m/\c[HANGUL JUNGSEONG OE]/), 'nomatch named HANGUL JUNGSEONG O-E versus OE');

# TODO: name aliases (see http://www.unicode.org/reports/tr18/#Name_Properties)
# for U+0009 the implementation could accept the official name CHARACTER TABULATION, and also the aliases HORIZONTAL TABULATION, HT, and TAB
# XXX should Perl-5 aliases be supported as a minimum?
# XXX should there be something like "use warning 'deprecated'"?

# TODO: named sequences (see http://www.unicode.org/reports/tr18/#Name_Properties)

# TODO: loose match, disregarding case, spaces and hyphen (see http://www.unicode.org/reports/tr18/#Name_Properties)

# TODO: global prefix like "LATIN LETTER" (see http://www.unicode.org/reports/tr18/#Name_Properties)
# XXX should this be supported?

# TODO: border values
# \x[0000], \x[007F], \x[0080], \x[00FF],
# \x[FFFF], \x[00010000], \x[0010FFFF],
# \x[00110000], ... \x[FFFFFFFF] XXX should do what?

# TODO: Grapheme
# XXX The character name of a grapheme is a list of NFC-names?

# TODO: no-names (like <control>) , invalid names, deprecated names

# vim: ft=perl6
