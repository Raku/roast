use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/named_chars.t.

# L<S02/Unicode codepoints/"(Within a regex you may also use \C to match a character 
# that is not the specified character.)">

=end pod

plan 431; 


#?pugs todo
ok("abc\x[a]def" ~~ m/\c[LINE FEED (LF)]/, 'Unanchored named LINE FEED (LF)');
#?pugs todo
ok("abc\c[LINE FEED (LF)]def" ~~ m/\x[A]/, 'Unanchored \x[A]');
#?pugs todo
ok("abc\c[LINE FEED (LF)]def" ~~ m/\o[12]/, 'Unanchored \o[12]');
#?pugs todo
ok("abc\x[a]def" ~~ m/^ abc \c[LINE FEED (LF)] def $/, 'Anchored LINE FEED (LF)');
#?pugs todo
ok("abc\x[c]def" ~~ m/\c[FORM FEED (FF)]/, 'Unanchored named FORM FEED (FF)');
#?pugs todo
ok("abc\c[FORM FEED (FF)]def" ~~ m/\x[C]/, 'Unanchored \x[C]');
#?pugs todo
ok("abc\c[FORM FEED (FF)]def" ~~ m/\o[14]/, 'Unanchored \o[14]');
#?pugs todo
ok("abc\x[c]def" ~~ m/^ abc \c[FORM FEED (FF)] def $/, 'Anchored FORM FEED (FF)');
#?pugs todo
ok("abc\x[c]\x[a]def" ~~ m/\c[FORM FEED (FF), LINE FEED (LF)]/, 'Multiple FORM FEED (FF), LINE FEED (LF)');
#?pugs todo
ok("\x[c]\x[a]" ~~ m/<[\c[FORM FEED (FF), LINE FEED (LF)]]>/, 'Charclass multiple FORM FEED (FF), LINE FEED (LF)');
ok(!( "\x[c]\x[a]" ~~ m/^ <-[\c[FORM FEED (FF), LINE FEED (LF)]]>/ ), 'Negative charclass FORM FEED (FF), LINE FEED (LF)');
ok(!( "\x[c]" ~~ m/^ \C[FORM FEED (FF)]/ ), 'Negative named FORM FEED (FF) nomatch');
#?pugs todo
ok("\x[a]" ~~ m/^ \C[FORM FEED (FF)]/, 'Negative named FORM FEED (FF) match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[c]" ~~ m/^ <[\C[FORM FEED (FF)]]>/ ), 'Negative charclass named FORM FEED (FF) nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[a]" ~~ m/^ <[\C[FORM FEED (FF)]]>/, 'Negative charclass named FORM FEED (FF) match');
ok(!( "\x[c]" ~~ m/^ \X[C]/ ), 'Negative hex \X[C] nomatch');
ok(!( "\x[c]" ~~ m/^ <[\X[C]]>/ ), 'Negative charclass hex \X[C] nomatch');
#?pugs todo
ok("\x[c]" ~~ m/^ \X[A]/, 'Negative hex \X[A] match');
#?pugs todo
ok("\x[c]" ~~ m/^ <[\X[A]]>/, 'Negative charclass hex \X[A] match');
#?pugs todo
ok("abc\x[d]def" ~~ m/\c[CARRIAGE RETURN (CR)]/, 'Unanchored named CARRIAGE RETURN (CR)');
#?pugs todo
ok("abc\c[CARRIAGE RETURN (CR)]def" ~~ m/\x[d]/, 'Unanchored \x[d]');
#?pugs todo
ok("abc\c[CARRIAGE RETURN (CR)]def" ~~ m/\o[15]/, 'Unanchored \o[15]');
#?pugs todo
ok("abc\x[d]def" ~~ m/^ abc \c[CARRIAGE RETURN (CR)] def $/, 'Anchored CARRIAGE RETURN (CR)');
#?pugs todo
ok("abc\x[d]\x[c]def" ~~ m/\c[CARRIAGE RETURN (CR), FORM FEED (FF)]/, 'Multiple CARRIAGE RETURN (CR), FORM FEED (FF)');

#?pugs todo
ok("\x[d]\x[c]" ~~ m/<[\c[CARRIAGE RETURN (CR), FORM FEED (FF)]]>/, 'Charclass multiple CARRIAGE RETURN (CR), FORM FEED (FF)');
ok(!( "\x[d]\x[c]" ~~ m/^ <-[\c[CARRIAGE RETURN (CR), FORM FEED (FF)]]>/ ), 'Negative charclass CARRIAGE RETURN (CR), FORM FEED (FF)');
ok(!( "\x[d]" ~~ m/^ \C[CARRIAGE RETURN (CR)]/ ), 'Negative named CARRIAGE RETURN (CR) nomatch');
#?pugs todo
ok("\x[c]" ~~ m/^ \C[CARRIAGE RETURN (CR)]/, 'Negative named CARRIAGE RETURN (CR) match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[d]" ~~ m/^ <[\C[CARRIAGE RETURN (CR)]]>/ ), 'Negative charclass named CARRIAGE RETURN (CR) nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[c]" ~~ m/^ <[\C[CARRIAGE RETURN (CR)]]>/, 'Negative charclass named CARRIAGE RETURN (CR) match');
ok(!( "\x[d]" ~~ m/^ \X[D]/ ), 'Negative hex \X[D] nomatch');
ok(!( "\x[d]" ~~ m/^ <[\X[D]]>/ ), 'Negative charclass hex \X[D] nomatch');
#?pugs todo
ok("\x[d]" ~~ m/^ \X[C]/, 'Negative hex \X[C] match');
#?pugs todo
ok("\x[d]" ~~ m/^ <[\X[C]]>/, 'Negative charclass hex \X[C] match');
#?pugs todo
ok("abc\x[85]def" ~~ m/\c[NEXT LINE (NEL)]/, 'Unanchored named NEXT LINE (NEL)');
#?pugs todo
ok("abc\c[NEXT LINE (NEL)]def" ~~ m/\x[85]/, 'Unanchored \x[85]');
#?pugs todo
ok("abc\c[NEXT LINE (NEL)]def" ~~ m/\o[205]/, 'Unanchored \o[205]');
#?pugs todo
ok("abc\x[85]def" ~~ m/^ abc \c[NEXT LINE (NEL)] def $/, 'Anchored NEXT LINE (NEL)');
#?pugs todo
ok("abc\x[85]\x[d]def" ~~ m/\c[NEXT LINE (NEL), CARRIAGE RETURN (CR)]/, 'Multiple NEXT LINE (NEL), CARRIAGE RETURN (CR)');
#?pugs todo
ok("\x[85]\x[d]" ~~ m/<[\c[NEXT LINE (NEL), CARRIAGE RETURN (CR)]]>/, 'Charclass multiple NEXT LINE (NEL), CARRIAGE RETURN (CR)');
ok(!( "\x[85]\x[d]" ~~ m/^ <-[\c[NEXT LINE (NEL), CARRIAGE RETURN (CR)]]>/ ), 'Negative charclass NEXT LINE (NEL), CARRIAGE RETURN (CR)');
ok(!( "\x[85]" ~~ m/^ \C[NEXT LINE (NEL)]/ ), 'Negative named NEXT LINE (NEL) nomatch');
#?pugs todo
ok("\x[d]" ~~ m/^ \C[NEXT LINE (NEL)]/, 'Negative named NEXT LINE (NEL) match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[85]" ~~ m/^ <[\C[NEXT LINE (NEL)]]>/ ), 'Negative charclass named NEXT LINE (NEL) nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[d]" ~~ m/^ <[\C[NEXT LINE (NEL)]]>/, 'Negative charclass named NEXT LINE (NEL) match');
ok(!( "\x[85]" ~~ m/^ \X[85]/ ), 'Negative hex \X[85] nomatch');
ok(!( "\x[85]" ~~ m/^ <[\X[85]]>/ ), 'Negative charclass hex \X[85] nomatch');
#?pugs todo
ok("\x[85]" ~~ m/^ \X[D]/, 'Negative hex \X[D] match');
#?pugs todo
ok("\x[85]" ~~ m/^ <[\X[D]]>/, 'Negative charclass hex \X[D] match');

#?pugs todo
ok("abc\c[LINE FEED (LF)]def" ~~ m/\c[LINE FEED (LF)]/, 'Unanchored named LINE FEED (LF)');
#?pugs todo
ok("abc\c[LINE FEED (LF)]def" ~~ m/^ abc \c[LINE FEED (LF)] def $/, 'Anchored LINE FEED (LF)');
#?pugs todo
ok("abc\c[LINE FEED (LF)]\x[85]def" ~~ m/\c[LINE FEED (LF), NEXT LINE (NEL)]/, 'Multiple LINE FEED (LF), NEXT LINE (NEL)');
#?pugs todo
ok("\c[LINE FEED (LF)]\x[85]" ~~ m/<[\c[LINE FEED (LF), NEXT LINE (NEL)]]>/, 'Charclass multiple LINE FEED (LF), NEXT LINE (NEL)');
ok(!( "\c[LINE FEED (LF)]\x[85]" ~~ m/^ <-[\c[LINE FEED (LF), NEXT LINE (NEL)]]>/ ), 'Negative charclass LINE FEED (LF), NEXT LINE (NEL)');
ok(!( "\c[LINE FEED (LF)]" ~~ m/^ \C[LINE FEED (LF)]/ ), 'Negative named LINE FEED (LF) nomatch');
#?pugs todo
ok("\x[85]" ~~ m/^ \C[LINE FEED (LF)]/, 'Negative named LINE FEED (LF) match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\c[LINE FEED (LF)]" ~~ m/^ <[\C[LINE FEED (LF)]]>/ ), 'Negative charclass named LINE FEED (LF) nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[85]" ~~ m/^ <[\C[LINE FEED (LF)]]>/, 'Negative charclass named LINE FEED (LF) match');
#?pugs todo
ok("abc\c[FORM FEED (FF)]def" ~~ m/\c[FORM FEED (FF)]/, 'Unanchored named FORM FEED (FF)');
#?pugs todo
ok("abc\c[FORM FEED (FF)]def" ~~ m/^ abc \c[FORM FEED (FF)] def $/, 'Anchored FORM FEED (FF)');
#?pugs todo
ok("abc\c[FORM FEED (FF)]\c[LINE FEED (LF)]def" ~~ m/\c[FORM FEED (FF), LINE FEED (LF)]/, 'Multiple FORM FEED (FF), LINE FEED (LF)');
#?pugs todo
ok("\c[FORM FEED (FF)]\c[LINE FEED (LF)]" ~~ m/<[\c[FORM FEED (FF), LINE FEED (LF)]]>/, 'Charclass multiple FORM FEED (FF), LINE FEED (LF)');
ok(!( "\c[FORM FEED (FF)]\c[LINE FEED (LF)]" ~~ m/^ <-[\c[FORM FEED (FF), LINE FEED (LF)]]>/ ), 'Negative charclass FORM FEED (FF), LINE FEED (LF)');
ok(!( "\c[FORM FEED (FF)]" ~~ m/^ \C[FORM FEED (FF)]/ ), 'Negative named FORM FEED (FF) nomatch');
#?pugs todo
ok("\c[LINE FEED (LF)]" ~~ m/^ \C[FORM FEED (FF)]/, 'Negative named FORM FEED (FF) match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\c[FORM FEED (FF)]" ~~ m/^ <[\C[FORM FEED (FF)]]>/ ), 'Negative charclass named FORM FEED (FF) nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\c[LINE FEED (LF)]" ~~ m/^ <[\C[FORM FEED (FF)]]>/, 'Negative charclass named FORM FEED (FF) match');
#?pugs todo
ok("abc\c[CARRIAGE RETURN (CR)]def" ~~ m/\c[CARRIAGE RETURN (CR)]/, 'Unanchored named CARRIAGE RETURN (CR)');
#?pugs todo
ok("abc\c[CARRIAGE RETURN (CR)]def" ~~ m/^ abc \c[CARRIAGE RETURN (CR)] def $/, 'Anchored CARRIAGE RETURN (CR)');
#?pugs todo
ok("abc\c[CARRIAGE RETURN (CR)]\c[FORM FEED (FF)]def" ~~ m/\c[CARRIAGE RETURN (CR),FORM FEED (FF)]/, 'Multiple CARRIAGE RETURN (CR),FORM FEED (FF)');

#?pugs todo
ok("\c[CARRIAGE RETURN (CR)]\c[FORM FEED (FF)]" ~~ m/<[\c[CARRIAGE RETURN (CR),FORM FEED (FF)]]>/, 'Charclass multiple CARRIAGE RETURN (CR),FORM FEED (FF)');
ok(!( "\c[CARRIAGE RETURN (CR)]\c[FORM FEED (FF)]" ~~ m/^ <-[\c[CARRIAGE RETURN (CR),FORM FEED (FF)]]>/ ), 'Negative charclass CARRIAGE RETURN (CR),FORM FEED (FF)');
ok(!( "\c[CARRIAGE RETURN (CR)]" ~~ m/^ \C[CARRIAGE RETURN (CR)]/ ), 'Negative named CARRIAGE RETURN (CR) nomatch');
#?pugs todo
ok("\c[FORM FEED (FF)]" ~~ m/^ \C[CARRIAGE RETURN (CR)]/, 'Negative named CARRIAGE RETURN (CR) match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\c[CARRIAGE RETURN (CR)]" ~~ m/^ <[\C[CARRIAGE RETURN (CR)]]>/ ), 'Negative charclass named CARRIAGE RETURN (CR) nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\c[FORM FEED (FF)]" ~~ m/^ <[\C[CARRIAGE RETURN (CR)]]>/, 'Negative charclass named CARRIAGE RETURN (CR) match');
#?pugs todo
ok("abc\c[NEXT LINE (NEL)]def" ~~ m/\c[NEXT LINE (NEL)]/, 'Unanchored named NEXT LINE (NEL)');
#?pugs todo
ok("abc\c[NEXT LINE (NEL)]def" ~~ m/^ abc \c[NEXT LINE (NEL)] def $/, 'Anchored NEXT LINE (NEL)');
#?pugs todo
ok("abc\c[NEXT LINE (NEL)]\c[CARRIAGE RETURN (CR)]def" ~~ m/\c[NEXT LINE (NEL),CARRIAGE RETURN (CR)]/, 'Multiple NEXT LINE (NEL),CARRIAGE RETURN (CR)');
#?pugs todo
ok("\c[NEXT LINE (NEL)]\c[CARRIAGE RETURN (CR)]" ~~ m/<[\c[NEXT LINE (NEL),CARRIAGE RETURN (CR)]]>/, 'Charclass multiple NEXT LINE (NEL),CARRIAGE RETURN (CR)');
ok(!( "\c[NEXT LINE (NEL)]\c[CARRIAGE RETURN (CR)]" ~~ m/^ <-[\c[NEXT LINE (NEL),CARRIAGE RETURN (CR)]]>/ ), 'Negative charclass NEXT LINE (NEL),CARRIAGE RETURN (CR)');
ok(!( "\c[NEXT LINE (NEL)]" ~~ m/^ \C[NEXT LINE (NEL)]/ ), 'Negative named NEXT LINE (NEL) nomatch');
#?pugs todo
ok("\c[CARRIAGE RETURN (CR)]" ~~ m/^ \C[NEXT LINE (NEL)]/, 'Negative named NEXT LINE (NEL) match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\c[NEXT LINE (NEL)]" ~~ m/^ <[\C[NEXT LINE (NEL)]]>/ ), 'Negative charclass named NEXT LINE (NEL) nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\c[CARRIAGE RETURN (CR)]" ~~ m/^ <[\C[NEXT LINE (NEL)]]>/, 'Negative charclass named NEXT LINE (NEL) match');
#?rakudo 4 skip '\c[LF] not valid charname'
#?pugs todo
ok("abc\c[LF]def" ~~ m/\c[LF]/, 'Unanchored named LF');
#?pugs todo
ok("abc\c[LF]def" ~~ m/^ abc \c[LF] def $/, 'Anchored LF');
#?pugs todo
ok("abc\c[LF]\c[NEXT LINE (NEL)]def" ~~ m/\c[LF, NEXT LINE (NEL)]/, 'Multiple LF, NEXT LINE (NEL)');
#?pugs todo
ok("\c[LF]\c[NEXT LINE (NEL)]" ~~ m/<[\c[LF, NEXT LINE (NEL)]]>/, 'Charclass multiple LF, NEXT LINE (NEL)');
#?rakudo skip 'escapes in char classes'
ok(!( "\c[LF]\c[NEXT LINE (NEL)]" ~~ m/^ <-[\c[LF, NEXT LINE (NEL)]]>/ ), 'Negative charclass LF, NEXT LINE (NEL)');
#?rakudo 2 skip 'LF as char name'
ok(!( "\c[LF]" ~~ m/^ \C[LF]/ ), 'Negative named LF nomatch');
#?pugs todo
ok("\c[NEXT LINE (NEL)]" ~~ m/^ \C[LF]/, 'Negative named LF match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\c[LF]" ~~ m/^ <[\C[LF]]>/ ), 'Negative charclass named LF nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\c[NEXT LINE (NEL)]" ~~ m/^ <[\C[LF]]>/, 'Negative charclass named LF match');
#?rakudo 4 skip '\c[FF] not valid charname'
#?pugs todo
ok("abc\c[FF]def" ~~ m/\c[FF]/, 'Unanchored named FF');
#?pugs todo
ok("abc\c[FF]def" ~~ m/^ abc \c[FF] def $/, 'Anchored FF');
#?pugs todo
ok("abc\c[FF]\c[LF]def" ~~ m/\c[FF,LF]/, 'Multiple FF,LF');
#?pugs todo
ok("\c[FF]\c[LF]" ~~ m/<[\c[FF,LF]]>/, 'Charclass multiple FF,LF');
#?rakudo skip 'escapes in char classes'
ok(!( "\c[FF]\c[LF]" ~~ m/^ <-[\c[FF,LF]]>/ ), 'Negative charclass FF,LF');

#?rakudo 2 skip 'FF as char name'
ok(!( "\c[FF]" ~~ m/^ \C[FF]/ ), 'Negative named FF nomatch');
#?pugs todo
ok("\c[LF]" ~~ m/^ \C[FF]/, 'Negative named FF match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\c[FF]" ~~ m/^ <[\C[FF]]>/ ), 'Negative charclass named FF nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\c[LF]" ~~ m/^ <[\C[FF]]>/, 'Negative charclass named FF match');
#?rakudo 4 skip '\c[CR] not valid charname'
#?pugs todo
ok("abc\c[CR]def" ~~ m/\c[CR]/, 'Unanchored named CR');
#?pugs todo
ok("abc\c[CR]def" ~~ m/^ abc \c[CR] def $/, 'Anchored CR');
#?pugs todo
ok("abc\c[CR]\c[FF]def" ~~ m/\c[CR,FF]/, 'Multiple CR,FF');
#?pugs todo
ok("\c[CR]\c[FF]" ~~ m/<[\c[CR,FF]]>/, 'Charclass multiple CR,FF');
#?rakudo skip 'escapes in char classes'
ok(!( "\c[CR]\c[FF]" ~~ m/^ <-[\c[CR,FF]]>/ ), 'Negative charclass CR,FF');
#?rakudo 2 skip 'CR as char name'
ok(!( "\c[CR]" ~~ m/^ \C[CR]/ ), 'Negative named CR nomatch');
#?pugs todo
ok("\c[FF]" ~~ m/^ \C[CR]/, 'Negative named CR match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\c[CR]" ~~ m/^ <[\C[CR]]>/ ), 'Negative charclass named CR nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\c[FF]" ~~ m/^ <[\C[CR]]>/, 'Negative charclass named CR match');
#?rakudo 4 skip '\c[NEL] not valid charname'
#?pugs todo
ok("abc\c[NEL]def" ~~ m/\c[NEL]/, 'Unanchored named NEL');
#?pugs todo
ok("abc\c[NEL]def" ~~ m/^ abc \c[NEL] def $/, 'Anchored NEL');
#?pugs todo
ok("abc\c[NEL]\c[CR]def" ~~ m/\c[NEL,CR]/, 'Multiple NEL,CR');
#?pugs todo
ok("\c[NEL]\c[CR]" ~~ m/<[\c[NEL,CR]]>/, 'Charclass multiple NEL,CR');
#?rakudo skip 'escapes in char classes'
ok(!( "\c[NEL]\c[CR]" ~~ m/^ <-[\c[NEL,CR]]>/ ), 'Negative charclass NEL,CR');
#?rakudo 2 skip 'NEL as char name'
ok(!( "\c[NEL]" ~~ m/^ \C[NEL]/ ), 'Negative named NEL nomatch');
#?pugs todo
ok("\c[CR]" ~~ m/^ \C[NEL]/, 'Negative named NEL match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\c[NEL]" ~~ m/^ <[\C[NEL]]>/ ), 'Negative charclass named NEL nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\c[CR]" ~~ m/^ <[\C[NEL]]>/, 'Negative charclass named NEL match');
#?pugs todo
ok("abc\x[fd55]def" ~~ m/\c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]/, 'Unanchored named ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM');
#?pugs todo
ok("abc\c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]def" ~~ m/\x[fd55]/, 'Unanchored \x[fd55]');
#?pugs todo
ok("abc\c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]def" ~~ m/\o[176525]/, 'Unanchored \o[176525]');
#?pugs todo
ok("abc\x[fd55]def" ~~ m/^ abc \c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM] def $/, 'Anchored ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM');
#?rakudo 3 skip '\c[NEL] not valid charname'
#?pugs todo
ok("abc\x[fd55]\c[NEL]def" ~~ m/\c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM,NEL]/, 'Multiple ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM,NEL');
#?pugs todo
ok("\x[fd55]\c[NEL]" ~~ m/<[\c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM,NEL]]>/, 'Charclass multiple ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM,NEL');
#?rakudo skip 'escapes in char classes'
ok(!( "\x[fd55]\c[NEL]" ~~ m/^ <-[\c[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM,NEL]]>/ ), 'Negative charclass ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM,NEL');
ok(!( "\x[fd55]" ~~ m/^ \C[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]/ ), 'Negative named ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM nomatch');
#?rakudo skip '\c[NEL] not valid charname'
#?pugs todo
ok("\c[NEL]" ~~ m/^ \C[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]/, 'Negative named ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[fd55]" ~~ m/^ <[\C[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]]>/ ), 'Negative charclass named ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\c[NEL]" ~~ m/^ <[\C[ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]]>/, 'Negative charclass named ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM match');

ok(!( "\x[fd55]" ~~ m/^ \X[FD55]/ ), 'Negative hex \X[FD55] nomatch');
ok(!( "\x[fd55]" ~~ m/^ <[\X[FD55]]>/ ), 'Negative charclass hex \X[FD55] nomatch');
#?pugs todo
ok("abc\x[5b4]def" ~~ m/\c[HEBREW POINT HIRIQ]/, 'Unanchored named HEBREW POINT HIRIQ');
#?pugs todo
ok("abc\c[HEBREW POINT HIRIQ]def" ~~ m/\x[5B4]/, 'Unanchored \x[5B4]');
#?pugs todo
ok("abc\c[HEBREW POINT HIRIQ]def" ~~ m/\o[2664]/, 'Unanchored \o[2664]');
#?pugs todo
ok("abc\x[5b4]def" ~~ m/^ abc \c[HEBREW POINT HIRIQ] def $/, 'Anchored HEBREW POINT HIRIQ');
#?pugs todo
ok("abc\x[5b4]\x[fd55]def" ~~ m/\c[HEBREW POINT HIRIQ,ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]/, 'Multiple HEBREW POINT HIRIQ,ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM');
#?pugs todo
ok("\x[5b4]\x[fd55]" ~~ m/<[\c[HEBREW POINT HIRIQ,ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]]>/, 'Charclass multiple HEBREW POINT HIRIQ,ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM');
ok(!( "\x[5b4]\x[fd55]" ~~ m/^ <-[\c[HEBREW POINT HIRIQ,ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM]]>/ ), 'Negative charclass HEBREW POINT HIRIQ,ARABIC LIGATURE TEH WITH MEEM WITH JEEM INITIAL FORM');
ok(!( "\x[5b4]" ~~ m/^ \C[HEBREW POINT HIRIQ]/ ), 'Negative named HEBREW POINT HIRIQ nomatch');
#?pugs todo
ok("\x[fd55]" ~~ m/^ \C[HEBREW POINT HIRIQ]/, 'Negative named HEBREW POINT HIRIQ match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[5b4]" ~~ m/^ <[\C[HEBREW POINT HIRIQ]]>/ ), 'Negative charclass named HEBREW POINT HIRIQ nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[fd55]" ~~ m/^ <[\C[HEBREW POINT HIRIQ]]>/, 'Negative charclass named HEBREW POINT HIRIQ match');
ok(!( "\x[5b4]" ~~ m/^ \X[5B4]/ ), 'Negative hex \X[5B4] nomatch');
ok(!( "\x[5b4]" ~~ m/^ <[\X[5B4]]>/ ), 'Negative charclass hex \X[5B4] nomatch');
#?pugs todo
ok("\x[5b4]" ~~ m/^ \X[FD55]/, 'Negative hex \X[FD55] match');
#?pugs todo
ok("\x[5b4]" ~~ m/^ <[\X[FD55]]>/, 'Negative charclass hex \X[FD55] match');
#?pugs todo
ok("abc\x[1ea2]def" ~~ m/\c[LATIN CAPITAL LETTER A WITH HOOK ABOVE]/, 'Unanchored named LATIN CAPITAL LETTER A WITH HOOK ABOVE');
#?pugs todo
ok("abc\c[LATIN CAPITAL LETTER A WITH HOOK ABOVE]def" ~~ m/\x[1EA2]/, 'Unanchored \x[1EA2]');
#?pugs todo
ok("abc\c[LATIN CAPITAL LETTER A WITH HOOK ABOVE]def" ~~ m/\o[17242]/, 'Unanchored \o[17242]');
#?pugs todo
ok("abc\x[1ea2]def" ~~ m/^ abc \c[LATIN CAPITAL LETTER A WITH HOOK ABOVE] def $/, 'Anchored LATIN CAPITAL LETTER A WITH HOOK ABOVE');
#?pugs todo
ok("abc\x[1ea2]\x[5b4]def" ~~ m/\c[LATIN CAPITAL LETTER A WITH HOOK ABOVE,HEBREW POINT HIRIQ]/, 'Multiple LATIN CAPITAL LETTER A WITH HOOK ABOVE,HEBREW POINT HIRIQ');
#?pugs todo
ok("\x[1ea2]\x[5b4]" ~~ m/<[\c[LATIN CAPITAL LETTER A WITH HOOK ABOVE,HEBREW POINT HIRIQ]]>/, 'Charclass multiple LATIN CAPITAL LETTER A WITH HOOK ABOVE,HEBREW POINT HIRIQ');
ok(!( "\x[1ea2]\x[5b4]" ~~ m/^ <-[\c[LATIN CAPITAL LETTER A WITH HOOK ABOVE,HEBREW POINT HIRIQ]]>/ ), 'Negative charclass LATIN CAPITAL LETTER A WITH HOOK ABOVE,HEBREW POINT HIRIQ');
ok(!( "\x[1ea2]" ~~ m/^ \C[LATIN CAPITAL LETTER A WITH HOOK ABOVE]/ ), 'Negative named LATIN CAPITAL LETTER A WITH HOOK ABOVE nomatch');
#?pugs todo
ok("\x[5b4]" ~~ m/^ \C[LATIN CAPITAL LETTER A WITH HOOK ABOVE]/, 'Negative named LATIN CAPITAL LETTER A WITH HOOK ABOVE match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[1ea2]" ~~ m/^ <[\C[LATIN CAPITAL LETTER A WITH HOOK ABOVE]]>/ ), 'Negative charclass named LATIN CAPITAL LETTER A WITH HOOK ABOVE nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[5b4]" ~~ m/^ <[\C[LATIN CAPITAL LETTER A WITH HOOK ABOVE]]>/, 'Negative charclass named LATIN CAPITAL LETTER A WITH HOOK ABOVE match');
ok(!( "\x[1ea2]" ~~ m/^ \X[1EA2]/ ), 'Negative hex \X[1EA2] nomatch');
ok(!( "\x[1ea2]" ~~ m/^ <[\X[1EA2]]>/ ), 'Negative charclass hex \X[1EA2] nomatch');
#?pugs todo
ok("\x[1ea2]" ~~ m/^ \X[5B4]/, 'Negative hex \X[5B4] match');
#?pugs todo
ok("\x[1ea2]" ~~ m/^ <[\X[5B4]]>/, 'Negative charclass hex \X[5B4] match');
#?pugs todo
ok("abc\x[565]def" ~~ m/\c[ARMENIAN SMALL LETTER ECH]/, 'Unanchored named ARMENIAN SMALL LETTER ECH');
#?pugs todo
ok("abc\c[ARMENIAN SMALL LETTER ECH]def" ~~ m/\x[565]/, 'Unanchored \x[565]');
#?pugs todo
ok("abc\c[ARMENIAN SMALL LETTER ECH]def" ~~ m/\o[2545]/, 'Unanchored \o[2545]');
#?pugs todo
ok("abc\x[565]def" ~~ m/^ abc \c[ARMENIAN SMALL LETTER ECH] def $/, 'Anchored ARMENIAN SMALL LETTER ECH');
#?pugs todo
ok("abc\x[565]\x[1ea2]def" ~~ m/\c[ARMENIAN SMALL LETTER ECH,LATIN CAPITAL LETTER A WITH HOOK ABOVE]/, 'Multiple ARMENIAN SMALL LETTER ECH,LATIN CAPITAL LETTER A WITH HOOK ABOVE');
#?pugs todo
ok("\x[565]\x[1ea2]" ~~ m/<[\c[ARMENIAN SMALL LETTER ECH,LATIN CAPITAL LETTER A WITH HOOK ABOVE]]>/, 'Charclass multiple ARMENIAN SMALL LETTER ECH,LATIN CAPITAL LETTER A WITH HOOK ABOVE');
ok(!( "\x[565]\x[1ea2]" ~~ m/^ <-[\c[ARMENIAN SMALL LETTER ECH,LATIN CAPITAL LETTER A WITH HOOK ABOVE]]>/ ), 'Negative charclass ARMENIAN SMALL LETTER ECH,LATIN CAPITAL LETTER A WITH HOOK ABOVE');
ok(!( "\x[565]" ~~ m/^ \C[ARMENIAN SMALL LETTER ECH]/ ), 'Negative named ARMENIAN SMALL LETTER ECH nomatch');
#?pugs todo
ok("\x[1ea2]" ~~ m/^ \C[ARMENIAN SMALL LETTER ECH]/, 'Negative named ARMENIAN SMALL LETTER ECH match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[565]" ~~ m/^ <[\C[ARMENIAN SMALL LETTER ECH]]>/ ), 'Negative charclass named ARMENIAN SMALL LETTER ECH nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[1ea2]" ~~ m/^ <[\C[ARMENIAN SMALL LETTER ECH]]>/, 'Negative charclass named ARMENIAN SMALL LETTER ECH match');
ok(!( "\x[565]" ~~ m/^ \X[565]/ ), 'Negative hex \X[565] nomatch');
ok(!( "\x[565]" ~~ m/^ <[\X[565]]>/ ), 'Negative charclass hex \X[565] nomatch');
#?pugs todo
ok("\x[565]" ~~ m/^ \X[1EA2]/, 'Negative hex \X[1EA2] match');
#?pugs todo
ok("\x[565]" ~~ m/^ <[\X[1EA2]]>/, 'Negative charclass hex \X[1EA2] match');
#?pugs todo
ok("abc\x[25db]def" ~~ m/\c[LOWER HALF INVERSE WHITE CIRCLE]/, 'Unanchored named LOWER HALF INVERSE WHITE CIRCLE');
#?pugs todo
ok("abc\c[LOWER HALF INVERSE WHITE CIRCLE]def" ~~ m/\x[25DB]/, 'Unanchored \x[25DB]');
#?pugs todo
ok("abc\c[LOWER HALF INVERSE WHITE CIRCLE]def" ~~ m/\o[22733]/, 'Unanchored \o[22733]');
#?pugs todo
ok("abc\x[25db]def" ~~ m/^ abc \c[LOWER HALF INVERSE WHITE CIRCLE] def $/, 'Anchored LOWER HALF INVERSE WHITE CIRCLE');
#?pugs todo
ok("abc\x[25db]\x[565]def" ~~ m/\c[LOWER HALF INVERSE WHITE CIRCLE,ARMENIAN SMALL LETTER ECH]/, 'Multiple LOWER HALF INVERSE WHITE CIRCLE,ARMENIAN SMALL LETTER ECH');
#?pugs todo
ok("\x[25db]\x[565]" ~~ m/<[\c[LOWER HALF INVERSE WHITE CIRCLE,ARMENIAN SMALL LETTER ECH]]>/, 'Charclass multiple LOWER HALF INVERSE WHITE CIRCLE,ARMENIAN SMALL LETTER ECH');
ok(!( "\x[25db]\x[565]" ~~ m/^ <-[\c[LOWER HALF INVERSE WHITE CIRCLE,ARMENIAN SMALL LETTER ECH]]>/ ), 'Negative charclass LOWER HALF INVERSE WHITE CIRCLE,ARMENIAN SMALL LETTER ECH');
ok(!( "\x[25db]" ~~ m/^ \C[LOWER HALF INVERSE WHITE CIRCLE]/ ), 'Negative named LOWER HALF INVERSE WHITE CIRCLE nomatch');
#?pugs todo
ok("\x[565]" ~~ m/^ \C[LOWER HALF INVERSE WHITE CIRCLE]/, 'Negative named LOWER HALF INVERSE WHITE CIRCLE match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[25db]" ~~ m/^ <[\C[LOWER HALF INVERSE WHITE CIRCLE]]>/ ), 'Negative charclass named LOWER HALF INVERSE WHITE CIRCLE nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[565]" ~~ m/^ <[\C[LOWER HALF INVERSE WHITE CIRCLE]]>/, 'Negative charclass named LOWER HALF INVERSE WHITE CIRCLE match');
ok(!( "\x[25db]" ~~ m/^ \X[25DB]/ ), 'Negative hex \X[25DB] nomatch');
ok(!( "\x[25db]" ~~ m/^ <[\X[25DB]]>/ ), 'Negative charclass hex \X[25DB] nomatch');
#?pugs todo
ok("\x[25db]" ~~ m/^ \X[565]/, 'Negative hex \X[565] match');
#?pugs todo
ok("\x[25db]" ~~ m/^ <[\X[565]]>/, 'Negative charclass hex \X[565] match');
#?pugs todo
ok("abc\x[fe7d]def" ~~ m/\c[ARABIC SHADDA MEDIAL FORM]/, 'Unanchored named ARABIC SHADDA MEDIAL FORM');
#?pugs todo
ok("abc\c[ARABIC SHADDA MEDIAL FORM]def" ~~ m/\x[fe7d]/, 'Unanchored \x[fe7d]');
#?pugs todo
ok("abc\c[ARABIC SHADDA MEDIAL FORM]def" ~~ m/\o[177175]/, 'Unanchored \o[177175]');
#?pugs todo
ok("abc\x[fe7d]def" ~~ m/^ abc \c[ARABIC SHADDA MEDIAL FORM] def $/, 'Anchored ARABIC SHADDA MEDIAL FORM');
#?pugs todo
ok("abc\x[fe7d]\x[25db]def" ~~ m/\c[ARABIC SHADDA MEDIAL FORM,LOWER HALF INVERSE WHITE CIRCLE]/, 'Multiple ARABIC SHADDA MEDIAL FORM,LOWER HALF INVERSE WHITE CIRCLE');
#?pugs todo
ok("\x[fe7d]\x[25db]" ~~ m/<[\c[ARABIC SHADDA MEDIAL FORM,LOWER HALF INVERSE WHITE CIRCLE]]>/, 'Charclass multiple ARABIC SHADDA MEDIAL FORM,LOWER HALF INVERSE WHITE CIRCLE');
ok(!( "\x[fe7d]\x[25db]" ~~ m/^ <-[\c[ARABIC SHADDA MEDIAL FORM,LOWER HALF INVERSE WHITE CIRCLE]]>/ ), 'Negative charclass ARABIC SHADDA MEDIAL FORM,LOWER HALF INVERSE WHITE CIRCLE');
ok(!( "\x[fe7d]" ~~ m/^ \C[ARABIC SHADDA MEDIAL FORM]/ ), 'Negative named ARABIC SHADDA MEDIAL FORM nomatch');
#?pugs todo
ok("\x[25db]" ~~ m/^ \C[ARABIC SHADDA MEDIAL FORM]/, 'Negative named ARABIC SHADDA MEDIAL FORM match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[fe7d]" ~~ m/^ <[\C[ARABIC SHADDA MEDIAL FORM]]>/ ), 'Negative charclass named ARABIC SHADDA MEDIAL FORM nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[25db]" ~~ m/^ <[\C[ARABIC SHADDA MEDIAL FORM]]>/, 'Negative charclass named ARABIC SHADDA MEDIAL FORM match');
ok(!( "\x[fe7d]" ~~ m/^ \X[FE7D]/ ), 'Negative hex \X[FE7D] nomatch');
ok(!( "\x[fe7d]" ~~ m/^ <[\X[FE7D]]>/ ), 'Negative charclass hex \X[FE7D] nomatch');
#?pugs todo
ok("\x[fe7d]" ~~ m/^ \X[25DB]/, 'Negative hex \X[25DB] match');
#?pugs todo
ok("\x[fe7d]" ~~ m/^ <[\X[25DB]]>/, 'Negative charclass hex \X[25DB] match');
#?pugs todo
ok("abc\x[a15d]def" ~~ m/\c[YI SYLLABLE NDO]/, 'Unanchored named YI SYLLABLE NDO');
#?pugs todo
ok("abc\c[YI SYLLABLE NDO]def" ~~ m/\x[A15D]/, 'Unanchored \x[A15D]');
#?pugs todo
ok("abc\c[YI SYLLABLE NDO]def" ~~ m/\o[120535]/, 'Unanchored \o[120535]');
#?pugs todo
ok("abc\x[a15d]def" ~~ m/^ abc \c[YI SYLLABLE NDO] def $/, 'Anchored YI SYLLABLE NDO');
#?pugs todo
ok("abc\x[a15d]\x[fe7d]def" ~~ m/\c[YI SYLLABLE NDO, ARABIC SHADDA MEDIAL FORM]/, 'Multiple YI SYLLABLE NDO, ARABIC SHADDA MEDIAL FORM');
#?pugs todo
ok("\x[a15d]\x[fe7d]" ~~ m/<[\c[YI SYLLABLE NDO, ARABIC SHADDA MEDIAL FORM]]>/, 'Charclass multiple YI SYLLABLE NDO, ARABIC SHADDA MEDIAL FORM');
ok(!( "\x[a15d]\x[fe7d]" ~~ m/^ <-[\c[YI SYLLABLE NDO, ARABIC SHADDA MEDIAL FORM]]>/ ), 'Negative charclass YI SYLLABLE NDO, ARABIC SHADDA MEDIAL FORM');
ok(!( "\x[a15d]" ~~ m/^ \C[YI SYLLABLE NDO]/ ), 'Negative named YI SYLLABLE NDO nomatch');
#?pugs todo
ok("\x[fe7d]" ~~ m/^ \C[YI SYLLABLE NDO]/, 'Negative named YI SYLLABLE NDO match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[a15d]" ~~ m/^ <[\C[YI SYLLABLE NDO]]>/ ), 'Negative charclass named YI SYLLABLE NDO nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[fe7d]" ~~ m/^ <[\C[YI SYLLABLE NDO]]>/, 'Negative charclass named YI SYLLABLE NDO match');
ok(!( "\x[a15d]" ~~ m/^ \X[A15D]/ ), 'Negative hex \X[A15D] nomatch');
ok(!( "\x[a15d]" ~~ m/^ <[\X[A15D]]>/ ), 'Negative charclass hex \X[A15D] nomatch');
#?pugs todo
ok("\x[a15d]" ~~ m/^ \X[FE7D]/, 'Negative hex \X[FE7D] match');
#?pugs todo
ok("\x[a15d]" ~~ m/^ <[\X[FE7D]]>/, 'Negative charclass hex \X[FE7D] match');
#?pugs todo
ok("abc\x[2964]def" ~~ m/\c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]/, 'Unanchored named RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN');
#?pugs todo
ok("abc\c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]def" ~~ m/\x[2964]/, 'Unanchored \x[2964]');
#?pugs todo
ok("abc\c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]def" ~~ m/\o[24544]/, 'Unanchored \o[24544]');
#?pugs todo
ok("abc\x[2964]def" ~~ m/^ abc \c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN] def $/, 'Anchored RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN');
#?pugs todo
ok("abc\x[2964]\x[a15d]def" ~~ m/\c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN,YI SYLLABLE NDO]/, 'Multiple RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN,YI SYLLABLE NDO');
#?pugs todo
ok("\x[2964]\x[a15d]" ~~ m/<[\c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN,YI SYLLABLE NDO]]>/, 'Charclass multiple RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN,YI SYLLABLE NDO');
ok(!( "\x[2964]\x[a15d]" ~~ m/^ <-[\c[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN,YI SYLLABLE NDO]]>/ ), 'Negative charclass RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN,YI SYLLABLE NDO');
ok(!( "\x[2964]" ~~ m/^ \C[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]/ ), 'Negative named RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN nomatch');
#?pugs todo
ok("\x[a15d]" ~~ m/^ \C[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]/, 'Negative named RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[2964]" ~~ m/^ <[\C[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]]>/ ), 'Negative charclass named RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[a15d]" ~~ m/^ <[\C[RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]]>/, 'Negative charclass named RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN match');
ok(!( "\x[2964]" ~~ m/^ \X[2964]/ ), 'Negative hex \X[2964] nomatch');
ok(!( "\x[2964]" ~~ m/^ <[\X[2964]]>/ ), 'Negative charclass hex \X[2964] nomatch');
#?pugs todo
ok("\x[2964]" ~~ m/^ \X[A15D]/, 'Negative hex \X[A15D] match');
#?pugs todo
ok("\x[2964]" ~~ m/^ <[\X[A15D]]>/, 'Negative charclass hex \X[A15D] match');
#?pugs todo
ok("abc\x[ff6d]def" ~~ m/\c[HALFWIDTH KATAKANA LETTER SMALL YU]/, 'Unanchored named HALFWIDTH KATAKANA LETTER SMALL YU');
#?pugs todo
ok("abc\c[HALFWIDTH KATAKANA LETTER SMALL YU]def" ~~ m/\x[FF6D]/, 'Unanchored \x[FF6D]');
#?pugs todo
ok("abc\c[HALFWIDTH KATAKANA LETTER SMALL YU]def" ~~ m/\o[177555]/, 'Unanchored \o[177555]');
#?pugs todo
ok("abc\x[ff6d]def" ~~ m/^ abc \c[HALFWIDTH KATAKANA LETTER SMALL YU] def $/, 'Anchored HALFWIDTH KATAKANA LETTER SMALL YU');
#?pugs todo
ok("abc\x[ff6d]\x[2964]def" ~~ m/\c[HALFWIDTH KATAKANA LETTER SMALL YU, RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]/, 'Multiple HALFWIDTH KATAKANA LETTER SMALL YU, RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN');
#?pugs todo
ok("\x[ff6d]\x[2964]" ~~ m/<[\c[HALFWIDTH KATAKANA LETTER SMALL YU, RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]]>/, 'Charclass multiple HALFWIDTH KATAKANA LETTER SMALL YU, RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN');
ok(!( "\x[ff6d]\x[2964]" ~~ m/^ <-[\c[HALFWIDTH KATAKANA LETTER SMALL YU, RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN]]>/ ), 'Negative charclass HALFWIDTH KATAKANA LETTER SMALL YU, RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN');
ok(!( "\x[ff6d]" ~~ m/^ \C[HALFWIDTH KATAKANA LETTER SMALL YU]/ ), 'Negative named HALFWIDTH KATAKANA LETTER SMALL YU nomatch');
#?pugs todo
ok("\x[2964]" ~~ m/^ \C[HALFWIDTH KATAKANA LETTER SMALL YU]/, 'Negative named HALFWIDTH KATAKANA LETTER SMALL YU match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[ff6d]" ~~ m/^ <[\C[HALFWIDTH KATAKANA LETTER SMALL YU]]>/ ), 'Negative charclass named HALFWIDTH KATAKANA LETTER SMALL YU nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[2964]" ~~ m/^ <[\C[HALFWIDTH KATAKANA LETTER SMALL YU]]>/, 'Negative charclass named HALFWIDTH KATAKANA LETTER SMALL YU match');
ok(!( "\x[ff6d]" ~~ m/^ \X[FF6D]/ ), 'Negative hex \X[FF6D] nomatch');
ok(!( "\x[ff6d]" ~~ m/^ <[\X[FF6D]]>/ ), 'Negative charclass hex \X[FF6D] nomatch');
#?pugs todo
ok("\x[ff6d]" ~~ m/^ \X[2964]/, 'Negative hex \X[2964] match');
#?pugs todo
ok("\x[ff6d]" ~~ m/^ <[\X[2964]]>/, 'Negative charclass hex \X[2964] match');
#?pugs todo
ok("abc\x[36]def" ~~ m/\c[DIGIT SIX]/, 'Unanchored named DIGIT SIX');
#?pugs todo
ok("abc\c[DIGIT SIX]def" ~~ m/\x[36]/, 'Unanchored \x[36]');
#?pugs todo
ok("abc\c[DIGIT SIX]def" ~~ m/\o[66]/, 'Unanchored \o[66]');
#?pugs todo
ok("abc\x[36]def" ~~ m/^ abc \c[DIGIT SIX] def $/, 'Anchored DIGIT SIX');
#?pugs todo
ok("abc\x[36]\x[ff6d]def" ~~ m/\c[DIGIT SIX,HALFWIDTH KATAKANA LETTER SMALL YU]/, 'Multiple DIGIT SIX,HALFWIDTH KATAKANA LETTER SMALL YU');
#?pugs todo
ok("\x[36]\x[ff6d]" ~~ m/<[\c[DIGIT SIX,HALFWIDTH KATAKANA LETTER SMALL YU]]>/, 'Charclass multiple DIGIT SIX,HALFWIDTH KATAKANA LETTER SMALL YU');
ok(!( "\x[36]\x[ff6d]" ~~ m/^ <-[\c[DIGIT SIX,HALFWIDTH KATAKANA LETTER SMALL YU]]>/ ), 'Negative charclass DIGIT SIX,HALFWIDTH KATAKANA LETTER SMALL YU');
ok(!( "\x[36]" ~~ m/^ \C[DIGIT SIX]/ ), 'Negative named DIGIT SIX nomatch');
#?pugs todo
ok("\x[ff6d]" ~~ m/^ \C[DIGIT SIX]/, 'Negative named DIGIT SIX match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[36]" ~~ m/^ <[\C[DIGIT SIX]]>/ ), 'Negative charclass named DIGIT SIX nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[ff6d]" ~~ m/^ <[\C[DIGIT SIX]]>/, 'Negative charclass named DIGIT SIX match');
ok(!( "\x[36]" ~~ m/^ \X[36]/ ), 'Negative hex \X[36] nomatch');
ok(!( "\x[36]" ~~ m/^ <[\X[36]]>/ ), 'Negative charclass hex \X[36] nomatch');
#?pugs todo
ok("\x[36]" ~~ m/^ \X[FF6D]/, 'Negative hex \X[FF6D] match');
#?pugs todo
ok("\x[36]" ~~ m/^ <[\X[FF6D]]>/, 'Negative charclass hex \X[FF6D] match');
#?pugs todo
ok("abc\x[1323]def" ~~ m/\c[ETHIOPIC SYLLABLE THAA]/, 'Unanchored named ETHIOPIC SYLLABLE THAA');
#?pugs todo
ok("abc\c[ETHIOPIC SYLLABLE THAA]def" ~~ m/\x[1323]/, 'Unanchored \x[1323]');
#?pugs todo
ok("abc\c[ETHIOPIC SYLLABLE THAA]def" ~~ m/\o[11443]/, 'Unanchored \o[11443]');
#?pugs todo
ok("abc\x[1323]def" ~~ m/^ abc \c[ETHIOPIC SYLLABLE THAA] def $/, 'Anchored ETHIOPIC SYLLABLE THAA');
#?pugs todo
ok("abc\x[1323]\x[36]def" ~~ m/\c[ETHIOPIC SYLLABLE THAA, DIGIT SIX]/, 'Multiple ETHIOPIC SYLLABLE THAA, DIGIT SIX');
#?pugs todo
ok("\x[1323]\x[36]" ~~ m/<[\c[ETHIOPIC SYLLABLE THAA, DIGIT SIX]]>/, 'Charclass multiple ETHIOPIC SYLLABLE THAA, DIGIT SIX');
ok(!( "\x[1323]\x[36]" ~~ m/^ <-[\c[ETHIOPIC SYLLABLE THAA, DIGIT SIX]]>/ ), 'Negative charclass ETHIOPIC SYLLABLE THAA, DIGIT SIX');
ok(!( "\x[1323]" ~~ m/^ \C[ETHIOPIC SYLLABLE THAA]/ ), 'Negative named ETHIOPIC SYLLABLE THAA nomatch');
#?pugs todo
ok("\x[36]" ~~ m/^ \C[ETHIOPIC SYLLABLE THAA]/, 'Negative named ETHIOPIC SYLLABLE THAA match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[1323]" ~~ m/^ <[\C[ETHIOPIC SYLLABLE THAA]]>/ ), 'Negative charclass named ETHIOPIC SYLLABLE THAA nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[36]" ~~ m/^ <[\C[ETHIOPIC SYLLABLE THAA]]>/, 'Negative charclass named ETHIOPIC SYLLABLE THAA match');
ok(!( "\x[1323]" ~~ m/^ \X[1323]/ ), 'Negative hex \X[1323] nomatch');
ok(!( "\x[1323]" ~~ m/^ <[\X[1323]]>/ ), 'Negative charclass hex \X[1323] nomatch');
#?pugs todo
ok("\x[1323]" ~~ m/^ \X[36]/, 'Negative hex \X[36] match');
#?pugs todo
ok("\x[1323]" ~~ m/^ <[\X[36]]>/, 'Negative charclass hex \X[36] match');
#?pugs todo
ok("abc\x[1697]def" ~~ m/\c[OGHAM LETTER UILLEANN]/, 'Unanchored named OGHAM LETTER UILLEANN');
#?pugs todo
ok("abc\c[OGHAM LETTER UILLEANN]def" ~~ m/\x[1697]/, 'Unanchored \x[1697]');
#?pugs todo
ok("abc\c[OGHAM LETTER UILLEANN]def" ~~ m/\o[13227]/, 'Unanchored \o[13227]');
#?pugs todo
ok("abc\x[1697]def" ~~ m/^ abc \c[OGHAM LETTER UILLEANN] def $/, 'Anchored OGHAM LETTER UILLEANN');
#?pugs todo
ok("abc\x[1697]\x[1323]def" ~~ m/\c[OGHAM LETTER UILLEANN,ETHIOPIC SYLLABLE THAA]/, 'Multiple OGHAM LETTER UILLEANN,ETHIOPIC SYLLABLE THAA');
#?pugs todo
ok("\x[1697]\x[1323]" ~~ m/<[\c[OGHAM LETTER UILLEANN,ETHIOPIC SYLLABLE THAA]]>/, 'Charclass multiple OGHAM LETTER UILLEANN,ETHIOPIC SYLLABLE THAA');
ok(!( "\x[1697]\x[1323]" ~~ m/^ <-[\c[OGHAM LETTER UILLEANN,ETHIOPIC SYLLABLE THAA]]>/ ), 'Negative charclass OGHAM LETTER UILLEANN,ETHIOPIC SYLLABLE THAA');
ok(!( "\x[1697]" ~~ m/^ \C[OGHAM LETTER UILLEANN]/ ), 'Negative named OGHAM LETTER UILLEANN nomatch');
#?pugs todo
ok("\x[1323]" ~~ m/^ \C[OGHAM LETTER UILLEANN]/, 'Negative named OGHAM LETTER UILLEANN match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[1697]" ~~ m/^ <[\C[OGHAM LETTER UILLEANN]]>/ ), 'Negative charclass named OGHAM LETTER UILLEANN nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[1323]" ~~ m/^ <[\C[OGHAM LETTER UILLEANN]]>/, 'Negative charclass named OGHAM LETTER UILLEANN match');
ok(!( "\x[1697]" ~~ m/^ \X[1697]/ ), 'Negative hex \X[1697] nomatch');
ok(!( "\x[1697]" ~~ m/^ <[\X[1697]]>/ ), 'Negative charclass hex \X[1697] nomatch');
#?pugs todo
ok("\x[1697]" ~~ m/^ \X[1323]/, 'Negative hex \X[1323] match');
#?pugs todo
ok("\x[1697]" ~~ m/^ <[\X[1323]]>/, 'Negative charclass hex \X[1323] match');
#?pugs todo
ok("abc\x[fe8b]def" ~~ m/\c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]/, 'Unanchored named ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM');
#?pugs todo
ok("abc\c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]def" ~~ m/\x[fe8b]/, 'Unanchored \x[fe8b]');
#?pugs todo
ok("abc\c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]def" ~~ m/\o[177213]/, 'Unanchored \o[177213]');
#?pugs todo
ok("abc\x[fe8b]def" ~~ m/^ abc \c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM] def $/, 'Anchored ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM');
#?pugs todo
ok("abc\x[fe8b]\x[1697]def" ~~ m/\c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM,OGHAM LETTER UILLEANN]/, 'Multiple ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM,OGHAM LETTER UILLEANN');
#?pugs todo
ok("\x[fe8b]\x[1697]" ~~ m/<[\c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM,OGHAM LETTER UILLEANN]]>/, 'Charclass multiple ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM,OGHAM LETTER UILLEANN');
ok(!( "\x[fe8b]\x[1697]" ~~ m/^ <-[\c[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM,OGHAM LETTER UILLEANN]]>/ ), 'Negative charclass ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM,OGHAM LETTER UILLEANN');
ok(!( "\x[fe8b]" ~~ m/^ \C[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]/ ), 'Negative named ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM nomatch');
#?pugs todo
ok("\x[1697]" ~~ m/^ \C[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]/, 'Negative named ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[fe8b]" ~~ m/^ <[\C[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]]>/ ), 'Negative charclass named ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[1697]" ~~ m/^ <[\C[ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]]>/, 'Negative charclass named ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM match');
ok(!( "\x[fe8b]" ~~ m/^ \X[FE8B]/ ), 'Negative hex \X[FE8B] nomatch');
ok(!( "\x[fe8b]" ~~ m/^ <[\X[FE8B]]>/ ), 'Negative charclass hex \X[FE8B] nomatch');
#?pugs todo
ok("\x[fe8b]" ~~ m/^ \X[1697]/, 'Negative hex \X[1697] match');
#?pugs todo
ok("\x[fe8b]" ~~ m/^ <[\X[1697]]>/, 'Negative charclass hex \X[1697] match');
#?pugs todo
ok("abc\x[16de]def" ~~ m/\c[RUNIC LETTER DAGAZ DAEG D]/, 'Unanchored named RUNIC LETTER DAGAZ DAEG D');
#?pugs todo
ok("abc\c[RUNIC LETTER DAGAZ DAEG D]def" ~~ m/\x[16DE]/, 'Unanchored \x[16DE]');
#?pugs todo
ok("abc\c[RUNIC LETTER DAGAZ DAEG D]def" ~~ m/\o[13336]/, 'Unanchored \o[13336]');
#?pugs todo
ok("abc\x[16de]def" ~~ m/^ abc \c[RUNIC LETTER DAGAZ DAEG D] def $/, 'Anchored RUNIC LETTER DAGAZ DAEG D');
#?pugs todo
ok("abc\x[16de]\x[fe8b]def" ~~ m/\c[RUNIC LETTER DAGAZ DAEG D,ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]/, 'Multiple RUNIC LETTER DAGAZ DAEG D,ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM');
#?pugs todo
ok("\x[16de]\x[fe8b]" ~~ m/<[\c[RUNIC LETTER DAGAZ DAEG D,ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]]>/, 'Charclass multiple RUNIC LETTER DAGAZ DAEG D,ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM');
ok(!( "\x[16de]\x[fe8b]" ~~ m/^ <-[\c[RUNIC LETTER DAGAZ DAEG D,ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM]]>/ ), 'Negative charclass RUNIC LETTER DAGAZ DAEG D,ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM');
ok(!( "\x[16de]" ~~ m/^ \C[RUNIC LETTER DAGAZ DAEG D]/ ), 'Negative named RUNIC LETTER DAGAZ DAEG D nomatch');
#?pugs todo
ok("\x[fe8b]" ~~ m/^ \C[RUNIC LETTER DAGAZ DAEG D]/, 'Negative named RUNIC LETTER DAGAZ DAEG D match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[16de]" ~~ m/^ <[\C[RUNIC LETTER DAGAZ DAEG D]]>/ ), 'Negative charclass named RUNIC LETTER DAGAZ DAEG D nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[fe8b]" ~~ m/^ <[\C[RUNIC LETTER DAGAZ DAEG D]]>/, 'Negative charclass named RUNIC LETTER DAGAZ DAEG D match');
ok(!( "\x[16de]" ~~ m/^ \X[16DE]/ ), 'Negative hex \X[16DE] nomatch');
ok(!( "\x[16de]" ~~ m/^ <[\X[16DE]]>/ ), 'Negative charclass hex \X[16DE] nomatch');
#?pugs todo
ok("\x[16de]" ~~ m/^ \X[FE8B]/, 'Negative hex \X[FE8B] match');
#?pugs todo
ok("\x[16de]" ~~ m/^ <[\X[FE8B]]>/, 'Negative charclass hex \X[FE8B] match');
#?pugs todo
ok("abc\x[64]def" ~~ m/\c[LATIN SMALL LETTER D]/, 'Unanchored named LATIN SMALL LETTER D');
#?pugs todo
ok("abc\c[LATIN SMALL LETTER D]def" ~~ m/\x[64]/, 'Unanchored \x[64]');
#?pugs todo
ok("abc\c[LATIN SMALL LETTER D]def" ~~ m/\o[144]/, 'Unanchored \o[144]');
#?pugs todo
ok("abc\x[64]def" ~~ m/^ abc \c[LATIN SMALL LETTER D] def $/, 'Anchored LATIN SMALL LETTER D');
#?pugs todo
ok("abc\x[64]\x[16de]def" ~~ m/\c[LATIN SMALL LETTER D,RUNIC LETTER DAGAZ DAEG D]/, 'Multiple LATIN SMALL LETTER D,RUNIC LETTER DAGAZ DAEG D');
#?pugs todo
ok("\x[64]\x[16de]" ~~ m/<[\c[LATIN SMALL LETTER D,RUNIC LETTER DAGAZ DAEG D]]>/, 'Charclass multiple LATIN SMALL LETTER D,RUNIC LETTER DAGAZ DAEG D');
ok(!( "\x[64]\x[16de]" ~~ m/^ <-[\c[LATIN SMALL LETTER D,RUNIC LETTER DAGAZ DAEG D]]>/ ), 'Negative charclass LATIN SMALL LETTER D,RUNIC LETTER DAGAZ DAEG D');
ok(!( "\x[64]" ~~ m/^ \C[LATIN SMALL LETTER D]/ ), 'Negative named LATIN SMALL LETTER D nomatch');
#?pugs todo
ok("\x[16de]" ~~ m/^ \C[LATIN SMALL LETTER D]/, 'Negative named LATIN SMALL LETTER D match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[64]" ~~ m/^ <[\C[LATIN SMALL LETTER D]]>/ ), 'Negative charclass named LATIN SMALL LETTER D nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[16de]" ~~ m/^ <[\C[LATIN SMALL LETTER D]]>/, 'Negative charclass named LATIN SMALL LETTER D match');
ok(!( "\x[64]" ~~ m/^ \X[64]/ ), 'Negative hex \X[64] nomatch');
ok(!( "\x[64]" ~~ m/^ <[\X[64]]>/ ), 'Negative charclass hex \X[64] nomatch');
#?pugs todo
ok("\x[64]" ~~ m/^ \X[16DE]/, 'Negative hex \X[16DE] match');
#?pugs todo
ok("\x[64]" ~~ m/^ <[\X[16DE]]>/, 'Negative charclass hex \X[16DE] match');
#?pugs todo
ok("abc\x[2724]def" ~~ m/\c[HEAVY FOUR BALLOON-SPOKED ASTERISK]/, 'Unanchored named HEAVY FOUR BALLOON-SPOKED ASTERISK');
#?pugs todo
ok("abc\c[HEAVY FOUR BALLOON-SPOKED ASTERISK]def" ~~ m/\x[2724]/, 'Unanchored \x[2724]');
#?pugs todo
ok("abc\c[HEAVY FOUR BALLOON-SPOKED ASTERISK]def" ~~ m/\o[23444]/, 'Unanchored \o[23444]');
#?pugs todo
ok("abc\x[2724]def" ~~ m/^ abc \c[HEAVY FOUR BALLOON-SPOKED ASTERISK] def $/, 'Anchored HEAVY FOUR BALLOON-SPOKED ASTERISK');
#?pugs todo
ok("abc\x[2724]\x[64]def" ~~ m/\c[HEAVY FOUR BALLOON-SPOKED ASTERISK,LATIN SMALL LETTER D]/, 'Multiple HEAVY FOUR BALLOON-SPOKED ASTERISK,LATIN SMALL LETTER D');
#?pugs todo
ok("\x[2724]\x[64]" ~~ m/<[\c[HEAVY FOUR BALLOON-SPOKED ASTERISK,LATIN SMALL LETTER D]]>/, 'Charclass multiple HEAVY FOUR BALLOON-SPOKED ASTERISK,LATIN SMALL LETTER D');
ok(!( "\x[2724]\x[64]" ~~ m/^ <-[\c[HEAVY FOUR BALLOON-SPOKED ASTERISK,LATIN SMALL LETTER D]]>/ ), 'Negative charclass HEAVY FOUR BALLOON-SPOKED ASTERISK,LATIN SMALL LETTER D');
ok(!( "\x[2724]" ~~ m/^ \C[HEAVY FOUR BALLOON-SPOKED ASTERISK]/ ), 'Negative named HEAVY FOUR BALLOON-SPOKED ASTERISK nomatch');
#?pugs todo
ok("\x[64]" ~~ m/^ \C[HEAVY FOUR BALLOON-SPOKED ASTERISK]/, 'Negative named HEAVY FOUR BALLOON-SPOKED ASTERISK match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[2724]" ~~ m/^ <[\C[HEAVY FOUR BALLOON-SPOKED ASTERISK]]>/ ), 'Negative charclass named HEAVY FOUR BALLOON-SPOKED ASTERISK nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[64]" ~~ m/^ <[\C[HEAVY FOUR BALLOON-SPOKED ASTERISK]]>/, 'Negative charclass named HEAVY FOUR BALLOON-SPOKED ASTERISK match');
ok(!( "\x[2724]" ~~ m/^ \X[2724]/ ), 'Negative hex \X[2724] nomatch');
ok(!( "\x[2724]" ~~ m/^ <[\X[2724]]>/ ), 'Negative charclass hex \X[2724] nomatch');
#?pugs todo
ok("\x[2724]" ~~ m/^ \X[64]/, 'Negative hex \X[64] match');
#?pugs todo
ok("\x[2724]" ~~ m/^ <[\X[64]]>/, 'Negative charclass hex \X[64] match');
#?pugs todo
ok("abc\x[2719]def" ~~ m/\c[OUTLINED GREEK CROSS]/, 'Unanchored named OUTLINED GREEK CROSS');
#?pugs todo
ok("abc\c[OUTLINED GREEK CROSS]def" ~~ m/\x[2719]/, 'Unanchored \x[2719]');
#?pugs todo
ok("abc\c[OUTLINED GREEK CROSS]def" ~~ m/\o[23431]/, 'Unanchored \o[23431]');
#?pugs todo
ok("abc\x[2719]def" ~~ m/^ abc \c[OUTLINED GREEK CROSS] def $/, 'Anchored OUTLINED GREEK CROSS');
#?pugs todo
ok("abc\x[2719]\x[2724]def" ~~ m/\c[OUTLINED GREEK CROSS,HEAVY FOUR BALLOON-SPOKED ASTERISK]/, 'Multiple OUTLINED GREEK CROSS,HEAVY FOUR BALLOON-SPOKED ASTERISK');
#?pugs todo
ok("\x[2719]\x[2724]" ~~ m/<[\c[OUTLINED GREEK CROSS,HEAVY FOUR BALLOON-SPOKED ASTERISK]]>/, 'Charclass multiple OUTLINED GREEK CROSS,HEAVY FOUR BALLOON-SPOKED ASTERISK');
ok(!( "\x[2719]\x[2724]" ~~ m/^ <-[\c[OUTLINED GREEK CROSS,HEAVY FOUR BALLOON-SPOKED ASTERISK]]>/ ), 'Negative charclass OUTLINED GREEK CROSS,HEAVY FOUR BALLOON-SPOKED ASTERISK');
ok(!( "\x[2719]" ~~ m/^ \C[OUTLINED GREEK CROSS]/ ), 'Negative named OUTLINED GREEK CROSS nomatch');
#?pugs todo
ok("\x[2724]" ~~ m/^ \C[OUTLINED GREEK CROSS]/, 'Negative named OUTLINED GREEK CROSS match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[2719]" ~~ m/^ <[\C[OUTLINED GREEK CROSS]]>/ ), 'Negative charclass named OUTLINED GREEK CROSS nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[2724]" ~~ m/^ <[\C[OUTLINED GREEK CROSS]]>/, 'Negative charclass named OUTLINED GREEK CROSS match');
ok(!( "\x[2719]" ~~ m/^ \X[2719]/ ), 'Negative hex \X[2719] nomatch');
ok(!( "\x[2719]" ~~ m/^ <[\X[2719]]>/ ), 'Negative charclass hex \X[2719] nomatch');
#?pugs todo
ok("\x[2719]" ~~ m/^ \X[2724]/, 'Negative hex \X[2724] match');
#?pugs todo
ok("\x[2719]" ~~ m/^ <[\X[2724]]>/, 'Negative charclass hex \X[2724] match');
#?pugs todo
ok("abc\x[e97]def" ~~ m/\c[LAO LETTER THO TAM]/, 'Unanchored named LAO LETTER THO TAM');
#?pugs todo
ok("abc\c[LAO LETTER THO TAM]def" ~~ m/\x[e97]/, 'Unanchored \x[e97]');
#?pugs todo
ok("abc\c[LAO LETTER THO TAM]def" ~~ m/\o[7227]/, 'Unanchored \o[7227]');
#?pugs todo
ok("abc\x[e97]def" ~~ m/^ abc \c[LAO LETTER THO TAM] def $/, 'Anchored LAO LETTER THO TAM');
#?pugs todo
ok("abc\x[e97]\x[2719]def" ~~ m/\c[LAO LETTER THO TAM, OUTLINED GREEK CROSS]/, 'Multiple LAO LETTER THO TAM, OUTLINED GREEK CROSS');
#?pugs todo
ok("\x[e97]\x[2719]" ~~ m/<[\c[LAO LETTER THO TAM, OUTLINED GREEK CROSS]]>/, 'Charclass multiple LAO LETTER THO TAM, OUTLINED GREEK CROSS');
ok(!( "\x[e97]\x[2719]" ~~ m/^ <-[\c[LAO LETTER THO TAM, OUTLINED GREEK CROSS]]>/ ), 'Negative charclass LAO LETTER THO TAM, OUTLINED GREEK CROSS');
ok(!( "\x[e97]" ~~ m/^ \C[LAO LETTER THO TAM]/ ), 'Negative named LAO LETTER THO TAM nomatch');
#?pugs todo
ok("\x[2719]" ~~ m/^ \C[LAO LETTER THO TAM]/, 'Negative named LAO LETTER THO TAM match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[e97]" ~~ m/^ <[\C[LAO LETTER THO TAM]]>/ ), 'Negative charclass named LAO LETTER THO TAM nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[2719]" ~~ m/^ <[\C[LAO LETTER THO TAM]]>/, 'Negative charclass named LAO LETTER THO TAM match');
ok(!( "\x[e97]" ~~ m/^ \X[E97]/ ), 'Negative hex \X[E97] nomatch');
ok(!( "\x[e97]" ~~ m/^ <[\X[E97]]>/ ), 'Negative charclass hex \X[E97] nomatch');
#?pugs todo
ok("\x[e97]" ~~ m/^ \X[2719]/, 'Negative hex \X[2719] match');
#?pugs todo
ok("\x[e97]" ~~ m/^ <[\X[2719]]>/, 'Negative charclass hex \X[2719] match');
#?pugs todo
ok("abc\x[a42d]def" ~~ m/\c[YI SYLLABLE JJYT]/, 'Unanchored named YI SYLLABLE JJYT');
#?pugs todo
ok("abc\c[YI SYLLABLE JJYT]def" ~~ m/\x[a42d]/, 'Unanchored \x[a42d]');
#?pugs todo
ok("abc\c[YI SYLLABLE JJYT]def" ~~ m/\o[122055]/, 'Unanchored \o[122055]');
#?pugs todo
ok("abc\x[a42d]def" ~~ m/^ abc \c[YI SYLLABLE JJYT] def $/, 'Anchored YI SYLLABLE JJYT');
#?pugs todo
ok("abc\x[a42d]\x[e97]def" ~~ m/\c[YI SYLLABLE JJYT,LAO LETTER THO TAM]/, 'Multiple YI SYLLABLE JJYT,LAO LETTER THO TAM');
#?pugs todo
ok("\x[a42d]\x[e97]" ~~ m/<[\c[YI SYLLABLE JJYT,LAO LETTER THO TAM]]>/, 'Charclass multiple YI SYLLABLE JJYT,LAO LETTER THO TAM');
ok(!( "\x[a42d]\x[e97]" ~~ m/^ <-[\c[YI SYLLABLE JJYT,LAO LETTER THO TAM]]>/ ), 'Negative charclass YI SYLLABLE JJYT,LAO LETTER THO TAM');
ok(!( "\x[a42d]" ~~ m/^ \C[YI SYLLABLE JJYT]/ ), 'Negative named YI SYLLABLE JJYT nomatch');
#?pugs todo
ok("\x[e97]" ~~ m/^ \C[YI SYLLABLE JJYT]/, 'Negative named YI SYLLABLE JJYT match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[a42d]" ~~ m/^ <[\C[YI SYLLABLE JJYT]]>/ ), 'Negative charclass named YI SYLLABLE JJYT nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[e97]" ~~ m/^ <[\C[YI SYLLABLE JJYT]]>/, 'Negative charclass named YI SYLLABLE JJYT match');
ok(!( "\x[a42d]" ~~ m/^ \X[A42D]/ ), 'Negative hex \X[A42D] nomatch');
ok(!( "\x[a42d]" ~~ m/^ <[\X[A42D]]>/ ), 'Negative charclass hex \X[A42D] nomatch');
#?pugs todo
ok("\x[a42d]" ~~ m/^ \X[E97]/, 'Negative hex \X[E97] match');
#?pugs todo
ok("\x[a42d]" ~~ m/^ <[\X[E97]]>/, 'Negative charclass hex \X[E97] match');
#?pugs todo
ok("abc\x[ff6e]def" ~~ m/\c[HALFWIDTH KATAKANA LETTER SMALL YO]/, 'Unanchored named HALFWIDTH KATAKANA LETTER SMALL YO');
#?pugs todo
ok("abc\c[HALFWIDTH KATAKANA LETTER SMALL YO]def" ~~ m/\x[FF6E]/, 'Unanchored \x[FF6E]');
#?pugs todo
ok("abc\c[HALFWIDTH KATAKANA LETTER SMALL YO]def" ~~ m/\o[177556]/, 'Unanchored \o[177556]');
#?pugs todo
ok("abc\x[ff6e]def" ~~ m/^ abc \c[HALFWIDTH KATAKANA LETTER SMALL YO] def $/, 'Anchored HALFWIDTH KATAKANA LETTER SMALL YO');
#?pugs todo
ok("abc\x[ff6e]\x[a42d]def" ~~ m/\c[HALFWIDTH KATAKANA LETTER SMALL YO,YI SYLLABLE JJYT]/, 'Multiple HALFWIDTH KATAKANA LETTER SMALL YO,YI SYLLABLE JJYT');
#?pugs todo
ok("\x[ff6e]\x[a42d]" ~~ m/<[\c[HALFWIDTH KATAKANA LETTER SMALL YO,YI SYLLABLE JJYT]]>/, 'Charclass multiple HALFWIDTH KATAKANA LETTER SMALL YO,YI SYLLABLE JJYT');
ok(!( "\x[ff6e]\x[a42d]" ~~ m/^ <-[\c[HALFWIDTH KATAKANA LETTER SMALL YO,YI SYLLABLE JJYT]]>/ ), 'Negative charclass HALFWIDTH KATAKANA LETTER SMALL YO,YI SYLLABLE JJYT');
ok(!( "\x[ff6e]" ~~ m/^ \C[HALFWIDTH KATAKANA LETTER SMALL YO]/ ), 'Negative named HALFWIDTH KATAKANA LETTER SMALL YO nomatch');
#?pugs todo
ok("\x[a42d]" ~~ m/^ \C[HALFWIDTH KATAKANA LETTER SMALL YO]/, 'Negative named HALFWIDTH KATAKANA LETTER SMALL YO match');
#?rakudo skip 'negative char class in enumerated list RT #122245'
ok(!( "\x[ff6e]" ~~ m/^ <[\C[HALFWIDTH KATAKANA LETTER SMALL YO]]>/ ), 'Negative charclass named HALFWIDTH KATAKANA LETTER SMALL YO nomatch');
#?rakudo skip 'negative char class in enumerated list RT #122245'
#?pugs todo
ok("\x[a42d]" ~~ m/^ <[\C[HALFWIDTH KATAKANA LETTER SMALL YO]]>/, 'Negative charclass named HALFWIDTH KATAKANA LETTER SMALL YO match');
ok(!( "\x[ff6e]" ~~ m/^ \X[FF6E]/ ), 'Negative hex \X[FF6E] nomatch');
ok(!( "\x[ff6e]" ~~ m/^ <[\X[FF6E]]>/ ), 'Negative charclass hex \X[FF6E] nomatch');
#?pugs todo
ok("\x[ff6e]" ~~ m/^ \X[A42D]/, 'Negative hex \X[A42D] match');
#?pugs todo
ok("\x[ff6e]" ~~ m/^ <[\X[A42D]]>/, 'Negative charclass hex \X[A42D] match');
 

# names special cases (see http://www.unicode.org/reports/tr18/#Name_Properties) "... that require special-casing ..."

#?pugs todo
ok("\x[0F68]" ~~ m/\c[TIBETAN LETTER A]/, 'match named TIBETAN LETTER A');
#?pugs todo
ok("\x[0F60]" ~~ m/\c[TIBETAN LETTER -A]/, 'match named TIBETAN LETTER -A');
ok(!("\c[TIBETAN LETTER A]" ~~ m/\c[TIBETAN LETTER -A]/), 'nomatch named TIBETAN LETTER A versus -A');
ok(!("\c[TIBETAN LETTER -A]" ~~ m/\c[TIBETAN LETTER A]/), 'nomatch named TIBETAN LETTER -A versus A');

#?pugs todo
ok("\x[0FB8]" ~~ m/\c[TIBETAN SUBJOINED LETTER A]/, 'match named TIBETAN SUBJOINED LETTER A');
#?pugs todo
ok("\x[0FB0]" ~~ m/\c[TIBETAN SUBJOINED LETTER -A]/, 'match named TIBETAN SUBJOINED LETTER -A');
ok(!("\c[TIBETAN SUBJOINED LETTER A]" ~~ m/\c[TIBETAN SUBJOINED LETTER -A]/), 'nomatch named TIBETAN SUBJOINED LETTER A versus -A');
ok(!("\c[TIBETAN SUBJOINED LETTER -A]" ~~ m/\c[TIBETAN SUBJOINED LETTER A]/), 'nomatch named TIBETAN SUBJOINED LETTER -A versus A');

#?pugs todo
ok("\x[116C]" ~~ m/\c[HANGUL JUNGSEONG OE]/, 'match named HANGUL JUNGSEONG OE');
#?pugs todo
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
