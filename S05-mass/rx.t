use v6;
use Test;

plan 756;

### for now
sub matchcheck(*@) { 1 }

# L<S05/Backtracking control/"To force the preceding atom to do no
# backtracking">

##   Backtracking control tests
#### a* a			bazaar		y	control
ok 'bazaar' ~~ /a* a/, 'control';

#### a*: a			bazaar		n	basic
ok !('bazaar' ~~ /a*: a/), 'basic';

#### ^[a|b]*  aba		abbabbababba	y	control
ok 'abbabbababba' ~~ /^[a|b]*  aba/, 'control';

#### ^[a|b]*: aba		abbabbababba	n	outside a group
ok !('abbabbababba' ~~ /^[a|b]*: aba/), 'outside a group';

#### \d+:			123abc		y	cut on character class shortcut
ok '123abc' ~~ /\d+:/, 'cut on character class shortcut';

#### \d+:			abc		n	cut on character class shortcut
ok 'abc' !~~ /\d+:/, 'cut on character class shortcut';

#### [ if    not | ify ]	verify		y	control
ok 'verify' ~~ /[ if    not | ify ]/, 'control';

# L<S05/Backtracking control/"Evaluating a double colon">

#### [ if :: not | ify ]	verify		n	inside a group
#?rakudo skip ':: NYI RT #124889'
ok 'verify' !~~ /[ if :: not | ify ]/, 'inside a group';

####   if :: not | ify	verify		n	the default all group
#?rakudo skip ':: NYI RT #124890'
ok 'verify' !~~ /  if :: not | ify/, 'the default all group';

#### [ if :  not | ify ]	verify		y	simple backtrack still works
ok 'verify' ~~ /[ if :  not | ify ]/, 'simple backtrack still works';

#### [ if :: not | ify ] | verify	verify	y	rule continues
#?rakudo skip ':: NYI RT #124891'
ok 'verify' ~~ /[ if :: not | ify ] | verify/, 'rule continues';

# L<S05/Backtracking control/"Evaluating a triple colon">
#### [ when     ever ] | whence	whence	y	full backtrack failure
ok 'whence' ~~ /[ when     ever ] | whence/, 'full backtrack failure';

#### [ when ::: ever ] | whence	whence	n	full backtrack failure
#?rakudo skip '::: NYI RT #124892'
ok 'whence' !~~ /[ when ::: ever ] | whence/, 'full backtrack failure';

#### ab::cd | gh::ij		xyabghij	y	group cut at top
#?rakudo skip ':: NYI RT #124893'
ok 'xyabghij' ~~ /ab::cd | gh::ij/, 'group cut at top';

#### ab:::cd | gh:::ij	xyabghij	n	rule cut at top
#?rakudo skip ':: NYI RT #124894'
ok 'xyabghij' !~~ /ab:::cd | gh:::ij/, 'rule cut at top';

#### [ab::cd | gh::ij]	xyabghij	y	group cut in group
#?rakudo skip ':: NYI RT #124895'
ok 'xyabghij' ~~ /[ab::cd | gh::ij]/, 'group cut in group';

#### [ab:::cd | gh:::ij]	xyabghij	n	rule cut in group
#?rakudo skip '::: NYI RT #124896'
ok 'xyabghij' !~~ /[ab:::cd | gh:::ij]/, 'rule cut in group';

#### [ ab | abc ]: de	xyzabcde	n	no backtrack into group
#?rakudo todo 'RT #121307'
ok 'xyzabcde' !~~ /[ ab | abc ]: de/, 'no backtrack into group';

#### ( ab | abc ): de	xyzabcde	n	no backtrack into subpattern
ok 'xyzabcde' !~~ /( ab || abc ): de/, 'no backtrack into subpattern';

#### [ when <commit> ever ] | whence	whence	n	full backtrack failure
#?rakudo todo '<commit> NYI RT #124897'
ok 'whence' !~~ /[ when <commit> ever ] | whence/, 'full backtrack failure';

#L<S05/Modifiers/"The new :r or :ratchet modifier">

#### :ratchet a* a		bazaar		n	ratchet modifier
ok 'bazaar' !~~ /:ratchet a* a/, 'ratchet modifier';

#### :ratchet a*! a		bazaar		y	force backtracking !
ok 'bazaar' ~~ /:ratchet a*! a/, 'force backtracking !';

#L<S05/Unchanged syntactic features/"Capturing: (...)">

##   captures
#### (a.)..(..)		zzzabcdefzzz	y			basic match
ok 'zzzabcdefzzz' ~~ /(a.)..(..)/, 'basic match';

#### (a.)..(..)		zzzabcdefzzz	/mob: <abcdef @ 3>/	basic $/
ok ('zzzabcdefzzz' ~~ /(a.)..(..)/) && matchcheck($/, q/mob: <abcdef @ 3>/), 'basic $/';

#### (a.)..(..)		zzzabcdefzzz	/mob 0: <ab @ 3>/	basic $0
ok ('zzzabcdefzzz' ~~ /(a.)..(..)/) && matchcheck($/, q/mob 0: <ab @ 3>/), 'basic $0';

#### (a.)..(..)		zzzabcdefzzz	/mob 1: <ef @ 7>/	basic $1
ok ('zzzabcdefzzz' ~~ /(a.)..(..)/) && matchcheck($/, q/mob 1: <ef @ 7>/), 'basic $1';

#### (a(b(c))(d))		abcd		y			nested match
ok 'abcd' ~~ /(a(b(c))(d))/, 'nested match';

#### (a(b(c))(d))		abcd		/mob: <abcd @ 0>/	nested match
ok ('abcd' ~~ /(a(b(c))(d))/) && matchcheck($/, q/mob: <abcd @ 0>/), 'nested match';

#### (a(b(c))(d))		abcd		/mob 0: <abcd @ 0>/	nested match
ok ('abcd' ~~ /(a(b(c))(d))/) && matchcheck($/, q/mob 0: <abcd @ 0>/), 'nested match';

#### (a(b(c))(d))		abcd		/mob 0 0: <bc @ 1>/	nested match
ok ('abcd' ~~ /(a(b(c))(d))/) && matchcheck($/, q/mob 0 0: <bc @ 1>/), 'nested match';

#### (a(b(c))(d))		abcd		/mob 0 0 0: <c @ 2>/	nested match
ok ('abcd' ~~ /(a(b(c))(d))/) && matchcheck($/, q/mob 0 0 0: <c @ 2>/), 'nested match';

#### (a(b(c))(d))		abcd		/mob 0 1: <d @ 3>/	nested match
ok ('abcd' ~~ /(a(b(c))(d))/) && matchcheck($/, q/mob 0 1: <d @ 3>/), 'nested match';

#### ((\w+)+)		abcd		/mob: <abcd @ 0>/	nested match
ok ('abcd' ~~ /((\w+)+)/) && matchcheck($/, q/mob: <abcd @ 0>/), 'nested match';

#### ((\w+)+)		abcd		/mob 0: <abcd @ 0>/	nested match
ok ('abcd' ~~ /((\w+)+)/) && matchcheck($/, q/mob 0: <abcd @ 0>/), 'nested match';

#### ((\w+)+)		abcd		/mob 0 0 0: <abcd @ 0>/	nested match
ok ('abcd' ~~ /((\w+)+)/) && matchcheck($/, q/mob 0 0 0: <abcd @ 0>/), 'nested match';

#### ((\w+)+)	ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz	/mob: <ABCD/	nested match
ok ('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' ~~ /((\w+)+)/) && matchcheck($/, q/mob: <ABCD/), 'nested match';

#### ((\w+)+)	ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz	/mob 0: <ABCD/	nested match
ok ('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' ~~ /((\w+)+)/) && matchcheck($/, q/mob 0: <ABCD/), 'nested match';

#### ((\w+)+)	ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz	/mob 0 0 0: <ABCD/	nested match
ok ('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' ~~ /((\w+)+)/) && matchcheck($/, q/mob 0 0 0: <ABCD/), 'nested match';

#### (a) [ (bc) (d) | .* (ef) ] .* (g)	abcdefg	/mob 0: <a @ 0>/	alt subpattern before group
ok ('abcdefg' ~~ /(a) [ (bc) (d) | .* (ef) ] .* (g)/) && matchcheck($/, q/mob 0: <a @ 0>/), 'alt subpattern before group';

#### (a) [ (bc) (d) | .* (ef) ] .* (g)	abcdefg	/mob 1: <bc @ 1>/	alt subpattern in group
ok ('abcdefg' ~~ /(a) [ (bc) (d) | .* (ef) ] .* (g)/) && matchcheck($/, q/mob 1: <bc @ 1>/), 'alt subpattern in group';

#### (a) [ (bc) (d) | .* (ef) ] .* (g)	abcdefg	/mob 2: <d @ 3>/	alt subpattern in group
ok ('abcdefg' ~~ /(a) [ (bc) (d) | .* (ef) ] .* (g)/) && matchcheck($/, q/mob 2: <d @ 3>/), 'alt subpattern in group';

#### (a) [ (bc) (d) | .* (ef) ] .* (g)	abcdefg	/mob 3: <g @ 6>/	alt subpattern after group
ok ('abcdefg' ~~ /(a) [ (bc) (d) | .* (ef) ] .* (g)/) && matchcheck($/, q/mob 3: <g @ 6>/), 'alt subpattern after group';

#### (a) [ (bc) (x) | .* (ef) ] .* (g)	abcdefg	/mob 1: <ef @ 4>/	2nd alt subpattern in group
ok ('abcdefg' ~~ /(a) [ (bc) (x) | .* (ef) ] .* (g)/) && matchcheck($/, q/mob 1: <ef @ 4>/), '2nd alt subpattern in group';

#### (a) [ (bc) (x) | .* (ef) ] .* (g)	abcdefg	/mob 3: <g @ 6>/	2nd alt subpattern after group
ok ('abcdefg' ~~ /(a) [ (bc) (x) | .* (ef) ] .* (g)/) && matchcheck($/, q/mob 3: <g @ 6>/), '2nd alt subpattern after group';

#### ( (.) )*				abc	/mob 0 1 0: <b @ 1>/	nested repeated captures
ok ('abc' ~~ /( (.) )*/) && matchcheck($/, q/mob 0 1 0: <b @ 1>/), 'nested repeated captures';

#### [ (.) ]*				abc	/mob 0 1: <b @ 1>/	nested repeated captures
ok ('abc' ~~ /[ (.) ]*/) && matchcheck($/, q/mob 0 1: <b @ 1>/), 'nested repeated captures';

#### ( [.] )*				abc	/mob 0 1: <b @ 1>/	nested repeated captures
ok ('abc' ~~ /( [ . ] )*/) && matchcheck($/, q/mob 0 1: <b @ 1>/), 'nested repeated captures';

#### (.) (.) $7=(.) (.) $4=(.)		abcdefg	/mob 0: <a @ 0>/	numbered aliases $0
ok ('abcdefg' ~~ /(.) (.) $7=(.) (.) $4=(.)/) && matchcheck($/, q/mob 0: <a @ 0>/), 'numbered aliases $0';

#### (.) (.) $7=(.) (.) $4=(.)		abcdefg	/mob 1: <b @ 1>/	numbered aliases $1
ok ('abcdefg' ~~ /(.) (.) $7=(.) (.) $4=(.)/) && matchcheck($/, q/mob 1: <b @ 1>/), 'numbered aliases $1';

#### (.) (.) $7=(.) (.) $4=(.)		abcdefg	/mob 7: <c @ 2>/	numbered aliases $7
ok ('abcdefg' ~~ /(.) (.) $7=(.) (.) $4=(.)/) && matchcheck($/, q/mob 7: <c @ 2>/), 'numbered aliases $7';

#### (.) (.) $7=(.) (.) $4=(.)		abcdefg	/mob 8: <d @ 3>/	numbered aliases $8
ok ('abcdefg' ~~ /(.) (.) $7=(.) (.) $4=(.)/) && matchcheck($/, q/mob 8: <d @ 3>/), 'numbered aliases $8';

#### (.) (.) $7=(.) (.) $4=(.)		abcdefg	/mob 4: <e @ 4>/	numbered aliases $4
ok ('abcdefg' ~~ /(.) (.) $7=(.) (.) $4=(.)/) && matchcheck($/, q/mob 4: <e @ 4>/), 'numbered aliases $4';

#### $1=[ (.) (.) (.) ] (.)			abcdefg	/mob 1: <abc @ 0>/	Perl numbered captures $1
ok ('abcdefg' ~~ /$1=[ (.) (.) (.) ] (.)/) && matchcheck($/, q/mob 1: <abc @ 0>/), 'Perl numbered captures $1';

#### $1=[ (.) (.) (.) ] (.)			abcdefg	/mob 2: <a @ 0>/	Perl numbered captures $1
ok ('abcdefg' ~~ /$1=[ (.) (.) (.) ] (.)/) && matchcheck($/, q/mob 2: <a @ 0>/), 'Perl numbered captures $1';

#### $1=[ (.) (.) (.) ] (.)			abcdefg	/mob 3: <b @ 1>/	Perl numbered captures $1
ok ('abcdefg' ~~ /$1=[ (.) (.) (.) ] (.)/) && matchcheck($/, q/mob 3: <b @ 1>/), 'Perl numbered captures $1';

#### $1=[ (.) (.) (.) ] (.)			abcdefg	/mob 4: <c @ 2>/	Perl numbered captures $1
ok ('abcdefg' ~~ /$1=[ (.) (.) (.) ] (.)/) && matchcheck($/, q/mob 4: <c @ 2>/), 'Perl numbered captures $1';

#### $1=[ (.) (.) (.) ] (.)			abcdefg	/mob 5: <d @ 3>/	Perl numbered captures $1
ok ('abcdefg' ~~ /$1=[ (.) (.) (.) ] (.)/) && matchcheck($/, q/mob 5: <d @ 3>/), 'Perl numbered captures $1';

#### :s $<key>=[\w+] \= $<val>=[\S+]	 abc = 123	/mob<key>: <abc @ 1>/	named capture
ok (' abc = 123' ~~ /:s $<key>=[\w+] \= $<val>=[\S+]/) && matchcheck($/, q/mob<key>: <abc @ 1>/), 'named capture';

#### :s $<key>=[\w+] \= $<val>=[\S+]	 abc = 123	/mob<val>: <123 @ 7>/	named capture
ok (' abc = 123' ~~ /:s $<key>=[\w+] \= $<val>=[\S+]/) && matchcheck($/, q/mob<val>: <123 @ 7>/), 'named capture';

#### :s (\w+) $<foo>=(\w+) (\w+)		abc def ghi	/mob<foo>: <def @ 4>/	mixing named and unnamed capture
ok ('abc def ghi' ~~ /:s (\w+) $<foo>=(\w+) (\w+)/) && matchcheck($/, q/mob<foo>: <def @ 4>/), 'mixing named and unnamed capture';

#### :s (\w+) $<foo>=(\w+) (\w+)		abc def ghi	/mob 1: <ghi @ 8>/	mixing named and unnamed capture
ok ('abc def ghi' ~~ /:s (\w+) $<foo>=(\w+) (\w+)/) && matchcheck($/, q/mob 1: <ghi @ 8>/), 'mixing named and unnamed capture';

#### <alpha> [ \- <alpha> ]?			abc def ghi	/mob<alpha> 0: <a @ 0>/	multiple subrule captures in same scope
ok ('abc def ghi' ~~ /<alpha> [ \- <alpha> ]?/) && matchcheck($/, q/mob<alpha> 0: <a @ 0>/), 'multiple subrule captures in same scope';

#### [(.)$0]+				bookkeeper	y			backreference
ok 'bookkeeper' ~~ /[ (.) $0 ]+/, 'backreference';

#### [(.)$٠]+				bookkeeper	y			backreference
ok 'bookkeeper' ~~ /[ (.) $٠ ]+/,
    'Nd digit backreference (٠ U+0660 ARABIC-INDIC DIGIT ZERO)';

#### (\w+) <+ws> $0				hello hello	y			backreference at end of string
ok 'hello hello' ~~ /(\w+) <+ws> $0/, 'backreference at end of string';

#### [(.)$0]+				bookkeeper	/mob 0 0: <o @ 1>/	backref $0
ok ('bookkeeper' ~~ /[ (.) $0 ]+/) && matchcheck($/, q/mob 0 0: <o @ 1>/), 'backref $0';

#### [(.)$0]+				bookkeeper	/mob 0 1: <k @ 3>/	backref $0
ok ('bookkeeper' ~~ /[ (.) $0 ]+/) && matchcheck($/, q/mob 0 1: <k @ 3>/), 'backref $0';

#### [(.)$0]+				bookkeeper	/mob 0 2: <e @ 5>/	backref $0
ok ('bookkeeper' ~~ /[ (.) $0 ]+/) && matchcheck($/, q/mob 0 2: <e @ 5>/), 'backref $0';

#### (.)*x					123x		/mob: <123x @ 0>/	repeated dot capture
ok ('123x' ~~ /(.)*x/) && matchcheck($/, q/mob: <123x @ 0>/), 'repeated dot capture';


#### $<key>=<alpha>				12ab34		/mob<key>: <a @ 2>/	alias capture
ok ('12ab34' ~~ /$<key>=<alpha>/) && matchcheck($/, q/mob<key>: <a @ 2>/), 'alias capture';

#### <key=alpha>				12ab34		/mob<key>: <a @ 2>/	alias capture
ok ('12ab34' ~~ /<key=alpha>/) && matchcheck($/, q/mob<key>: <a @ 2>/), 'alias capture';

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading [ indicates">

##   Enumerated character lists
#### <[c]>			abcdef		y	character class
ok 'abcdef' ~~ /<[c]>/, 'character class';

#### <[ z ]>			abc def		n	character class ignores ws
ok 'abc def' !~~ /<[ z ]>/, 'character class ignores ws';

#### <[dcb]>**{3}		abcdef		y	repeated character class
ok 'abcdef' ~~ /<[dcb]>**{3}/, 'repeated character class';

#### ^<[a]>			abcdef		y	anchored character class
ok 'abcdef' ~~ /^<[a]>/, 'anchored character class';

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading - indicates">

#### <-[e]>			abcdef		y	negated character class
ok 'abcdef' ~~ /<-[e]>/, 'negated character class';

#### ^<[a]>?			abcdef		y	anchored optional character class
ok 'abcdef' ~~ /^<[a]>?/, 'anchored optional character class';

#### <-[e]>?			abcdef		y	negated optional character class
ok 'abcdef' ~~ /<-[e]>?/, 'negated optional character class';

#### <-[dcb]>**{3}		abcdef		n	repeated negated character class
ok 'abcdef' !~~ /<-[dcb]>**{3}/, 'repeated negated character class';

#### ^<-[e]>			abcdef		y	anchored negated character class
ok 'abcdef' ~~ /^<-[e]>/, 'anchored negated character class';

#### ^<-[a]>			abcdef		n	anchored negated character class
ok 'abcdef' !~~ /^<-[a]>/, 'anchored negated character class';

# L<S05/Extensible metasyntax (C<< <...> >>)/"Ranges in enumerated character classes">
#### <[b..d]>		abcdef		y	character range
ok 'abcdef' ~~ /<[b..d]>/, 'character range';

#### <[b .. d]>		c		y	character range ignores ws
ok 'c' ~~ /<[b .. d]>/, 'character range ignores ws';

#### <[b..d]>		abxxef		y	character range
ok 'abxxef' ~~ /<[b..d]>/, 'character range';

#### <[b..d]>		axcxef		y	character range
ok 'axcxef' ~~ /<[b..d]>/, 'character range';

#### <[b..d]>		axxdef		y	character range
ok 'axxdef' ~~ /<[b..d]>/, 'character range';

#### <[b..d]>		axxxef		n	character range
ok 'axxxef' !~~ /<[b..d]>/, 'character range';

#### <-[b..d]>		abcdef		y	negated character range
ok 'abcdef' ~~ /<-[b..d]>/, 'negated character range';

#### <- [b..d]>		abcdef		y	negated allows ws
ok 'abcdef' ~~ /<- [b..d]>/, 'negated allows ws';

#### <-[b..d]>		bbccdd		n	negated character range
ok 'bbccdd' !~~ /<-[b..d]>/, 'negated character range';

#### <-[d..b]>		dies
throws-like '/<-[d..b]>/', Exception, 'illegal character range';

ok '-' ~~ /<[-]>/, 'unescaped hyphen is fine on its own';

#### <[\-]>			ab-def		y	escaped hyphen
ok 'ab-def' ~~ /<[\-]>/, 'escaped hyphen';

#### <[\-]>			abcdef		n	escaped hyphen
ok 'abcdef' !~~ /<[\-]>/, 'escaped hyphen';

#### <-[\-]>			---x--		y	negated escaped hyphen
ok '---x--' ~~ /<-[\-]>/, 'negated escaped hyphen';

#### <-[\-]>			------		n	negated escaped hyphen
ok '------' !~~ /<-[\-]>/, 'negated escaped hyphen';

#### <[\-+]>			ab-def		y	escaped hyphen in range
ok 'ab-def' ~~ /<[\-+]>/, 'escaped hyphen in range';

#### <[\-+]>			ab+def		y	escaped hyphen in range
ok 'ab+def' ~~ /<[\-+]>/, 'escaped hyphen in range';

#### <[\-+]>			abcdef		n	escaped hyphen in range
ok 'abcdef' !~~ /<[\-+]>/, 'escaped hyphen in range';

#### <[+\-]>			ab-def		y	escaped hyphen in range
ok 'ab-def' ~~ /<[+\-]>/, 'escaped hyphen in range';

#### <[+\-]>			ab+def		y	escaped hyphen in range
ok 'ab+def' ~~ /<[+\-]>/, 'escaped hyphen in range';

#### <[+\-]>			abcdef		n	escaped hyphen in range
ok 'abcdef' !~~ /<[+\-]>/, 'escaped hyphen in range';

#### <-[\-+]>		---x--		y	negated escaped hyphen in range
ok '---x--' ~~ /<-[\-+]>/, 'negated escaped hyphen in range';

#### <-[\-+]>		------		n	negated escaped hyphen in range
ok '------' !~~ /<-[\-+]>/, 'negated escaped hyphen in range';

#### <-[+\-]>		---x--		y	negated escaped hyphen in range
ok '---x--' ~~ /<-[+\-]>/, 'negated escaped hyphen in range';

#### <-[+\-]>		------		n	negated escaped hyphen in range
ok '------' !~~ /<-[+\-]>/, 'negated escaped hyphen in range';

#### <["\\]>			\\			y	escaped backslash
ok '\\' ~~ /<["\\]>/, 'escaped backslash';

#### <[\]]>			]			y	escaped close bracket
ok ']' ~~ /<[\]]>/, 'escaped close bracket';

#### <[\]>			\\]]		/parse error/	unescaped backslash (or no closing brace)
throws-like ' /<[\]>/ ', X::Comp::Group, 'unescaped backslash (or no closing brace)';

#### ^\><[<]>		><		y	lt character class
ok '><' ~~ /^\><[<]>/, 'lt character class';

#### ^<[>]>\<		><		y	gt character class
ok '><' ~~ /^<[>]>\</, 'gt character class';

#### ^<[><]>**{2}		><		y	gt, lt character class
ok '><' ~~ /^<[><]>**{2}/, 'gt, lt character class';

#### ^<[<>]>**{2}		><		y	lt, gt  character class
ok '><' ~~ /^<[<>]>**{2}/, 'lt, gt  character class';

#### ^<-[><]>		><		n	not gt, lt character class
ok '><' !~~ /^<-[><]>/, 'not gt, lt character class';

#### ^<-[<>]>		><		n	not lt, gt  character class
ok '><' !~~ /^<-[<>]>/, 'not lt, gt  character class';

#### '... --- ...'		... --- ...	y	literal match (\\\')
ok '... --- ...' ~~ /'... --- ...'/, 'literal match (\\\')';

#### '... --- ...'		...---...	n	literal match (\\\')
ok '...---...' !~~ /'... --- ...'/, 'literal match (\\\')';

#### 'ab\'>cd'		ab\'>cd		y	literal match with quote
ok 'ab\'>cd' ~~ /'ab\'>cd'/, 'literal match with quote';

#### 'ab\\yz'		ab\x5cyz	y	literal match with backslash
ok "ab\x5cyz" ~~ /'ab\\yz'/, 'literal match with backslash';

#### 'ab"cd'			ab"cd		y	literal match with quote
ok 'ab"cd' ~~ /'ab"cd'/, 'literal match with quote';

#### 'ab\\yz'		ab\x5cyz	y	literal match with backslash
ok "ab\x5cyz" ~~ /'ab\\yz'/, 'literal match with backslash';

#### "... --- ..."		... --- ...	y	literal match (\")
ok '... --- ...' ~~ /"... --- ..."/, 'literal match (\")';

#### "... --- ..."		...---...	n	literal match (\")
# RT #64880
ok '...---...' !~~ /"... --- ..."/, 'literal match (\")';

#### "ab<\">cd"		ab<">cd		y	literal match with quote
# RT #64880
ok 'ab<">cd' ~~ /"ab<\">cd"/, 'literal match with quote';

#### "ab<'>cd"		ab<\'>cd		y	literal match with quote
# RT #64880
ok 'ab<\'>cd' ~~ /"ab<'>cd"/, 'literal match with quote';

#### "ab\\cd"		ab\x5ccd	y	literal match with backslash
ok "ab\x[5c]cd" ~~ /"ab\\cd"/, 'literal match with backslash';

#### (ab)x"$0"		abxab		y	literal match with interpolation
ok 'abxab' ~~ /(ab)x"$0"/, 'literal match with interpolation';

#### (ab)"x$0"		abxab		y	literal match with interpolation
ok 'abxab' ~~ /(ab)"x$0"/, 'literal match with interpolation';

#### (ab)x“$0”		abxab		y	literal match with interpolation
ok 'abxab' ~~ /(ab)x"$0"/, 'literal match with interpolation';

#### (ab)“x$0”		abxab		y	literal match with interpolation
ok 'abxab' ~~ /(ab)"x$0"/, 'literal match with interpolation';

#### (ab)x„$0”		abxab		y	literal match with interpolation
ok 'abxab' ~~ /(ab)x"$0"/, 'literal match with interpolation';

#### (ab)„x$0”		abxab		y	literal match with interpolation
ok 'abxab' ~~ /(ab)"x$0"/, 'literal match with interpolation';

#### (ab)x„$0“		abxab		y	literal match with interpolation
ok 'abxab' ~~ /(ab)x"$0"/, 'literal match with interpolation';

#### (ab)„x$0“		abxab		y	literal match with interpolation
ok 'abxab' ~~ /(ab)"x$0"/, 'literal match with interpolation';

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading ? indicates">
#
#### '?'			ab<?		y	literal match with question mark
ok 'ab<?' ~~ /'?'/, 'literal match with question mark';

#### '<'			ab<?		y	literal match with lt
ok 'ab<?' ~~ /'<'/, 'literal match with lt ';

#### '<?'			ab<?		y	literal match with lt and question mark
ok 'ab<?' ~~ /'<?'/, 'literal match with lt and question mark';

#### '<?'			ab<x?		n	non-matching literal match
ok 'ab<x?' !~~ /'<?'/, 'non-matching literal match ';

#### <[A..Z0..9]>		abcdef		n	two enumerated ranges
ok 'abcdef' !~~ /<[A..Z0..9]>/, 'two enumerated ranges';

#### <[A..Z0..9]>		abcDef		y	two enumerated ranges
ok 'abcDef' ~~ /<[A..Z0..9]>/, 'two enumerated ranges';

# RT #120753
ok 'Z' ~~ /<[A..MZ]>/, 'range and singleton';

# L<S05/Extensible metasyntax (C<< <...> >>)/"The special named assertions">
#
## lookarounds
#### <before .d> a.		abacad		/mob: <ad @ 4>/			lookahead <before>
ok ('abacad' ~~ /<before .d> a./) && matchcheck($/, q/mob: <ad @ 4>/), 'lookahead <before>';

#### <before c> ....		abacad		n				lookahead <before>
ok 'abacad' !~~ /<before c> ..../, 'lookahead <before>';

#### <before> .		abcd		n				null <before>
throws-like "'abcd' !~~ /<before> ./", Exception, 'null <before>';

#### <!before ..b> aa	aabaaa		/mob: <aa @ 3>/			negated lookahead
ok ('aabaaa' ~~ /<!before ..b> aa/) && matchcheck($/, q/mob: <aa @ 3>/), 'negated lookahead';

#### <after a>b		ab		y				lookbehind <after>
ok 'ab' ~~ /<after a>b/, 'lookbehind <after>';

#### <after a>b		cb		n				lookbehind <after>
ok 'cb' !~~ /<after a>b/, 'lookbehind <after>';

#### <after a>b		b		n				lookbehind <after>
ok 'b' !~~ /<after a>b/, 'lookbehind <after>';

#### <!after c>b		ab		y				lookbehind <!after>
ok 'ab' ~~ /<!after c>b/, 'lookbehind <!after>';

#### <!after c>b		cb		n				lookbehind <!after>
ok 'cb' !~~ /<!after c>b/, 'lookbehind <!after>';

#### <!after c>b		b		y				lookbehind <!after>
ok 'b' ~~ /<!after c>b/, 'lookbehind <!after>';

#### <!after <[cd]>>b	dbcb		n				lookbehind <!after>
ok 'dbcb' !~~ /<!after <[cd]>>b/, 'lookbehind <!after>';

#### <!after <[cd]>><[ab]>	dbaacb		y				lookbehind <!after>
ok 'dbaacb' ~~ /<!after <[cd]>><[ab]>/, 'lookbehind <!after>';

#### <!after c|d>b		dbcb		n				lookbehind <!after>
ok 'dbcb' !~~ /<!after c|d>b/, 'lookbehind <!after>';

#### <!after c|d><[ab]>	dbaacb		y				lookbehind <!after>
ok 'dbaacb' ~~ /<!after c|d><[ab]>/, 'lookbehind <!after>';

#### <!after cd><[ab]>	cbaccb		y				lookbehind <!after>
ok 'cbaccb' ~~ /<!after cd><[ab]>/, 'lookbehind <!after>';

#### $ <after ^a>		a		y				lookbehind <after>
ok 'a' ~~ /$ <after ^a>/, 'lookbehind <after>'; # RT #124898'

#### <after x+>y		axxbxxyc	y				lookbehind <after>
ok 'axxbxxyc' ~~ /<after x+>y/, 'lookbehind <after>';

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading + may also">

#### <[a..z]>+		az		y				metasyntax with leading + (<+...>)
ok 'az' ~~ /<[a..z]>+/, 'metasyntax with leading + (<+...>)';

#### <+[a..z]>+		az		y				metasyntax with leading + (<+...>)
ok 'az' ~~ /<+[a..z]>+/, 'metasyntax with leading + (<+...>)';

#### <+alpha>+		az		y				metasyntax with leading + (<+...>)
ok 'az' ~~ /<+alpha>+/, 'metasyntax with leading + (<+...>)';


#### a[b}		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/rule error/	mismatched close
throws-like '/a[b}/', Exception, 'mismatched close';


#### c <before .d>		abacad		/mob: <c @ 3>/				one character and lookahead <before>
ok ('abacad' ~~ /c <before .d>/) && matchcheck($/, q/mob: <c @ 3>/), 'one character and lookahead <before>';

#### .* <before .d>		abacad		/mob: <abac @ 0>/			multiple characters and lookahead <before>
ok ('abacad' ~~ /.* <before .d>/) && matchcheck($/, q/mob: <abac @ 0>/), 'multiple characters and lookahead <before>';

#### .* <before .\<>		abaca<d		/mob: <abac @ 0>/			multiple characters and lookahead <before> with a \'<\'
ok ('abaca<d' ~~ /.* <before .\<>/) && matchcheck($/, q/mob: <abac @ 0>/), 'multiple characters and lookahead <before> with a \'<\'';

#### .* <before \<>		aba<ca<d		/mob: <aba<ca @ 0>/		greedy any character and lookahead <before> with a \'<\'
ok ('aba<ca<d' ~~ /.* <before \<>/) && matchcheck($/, q/mob: <aba<ca @ 0>/), 'greedy any character and lookahead <before> with a \'<\'';

#### .*? <before \<>		aba<ca<d		/mob: <aba @ 0>/		non-greedy any character and lookahead <before> with a \'<\'
ok ('aba<ca<d' ~~ /.*? <before \<>/) && matchcheck($/, q/mob: <aba @ 0>/), 'non-greedy any character and lookahead <before> with a \'<\'';


##   Metacharacter tests
#### .			a		y	dot (.)
ok 'a' ~~ /./, 'dot (.)';

#### .			\n		y	dot (.)
ok '\n' ~~ /./, 'dot (.)';

#### .			''		n	dot (.)
ok '' !~~ /./, 'dot (.)';

#### a\s+f			abcdef		n	whitespace (\s)
ok 'abcdef' !~~ /a\s+f/, 'whitespace (\s)';

#### ab\s+cdef		ab  cdef	y	whitespace (\s)
ok 'ab  cdef' ~~ /ab\s+cdef/, 'whitespace (\s)';

#### a\S+f			abcdef		y	not whitespace (\S)
ok 'abcdef' ~~ /a\S+f/, 'not whitespace (\S)';

#### a\S+f			ab cdef		n	not whitespace (\S)
ok 'ab cdef' !~~ /a\S+f/, 'not whitespace (\S)';

#### ^ abc			abcdef		y	start and end of string (^)
ok 'abcdef' ~~ /^ abc/, 'start and end of string (^)';

#### ^ abc			abc\ndef	y	start and end of string (^)
ok "abc\ndef" ~~ /^ abc/, 'start and end of string (^)';

#### ^ abc			def\nabc	n	start and end of string (^)
ok "def\nabc" !~~ /^ abc/, 'start and end of string (^)';

#### def \n ^ abc		def\nabc	n	start and end of string (^)
ok "def\nabc" !~~ /def \n ^ abc/, 'start and end of string (^)';

#### def $			abcdef		y	start and end of string ($)
ok 'abcdef' ~~ /def $/, 'start and end of string ($)';

#### def $			abc\ndef	y	start and end of string ($)
ok "abc\ndef" ~~ /def $/, 'start and end of string ($)';

#### def $			def\nabc	n	start and end of string ($)
ok "def\nabc" !~~ /def $/, 'start and end of string ($)';

#### def $ \n abc		def\nabc	n	start and end of string (^)
ok "def\nabc" !~~ /def $ \n abc/, 'start and end of string (^)';

#### abc \n $		abc\n		y	end of string ($)
ok "abc\n" ~~ /abc \n $/, 'end of string ($)';

#### abc $			abc\n		n	end of string ($)
ok "abc\n" !~~ /abc $/, 'end of string ($)';

#### <<def			abc-def		y	left word boundary, beginning of word
ok 'abc-def' ~~ /<<def/, 'left word boundary, beginning of word';

#### <<bc			abc-def		n	left word boundary, mid-word
ok 'abc-def' !~~ /<<bc/, 'left word boundary, mid-word';

#### c<<			abc-def		n	left word boundary, end of word
ok 'abc-def' !~~ /c<</, 'left word boundary, end of word';

#### <<abc			abc-def		y	left word boundary, BOS
ok 'abc-def' ~~ /<<abc/, 'left word boundary, BOS';

#### def<<			abc-def		n	left word boundary, EOS
ok 'abc-def' !~~ /def<</, 'left word boundary, EOS';

#### <<			-------		n	left word boundary, no word chars
ok '-------' !~~ /<</, 'left word boundary, no word chars';

#### >>def			abc-def		n	right word boundary, beginning of word
ok 'abc-def' !~~ />>def/, 'right word boundary, beginning of word';

#### >>bc			abc-def		n	right word boundary, mid-word
ok 'abc-def' !~~ />>bc/, 'right word boundary, mid-word';

#### c>>			abc-def		y	right word boundary, end of word
ok 'abc-def' ~~ /c>>/, 'right word boundary, end of word';

#### >>abc			abc-def		n	right word boundary, BOS
ok 'abc-def' !~~ />>abc/, 'right word boundary, BOS';

#### def>>			abc-def		y	right word boundary, EOS
ok 'abc-def' ~~ /def>>/, 'right word boundary, EOS';

#### >>			-------		n	right word boundary, no word chars
ok '-------' !~~ />>/, 'right word boundary, no word chars';


#### c \n d			abc\ndef	y	logical newline (\n)
ok "abc\ndef" ~~ /c \n d/, 'logical newline (\n)';

#### c \n d			abc\rdef	y	logical newline matches \r
ok "abc\rdef" ~~ /c \n d/, 'logical newline matches \r';

#### c \n+ d			abc\n\ndef	y	logical newline quantified
ok "abc\n\ndef" ~~ /c \n+ d/, 'logical newline quantified';

#### a\n+f			abcdef		n	logical newline (\n)
ok 'abcdef' !~~ /a\n+f/, 'logical newline (\n)';

#### c \n d			abc\n\rdef	n	logical newline matches \n\r
ok "abc\n\rdef" !~~ /c \n d/, 'logical newline matches \n\r';

#### c \n d			abc\r\ndef	y	logical newline matches \r\n
ok "abc\r\ndef" ~~ /c \n d/, 'logical newline matches \r\n';

#### b \n c			abc\ndef	n	logical newline (\n)
ok "abc\ndef" !~~ /b \n c/, 'logical newline (\n)';

#### \N			a		y	not logical newline (\N)
ok 'a' ~~ /\N/, 'not logical newline (\N)';

#### a \N c			abc		y	not logical newline (\N)
ok 'abc' ~~ /a \N c/, 'not logical newline (\N)';

#### \N			''		n	not logical newline (\N)
ok '' !~~ /\N/, 'not logical newline (\N)';

#### c \N d			abc\ndef	n	not logical newline (\N)
ok "abc\ndef" !~~ /c \N d/, 'not logical newline (\N)';

#### c \N d			abc\rdef	n	not logical newline (\N)
ok "abc\rdef" !~~ /c \N d/, 'not logical newline (\N)';

#### c \N+ d			abc\n\ndef	n	not logical newline (\N)
ok "abc\n\ndef" !~~ /c \N+ d/, 'not logical newline (\N)';

#### a\N+f			abcdef		y	not logical newline (\N)
ok 'abcdef' ~~ /a\N+f/, 'not logical newline (\N)';

#### c \N d			abc\n\rdef	n	not logical newline (\N)
ok "abc\n\rdef" !~~ /c \N d/, 'not logical newline (\N)';

#### c \N d			abc\r\ndef	n	not logical newline (\N)
ok "abc\r\ndef" !~~ /c \N d/, 'not logical newline (\N)';

#### b \N \n			abc\ndef	y	not logical newline (\N)
ok "abc\ndef" ~~ /b \N \n/, 'not logical newline (\N)';

#### \Aabc			Aabc		/reserved/	retired metachars (\A)
throws-like '/\Aabc/', X::Obsolete, 'retired metachars (\A)';

#### abc\Z			abcZ		/reserved/	retired metachars (\Z)
throws-like '/abc\Z/', X::Obsolete, 'retired metachars (\Z)';

#### abc\z			abcz		/reserved/	retired metachars (\z)
throws-like '/abc\z/', X::Obsolete, 'retired metachars (\z)';

#### abc # def		abc#def		y	comments (#)
ok 'abc#def' ~~ /abc # def
/, 'comments (#)';

#### abc # xyz		abc#def		y	comments (#)
ok 'abc#def' ~~ /abc # xyz
/, 'comments (#)';

#### abc # def \n \$		abc#def		y	comments (#)
ok 'abc#def' ~~ /abc # def \n \$
/, 'comments (#)';

#### abc '#' def		abc#def		y	comments (#)
ok 'abc#def' ~~ /abc '#' def
/, 'comments (#)';

#### abc '#' xyz		abc#def		n	comments (#)
ok 'abc#def' !~~ /abc '#' xyz
/, 'comments (#)';

#### ^ abc '#' def $		abc#def		y	comments (#)
ok 'abc#def' ~~ /^ abc '#' def $
/, 'comments (#)';

#### ^^ abc \n ^^ def	abc\ndef	y	line beginnings and endings (^^)
ok "abc\ndef" ~~ /^^ abc \n ^^ def/, 'line beginnings and endings (^^)';

#### ^^ abc \n ^^ def \n ^^	abc\ndef\n	n	line beginnings and endings (^^)
ok "abc\ndef\n" !~~ /^^ abc \n ^^ def \n ^^/, 'line beginnings and endings (^^)';

#### ^^ \n			\n		y	line beginnings and endings (^^)
ok "\n" ~~ /^^ \n/, 'line beginnings and endings (^^)';

#### \n ^^			\n		n	line beginnings and endings (^^)
ok "\n" !~~ /\n ^^/, 'line beginnings and endings (^^)';

#### abc $$ \n def $$	abc\ndef	y	line beginnings and endings ($$)
ok "abc\ndef" ~~ /abc $$ \n def $$/, 'line beginnings and endings ($$)';

#### abc $$ \n def $$ \n $$	abc\ndef\n	n	line beginnings and endings ($$)
ok "abc\ndef\n" !~~ /abc $$ \n def $$ \n $$/, 'line beginnings and endings ($$)';

#### $$ \n			\n		y	line beginnings and endings ($$)
ok "\n" ~~ /$$ \n/, 'line beginnings and endings ($$)';

#### \n $$			\n		n	line beginnings and endings ($$)
ok "\n" !~~ /\n $$/, 'line beginnings and endings ($$)';

#### <[a..d]> | <[b..e]>	c		y	alternation (|)
ok 'c' ~~ /<[a..d]> | <[b..e]>/, 'alternation (|)';

#### <[a..d]> | <[d..e]>	c		y	alternation (|)
ok 'c' ~~ /<[a..d]> | <[d..e]>/, 'alternation (|)';

#### <[a..b]> | <[b..e]>	c		y	alternation (|)
ok 'c' ~~ /<[a..b]> | <[b..e]>/, 'alternation (|)';

#### <[a..b]> | <[d..e]>	c		n	alternation (|)
ok 'c' !~~ /<[a..b]> | <[d..e]>/, 'alternation (|)';

#### <[a..d]>+ | <[b..e]>+	bcd		y	alternation (|)
ok 'bcd' ~~ /<[a..d]>+ | <[b..e]>+/, 'alternation (|)';

#### ^ [ <[a..d]>+ | <[b..e]>+ ] $	bcd		y	alternation (|)
ok 'bcd' ~~ /^ [ <[a..d]>+ | <[b..e]>+ ] $/, 'alternation (|)';

#### ^ [ <[a..c]>+ | <[b..e]>+ ] $	bcd		y	alternation (|)
ok 'bcd' ~~ /^ [ <[a..c]>+ | <[b..e]>+ ] $/, 'alternation (|)';

#### ^ [ <[a..d]>+ | <[c..e]>+ ] $	bcd		y	alternation (|)
ok 'bcd' ~~ /^ [ <[a..d]>+ | <[c..e]>+ ] $/, 'alternation (|)';

#### b|			bcd		/rule error/	alternation (|) - null right arg illegal
throws-like '/b|/', X::Syntax::Regex::NullRegex, 'alternation (|) - null right arg illegal';

#### |b			bcd		y	alternation (|) - null left arg ignored
ok 'bcd' ~~ /|b/, 'alternation (|) - null left arg ignored';

#### |			bcd		/rule error/	alternation (|) - null both args illegal
#### |			|		/rule error/	alternation (|) - literal must be escaped
throws-like '/|/', X::Syntax::Regex::NullRegex, 'alternation (|) - null both args illegal';

#### \|			|		y	alternation (|) - literal must be escaped
ok '|' ~~ /\|/, 'alternation (|) - literal must be escaped';

#### <[a..d]> & <[b..e]>	c		y	conjunction (&)
ok 'c' ~~ /<[a..d]> & <[b..e]>/, 'conjunction (&)';

#### <[a..d]> & <[d..e]>	c		n	conjunction (&)
ok 'c' !~~ /<[a..d]> & <[d..e]>/, 'conjunction (&)';

#### <[a..b]> & <[b..e]>	c		n	conjunction (&)
ok 'c' !~~ /<[a..b]> & <[b..e]>/, 'conjunction (&)';

#### <[a..b]> & <[d..e]>	c		n	conjunction (&)
ok 'c' !~~ /<[a..b]> & <[d..e]>/, 'conjunction (&)';

#### <[a..d]>+ & <[b..e]>+	bcd		y	conjunction (&)
ok 'bcd' ~~ /<[a..d]>+ & <[b..e]>+/, 'conjunction (&)';

#### ^ [ <[a..d]>+ & <[b..e]>+ ] $	bcd		y	conjunction (&)
ok 'bcd' ~~ /^ [ <[a..d]>+ & <[b..e]>+ ] $/, 'conjunction (&)';

#### <[a..c]>+ & <[b..e]>+	bcd		y	conjunction (&)
ok 'bcd' ~~ /<[a..c]>+ & <[b..e]>+/, 'conjunction (&)';

#### <[a..d]>+ & <[c..e]>+	bcd		y	conjunction (&)
ok 'bcd' ~~ /<[a..d]>+ & <[c..e]>+/, 'conjunction (&)';

#### b&			bcd		/rule error/	conjunction (&) - null right arg illegal
throws-like '/b&/', X::Syntax::Regex::NullRegex, 'conjunction (&) - null right arg illegal';

#### &b			bcd		/rule error/	conjunction (&) - null left arg legal
eval-lives-ok '/&b/', 'conjunction (&) - null left arg legal';

#### &			bcd		/rule error/	conjunction (&) - null both args illegal
#### &			&		/rule error/	conjunction (&) - literal must be escaped
throws-like '/&/', X::Syntax::Regex::NullRegex, 'conjunction (&) - null both args illegal';

#### \&			&		y	conjunction (&) - literal must be escaped
ok '&' ~~ /\&/, 'conjunction (&) - literal must be escaped';

# todo :pge<leading |>
#### a &| b		a		/rule error/	trailing & not allowed inside |
throws-like '/a &| b/', X::Syntax::Regex::NullRegex, 'alternation and conjunction (&|) - parse error';

#### a |& b		a		y       leading & inside | is okay
ok 'a' ~~ /a |& b/, 'alternation and conjunction (|&) - leading & inside | is okay';

#### |d|b			abc		y	leading alternation ignored
ok 'abc' ~~ /|d|b/, 'leading alternation ignored';

####  |d|b			abc		y	leading alternation ignored
ok 'abc' ~~ / |d|b/, 'leading alternation ignored';

#### |d |b			abc		y	leading alternation ignored
ok 'abc' ~~ /|d |b/, 'leading alternation ignored';

####  | d | b		abc		y	leading alternation ignored
ok 'abc' ~~ / | d | b/, 'leading alternation ignored';

####  b |  | d		abc		n	null pattern invalid
throws-like '/ b |  | d/', X::Syntax::Regex::NullRegex, 'null pattern invalid';

#### \pabc			pabc		/reserved/	retired metachars (\p)
throws-like '/\pabc/', Exception, 'retired metachars (\p)';

#### \p{InConsonant}		a		/reserved/	retired metachars (\p)
throws-like '/\p{InConsonant}/', Exception, 'retired metachars (\p)';

#### \Pabc			Pabc		/reserved/	retired metachars (\P)
throws-like '/\Pabc/', Exception, 'retired metachars (\P)';

#### \P{InConsonant}		a		/reserved/	retired metachars (\P)
throws-like '/\P{InConsonant}/', Exception, 'retired metachars (\P)';

#### \Labc\E			LabcE		/reserved/	retired metachars (\L...\E)
throws-like '/\Labc\E/', Exception, 'retired metachars (\L...\E)';

#### \LABC\E			abc		/reserved/	retired metachars (\L...\E)
throws-like '/\LABC\E/', Exception, 'retired metachars (\L...\E)';

#### \Uabc\E			UabcE		/reserved/	retired metachars (\U...\E)
throws-like '/\Uabc\E/', Exception, 'retired metachars (\U...\E)';

#### \Uabc\E			ABC		/reserved/	retired metachars (\U...\E)
throws-like '/\Uabc\E/', Exception, 'retired metachars (\U...\E)';

#### \Qabc\E			QabcE		/reserved/	retired metachars (\Q...\E)
throws-like '/\Qabc\E/', X::Obsolete, 'retired metachars (\Q...\E)';

#### \Qabc d?\E		abc d		/reserved/	retired metachars (\Q...\E)
throws-like '/\Qabc d?\E/', X::Obsolete, 'retired metachars (\Q...\E)';

#### \Gabc			Gabc		/reserved/	retired metachars (\G)
throws-like '/\Gabc/', Exception, 'retired metachars (\G)';

#### \1abc			1abc		/reserved/	retired metachars (\1)
throws-like '/\1abc/', Exception, 'retired metachars (\1)';

#### ^ \s+ $			\x0009\x0020\x00a0\x000a\x000b\x000c\x000d\x0085	y	0-255 whitespace (\s)
ok "\x0009\x0020\x00a0\x000a\x000b\x000c\x000d\x0085" ~~ /^ \s+ $/, '0-255 whitespace (\s)';

#### ^ \h+ $			\x0009\x0020\x00a0	y	0-255 horizontal whitespace (\h)
ok "\x0009\x0020\x00a0" ~~ /^ \h+ $/, '0-255 horizontal whitespace (\h)';

#### ^ \V+ $			\x0009\x0020\x00a0	y	0-255 horizontal whitespace (\V)
ok "\x0009\x0020\x00a0" ~~ /^ \V+ $/, '0-255 horizontal whitespace (\V)';

#### ^ \v+ $			\x000a\x000b\x000c\x000d\x0085	y	0-255 vertical whitespace (\v)
ok "\x000a\x000b\x000c\x000d\x0085" ~~ /^ \v+ $/, '0-255 vertical whitespace (\v)';

#### ^ \h+ $			\x000a\x000b\x000c\x000d\x0085	n	0-255 horizontal whitespace (\h)
ok "\x000a\x000b\x000c\x000d\x0085" !~~ /^ \h+ $/, '0-255 horizontal whitespace (\h)';

#### ^ \v+ $			\x0009\x0020\x00a0	n	0-255 vertical whitespace (\v)
ok "\x0009\x0020\x00a0" !~~ /^ \v+ $/, '0-255 vertical whitespace (\v)';

#### ^ \s+ $			\x1680\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000	y	unicode whitespace (\s)
ok "\x1680\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000" ~~ /^ \s+ $/, 'unicode whitespace (\s)';

#### ^ \h+ $			\x1680\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000	y	unicode whitespace (\h)
ok "\x1680\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000" ~~ /^ \h+ $/, 'unicode whitespace (\h)';

#### ^ \V+ $			\x1680\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000	y	unicode whitespace (\V)
ok "\x1680\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000" ~~ /^ \V+ $/, 'unicode whitespace (\V)';

#### ^ \v+ $			\x1680\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000	n	unicode whitespace (\v)
ok "\x1680\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000" !~~ /^ \v+ $/, 'unicode whitespace (\v)';

#### c \t d			abc\tdef	y	horizontal tab (\t)
ok "abc\tdef" ~~ /c \t d/, 'horizontal tab (\t)';

#### c \t+ d			abc\t\tdef	y	horizontal tab (\t)
ok "abc\t\tdef" ~~ /c \t+ d/, 'horizontal tab (\t)';

#### a \t+ f			abcdef		n	horizontal tab (\t)
ok 'abcdef' !~~ /a \t+ f/, 'horizontal tab (\t)';

#### b \t c			abc\tdef	n	horizontal tab (\t)
ok "abc\tdef" !~~ /b \t c/, 'horizontal tab (\t)';

#### \T			a		y	not horizontal tab (\T)
ok 'a' ~~ /\T/, 'not horizontal tab (\T)';

#### a \T c			abc		y	not horizontal tab (\T)
ok 'abc' ~~ /a \T c/, 'not horizontal tab (\T)';

#### \T			''		n	not horizontal tab (\T)
ok '' !~~ /\T/, 'not horizontal tab (\T)';

#### c \T d			abc\tdef	n	not horizontal tab (\T)
ok "abc\tdef" !~~ /c \T d/, 'not horizontal tab (\T)';

#### c \T+ d			abc\t\tdef	n	not horizontal tab (\T)
ok "abc\t\tdef" !~~ /c \T+ d/, 'not horizontal tab (\T)';

#### a \T+ f			abcdef		y	not horizontal tab (\T)
ok "abcdef" ~~ /a \T+ f/, 'not horizontal tab (\T)';

#### c \r d			abc\rdef	y	return (\r)
ok "abc\rdef" ~~ /c \r d/, 'return (\r)';

#### c \r+ d			abc\r\rdef	y	return (\r)
ok "abc\r\rdef" ~~ /c \r+ d/, 'return (\r)';

#### a \r+ f			abcdef		n	return (\r)
ok 'abcdef' !~~ /a \r+ f/, 'return (\r)';

#### b \r c			abc\rdef	n	return (\r)
ok "abc\rdef" !~~ /b \r c/, 'return (\r)';

#### \R			a		y	not return (\R)
ok 'a' ~~ /\R/, 'not return (\R)';

#### a \R c			abc		y	not return (\R)
ok 'abc' ~~ /a \R c/, 'not return (\R)';

#### \R			''		n	not return (\R)
ok '' !~~ /\R/, 'not return (\R)';

#### c \R d			abc\rdef	n	not return (\R)
ok "abc\rdef" !~~ /c \R d/, 'not return (\R)';

#### c \R+ d			abc\r\rdef	n	not return (\R)
ok "abc\r\rdef" !~~ /c \R+ d/, 'not return (\R)';

#### a \R+ f			abcdef		y	not return (\R)
ok 'abcdef' ~~ /a \R+ f/, 'not return (\R)';

#### c \f d			abc\fdef	y	formfeed (\f)
ok "abc\fdef" ~~ /c \f d/, 'formfeed (\f)';

#### c \f+ d			abc\f\fdef	y	formfeed (\f)
ok "abc\f\fdef" ~~ /c \f+ d/, 'formfeed (\f)';

#### a \f+ f			abcdef		n	formfeed (\f)
ok 'abcdef' !~~ /a \f+ f/, 'formfeed (\f)';

#### b \f c			abc\fdef	n	formfeed (\f)
ok "abc\fdef" !~~ /b \f c/, 'formfeed (\f)';

#### \F			a		y	not formfeed (\F)
ok 'a' ~~ /\F/, 'not formfeed (\F)';

#### a \F c			abc		y	not formfeed (\F)
ok 'abc' ~~ /a \F c/, 'not formfeed (\F)';

#### \F			''		n	not formfeed (\F)
ok '' !~~ /\F/, 'not formfeed (\F)';

#### c \F d			abc\fdef	n	not formfeed (\F)
ok "abc\fdef" !~~ /c \F d/, 'not formfeed (\F)';

#### c \F+ d			abc\f\fdef	n	not formfeed (\F)
ok "abc\f\fdef" !~~ /c \F+ d/, 'not formfeed (\F)';

#### a \F+ f			abcdef		y	not formfeed (\F)
ok 'abcdef' ~~ /a \F+ f/, 'not formfeed (\F)';

#### c \e d			abc\edef	y	escape (\e)
ok "abc\edef" ~~ /c \e d/, 'escape (\e)';

#### c \e+ d			abc\e\edef	y	escape (\e)
ok "abc\e\edef" ~~ /c \e+ d/, 'escape (\e)';

#### a \e+ f			abcdef		n	escape (\e)
ok 'abcdef' !~~ /a \e+ f/, 'escape (\e)';

#### b \e c			abc\edef	n	escape (\e)
ok "abc\edef" !~~ /b \e c/, 'escape (\e)';

#### \E			a		y	not escape (\E)
ok 'a' ~~ /\E/, 'not escape (\E)';

#### a \E c			abc		y	not escape (\E)
ok 'abc' ~~ /a \E c/, 'not escape (\E)';

#### \E			''		n	not escape (\E)
ok '' !~~ /\E/, 'not escape (\E)';

#### c \E d			abc\edef	n	not escape (\E)
ok "abc\edef" !~~ /c \E d/, 'not escape (\E)';

#### c \E+ d			abc\e\edef	n	not escape (\E)
ok "abc\e\edef" !~~ /c \E+ d/, 'not escape (\E)';

#### a \E+ f			abcdef		y	not escape (\E)
ok 'abcdef' ~~ /a \E+ f/, 'not escape (\E)';

#### c \x0021 d		abc!def	y	hex (\x)
ok 'abc!def' ~~ /c \x0021 d/, 'hex (\x)';

#### c \x0021+ d		abc!!def	y	hex (\x)
ok 'abc!!def' ~~ /c \x0021+ d/, 'hex (\x)';

#### a \x0021+ f		abcdef		n	hex (\x)
ok 'abcdef' !~~ /a \x0021+ f/, 'hex (\x)';

#### b \x0021 c		abc!def		n	hex (\x)
ok 'abc!def' !~~ /b \x0021 c/, 'hex (\x)';

#### c \x[0021] d		abc!def		y	hex (\x[])
ok 'abc!def' ~~ /c \x[0021] d/, 'hex (\x[])';

#### c \x[0021]+ d		abc!!def	y	hex (\x[])
ok 'abc!!def' ~~ /c \x[0021]+ d/, 'hex (\x[])';

#### c \x[21,21] d		abc!!def	y	hex (\x[])
ok 'abc!!def' ~~ /c \x[21,21] d/, 'hex (\x[])';

#### a \x[0021]+ f		abcdef		n	hex (\x[])
ok 'abcdef' !~~ /a \x[0021]+ f/, 'hex (\x[])';

#### b \x[0021] c		abc!def		n	hex (\x[])
ok 'abc!def' !~~ /b \x[0021] c/, 'hex (\x[])';

#### \X0021			a		y	not hex (\X)
ok 'a' ~~ /\X0021/, 'not hex (\X)';

#### a \X0021 c		abc		y	not hex (\X)
ok 'abc' ~~ /a \X0021 c/, 'not hex (\X)';

#### \X0021			''		n	not hex (\X)
ok '' !~~ /\X0021/, 'not hex (\X)';

#### c \X0021 d		abc!def		n	not hex (\X)
ok 'abc!def' !~~ /c \X0021 d/, 'not hex (\X)';

#### c \X0021+ d		abc!!def	n	not hex (\X)
ok 'abc!!def' !~~ /c \X0021+ d/, 'not hex (\X)';

#### a \X0021+ f		abcdef		y	not hex (\X)
ok 'abcdef' ~~ /a \X0021+ f/, 'not hex (\X)';

#### \X[0021]		a		y	not hex (\X[])
ok 'a' ~~ /\X[0021]/, 'not hex (\X[])';

#### a \X[0021] c		abc		y	not hex (\X[])
ok 'abc' ~~ /a \X[0021] c/, 'not hex (\X[])';

#### \X[0021]		''		n	not hex (\X[])
ok '' !~~ /\X[0021]/, 'not hex (\X[])';

#### c \X[0021] d		abc!def		n	not hex (\X[])
ok 'abc!def' !~~ /c \X[0021] d/, 'not hex (\X[])';

#### c \X[0021]+ d		abc!!def	n	not hex (\X[])
ok 'abc!!def' !~~ /c \X[0021]+ d/, 'not hex (\X[])';

#### a \X[0021]+ f		abcdef		y	not hex (\X[])
ok 'abcdef' ~~ /a \X[0021]+ f/, 'not hex (\X[])';

#### c \o041 d		abc!def		y	octal (\o)
ok 'abc!def' ~~ /c \o041 d/, 'octal (\o)';

#### c \o41+ d		abc!!def	y	octal (\o)
ok 'abc!!def' ~~ /c \o41+ d/, 'octal (\o)';

#### a \o41+ f		abcdef		n	octal (\o)
ok 'abcdef' !~~ /a \o41+ f/, 'octal (\o)';

#### b \o41 c		abc!def		n	octal (\o)
ok 'abc!def' !~~ /b \o41 c/, 'octal (\o)';

#### c \o[41] d		abc!def		y	octal (\o[])
ok 'abc!def' ~~ /c \o[41] d/, 'octal (\o[])';

#### c \o[41]+ d		abc!!def	y	octal (\o[])
ok 'abc!!def' ~~ /c \o[41]+ d/, 'octal (\o[])';

#### c \o[41,41] d		abc!!def	y	octal (\o[])
ok 'abc!!def' ~~ /c \o[41,41] d/, 'octal (\o[])';

#### a \o[41]+ f		abcdef		n	octal (\o[])
ok 'abcdef' !~~ /a \o[41]+ f/, 'octal (\o[])';

#### b \o[41] c		abc!def		n	octal (\o[])
ok 'abc!def' !~~ /b \o[41] c/, 'octal (\o[])';

#### \O41			a		y	not octal (\O)
ok 'a' ~~ /\O41/, 'not octal (\O)';

#### a \O41 c		abc		y	not octal (\O)
ok 'abc' ~~ /a \O41 c/, 'not octal (\O)';

#### \O41			''		n	not octal (\O)
ok '' !~~ /\O41/, 'not octal (\O)';

#### c \O41 d		abc!def		n	not octal (\O)
ok 'abc!def' !~~ /c \O41 d/, 'not octal (\O)';

#### c \O41+ d		abc!!def	n	not octal (\O)
ok 'abc!!def' !~~ /c \O41+ d/, 'not octal (\O)';

#### a \O41+ f		abcdef		y	not octal (\O)
ok 'abcdef' ~~ /a \O41+ f/, 'not octal (\O)';

#### \O[41]			a		y	not octal (\O[])
ok 'a' ~~ /\O[41]/, 'not octal (\O[])';

#### a \O[41] c		abc		y	not octal (\O[])
ok 'abc' ~~ /a \O[41] c/, 'not octal (\O[])';

#### \O[41]			''		n	not octal (\O[])
ok '' !~~ /\O[41]/, 'not octal (\O[])';

#### c \O[41] d		abc!def		n	not octal (\O[])
ok 'abc!def' !~~ /c \O[41] d/, 'not octal (\O[])';

#### c \O[41]+ d		abc!!def	n	not octal (\O[])
ok 'abc!!def' !~~ /c \O[41]+ d/, 'not octal (\O[])';

#### a \O[41]+ f		abcdef		y	not octal (\O[])
ok 'abcdef' ~~ /a \O[41]+ f/, 'not octal (\O[])';

#### a\w+f			a=[ *f		n	word character
ok 'a=[ *f' !~~ /a\w+f/, 'word character';

#### a\w+f			abcdef		y	word character
ok 'abcdef' ~~ /a\w+f/, 'word character';

#### a\W+f			a&%- f		y	not word character
ok 'a&%- f' ~~ /a\W+f/, 'not word character';

#### a\W+f			abcdef		n	not word character
ok 'abcdef' !~~ /a\W+f/, 'not word character';

#### a\d+f			abcdef		n	digit
ok 'abcdef' !~~ /a\d+f/, 'digit';

#### ab\d+cdef		ab42cdef	y	digit
ok 'ab42cdef' ~~ /ab\d+cdef/, 'digit';

#### a\D+f			abcdef		y	not digit
ok 'abcdef' ~~ /a\D+f/, 'not digit';

#### a\D+f			ab0cdef		n	not digit
ok 'ab0cdef' !~~ /a\D+f/, 'not digit';


##  modifiers
#### :i bcd			abcdef	y	ignorecase (:i)
ok 'abcdef' ~~ /:i bcd/, 'ignorecase (:i)';

#### :i bcd			aBcdef	y	ignorecase (:i)
ok 'aBcdef' ~~ /:i bcd/, 'ignorecase (:i)';

#### :i bcd			abCdef	y	ignorecase (:i)
ok 'abCdef' ~~ /:i bcd/, 'ignorecase (:i)';

#### :i bcd			abcDef	y	ignorecase (:i)
ok 'abcDef' ~~ /:i bcd/, 'ignorecase (:i)';

#### :i bcd			abc-ef	n	ignorecase (:i)
ok 'abc-ef' !~~ /:i bcd/, 'ignorecase (:i)';

#### :ignorecase bcd		abcdef	y	ignorecase (:ignorecase)
ok 'abcdef' ~~ /:ignorecase bcd/, 'ignorecase (:ignorecase)';

#### :ignorecase bcd		aBCDef	y	ignorecase (:ignorecase)
ok 'aBCDef' ~~ /:ignorecase bcd/, 'ignorecase (:ignorecase)';

#### :ignorecase bcd		abc-ef	n	ignorecase (:ignorecase)
ok 'abc-ef' !~~ /:ignorecase bcd/, 'ignorecase (:ignorecase)';

#### :i(0) bcd		abcdef	y	ignorecase, repetition (:i(0))
ok 'abcdef' ~~ /:i(0) bcd/, 'ignorecase, repetition (:i(0))';

#### :i(0) bcd		abCdef	n	ignorecase, repetition (:i(0))
ok 'abCdef' !~~ /:i(0) bcd/, 'ignorecase, repetition (:i(0))';

#### :i(1) bcd		abcdef	y	ignorecase, repetition (:i(1))
ok 'abcdef' ~~ /:i(1) bcd/, 'ignorecase, repetition (:i(1))';

#### :i(1) bcd		abCdef	y	ignorecase, repetition (:i(1))
ok 'abCdef' ~~ /:i(1) bcd/, 'ignorecase, repetition (:i(1))';

#### :i(1) bcd		aBxDef	n	ignorecase, repetition (:i(1))
ok 'aBxDef' !~~ /:i(1) bcd/, 'ignorecase, repetition (:i(1))';

#### :0i bcd			abcdef	y	ignorecase, repetition (:0i)
ok 'abcdef' ~~ /:0i bcd/, 'ignorecase, repetition (:0i)';

#### :0i bcd			abCdef	n	ignorecase, repetition (:0i)
ok 'abCdef' !~~ /:0i bcd/, 'ignorecase, repetition (:0i)';

#### :1i bcd			abcdef	y	ignorecase, repetition (:1i)
ok 'abcdef' ~~ /:1i bcd/, 'ignorecase, repetition (:1i)';

#### :1i bcd			abCdef	y	ignorecase, repetition (:1i)
ok 'abCdef' ~~ /:1i bcd/, 'ignorecase, repetition (:1i)';

#### :1i bcd			aBCDef	y	ignorecase, repetition (:1i)
ok 'aBCDef' ~~ /:1i bcd/, 'ignorecase, repetition (:1i)';

#### :1i bcd			aBxDef	n	ignorecase, repetition (:1i)
ok 'aBxDef' !~~ /:1i bcd/, 'ignorecase, repetition (:1i)';

#### ab [:i cd ] ef		abcdef	y	ignorecase, lexical (:i)
ok 'abcdef' ~~ /ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### ab [:i cd ] ef		abCdef	y	ignorecase, lexical (:i)
ok 'abCdef' ~~ /ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### ab [:i cd ] ef		abcDef	y	ignorecase, lexical (:i)
ok 'abcDef' ~~ /ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### ab [:i cd ] ef		abCDef	y	ignorecase, lexical (:i)
ok 'abCDef' ~~ /ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### ab [:i cd ] ef		aBCDef	n	ignorecase, lexical (:i)
ok 'aBCDef' !~~ /ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### ab [:i cd ] ef		abCDEf	n	ignorecase, lexical (:i)
ok 'abCDEf' !~~ /ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### :i ab [:i cd ] ef	abCDef	y	ignorecase, lexical (:i)
ok 'abCDef' ~~ /:i ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### :i ab [:i cd ] ef	AbCDeF	y	ignorecase, lexical (:i)
ok 'AbCDeF' ~~ /:i ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### :i ab [:i cd ] ef	AbcdeF	y	ignorecase, lexical (:i)
ok 'AbcdeF' ~~ /:i ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### :i a [:i(0) b [:i(1) c [:0i d [:1i e [:i(0) f ] ] ] ] ]		AbCdEf		y	ignorecase, lexical (:i)
ok 'AbCdEf' ~~ /:i a [:i(0) b [:i(1) c [:0i d [:1i e [:i(0) f ] ] ] ] ]/, 'ignorecase, lexical (:i)';

#### :i aa [:i(0) bb [:i(1) cc [:0i dd [:1i ee [:i(0) ff ] ] ] ] ]	AabbCcddEeff	y	ignorecase, lexical (:i)
ok 'AabbCcddEeff' ~~ /:i aa [:i(0) bb [:i(1) cc [:0i dd [:1i ee [:i(0) ff ] ] ] ] ]/, 'ignorecase, lexical (:i)';

#### :i a [:i(0) b [:i(1) c [:0i d [:1i e [:i(0) f ] ] ] ] ]		AbCdEF		n	ignorecase, lexical (:i)
ok 'AbCdEF' !~~ /:i a [:i(0) b [:i(1) c [:0i d [:1i e [:i(0) f ] ] ] ] ]/, 'ignorecase, lexical (:i)';

#### :i aa [:i(0) bb [:i(1) cc [:0i dd [:1i ee [:i(0) ff ] ] ] ] ]	AabbCcddEeFf	n	ignorecase, lexical (:i)
ok 'AabbCcddEeFf' !~~ /:i aa [:i(0) bb [:i(1) cc [:0i dd [:1i ee [:i(0) ff ] ] ] ] ]/, 'ignorecase, lexical (:i)';

#### :i ab [:i(0) cd ] ef	AbcdeF	y	ignorecase, lexical repetition (:i)
ok 'AbcdeF' ~~ /:i ab [:i(0) cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :i ab [:!i cd ] ef	AbcdeF	y	ignorecase, lexical repetition (:i)
ok 'AbcdeF' ~~ /:i ab [:!i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :i ab [:0i cd ] ef	AbcdeF	y	ignorecase, lexical repetition (:i)
ok 'AbcdeF' ~~ /:i ab [:0i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :0i ab [:1i cd ] ef	abCDef	y	ignorecase, lexical repetition (:i)
ok 'abCDef' ~~ /:0i ab [:1i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :0i ab [:1i cd ] ef	AbCDeF	n	ignorecase, lexical repetition (:i)
ok 'AbCDeF' !~~ /:0i ab [:1i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :0i ab [:1i cd ] ef	AbcdeF	n	ignorecase, lexical repetition (:i)
ok 'AbcdeF' !~~ /:0i ab [:1i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :0i ab [:i(0) cd ] ef	abcdef	y	ignorecase, lexical repetition (:i)
ok 'abcdef' ~~ /:0i ab [:i(0) cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :0i ab [:1i cd ] ef	AbcdeF	n	ignorecase, lexical repetition (:i)
ok 'AbcdeF' !~~ /:0i ab [:1i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :i(1) ab [:1i cd ] ef	AbCdeF	y	ignorecase, lexical repetition (:i)
ok 'AbCdeF' ~~ /:i(1) ab [:1i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :i(1) ab [:i(0) cd ] ef	AbcdeF	y	ignorecase, lexical repetition (:i)
ok 'AbcdeF' ~~ /:i(1) ab [:i(0) cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :i(1) ab [:i(0) cd ] ef	AbcDeF	n	ignorecase, lexical repetition (:i)
ok 'AbcDeF' !~~ /:i(1) ab [:i(0) cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :i(2) ab [:i(999) cd ] ef	ABCDEF	y	ignorecase, lexical repetition (:i)
ok 'ABCDEF' ~~ /:i(2) ab [:i(999) cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :1i ab [:i(1) cd ] ef		ABCDEF	y	ignorecase, lexical repetition (:i)
ok 'ABCDEF' ~~ /:1i ab [:i(1) cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :0i ab [:1i cd ] ef		abcDeF	n	ignorecase, lexical repetition (:i)
ok 'abcDeF' !~~ /:0i ab [:1i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :2i ab [:999i cd ] ef		ABCDEF	y	ignorecase, lexical repetition (:i)
ok 'ABCDEF' ~~ /:2i ab [:999i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### ab [:ignorecase cd ] ef		abCDef	y	ignorecase, lexical (:ignorecase)
ok 'abCDef' ~~ /ab [:ignorecase cd ] ef/, 'ignorecase, lexical (:ignorecase)';

#### ab [:ignorecase cd ] ef		aBCDef	n	ignorecase, lexical (:ignorecase)
ok 'aBCDef' !~~ /ab [:ignorecase cd ] ef/, 'ignorecase, lexical (:ignorecase)';

#### :1ignorecase ab [:ignorecase(1) cd ] ef	ABCDEF	y	ignorecase, lexical repetition (:ignorecase)
ok 'ABCDEF' ~~ /:1ignorecase ab [:ignorecase(1) cd ] ef/, 'ignorecase, lexical repetition (:ignorecase)';

#### :s bcd			a bcdef		y	sigspace (:s)
ok 'a bcdef' ~~ /:s bcd/, 'sigspace (:s)';

#### :s bcd			a bcd ef	y	sigspace (:s)
ok 'a bcd ef' ~~ /:s bcd/, 'sigspace (:s)';

#### :s bcd			abcdef		y	sigspace (:s)
ok 'abcdef' ~~ /:s bcd/, 'sigspace (:s)';

#### :s bcd			abcd ef		y	sigspace (:s)
ok 'abcd ef' ~~ /:s bcd/, 'sigspace (:s)';

#### :s bcd			ab cdef		n	sigspace (:s)
ok 'ab cdef' !~~ /:s bcd/, 'sigspace (:s)';

#### :s b c d		a b c d ef	y	sigspace (:s)
ok 'a b c d ef' ~~ /:s b c d/, 'sigspace (:s)';

#### :s b c d		a b c def	y	sigspace (:s)
ok 'a b c def' ~~ /:s b c d/, 'sigspace (:s)';

#### :s b c d		ab c d ef	y	sigspace (:s)
ok 'ab c d ef' ~~ /:s b c d/, 'sigspace (:s)';

#### :s b c d		a bcdef		n	sigspace (:s)
ok 'a bcdef' !~~ /:s b c d/, 'sigspace (:s)';

#### :s b c d		abcdef		n	sigspace (:s)
ok 'abcdef' !~~ /:s b c d/, 'sigspace (:s)';

#### :sigspace bcd		a bcdef		y	sigspace (:sigspace)
ok 'a bcdef' ~~ /:sigspace bcd/, 'sigspace (:sigspace)';

#### :sigspace bcd		a bcd ef	y	sigspace (:sigspace)
ok 'a bcd ef' ~~ /:sigspace bcd/, 'sigspace (:sigspace)';

#### :sigspace bcd		abcdef		y	sigspace (:sigspace)
ok 'abcdef' ~~ /:sigspace bcd/, 'sigspace (:sigspace)';

#### :sigspace b c d		a b c d ef	y	sigspace (:sigspace)
ok 'a b c d ef' ~~ /:sigspace b c d/, 'sigspace (:sigspace)';

#### :sigspace b c d		a b c def	y	sigspace (:sigspace)
ok 'a b c def' ~~ /:sigspace b c d/, 'sigspace (:sigspace)';

#### :sigspace b c d		ab c d ef	y	sigspace (:sigspace)
ok 'ab c d ef' ~~ /:sigspace b c d/, 'sigspace (:sigspace)';

#### :s(1) b c [:s(0) d e f ]	a b c def	y	sigspace, lexical repetition (:s)
ok 'a b c def' ~~ /:s(1) b c [:s(0) d e f ]/, 'sigspace, lexical repetition (:s)';

#### :s b c [:!s d e f ]	a b c def	y	sigspace, lexical repetition (:s)
ok 'a b c def' ~~ /:s b c [:!s d e f ]/, 'sigspace, lexical repetition (:s)';

#### :s(0) b c [:s(1) d e f ]	a b c def	n	sigspace, lexical repetition (:s)
ok 'a b c def' !~~ /:s(0) b c [:s(1) d e f ]/, 'sigspace, lexical repetition (:s)';

# todo :pge<feature>
#### :!s b c [:s d e f ]	a b c def	n	sigspace, lexical repetition (:s)
ok 'a b c def' !~~ /:!s b c [:s d e f ]/, 'sigspace, lexical repetition (:s)';

#### :s(0) b c [:s(0) d e f ]	a b c def	n	sigspace, lexical repetition (:s)
ok 'a b c def' !~~ /:s(0) b c [:s(0) d e f ]/, 'sigspace, lexical repetition (:s)';

# todo :pge<feature>
#### :!s b c [:!s d e f ]	a b c def	n	sigspace, lexical repetition (:s)
ok 'a b c def' !~~ /:!s b c [:!s d e f ]/, 'sigspace, lexical repetition (:s)';

#### :s ab 				ab		y	sigspace, trailing ws
ok 'ab' ~~ /:s ab /, 'sigspace, trailing ws';

#### foo\s*'-'?\s*bar		foo\t \n-\n\t bar	y	basic match
ok "foo\t \n-\n\t bar" ~~ /foo\s*'-'?\s*bar/, 'basic match';

#### foo\s*'-'?\s*bar		foo - bar	y	basic match
ok 'foo - bar' ~~ /foo\s*'-'?\s*bar/, 'basic match';

#### foo\s+'-'?\s*bar		foo   bar	y	basic match \s+ \s*
ok 'foo   bar' ~~ /foo\s+'-'?\s*bar/, 'basic match \s+ \s*';

#### foo\s+'-'?\s*bar		foo  -bar	y	basic match \s+ \s*
ok 'foo  -bar' ~~ /foo\s+'-'?\s*bar/, 'basic match \s+ \s*';

#### foo\s*'-'?\s+bar		foo-  bar	y	basic match \s* \s+
ok 'foo-  bar' ~~ /foo\s*'-'?\s+bar/, 'basic match \s* \s+';

#### foo '-'? bar			foo-bar		y	basic match \s* \s*
ok 'foo-bar' ~~ /foo '-'? bar/, 'basic match \s* \s*';

#### foo '-'? bar			foobar		y	basic match
ok 'foobar' ~~ /foo '-'? bar/, 'basic match';

#### foo '-'? bar			foo - bar	n	basic non-match
ok 'foo - bar' !~~ /foo '-'? bar/, 'basic non-match';

#### :s foo '-'? bar			foo\n \t- \t\t\nbar	y	basic ws match
ok "foo\n \t- \t\t\nbar" ~~ /:s foo '-'? bar/, 'basic ws match';

#### :s foo '-'? bar			foo - bar	y	basic ws match
ok 'foo - bar' ~~ /:s foo '-'? bar/, 'basic ws match';

#### :s foo '-'? bar			foo   bar	y	basic ws match \s+ \s*
ok 'foo   bar' ~~ /:s foo '-'? bar/, 'basic ws match \s+ \s*';

#### :s foo '-'? bar			foo  -bar	y	basic ws match \s+ \s*
ok 'foo  -bar' ~~ /:s foo '-'? bar/, 'basic ws match \s+ \s*';

#### :s foo '-'? bar			foo-  bar	y	basic ws match \s* \s+
ok 'foo-  bar' ~~ /:s foo '-'? bar/, 'basic ws match \s* \s+';

#### :s foo '-'? bar			foo-bar		y	basic ws match \s* \s*
ok 'foo-bar' ~~ /:s foo '-'? bar/, 'basic ws match \s* \s*';

#### :s foo '-'? bar			foobar		n	basic ws non-match
ok 'foobar' !~~ /:s foo '-'? bar/, 'basic ws non-match';

#### :s()foo '-'? bar		foo - bar	n	basic ws match
#?rakudo skip ':s()'
ok 'foo - bar' !~~ /:s()foo '-'? bar/, 'basic ws match';

#### :s[]foo '-'? bar		foo - bar	y	basic ws match
ok 'foo - bar' ~~ /:s foo '-'? bar/, 'basic ws match';

#### :s<?wb>foo '-'? bar		foo - bar	y	basic ws match with boundary modifier separation
ok 'foo - bar' ~~ /:s<?wb>foo '-'? bar/, 'basic ws match with boundary modifier separation';

#### :s::foo '-'? bar			foo - bar	y	basic ws match with backtrack no-op modifier separation
#?rakudo skip ':: NYI RT #124900'
ok 'foo - bar' ~~ /:s::foo '-'? bar/, 'basic ws match with backtrack no-op modifier separation';

#### :s::(\w+) ':=' (\S+)		dog := spot	/mob 0: <dog @ 0>/	sigspace and capture together
#?rakudo skip ':: NYI RT #124901'
ok ('dog := spot' ~~ /:s::(\w+) ':=' (\S+)/) && matchcheck($/, q/mob 0: <dog @ 0>/), 'sigspace and capture together';

#### :s::(\w+) ':=' (\S+)		dog := spot	/mob 1: <spot @ 7>/	sigspace and capture together
#?rakudo skip ':: NYI RT #124902'
ok ('dog := spot' ~~ /:s::(\w+) ':=' (\S+)/) && matchcheck($/, q/mob 1: <spot @ 7>/), 'sigspace and capture together';

#### :Perl \A.*? bcd\Q$\E..\z	a bcd$ef	y	Perl syntax (:Perl5)
#?rakudo todo 'parse error RT #124903'
ok 'a bcd$ef' ~~ m:Perl5/\A.*? bcd\Q$\E..\z/, 'Perl syntax (:Perl5)';

#### :s^[\d+ ]* abc			11 12 13 abc	y	<?ws> before closing bracket
ok '11 12 13 abc' ~~ /:s^[\d+ ]* abc/, '<?ws> before closing bracket';

{
    ##  Quantifiers

    #### xa*			xaaaay		/<xaaaa @ 0>/	star 2+
    ok ('xaaaay' ~~ /xa*/) && matchcheck($/, q/<xaaaa @ 0>/), 'star 2+';

    #### xa*			xay		/<xa @ 0>/	star 1
    ok ('xay' ~~ /xa*/) && matchcheck($/, q/<xa @ 0>/), 'star 1';

    #### xa*			xy		/<x @ 0>/	star 0
    ok ('xy' ~~ /xa*/) && matchcheck($/, q/<x @ 0>/), 'star 0';

    #### xa*y			xaaaay		/<xaaaay @ 0>/	star 2+
    ok ('xaaaay' ~~ /xa*y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star 2+';

    #### xa*y			xay		/<xay @ 0>/	star 1
    ok ('xay' ~~ /xa*y/) && matchcheck($/, q/<xay @ 0>/), 'star 1';

    #### xa*y			xy		/<xy @ 0>/	star 0
    ok ('xy' ~~ /xa*y/) && matchcheck($/, q/<xy @ 0>/), 'star 0';


    #### xa+			xaaaay		/<xaaaa @ 0>/	plus 2+
    ok ('xaaaay' ~~ /xa+/) && matchcheck($/, q/<xaaaa @ 0>/), 'plus 2+';

    #### xa+			xay		/<xa @ 0>/	plus 1
    ok ('xay' ~~ /xa+/) && matchcheck($/, q/<xa @ 0>/), 'plus 1';

    #### xa+			xy		n		plus 0
    ok 'xy' !~~ /xa+/, 'plus 0';

    #### xa+y			xaaaay		/<xaaaay @ 0>/	plus 2+
    ok ('xaaaay' ~~ /xa+y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus 2+';

    #### xa+y			xay		/<xay @ 0>/	plus 1
    ok ('xay' ~~ /xa+y/) && matchcheck($/, q/<xay @ 0>/), 'plus 1';

    #### xa+y			xy		n		plus 0
    ok 'xy' !~~ /xa+y/, 'plus 0';


    #### xa?			xaaaay		/<xa @ 0>/	ques 2+
    ok ('xaaaay' ~~ /xa?/) && matchcheck($/, q/<xa @ 0>/), 'ques 2+';

    #### xa?			xay		/<xa @ 0>/	ques 1
    ok ('xay' ~~ /xa?/) && matchcheck($/, q/<xa @ 0>/), 'ques 1';

    #### xa?			xy		/<x @ 0>/	ques 0
    ok ('xy' ~~ /xa?/) && matchcheck($/, q/<x @ 0>/), 'ques 0';

    #### xa?y			xaaaay		n		ques 2+
    ok 'xaaaay' !~~ /xa?y/, 'ques 2+';

    #### xa?y			xay		/<xay @ 0>/	ques 1
    ok ('xay' ~~ /xa?y/) && matchcheck($/, q/<xay @ 0>/), 'ques 1';

    #### xa?y			xy		/<xy @ 0>/	ques 0
    ok ('xy' ~~ /xa?y/) && matchcheck($/, q/<xy @ 0>/), 'ques 0';


    #### xa*!			xaaaay		/<xaaaa @ 0>/	star greedy 2+
    ok ('xaaaay' ~~ /xa*!/) && matchcheck($/, q/<xaaaa @ 0>/), 'star greedy 2+';

    #### xa*!			xay		/<xa @ 0>/	star greedy 1
    ok ('xay' ~~ /xa*!/) && matchcheck($/, q/<xa @ 0>/), 'star greedy 1';

    #### xa*!			xy		/<x @ 0>/	star greedy 0
    ok ('xy' ~~ /xa*!/) && matchcheck($/, q/<x @ 0>/), 'star greedy 0';

    #### xa*!y			xaaaay		/<xaaaay @ 0>/	star greedy 2+
    ok ('xaaaay' ~~ /xa*!y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star greedy 2+';

    #### xa*!y			xay		/<xay @ 0>/	star greedy 1
    ok ('xay' ~~ /xa*!y/) && matchcheck($/, q/<xay @ 0>/), 'star greedy 1';

    #### xa*!y			xy		/<xy @ 0>/	star greedy 0
    ok ('xy' ~~ /xa*!y/) && matchcheck($/, q/<xy @ 0>/), 'star greedy 0';


    #### xa+!			xaaaay		/<xaaaa @ 0>/	plus greedy 2+
    ok ('xaaaay' ~~ /xa+!/) && matchcheck($/, q/<xaaaa @ 0>/), 'plus greedy 2+';

    #### xa+!			xay		/<xa @ 0>/	plus greedy 1
    ok ('xay' ~~ /xa+!/) && matchcheck($/, q/<xa @ 0>/), 'plus greedy 1';

    #### xa+!			xy		n		plus greedy 0
    ok 'xy' !~~ /xa+!/, 'plus greedy 0';

    #### xa+!y			xaaaay		/<xaaaay @ 0>/	plus greedy 2+
    ok ('xaaaay' ~~ /xa+!y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus greedy 2+';

    #### xa+!y			xay		/<xay @ 0>/	plus greedy 1
    ok ('xay' ~~ /xa+!y/) && matchcheck($/, q/<xay @ 0>/), 'plus greedy 1';

    #### xa+!y			xy		n		plus greedy 0
    ok 'xy' !~~ /xa+!y/, 'plus greedy 0';


    #### xa?!			xaaaay		/<xa @ 0>/	ques greedy 2+
    ok ('xaaaay' ~~ /xa?!/) && matchcheck($/, q/<xa @ 0>/), 'ques greedy 2+';

    #### xa?!			xay		/<xa @ 0>/	ques greedy 1
    ok ('xay' ~~ /xa?!/) && matchcheck($/, q/<xa @ 0>/), 'ques greedy 1';

    #### xa?!			xy		/<x @ 0>/	ques greedy 0
    ok ('xy' ~~ /xa?!/) && matchcheck($/, q/<x @ 0>/), 'ques greedy 0';

    #### xa?!y			xaaaay		n		ques greedy 2+
    ok 'xaaaay' !~~ /xa?!y/, 'ques greedy 2+';

    #### xa?!y			xay		/<xay @ 0>/	ques greedy 1
    ok ('xay' ~~ /xa?!y/) && matchcheck($/, q/<xay @ 0>/), 'ques greedy 1';

    #### xa?!y			xy		/<xy @ 0>/	ques greedy 0
    ok ('xy' ~~ /xa?!y/) && matchcheck($/, q/<xy @ 0>/), 'ques greedy 0';


    #### xa*:!			xaaaay		/<xaaaa @ 0>/	star :greedy 2+
    ok ('xaaaay' ~~ /xa*:!/) && matchcheck($/, q/<xaaaa @ 0>/), 'star :greedy 2+';

    #### xa*:!			xay		/<xa @ 0>/	star :greedy 1
    ok ('xay' ~~ /xa*:!/) && matchcheck($/, q/<xa @ 0>/), 'star :greedy 1';

    #### xa*:!			xy		/<x @ 0>/	star :greedy 0
    ok ('xy' ~~ /xa*:!/) && matchcheck($/, q/<x @ 0>/), 'star :greedy 0';

    #### xa*:!y			xaaaay		/<xaaaay @ 0>/	star :greedy 2+
    ok ('xaaaay' ~~ /xa*:!y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star :greedy 2+';

    #### xa*:!y			xay		/<xay @ 0>/	star :greedy 1
    ok ('xay' ~~ /xa*:!y/) && matchcheck($/, q/<xay @ 0>/), 'star :greedy 1';

    #### xa*:!y			xy		/<xy @ 0>/	star :greedy 0
    ok ('xy' ~~ /xa*:!y/) && matchcheck($/, q/<xy @ 0>/), 'star :greedy 0';


    #### xa+:!			xaaaay		/<xaaaa @ 0>/	plus :greedy 2+
    ok ('xaaaay' ~~ /xa+:!/) && matchcheck($/, q/<xaaaa @ 0>/), 'plus :greedy 2+';

    #### xa+:!			xay		/<xa @ 0>/	plus :greedy 1
    ok ('xay' ~~ /xa+:!/) && matchcheck($/, q/<xa @ 0>/), 'plus :greedy 1';

    #### xa+:!			xy		n		plus :greedy 0
    ok 'xy' !~~ /xa+:!/, 'plus :greedy 0';

    #### xa+:!y			xaaaay		/<xaaaay @ 0>/	plus :greedy 2+
    ok ('xaaaay' ~~ /xa+:!y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus :greedy 2+';

    #### xa+:!y			xay		/<xay @ 0>/	plus :greedy 1
    ok ('xay' ~~ /xa+:!y/) && matchcheck($/, q/<xay @ 0>/), 'plus :greedy 1';

    #### xa+:!y			xy		n		plus :greedy 0
    ok 'xy' !~~ /xa+:!y/, 'plus :greedy 0';


    #### xa?:!			xaaaay		/<xa @ 0>/	ques :greedy 2+
    ok ('xaaaay' ~~ /xa?:!/) && matchcheck($/, q/<xa @ 0>/), 'ques :greedy 2+';

    #### xa?:!			xay		/<xa @ 0>/	ques :greedy 1
    ok ('xay' ~~ /xa?:!/) && matchcheck($/, q/<xa @ 0>/), 'ques :greedy 1';

    #### xa?:!			xy		/<x @ 0>/	ques :greedy 0
    ok ('xy' ~~ /xa?:!/) && matchcheck($/, q/<x @ 0>/), 'ques :greedy 0';

    #### xa?:!y			xaaaay		n		ques :greedy 2+
    ok 'xaaaay' !~~ /xa?:!y/, 'ques :greedy 2+';

    #### xa?:!y			xay		/<xay @ 0>/	ques :greedy 1
    ok ('xay' ~~ /xa?:!y/) && matchcheck($/, q/<xay @ 0>/), 'ques :greedy 1';

    #### xa?:!y			xy		/<xy @ 0>/	ques :greedy 0
    ok ('xy' ~~ /xa?:!y/) && matchcheck($/, q/<xy @ 0>/), 'ques :greedy 0';


    #### xa*?			xaaaay		/<x @ 0>/	star eager 2+
    ok ('xaaaay' ~~ /xa*?/) && matchcheck($/, q/<x @ 0>/), 'star eager 2+';

    #### xa*?			xay		/<x @ 0>/	star eager 1
    ok ('xay' ~~ /xa*?/) && matchcheck($/, q/<x @ 0>/), 'star eager 1';

    #### xa*?			xy		/<x @ 0>/	star eager 0
    ok ('xy' ~~ /xa*?/) && matchcheck($/, q/<x @ 0>/), 'star eager 0';

    #### xa*?y			xaaaay		/<xaaaay @ 0>/	star eager 2+
    ok ('xaaaay' ~~ /xa*?y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star eager 2+';

    #### xa*?y			xay		/<xay @ 0>/	star eager 1
    ok ('xay' ~~ /xa*?y/) && matchcheck($/, q/<xay @ 0>/), 'star eager 1';

    #### xa*?y			xy		/<xy @ 0>/	star eager 0
    ok ('xy' ~~ /xa*?y/) && matchcheck($/, q/<xy @ 0>/), 'star eager 0';


    #### xa+?			xaaaay		/<xa @ 0>/	plus eager 2+
    ok ('xaaaay' ~~ /xa+?/) && matchcheck($/, q/<xa @ 0>/), 'plus eager 2+';

    #### xa+?			xay		/<xa @ 0>/	plus eager 1
    ok ('xay' ~~ /xa+?/) && matchcheck($/, q/<xa @ 0>/), 'plus eager 1';

    #### xa+?			xy		n		plus eager 0
    ok 'xy' !~~ /xa+?/, 'plus eager 0';

    #### xa+?y			xaaaay		/<xaaaay @ 0>/	plus eager 2+
    ok ('xaaaay' ~~ /xa+?y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus eager 2+';

    #### xa+?y			xay		/<xay @ 0>/	plus eager 1
    ok ('xay' ~~ /xa+?y/) && matchcheck($/, q/<xay @ 0>/), 'plus eager 1';

    #### xa+?y			xy		n		plus eager 0
    ok 'xy' !~~ /xa+?y/, 'plus eager 0';


    #### xa??			xaaaay		/<x @ 0>/	ques eager 2+
    ok ('xaaaay' ~~ /xa??/) && matchcheck($/, q/<x @ 0>/), 'ques eager 2+';

    #### xa??			xay		/<x @ 0>/	ques eager 1
    ok ('xay' ~~ /xa??/) && matchcheck($/, q/<x @ 0>/), 'ques eager 1';

    #### xa??			xy		/<x @ 0>/	ques eager 0
    ok ('xy' ~~ /xa??/) && matchcheck($/, q/<x @ 0>/), 'ques eager 0';

    #### xa??y			xaaaay		n		ques eager 2+
    ok 'xaaaay' !~~ /xa??y/, 'ques eager 2+';

    #### xa??y			xay		/<xay @ 0>/	ques eager 1
    ok ('xay' ~~ /xa??y/) && matchcheck($/, q/<xay @ 0>/), 'ques eager 1';

    #### xa??y			xy		/<xy @ 0>/	ques eager 0
    ok ('xy' ~~ /xa??y/) && matchcheck($/, q/<xy @ 0>/), 'ques eager 0';


    #### xa*:?			xaaaay		/<x @ 0>/	star :eager 2+
    ok ('xaaaay' ~~ /xa*:?/) && matchcheck($/, q/<x @ 0>/), 'star :eager 2+';

    #### xa*:?			xay		/<x @ 0>/	star :eager 1
    ok ('xay' ~~ /xa*:?/) && matchcheck($/, q/<x @ 0>/), 'star :eager 1';

    #### xa*:?			xy		/<x @ 0>/	star :eager 0
    ok ('xy' ~~ /xa*:?/) && matchcheck($/, q/<x @ 0>/), 'star :eager 0';

    #### xa*:?y			xaaaay		/<xaaaay @ 0>/	star :eager 2+
    ok ('xaaaay' ~~ /xa*:?y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star :eager 2+';

    #### xa*:?y			xay		/<xay @ 0>/	star :eager 1
    ok ('xay' ~~ /xa*:?y/) && matchcheck($/, q/<xay @ 0>/), 'star :eager 1';

    #### xa*:?y			xy		/<xy @ 0>/	star :eager 0
    ok ('xy' ~~ /xa*:?y/) && matchcheck($/, q/<xy @ 0>/), 'star :eager 0';


    #### xa+:?			xaaaay		/<xa @ 0>/	plus :eager 2+
    ok ('xaaaay' ~~ /xa+:?/) && matchcheck($/, q/<xa @ 0>/), 'plus :eager 2+';

    #### xa+:?			xay		/<xa @ 0>/	plus :eager 1
    ok ('xay' ~~ /xa+:?/) && matchcheck($/, q/<xa @ 0>/), 'plus :eager 1';

    #### xa+:?			xy		n		plus :eager 0
    ok 'xy' !~~ /xa+:?/, 'plus :eager 0';

    #### xa+:?y			xaaaay		/<xaaaay @ 0>/	plus :eager 2+
    ok ('xaaaay' ~~ /xa+:?y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus :eager 2+';

    #### xa+:?y			xay		/<xay @ 0>/	plus :eager 1
    ok ('xay' ~~ /xa+:?y/) && matchcheck($/, q/<xay @ 0>/), 'plus :eager 1';

    #### xa+:?y			xy		n		plus :eager 0
    ok 'xy' !~~ /xa+:?y/, 'plus :eager 0';


    #### xa?:?			xaaaay		/<x @ 0>/	ques :eager 2+
    ok ('xaaaay' ~~ /xa?:?/) && matchcheck($/, q/<x @ 0>/), 'ques :eager 2+';

    #### xa?:?			xay		/<x @ 0>/	ques :eager 1
    ok ('xay' ~~ /xa?:?/) && matchcheck($/, q/<x @ 0>/), 'ques :eager 1';

    #### xa?:?			xy		/<x @ 0>/	ques :eager 0
    ok ('xy' ~~ /xa?:?/) && matchcheck($/, q/<x @ 0>/), 'ques :eager 0';

    #### xa?:?y			xaaaay		n		ques :eager 2+
    ok 'xaaaay' !~~ /xa?:?y/, 'ques :eager 2+';

    #### xa?:?y			xay		/<xay @ 0>/	ques :eager 1
    ok ('xay' ~~ /xa?:?y/) && matchcheck($/, q/<xay @ 0>/), 'ques :eager 1';

    #### xa?:?y			xy		/<xy @ 0>/	ques :eager 0
    ok ('xy' ~~ /xa?:?y/) && matchcheck($/, q/<xy @ 0>/), 'ques :eager 0';


    #### xa*:y			xaaaay		/<xaaaay @ 0>/	star cut 2+
    ok ('xaaaay' ~~ /xa*: y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star cut 2+';

    #### xa*:y			xay		/<xay @ 0>/	star cut 1
    ok ('xay' ~~ /xa*: y/) && matchcheck($/, q/<xay @ 0>/), 'star cut 1';

    #### xa*:y			xy		/<xy @ 0>/	star cut 0
    ok ('xy' ~~ /xa*: y/) && matchcheck($/, q/<xy @ 0>/), 'star cut 0';

    #### xa*:a			xaaaay		n		star cut 2+
    ok 'xaaaay' !~~ /xa*: a/, 'star cut 2+';

    #### xa*:a			xay		n		star cut 1
    ok 'xay' !~~ /xa*: a/, 'star cut 1';


    #### xa+:y			xaaaay		/<xaaaay @ 0>/	plus cut 2+
    ok ('xaaaay' ~~ /xa+: y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus cut 2+';

    #### xa+:y			xay		/<xay @ 0>/	plus cut 1
    ok ('xay' ~~ /xa+: y/) && matchcheck($/, q/<xay @ 0>/), 'plus cut 1';

    #### xa+:y			xy		n		plus cut 0
    ok 'xy' !~~ /xa+: y/, 'plus cut 0';

    #### xa+:a			xaaaay		n		plus cut 2+
    ok 'xaaaay' !~~ /xa+: a/, 'plus cut 2+';

    #### xa+:a			xay		n		plus cut 1
    ok 'xay' !~~ /xa+: a/, 'plus cut 1';


    #### xa?:y			xaaaay		n		ques cut 2+
    ok 'xaaaay' !~~ /xa?: y/, 'ques cut 2+';

    #### xa?:y			xay		/<xay @ 0>/	ques cut 1
    ok ('xay' ~~ /xa?: y/) && matchcheck($/, q/<xay @ 0>/), 'ques cut 1';

    #### xa?:y			xy		/<xy @ 0>/	ques cut 0
    ok ('xy' ~~ /xa?: y/) && matchcheck($/, q/<xy @ 0>/), 'ques cut 0';

    #### xa?:a			xaaaay		/<xaa @ 0>/	ques cut 2+
    ok ('xaaaay' ~~ /xa?: a/) && matchcheck($/, q/<xaa @ 0>/), 'ques cut 2+';

    #### xa?:a			xay		n		ques cut 1
    ok 'xay' !~~ /xa?: a/, 'ques cut 1';


    #### :ratchet xa*y			xaaaay		/<xaaaay @ 0>/	star ratchet 2+
    ok ('xaaaay' ~~ /:ratchet xa*y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star ratchet 2+';

    #### :ratchet xa*y			xay		/<xay @ 0>/	star ratchet 1
    ok ('xay' ~~ /:ratchet xa*y/) && matchcheck($/, q/<xay @ 0>/), 'star ratchet 1';

    #### :ratchet xa*y			xy		/<xy @ 0>/	star ratchet 0
    ok ('xy' ~~ /:ratchet xa*y/) && matchcheck($/, q/<xy @ 0>/), 'star ratchet 0';

    #### :ratchet xa*a			xaaaay		n		star ratchet 2+
    ok 'xaaaay' !~~ /:ratchet xa*a/, 'star ratchet 2+';

    #### :ratchet xa*a			xay		n		star ratchet 1
    ok 'xay' !~~ /:ratchet xa*a/, 'star ratchet 1';


    #### :ratchet xa+y			xaaaay		/<xaaaay @ 0>/	plus ratchet 2+
    ok ('xaaaay' ~~ /:ratchet xa+y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus ratchet 2+';

    #### :ratchet xa+y			xay		/<xay @ 0>/	plus ratchet 1
    ok ('xay' ~~ /:ratchet xa+y/) && matchcheck($/, q/<xay @ 0>/), 'plus ratchet 1';

    #### :ratchet xa+y			xy		n		plus ratchet 0
    ok 'xy' !~~ /:ratchet xa+y/, 'plus ratchet 0';

    #### :ratchet xa+a			xaaaay		n		plus ratchet 2+
    ok 'xaaaay' !~~ /:ratchet xa+a/, 'plus ratchet 2+';

    #### :ratchet xa+a			xay		n		plus ratchet 1
    ok 'xay' !~~ /:ratchet xa+a/, 'plus ratchet 1';


    #### :ratchet xa?y			xaaaay		n		ques ratchet 2+
    ok 'xaaaay' !~~ /:ratchet xa?y/, 'ques ratchet 2+';

    #### :ratchet xa?y			xay		/<xay @ 0>/	ques ratchet 1
    ok ('xay' ~~ /:ratchet xa?y/) && matchcheck($/, q/<xay @ 0>/), 'ques ratchet 1';

    #### :ratchet xa?y			xy		/<xy @ 0>/	ques ratchet 0
    ok ('xy' ~~ /:ratchet xa?y/) && matchcheck($/, q/<xy @ 0>/), 'ques ratchet 0';

    #### :ratchet xa?a			xaaaay		/<xaa @ 0>/	ques ratchet 2+
    ok ('xaaaay' ~~ /:ratchet xa?a/) && matchcheck($/, q/<xaa @ 0>/), 'ques ratchet 2+';

    #### :ratchet xa?a			xay		n		ques ratchet 1
    ok 'xay' !~~ /:ratchet xa?a/, 'ques ratchet 1';


    #### :ratchet xa*!y			xaaaay		/<xaaaay @ 0>/	star ratchet greedy 2+
    ok ('xaaaay' ~~ /:ratchet xa*!y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star ratchet greedy 2+';

    #### :ratchet xa*!y			xay		/<xay @ 0>/	star ratchet greedy 1
    ok ('xay' ~~ /:ratchet xa*!y/) && matchcheck($/, q/<xay @ 0>/), 'star ratchet greedy 1';

    #### :ratchet xa*!y			xy		/<xy @ 0>/	star ratchet greedy 0
    ok ('xy' ~~ /:ratchet xa*!y/) && matchcheck($/, q/<xy @ 0>/), 'star ratchet greedy 0';

    #### :ratchet xa*!a			xaaaay		/<xaaaa @ 0>/	star ratchet greedy 2+
    ok ('xaaaay' ~~ /:ratchet xa*!a/) && matchcheck($/, q/<xaaaa @ 0>/), 'star ratchet greedy 2+';

    #### :ratchet xa*!a			xay		/<xa @ 0>/	star ratchet greedy 1
    ok ('xay' ~~ /:ratchet xa*!a/) && matchcheck($/, q/<xa @ 0>/), 'star ratchet greedy 1';


    #### :ratchet xa+!y			xaaaay		/<xaaaay @ 0>/	plus ratchet greedy 2+
    ok ('xaaaay' ~~ /:ratchet xa+!y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus ratchet greedy 2+';

    #### :ratchet xa+!y			xay		/<xay @ 0>/	plus ratchet greedy 1
    ok ('xay' ~~ /:ratchet xa+!y/) && matchcheck($/, q/<xay @ 0>/), 'plus ratchet greedy 1';

    #### :ratchet xa+!y			xy		n		plus ratchet greedy 0
    ok 'xy' !~~ /:ratchet xa+!y/, 'plus ratchet greedy 0';

    #### :ratchet xa+!a			xaaaay		/<xaaaa @ 0>/	plus ratchet greedy 2+
    ok ('xaaaay' ~~ /:ratchet xa+!a/) && matchcheck($/, q/<xaaaa @ 0>/), 'plus ratchet greedy 2+';

    #### :ratchet xa+!a			xay		n		plus ratchet greedy 1
    ok 'xay' !~~ /:ratchet xa+!a/, 'plus ratchet greedy 1';


    #### :ratchet xa?!y			xaaaay		n		ques ratchet greedy 2+
    ok 'xaaaay' !~~ /:ratchet xa?!y/, 'ques ratchet greedy 2+';

    #### :ratchet xa?!y			xay		/<xay @ 0>/	ques ratchet greedy 1
    ok ('xay' ~~ /:ratchet xa?!y/) && matchcheck($/, q/<xay @ 0>/), 'ques ratchet greedy 1';

    #### :ratchet xa?!y			xy		/<xy @ 0>/	ques ratchet greedy 0
    ok ('xy' ~~ /:ratchet xa?!y/) && matchcheck($/, q/<xy @ 0>/), 'ques ratchet greedy 0';

    #### :ratchet xa?!a			xaaaay		/<xaa @ 0>/	ques ratchet greedy 2+
    ok ('xaaaay' ~~ /:ratchet xa?!a/) && matchcheck($/, q/<xaa @ 0>/), 'ques ratchet greedy 2+';

    #### :ratchet xa?!a			xay		/<xa @ 0>/	ques ratchet greedy 1
    ok ('xay' ~~ /:ratchet xa?!a/) && matchcheck($/, q/<xa @ 0>/), 'ques ratchet greedy 1';



    ## Quantifier closure
    #### .**{2}			a			n	only one character
    ok 'a' !~~ /.**{2}/, 'only one character';

    #### .**{2}			ab			y	two characters
    ok 'ab' ~~ /.**{2}/, 'two characters';

    #### a**{2}			foobar		n	only one "a" character
    ok 'foobar' !~~ /a**{2}/, 'only one "a" character';

    #### a**{2}			baabaa		y	two "a" characters
    ok 'baabaa' ~~ /a**{2}/, 'two "a" characters';

    #### a**{0..4}		bbbbbbb		y	no "a" characters
    ok 'bbbbbbb' ~~ /a**{0..4}/, 'no "a" characters';

    #### a**{2..4}		bababab		n	not two consecutive "a" characters
    ok 'bababab' !~~ /a**{2..4}/, 'not two consecutive "a" characters';

    #### a**{2..4}		baabbbb		y	two "a" characters
    ok 'baabbbb' ~~ /a**{2..4}/, 'two "a" characters';

    #### a**{2..4}		baaabbb		y	three "a" characters
    ok 'baaabbb' ~~ /a**{2..4}/, 'three "a" characters';

    #### a**{2..4}		baaaabb		y	four "a" characters
    ok 'baaaabb' ~~ /a**{2..4}/, 'four "a" characters';

    #### a**{2..4}		baaaaaa		y	four "a" characters
    ok 'baaaaaa' ~~ /a**{2..4}/, 'four "a" characters';

    #### a**{2..*}		baaaaaa		y	six "a" characters
    ok 'baaaaaa' ~~ /a**{2..*}/, 'six "a" characters';

    #### a**?{2..*}		baaaaaa		y	two "a" characters (non-greedy)
    ok 'baaaaaa' ~~ /a**?{2..*}/, 'two "a" characters (non-greedy)';

    #### a**:?{2..*}		baaaaaa		y	two "a" characters (non-greedy)
    ok 'baaaaaa' ~~ /a**:?{2..*}/, 'two "a" characters (non-greedy)';

    #### a**!{2..*}		baaaaaa		y	six "a" characters (explicit greed)
    ok 'baaaaaa' ~~ /a**!{2..*}/, 'six "a" characters (explicit greed)';

    #### a**:!{2..*}		baaaaaa		y	six "a" characters (explicit greed)
    ok 'baaaaaa' ~~ /a**:!{2..*}/, 'six "a" characters (explicit greed)';

    #### a**?{2..4}		baaabbb		y	two "a" characters (non-greedy)
    ok 'baaabbb' ~~ /a**?{2..4}/, 'two "a" characters (non-greedy)';

    #### a**:?{2..4}		baaabbb		y	two "a" characters (non-greedy)
    ok 'baaabbb' ~~ /a**:?{2..4}/, 'two "a" characters (non-greedy)';

    #### a**!{2..4}		baaabbb		y	three "a" characters (explicit greed)
    ok 'baaabbb' ~~ /a**!{2..4}/, 'three "a" characters (explicit greed)';

    #### a**:!{2..4}		baaabbb		y	three "a" characters (explicit greed)
    ok 'baaabbb' ~~ /a**:!{2..4}/, 'three "a" characters (explicit greed)';


    ## Quantifier bare range
    #### .**2			a			n	only one character
    ok 'a' !~~ /.**2/, 'only one character';

    #### .**2			ab			y	two characters
    ok 'ab' ~~ /.**2/, 'two characters';

    #### a**2			foobar		n	only one "a" character
    ok 'foobar' !~~ /a**2/, 'only one "a" character';

    #### a**2			baabaa		y	two "a" characters
    ok 'baabaa' ~~ /a**2/, 'two "a" characters';

    #### a**0..4			bbbbbbb		y	no "a" characters
    ok 'bbbbbbb' ~~ /a**0..4/, 'no "a" characters';

    #### a**2..4			bababab		n	not two consecutive "a" characters
    ok 'bababab' !~~ /a**2..4/, 'not two consecutive "a" characters';

    #### a**2..4			baabbbb		y	two "a" characters
    ok 'baabbbb' ~~ /a**2..4/, 'two "a" characters';

    #### a**2..4			baaabbb		y	three "a" characters
    ok 'baaabbb' ~~ /a**2..4/, 'three "a" characters';

    #### a**2..4			baaaabb		y	four "a" characters
    ok 'baaaabb' ~~ /a**2..4/, 'four "a" characters';

    #### a**2..4			baaaaaa		y	four "a" characters
    ok 'baaaaaa' ~~ /a**2..4/, 'four "a" characters';

    #### a**2..*			baaaaaa		y	six "a" characters
    ok 'baaaaaa' ~~ /a**2..*/, 'six "a" characters';

    #### a**?2..*		baaaaaa		y	two "a" characters (non-greedy)
    ok 'baaaaaa' ~~ /a**?2..*/, 'two "a" characters (non-greedy)';

    #### a**:?2..*		baaaaaa		y	two "a" characters (non-greedy)
    ok 'baaaaaa' ~~ /a**:?2..*/, 'two "a" characters (non-greedy)';

    #### a**!2..*		baaaaaa		y	six "a" characters (explicit greed)
    ok 'baaaaaa' ~~ /a**!2..*/, 'six "a" characters (explicit greed)';

    #### a**:!2..*		baaaaaa		y	six "a" characters (explicit greed)
    ok 'baaaaaa' ~~ /a**:!2..*/, 'six "a" characters (explicit greed)';

    #### a**?2..4		baaabbb		y	two "a" characters (non-greedy)
    ok 'baaabbb' ~~ /a**?2..4/, 'two "a" characters (non-greedy)';

    #### a**:?2..4		baaabbb		y	two "a" characters (non-greedy)
    ok 'baaabbb' ~~ /a**:?2..4/, 'two "a" characters (non-greedy)';

    #### a**!2..4		baaabbb		y	three "a" characters (explicit greed)
    ok 'baaabbb' ~~ /a**!2..4/, 'three "a" characters (explicit greed)';

    #### a**:!2..4		baaabbb		y	three "a" characters (explicit greed)
    ok 'baaabbb' ~~ /a**:!2..4/, 'three "a" characters (explicit greed)';

    #?rakudo.jvm 2 skip "'۳' is not a valid number"
    is  'aaaa' ~~ /a**۳/, 'aaa', 'Unicode Nd digits work (match case)';
    nok 'aa'   ~~ /a**۳/,        'Unicode Nd digits work (no match case)';
}

# RT #112450
{
    ok 'foooo' ~~ /^ f o ** 4 $/, 'RT #112450 sanity';
    my $rt112450 = 4;
    ok 'foooo' ~~ /^ f o ** {$rt112450} $/, 'RT #112450 closure interpolation';
}

# RT #112454
{
    my $rt112454 = 3;
    my $ten_x = 'x' x 10;

    ok $ten_x ~~ / x ** 3 /, 'RT #112454 match sanity';
    is $/.Str, 'x' x 3, 'RT #112454 quantifier sanity';

    ok $ten_x ~~ / x ** {$rt112454} /, 'Simple match (RT #112454)';
    is $/.Str, 'x' x $rt112454, '** quantifier with braces (RT #112454)';
}

# RT #116415
{
    my $rt116415 = 0;

    ok 'foobar' ~~ / . ** 0 /, 'RT #116415 match sanity';
    is $/.Str, '', 'RT #116415 quantifier sanity';

    ok 'foobar' ~~ / . ** {$rt116415} /, 'Simple match (RT #116415)';
    is $/.Str, '', '** quantifier with braces (RT #116415)';
}

# RT #115294
{
    $_ = 'foo bar';
    is m/ "{ $_ }" /, 'foo bar',
        'using variable in interpolated block in double-quoted string';
}

# RT #115298
ok 'foobar' ~~ /$( $_ )/, '$( $_ ) will match literally';
is $/, 'foobar', '... will match correctly';

#### <ident>			2+3 ab2		/mob<ident>: <ab2 @ 4>/		capturing builtin <ident>
ok ('2+3 ab2' ~~ /<ident>/) && matchcheck($/, q/mob<ident>: <ab2 @ 4>/), 'capturing builtin <ident>';

#### <name>			ab::cd::x3::42	/mob<name>: <ab::cd::x3 @ 0>/	capturing builtin <name>
#?rakudo skip 'regex <name>'
ok ('ab::cd::x3::42' ~~ /<name>/) && matchcheck($/, q/mob<name>: <ab::cd::x3 @ 0>/), 'capturing builtin <name>';


#### <.ident>			2+3 ab2		y		non-capturing builtin <.ident>
ok '2+3 ab2' ~~ /<.ident>/, 'non-capturing builtin <.ident>';

#### <.name>			ab::cd::x3::42	y	non-capturing builtin <.name>
#?rakudo skip 'regex <name>'
ok 'ab::cd::x3::42' ~~ /<.name>/, 'non-capturing builtin <.name>';


#### <?wb>def		abc\ndef\n-==\nghi	y	word boundary \W\w
ok "abc\ndef\n-==\ngh" ~~ /<?wb>def/, 'word boundary \W\w';

#### abc<?wb>		abc\ndef\n-==\nghi	y	word boundary \w\W
ok "abc\ndef\n-==\nghi" ~~ /abc<?wb>/, 'word boundary \w\W';

#### <?wb>abc		abc\ndef\n-==\nghi	y	BOS word boundary
ok "abc\ndef\n-==\nghi" ~~ /<?wb>abc/, 'BOS word boundary';

#### ghi<?wb>		abc\ndef\n-==\nghi	y	EOS word boundary
ok "abc\ndef\n-==\nghi" ~~ /ghi<?wb>/, 'EOS word boundary';

#### a<?wb>			abc\ndef\n-==\nghi	n	\w\w word boundary
ok "abc\ndef\n-==\nghi" !~~ /a<?wb>/, '\w\w word boundary';

#### \-<?wb>			abc\ndef\n-==\nghi	n	\W\W word boundary
ok "abc\ndef\n-==\nghi" !~~ /\-<?wb>/, '\W\W word boundary';

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading ! indicates">

#### <!wb>def		abc\ndef\n-==\nghi	n	nonword boundary \W\w
ok "abc\ndef\n-==\nghi" !~~ /<!wb>def/, 'nonword boundary \W\w';

#### abc<!wb>		abc\ndef\n-==\nghi	n	nonword boundary \w\W
ok "abc\ndef\n-==\nghi" !~~ /abc<!wb>/, 'nonword boundary \w\W';

#### <!wb>abc		abc\ndef\n-==\nghi	n	BOS nonword boundary
ok "abc\ndef\n-==\nghi" !~~ /<!wb>abc/, 'BOS nonword boundary';

#### ghi<!wb>		abc\ndef\n-==\nghi	n	EOS nonword boundary
ok "abc\ndef\n-==\nghi" !~~ /ghi<!wb>/, 'EOS nonword boundary';

#### a<!wb>			abc\ndef\n-==\nghi	y	\w\w nonword boundary
ok "abc\ndef\n-==\nghi" ~~ /a<!wb>/, '\w\w nonword boundary';

#### \-<!wb>			abc\ndef\n-==\nghi	y	\W\W nonword boundary
ok "abc\ndef\n-==\nghi" ~~ /\-<!wb>/, '\W\W nonword boundary';


#### de<?ww>        abc\ndef\n-==\nghi	y	\w\w within word 1
ok "abc\ndef\n-==\nghi" ~~ /de<?ww>/, '\w\w within word 1';

#### <?ww>ef		abc\ndef\n-==\nghi	y	\w\w within word 2
ok "abc\ndef\n-==\nghi" ~~ /<?ww>ef/, '\w\w within word 2';

#### <?ww>gh		abc\ndef\n-==\nghi	n	within word \W\w
ok "abc\ndef\n-==\nghi" !~~ /<?ww>gh/, 'within word \W\w';

#### bc<?ww>		abc\ndef\n-==\nghi	n	within word \w\W
ok "abc\ndef\n-==\nghi" !~~ /bc<?ww>/, 'within word \w\W';

#### <?ww>ab		abc\ndef\n-==\nghi	n	BOS within word
ok "abc\ndef\n-==\nghi" !~~ /<?ww>ab/, 'BOS within word';

#### hi<?ww>		abc\ndef\n-==\nghi	n	EOS within word
ok "abc\ndef\n-==\nghi" !~~ /hi<?ww>/, 'EOS within word';

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading ! indicates">

#### de<!ww>        abc\ndef\n-==\nghi	n	\w\w not within word 1
ok "abc\ndef\n-==\nghi" !~~ /de<!ww>/, '\w\w not within word 1';

#### <!ww>ef		abc\ndef\n-==\nghi	n	\w\w not within word 2
ok "abc\ndef\n-==\nghi" !~~ /<!ww>ef/, '\w\w not within word 2';

#### <!ww>gh		abc\ndef\n-==\nghi	y	not within word \W\w
ok "abc\ndef\n-==\nghi" ~~ /<!ww>gh/, 'not within word \W\w';

#### bc<!ww>		abc\ndef\n-==\nghi	y	not within word \w\W
ok "abc\ndef\n-==\nghi" ~~ /bc<!ww>/, 'not within word \w\W';

#### <!ww>ab		abc\ndef\n-==\nghi	y	BOS not within word
ok "abc\ndef\n-==\nghi" ~~ /<!ww>ab/, 'BOS not within word';

#### hi<!ww>		abc\ndef\n-==\nghi	y	EOS not within word
ok "abc\ndef\n-==\nghi" ~~ /hi<!ww>/, 'EOS not within word';


#### <upper>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<upper>: <A @ 45>/		<upper>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<upper>/) && matchcheck($/, q/mob<upper>: <A @ 45>/), '<upper>';

#### <+upper>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <A @ 45>/			<+upper>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+upper>/) && matchcheck($/, q/mob: <A @ 45>/), '<+upper>';

#### <+upper>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <ABCDEFGHIJ @ 45>/	<+upper>+
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+upper>+/) && matchcheck($/, q/mob: <ABCDEFGHIJ @ 45>/), '<+upper>+';


#### <lower>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<lower>: <a @ 55>/		<lower>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<lower>/) && matchcheck($/, q/mob<lower>: <a @ 55>/), '<lower>';

#### <+lower>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <a @ 55>/			<+lower>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+lower>/) && matchcheck($/, q/mob: <a @ 55>/), '<+lower>';

#### <+lower>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <abcdefghij @ 55>/	<+lower>+
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+lower>+/) && matchcheck($/, q/mob: <abcdefghij @ 55>/), '<+lower>+';

#### <alpha>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<alpha>: <A @ 45>/		<alpha>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<alpha>/) && matchcheck($/, q/mob<alpha>: <A @ 45>/), '<alpha>';

#### <+alpha>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <A @ 45>/			<+alpha>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+alpha>/) && matchcheck($/, q/mob: <A @ 45>/), '<+alpha>';

#### <+alpha>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <ABCDEFGHIJabcdefghij @ 45>/	<+alpha>+
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+alpha>+/) && matchcheck($/, q/mob: <ABCDEFGHIJabcdefghij @ 45>/), '<+alpha>+';


#### <digit>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<digit>: <0 @ 35>/		<digit>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<digit>/) && matchcheck($/, q/mob<digit>: <0 @ 35>/), '<digit>';

#### <+digit>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <0 @ 35>/			<+digit>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+digit>/) && matchcheck($/, q/mob: <0 @ 35>/), '<+digit>';

#### <+digit>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <0123456789 @ 35>/	<+digit>+
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+digit>+/) && matchcheck($/, q/mob: <0123456789 @ 35>/), '<+digit>+';


#### <xdigit>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<xdigit>: <0 @ 35>/		<xdigit>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<xdigit>/) && matchcheck($/, q/mob<xdigit>: <0 @ 35>/), '<xdigit>';

#### <+xdigit>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <0 @ 35>/			<+xdigit>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+xdigit>/) && matchcheck($/, q/mob: <0 @ 35>/), '<+xdigit>';

#### <+xdigit>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <0123456789ABCDEF @ 35>/	<+xdigit>+
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+xdigit>+/) && matchcheck($/, q/mob: <0123456789ABCDEF @ 35>/), '<+xdigit>+';


#### <space>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<space>: <\t @ 0>/		<space>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<space>/) && matchcheck($/, q/mob<space>: <\t @ 0>/), '<space>';

#### <+space>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <\t @ 0>/		<+space>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+space>/) && matchcheck($/, q/mob: <\t @ 0>/), '<+space>';

#### <+space>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <\t\n\r  @ 0>/		<+space>+
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+space>+/) && matchcheck($/, q/mob: <\t\n\r  @ 0>/), '<+space>+';


#### <blank>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<blank>: <\t @ 0>/		<blank>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<blank>/) && matchcheck($/, q/mob<blank>: <\t @ 0>/), '<blank>';

#### <+blank>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <\t @ 0>/			<+blank>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+blank>/) && matchcheck($/, q/mob: <\t @ 0>/), '<+blank>';

#### <+blank>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <\t @ 0>/			<+blank>+
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+blank>+/) && matchcheck($/, q/mob: <\t @ 0>/), '<+blank>+';


#### <cntrl>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<cntrl>: <\t @ 0>/		<cntrl>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<cntrl>/) && matchcheck($/, q/mob<cntrl>: <\t @ 0>/), '<cntrl>';

#### <+cntrl>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <\t @ 0>/			<+cntrl>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+cntrl>/) && matchcheck($/, q/mob: <\t @ 0>/), '<+cntrl>';

#### <+cntrl>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <\t\n\r @ 0>/		<+cntrl>+
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+cntrl>+/) && matchcheck($/, q/mob: <\t\n\r @ 0>/), '<+cntrl>+';


#### <punct>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<punct>: <! @ 4>/		<punct>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<punct>/) && matchcheck($/, q/mob<punct>: <! @ 4>/), '<punct>';

#### <+punct>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <! @ 4>/			<+punct>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+punct>/) && matchcheck($/, q/mob: <! @ 4>/), '<+punct>';

#### <+punct>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <!"#$%&/		<+punct>+
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+punct>+/) && matchcheck($/, q/mob: <!"#$%&/), '<+punct>+';


#### <alnum>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<alnum>: <0 @ 35>/		<alnum>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<alnum>/) && matchcheck($/, q/mob<alnum>: <0 @ 35>/), '<alnum>';

#### <+alnum>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <0 @ 35>/	<+alnum>
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+alnum>/) && matchcheck($/, q/mob: <0 @ 35>/), '<+alnum>';

#### <+alnum>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <0123456789ABCDEFGHIJabcdefghij @ 35>/	<+alnum>+
ok ("\t\n\r"~' !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+alnum>+/) && matchcheck($/, q/mob: <0123456789ABCDEFGHIJabcdefghij @ 35>/), '<+alnum>+';

#### <+alnum+[_]>	ident_1				y	union of character classes
ok 'ident_1' ~~ /<+alnum+[_]>/, 'union of character classes';

#### <+[ab]+[\-]>+	aaa-bbb				y	enumerated character classes
ok 'aaa-bbb' ~~ /<+[ab]+[\-]>+/, 'enumerated character classes';

#### <+  [ a  b ]+[\-]>+		aaa-bbb		y	whitespace is ignored within square brackets and after the initial +
ok 'aaa-bbb' ~~ /<+  [ a  b ]+[\-]>+/, 'whitespace is ignored within square brackets and after the initial +';

#### <+[ab]+[\-]>+	-ab-				y	enumerated character classes variant
ok '-ab-' ~~ /<+[ab]+[\-]>+/, 'enumerated character classes variant';

#### <+[ab]+[\-]>+	----				y	enumerated character classes variant
ok '----' ~~ /<+[ab]+[\-]>+/, 'enumerated character classes variant';

#### <+[ab]+[\-]>+	-				y	enumerated character classes variant
ok '-' ~~ /<+[ab]+[\-]>+/, 'enumerated character classes variant';

#### <-[ab]+[cd]>+	ccdd				y	enumerated character classes variant
ok 'ccdd' ~~ /<-[ab]+[cd]>+/, 'enumerated character classes variant';

#### ^<-[ab]+[cd]>+$	caad				n	enumerated character classes variant
ok 'caad' !~~ /^<-[ab]+[cd]>+$/, 'enumerated character classes variant';

#### <-  [ a  b ]+[cd]>+	ccdd			y	whitespace is ignored within square brackets and after the initial -
ok 'ccdd' ~~ /<-  [ a  b ]+[cd]>+/, 'whitespace is ignored within square brackets and after the initial -';

#### ^<-upper>dent	ident_1				y	inverted character class
ok 'ident_1' ~~ /^<-upper>dent/, 'inverted character class';

#### ^<-upper>dent	Ident_1				n	inverted character class
ok 'Ident_1' !~~ /^<-upper>dent/, 'inverted character class';

#### <+alpha-[Jj]>+	abc				y	character class with no j
ok 'abc' ~~ /<+alpha-[Jj]>+/, 'character class with no j';

#### <+ alpha - [ Jj ]>	abc			y	character class with no j with ws
ok 'abc' ~~ /<+ alpha - [ Jj ]>/, 'character class with no j with ws';

#### ^<+alpha-[Jj]>+$	aJc			n	character class with no j fail
ok 'aJc' !~~ /^<+alpha-[Jj]>+$/, 'character class with no j fail';


##  syntax errors

#### {{		abcdef		/Missing closing braces/	unterminated closure
throws-like '/{{/', X::Comp::Group, 'unterminated closure';

#### \1		abcdef		/reserved/			back references
throws-like '/\1/', Exception, 'back references';

#### \۳		abcdef		/reserved/			back references
throws-like '/\۳/', Exception, 'Nd digit back references';

#### \x[		abcdef		/Missing close bracket/		unterminated \x[..]
throws-like '/\x[/', Exception, 'unterminated \x[..]';

#### \X[		abcdef		/Missing close bracket/		unterminated \X[..]
throws-like '/\X[/', Exception, 'unterminated \X[..]';


#### * abc		abcdef		/Quantifier follows nothing/	bare * at start
throws-like '/* abc/', X::Syntax::Regex::SolitaryQuantifier, 'bare * at start';

####   * abc		abcdef		/Quantifier follows nothing/	bare * after ws
throws-like '/  * abc/', X::Syntax::Regex::SolitaryQuantifier, 'bare * after ws';

#### [*|a]		abcdef		/Quantifier follows nothing/	bare * after [
throws-like '/[*|a]/', X::Syntax::Regex::SolitaryQuantifier, 'bare * after [';

#### [ *|a]		abcdef		/Quantifier follows nothing/	bare * after [+sp
throws-like '/[ *|a]/', X::Syntax::Regex::SolitaryQuantifier, 'bare * after [+sp';

#### [a|*]		abcdef		/Quantifier follows nothing/	bare * after |
throws-like '/[a|*]/', X::Syntax::Regex::SolitaryQuantifier, 'bare * after |';

#### [a| *]		abcdef		/Quantifier follows nothing/	bare * after |+sp
throws-like '/[a| *]/', X::Syntax::Regex::SolitaryQuantifier, 'bare * after |+sp';


#### + abc		abcdef		/Quantifier follows nothing/	bare + at start
throws-like '/+ abc/', X::Syntax::Regex::SolitaryQuantifier, 'bare + at start';

####   + abc		abcdef		/Quantifier follows nothing/	bare + after ws
throws-like '/  + abc/', X::Syntax::Regex::SolitaryQuantifier, 'bare + after ws';

#### [+|a]		abcdef		/Quantifier follows nothing/	bare + after [
throws-like '/[+|a]/', X::Syntax::Regex::SolitaryQuantifier, 'bare + after [';

#### [ +|a]		abcdef		/Quantifier follows nothing/	bare + after [+sp
throws-like '/[ +|a]/', X::Syntax::Regex::SolitaryQuantifier, 'bare + after [+sp';

#### [a|+]		abcdef		/Quantifier follows nothing/	bare + after |
throws-like '/[a|+]/', X::Syntax::Regex::SolitaryQuantifier, 'bare + after |';

#### [a| +]		abcdef		/Quantifier follows nothing/	bare + after |+sp
throws-like '/[a| +]/', X::Syntax::Regex::SolitaryQuantifier, 'bare + after |+sp';


#### ? abc		abcdef		/Quantifier follows nothing/	bare ? at start
throws-like '/? abc/', X::Syntax::Regex::SolitaryQuantifier, 'bare ? at start';

####   ? abc		abcdef		/Quantifier follows nothing/	bare ? after ws
throws-like '/  ? abc/', X::Syntax::Regex::SolitaryQuantifier, 'bare ? after ws';

#### [?|a]		abcdef		/Quantifier follows nothing/	bare ? after [
throws-like '/[?|a]/', X::Syntax::Regex::SolitaryQuantifier, 'bare ? after [';

#### [ ?|a]		abcdef		/Quantifier follows nothing/	bare ? after [+sp
throws-like '/[ ?|a]/', X::Syntax::Regex::SolitaryQuantifier, 'bare ? after [+sp';

#### [a|?]		abcdef		/Quantifier follows nothing/	bare ? after |
throws-like '/[a|?]/', X::Syntax::Regex::SolitaryQuantifier, 'bare ? after |';

#### [a| ?]		abcdef		/Quantifier follows nothing/	bare ? after |+sp
throws-like '/[a| ?]/', X::Syntax::Regex::SolitaryQuantifier, 'bare ? after |+sp';

# L<S05/Nothing is illegal/"The empty pattern is now illegal">

#### 		abcdef		/Null pattern illegal/		null pattern
throws-like '//', X::Syntax::Regex::NullRegex, '';

####   		abcdef		/Null pattern illegal/		ws null pattern
throws-like '/  /', X::Syntax::Regex::NullRegex, 'ws null pattern';

throws-like '"b" ~~ /b| /', X::Syntax::Regex::NullRegex, 'null pattern after alternation';

# RT #71702
throws-like '"foo" ~~ /<[d..b]>? foo/', Exception, 'no reversed char ranges';

# vim: ft=perl6 sw=4 expandtab
