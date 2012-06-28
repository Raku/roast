use Test;

plan 733;

### for now
sub matchcheck(*@a) { 1 }

# L<S05/Backtracking control/"To force the preceding atom to do no
# backtracking">

##   Backtracking control tests
#### a* a			bazaar		y	control
#?pugs todo 
ok 'bazaar' ~~ /a* a/, 'control';

#### a*: a			bazaar		n	basic
ok !('bazaar' ~~ /a*: a/), 'basic';

#### ^[a|b]*  aba		abbabbababba	y	control
#?pugs todo 
ok 'abbabbababba' ~~ /^[a|b]*  aba/, 'control';

#### ^[a|b]*: aba		abbabbababba	n	outside a group
ok !('abbabbababba' ~~ /^[a|b]*: aba/), 'outside a group';

#### \d+:			123abc		y	cut on character class shortcut
#?pugs todo 
ok '123abc' ~~ /\d+:/, 'cut on character class shortcut';

#### \d+:			abc		n	cut on character class shortcut
ok 'abc' !~~ /\d+:/, 'cut on character class shortcut';

#### [ if    not | ify ]	verify		y	control
#?pugs todo 
ok 'verify' ~~ /[ if    not | ify ]/, 'control';

# L<S05/Backtracking control/"Backtracking over a double colon">

#### [ if :: not | ify ]	verify		n	inside a group
#?rakudo skip ':: NYI'
#?niecza todo ':: issues'
ok 'verify' !~~ /[ if :: not | ify ]/, 'inside a group';

####   if :: not | ify	verify		n	the default all group
#?rakudo skip ':: NYI'
#?niecza todo ':: issues'
ok 'verify' !~~ /  if :: not | ify/, 'the default all group';

#### [ if :  not | ify ]	verify		y	simple backtrack still works
#?pugs todo 
ok 'verify' ~~ /[ if :  not | ify ]/, 'simple backtrack still works';

#### [ if :: not | ify ] | verify	verify	y	rule continues
#?rakudo skip ':: NYI'
#?pugs todo 
ok 'verify' ~~ /[ if :: not | ify ] | verify/, 'rule continues';

# L<S05/Backtracking control/"Backtracking over a triple colon">
#### [ when     ever ] | whence	whence	y	full backtrack failure
#?pugs todo 
ok 'whence' ~~ /[ when     ever ] | whence/, 'full backtrack failure';

#### [ when ::: ever ] | whence	whence	n	full backtrack failure
#?rakudo skip '::: NYI'
#?niecza todo '::: issue'
ok 'whence' !~~ /[ when ::: ever ] | whence/, 'full backtrack failure';

#### ab::cd | gh::ij		xyabghij	y	group cut at top
#?rakudo skip ':: NYI'
#?pugs todo 
ok 'xyabghij' ~~ /ab::cd | gh::ij/, 'group cut at top';

#### ab:::cd | gh:::ij	xyabghij	n	rule cut at top
#?rakudo skip ':: NYI'
#?niecza todo '::: issue'
ok 'xyabghij' !~~ /ab:::cd | gh:::ij/, 'rule cut at top';

#### [ab::cd | gh::ij]	xyabghij	y	group cut in group
#?rakudo skip ':: NYI'
#?pugs todo 
ok 'xyabghij' ~~ /[ab::cd | gh::ij]/, 'group cut in group';

#### [ab:::cd | gh:::ij]	xyabghij	n	rule cut in group
#?rakudo skip '::: NYI'
#?niecza todo '::: issue'
ok 'xyabghij' !~~ /[ab:::cd | gh:::ij]/, 'rule cut in group';

#### [ ab | abc ]: de	xyzabcde	n	no backtrack into group
#?rakudo todo 'nom regression'
#?niecza todo ''
ok 'xyzabcde' !~~ /[ ab | abc ]: de/, 'no backtrack into group';

#### ( ab | abc ): de	xyzabcde	n	no backtrack into subpattern
ok 'xyzabcde' !~~ /( ab || abc ): de/, 'no backtrack into subpattern';

#### [ when <commit> ever ] | whence	whence	n	full backtrack failure
#?rakudo skip '<commit> not implemented'
#?niecza todo ''
ok 'whence' !~~ /[ when <commit> ever ] | whence/, 'full backtrack failure';

#L<S05/Modifiers/"The new :ratchet modifier">

#### :ratchet a* a		bazaar		n	ratchet modifier
ok 'bazaar' !~~ /:ratchet a* a/, 'ratchet modifier';

#### :ratchet a*! a		bazaar		y	force backtracking !
#?pugs todo 
ok 'bazaar' ~~ /:ratchet a*! a/, 'force backtracking !';

#L<S05/Unchanged syntactic features/"Capturing: (...)">

##   captures
#### (a.)..(..)		zzzabcdefzzz	y			basic match
#?pugs todo 
ok 'zzzabcdefzzz' ~~ /(a.)..(..)/, 'basic match';

#### (a.)..(..)		zzzabcdefzzz	/mob: <abcdef @ 3>/	basic $/
#?pugs todo 
ok ('zzzabcdefzzz' ~~ /(a.)..(..)/) && matchcheck($/, q/mob: <abcdef @ 3>/), 'basic $/';

#### (a.)..(..)		zzzabcdefzzz	/mob 0: <ab @ 3>/	basic $0
#?pugs todo 
ok ('zzzabcdefzzz' ~~ /(a.)..(..)/) && matchcheck($/, q/mob 0: <ab @ 3>/), 'basic $0';

#### (a.)..(..)		zzzabcdefzzz	/mob 1: <ef @ 7>/	basic $1
#?pugs todo 
ok ('zzzabcdefzzz' ~~ /(a.)..(..)/) && matchcheck($/, q/mob 1: <ef @ 7>/), 'basic $1';

#### (a(b(c))(d))		abcd		y			nested match
#?pugs todo 
ok 'abcd' ~~ /(a(b(c))(d))/, 'nested match';

#### (a(b(c))(d))		abcd		/mob: <abcd @ 0>/	nested match
#?pugs todo 
ok ('abcd' ~~ /(a(b(c))(d))/) && matchcheck($/, q/mob: <abcd @ 0>/), 'nested match';

#### (a(b(c))(d))		abcd		/mob 0: <abcd @ 0>/	nested match
#?pugs todo 
ok ('abcd' ~~ /(a(b(c))(d))/) && matchcheck($/, q/mob 0: <abcd @ 0>/), 'nested match';

#### (a(b(c))(d))		abcd		/mob 0 0: <bc @ 1>/	nested match
#?pugs todo 
ok ('abcd' ~~ /(a(b(c))(d))/) && matchcheck($/, q/mob 0 0: <bc @ 1>/), 'nested match';

#### (a(b(c))(d))		abcd		/mob 0 0 0: <c @ 2>/	nested match
#?pugs todo 
ok ('abcd' ~~ /(a(b(c))(d))/) && matchcheck($/, q/mob 0 0 0: <c @ 2>/), 'nested match';

#### (a(b(c))(d))		abcd		/mob 0 1: <d @ 3>/	nested match
#?pugs todo 
ok ('abcd' ~~ /(a(b(c))(d))/) && matchcheck($/, q/mob 0 1: <d @ 3>/), 'nested match';

#### ((\w+)+)		abcd		/mob: <abcd @ 0>/	nested match
#?pugs todo 
ok ('abcd' ~~ /((\w+)+)/) && matchcheck($/, q/mob: <abcd @ 0>/), 'nested match';

#### ((\w+)+)		abcd		/mob 0: <abcd @ 0>/	nested match
#?pugs todo 
ok ('abcd' ~~ /((\w+)+)/) && matchcheck($/, q/mob 0: <abcd @ 0>/), 'nested match';

#### ((\w+)+)		abcd		/mob 0 0 0: <abcd @ 0>/	nested match
#?pugs todo 
ok ('abcd' ~~ /((\w+)+)/) && matchcheck($/, q/mob 0 0 0: <abcd @ 0>/), 'nested match';

#### ((\w+)+)	ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz	/mob: <ABCD/	nested match
#?pugs todo 
ok ('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' ~~ /((\w+)+)/) && matchcheck($/, q/mob: <ABCD/), 'nested match';

#### ((\w+)+)	ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz	/mob 0: <ABCD/	nested match
#?pugs todo 
ok ('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' ~~ /((\w+)+)/) && matchcheck($/, q/mob 0: <ABCD/), 'nested match';

#### ((\w+)+)	ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz	/mob 0 0 0: <ABCD/	nested match
#?pugs todo 
ok ('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' ~~ /((\w+)+)/) && matchcheck($/, q/mob 0 0 0: <ABCD/), 'nested match';

#### (a) [ (bc) (d) | .* (ef) ] .* (g)	abcdefg	/mob 0: <a @ 0>/	alt subpattern before group
#?pugs todo 
ok ('abcdefg' ~~ /(a) [ (bc) (d) | .* (ef) ] .* (g)/) && matchcheck($/, q/mob 0: <a @ 0>/), 'alt subpattern before group';

#### (a) [ (bc) (d) | .* (ef) ] .* (g)	abcdefg	/mob 1: <bc @ 1>/	alt subpattern in group
#?pugs todo 
ok ('abcdefg' ~~ /(a) [ (bc) (d) | .* (ef) ] .* (g)/) && matchcheck($/, q/mob 1: <bc @ 1>/), 'alt subpattern in group';

#### (a) [ (bc) (d) | .* (ef) ] .* (g)	abcdefg	/mob 2: <d @ 3>/	alt subpattern in group
#?pugs todo 
ok ('abcdefg' ~~ /(a) [ (bc) (d) | .* (ef) ] .* (g)/) && matchcheck($/, q/mob 2: <d @ 3>/), 'alt subpattern in group';

#### (a) [ (bc) (d) | .* (ef) ] .* (g)	abcdefg	/mob 3: <g @ 6>/	alt subpattern after group
#?pugs todo 
ok ('abcdefg' ~~ /(a) [ (bc) (d) | .* (ef) ] .* (g)/) && matchcheck($/, q/mob 3: <g @ 6>/), 'alt subpattern after group';

#### (a) [ (bc) (x) | .* (ef) ] .* (g)	abcdefg	/mob 1: <ef @ 4>/	2nd alt subpattern in group
#?pugs todo 
ok ('abcdefg' ~~ /(a) [ (bc) (x) | .* (ef) ] .* (g)/) && matchcheck($/, q/mob 1: <ef @ 4>/), '2nd alt subpattern in group';

#### (a) [ (bc) (x) | .* (ef) ] .* (g)	abcdefg	/mob 3: <g @ 6>/	2nd alt subpattern after group
#?pugs todo 
ok ('abcdefg' ~~ /(a) [ (bc) (x) | .* (ef) ] .* (g)/) && matchcheck($/, q/mob 3: <g @ 6>/), '2nd alt subpattern after group';

#### ( (.) )*				abc	/mob 0 1 0: <b @ 1>/	nested repeated captures
#?pugs todo 
ok ('abc' ~~ /( (.) )*/) && matchcheck($/, q/mob 0 1 0: <b @ 1>/), 'nested repeated captures';

#### [ (.) ]*				abc	/mob 0 1: <b @ 1>/	nested repeated captures
#?pugs todo 
ok ('abc' ~~ /[ (.) ]*/) && matchcheck($/, q/mob 0 1: <b @ 1>/), 'nested repeated captures';

#### ( [.] )*				abc	/mob 0 1: <b @ 1>/	nested repeated captures
#?pugs todo 
ok ('abc' ~~ /( [ . ] )*/) && matchcheck($/, q/mob 0 1: <b @ 1>/), 'nested repeated captures';

#### (.) (.) $7=(.) (.) $4=(.)		abcdefg	/mob 0: <a @ 0>/	numbered aliases $0
#?pugs todo 
ok ('abcdefg' ~~ /(.) (.) $7=(.) (.) $4=(.)/) && matchcheck($/, q/mob 0: <a @ 0>/), 'numbered aliases $0';

#### (.) (.) $7=(.) (.) $4=(.)		abcdefg	/mob 1: <b @ 1>/	numbered aliases $1
#?pugs todo 
ok ('abcdefg' ~~ /(.) (.) $7=(.) (.) $4=(.)/) && matchcheck($/, q/mob 1: <b @ 1>/), 'numbered aliases $1';

#### (.) (.) $7=(.) (.) $4=(.)		abcdefg	/mob 7: <c @ 2>/	numbered aliases $7
#?pugs todo 
ok ('abcdefg' ~~ /(.) (.) $7=(.) (.) $4=(.)/) && matchcheck($/, q/mob 7: <c @ 2>/), 'numbered aliases $7';

#### (.) (.) $7=(.) (.) $4=(.)		abcdefg	/mob 8: <d @ 3>/	numbered aliases $8
#?pugs todo 
ok ('abcdefg' ~~ /(.) (.) $7=(.) (.) $4=(.)/) && matchcheck($/, q/mob 8: <d @ 3>/), 'numbered aliases $8';

#### (.) (.) $7=(.) (.) $4=(.)		abcdefg	/mob 4: <e @ 4>/	numbered aliases $4
#?pugs todo 
ok ('abcdefg' ~~ /(.) (.) $7=(.) (.) $4=(.)/) && matchcheck($/, q/mob 4: <e @ 4>/), 'numbered aliases $4';

#### $1=[ (.) (.) (.) ] (.)			abcdefg	/mob 1: <abc @ 0>/	perl5 numbered captures $1
#?pugs todo 
ok ('abcdefg' ~~ /$1=[ (.) (.) (.) ] (.)/) && matchcheck($/, q/mob 1: <abc @ 0>/), 'perl5 numbered captures $1';

#### $1=[ (.) (.) (.) ] (.)			abcdefg	/mob 2: <a @ 0>/	perl5 numbered captures $1
#?pugs todo 
ok ('abcdefg' ~~ /$1=[ (.) (.) (.) ] (.)/) && matchcheck($/, q/mob 2: <a @ 0>/), 'perl5 numbered captures $1';

#### $1=[ (.) (.) (.) ] (.)			abcdefg	/mob 3: <b @ 1>/	perl5 numbered captures $1
#?pugs todo 
ok ('abcdefg' ~~ /$1=[ (.) (.) (.) ] (.)/) && matchcheck($/, q/mob 3: <b @ 1>/), 'perl5 numbered captures $1';

#### $1=[ (.) (.) (.) ] (.)			abcdefg	/mob 4: <c @ 2>/	perl5 numbered captures $1
#?pugs todo 
ok ('abcdefg' ~~ /$1=[ (.) (.) (.) ] (.)/) && matchcheck($/, q/mob 4: <c @ 2>/), 'perl5 numbered captures $1';

#### $1=[ (.) (.) (.) ] (.)			abcdefg	/mob 5: <d @ 3>/	perl5 numbered captures $1
#?pugs todo 
ok ('abcdefg' ~~ /$1=[ (.) (.) (.) ] (.)/) && matchcheck($/, q/mob 5: <d @ 3>/), 'perl5 numbered captures $1';

#### :s $<key>=[\w+] \= $<val>=[\S+]	 abc = 123	/mob<key>: <abc @ 1>/	named capture
#?pugs todo 
ok (' abc = 123' ~~ /:s $<key>=[\w+] \= $<val>=[\S+]/) && matchcheck($/, q/mob<key>: <abc @ 1>/), 'named capture';

#### :s $<key>=[\w+] \= $<val>=[\S+]	 abc = 123	/mob<val>: <123 @ 7>/	named capture
#?pugs todo 
ok (' abc = 123' ~~ /:s $<key>=[\w+] \= $<val>=[\S+]/) && matchcheck($/, q/mob<val>: <123 @ 7>/), 'named capture';

#### :s (\w+) $<foo>=(\w+) (\w+)		abc def ghi	/mob<foo>: <def @ 4>/	mixing named and unnamed capture
#?pugs todo 
ok ('abc def ghi' ~~ /:s (\w+) $<foo>=(\w+) (\w+)/) && matchcheck($/, q/mob<foo>: <def @ 4>/), 'mixing named and unnamed capture';

#### :s (\w+) $<foo>=(\w+) (\w+)		abc def ghi	/mob 1: <ghi @ 8>/	mixing named and unnamed capture
#?pugs todo 
ok ('abc def ghi' ~~ /:s (\w+) $<foo>=(\w+) (\w+)/) && matchcheck($/, q/mob 1: <ghi @ 8>/), 'mixing named and unnamed capture';

#### <alpha> [ \- <alpha> ]?			abc def ghi	/mob<alpha> 0: <a @ 0>/	multiple subrule captures in same scope
#?pugs todo 
ok ('abc def ghi' ~~ /<alpha> [ \- <alpha> ]?/) && matchcheck($/, q/mob<alpha> 0: <a @ 0>/), 'multiple subrule captures in same scope';

#### [(.)$0]+				bookkeeper	y			backreference
#?pugs todo 
ok 'bookkeeper' ~~ /[ (.) $0 ]+/, 'backreference';

#### (\w+) <+ws> $0				hello hello	y			backreference at end of string
#?pugs todo 
ok 'hello hello' ~~ /(\w+) <+ws> $0/, 'backreference at end of string';

#### [(.)$0]+				bookkeeper	/mob 0 0: <o @ 1>/	backref $0
#?pugs todo 
ok ('bookkeeper' ~~ /[ (.) $0 ]+/) && matchcheck($/, q/mob 0 0: <o @ 1>/), 'backref $0';

#### [(.)$0]+				bookkeeper	/mob 0 1: <k @ 3>/	backref $0
#?pugs todo 
ok ('bookkeeper' ~~ /[ (.) $0 ]+/) && matchcheck($/, q/mob 0 1: <k @ 3>/), 'backref $0';

#### [(.)$0]+				bookkeeper	/mob 0 2: <e @ 5>/	backref $0
#?pugs todo 
ok ('bookkeeper' ~~ /[ (.) $0 ]+/) && matchcheck($/, q/mob 0 2: <e @ 5>/), 'backref $0';

#### (.)*x					123x		/mob: <123x @ 0>/	repeated dot capture
#?pugs todo 
ok ('123x' ~~ /(.)*x/) && matchcheck($/, q/mob: <123x @ 0>/), 'repeated dot capture';


#### $<key>=<alpha>				12ab34		/mob<key>: <a @ 2>/	alias capture
#?pugs todo 
ok ('12ab34' ~~ /$<key>=<alpha>/) && matchcheck($/, q/mob<key>: <a @ 2>/), 'alias capture';

#### <key=alpha>				12ab34		/mob<key>: <a @ 2>/	alias capture
#?pugs todo 
ok ('12ab34' ~~ /<key=alpha>/) && matchcheck($/, q/mob<key>: <a @ 2>/), 'alias capture';

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading [ indicates">

##   Enumerated character lists
#### <[c]>			abcdef		y	character class
#?pugs todo 
ok 'abcdef' ~~ /<[c]>/, 'character class';

#### <[ z ]>			abc def		n	character class ignores ws
ok 'abc def' !~~ /<[ z ]>/, 'character class ignores ws';

#### <[dcb]>**{3}		abcdef		y	repeated character class
#?pugs todo 
#?rakudo skip 'closure repetition'
ok 'abcdef' ~~ /<[dcb]>**{3}/, 'repeated character class';

#### ^<[a]>			abcdef		y	anchored character class
#?pugs todo 
ok 'abcdef' ~~ /^<[a]>/, 'anchored character class';

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading - indicates">

#### <-[e]>			abcdef		y	negated character class
#?pugs todo 
ok 'abcdef' ~~ /<-[e]>/, 'negated character class';

#### ^<[a]>?			abcdef		y	anchored optional character class
#?pugs todo 
ok 'abcdef' ~~ /^<[a]>?/, 'anchored optional character class';

#### <-[e]>?			abcdef		y	negated optional character class
#?pugs todo 
ok 'abcdef' ~~ /<-[e]>?/, 'negated optional character class';

#### <-[dcb]>**{3}		abcdef		n	repeated negated character class
#?rakudo skip 'nom regression'
ok 'abcdef' !~~ /<-[dcb]>**{3}/, 'repeated negated character class';

#### ^<-[e]>			abcdef		y	anchored negated character class
#?pugs todo 
ok 'abcdef' ~~ /^<-[e]>/, 'anchored negated character class';

#### ^<-[a]>			abcdef		n	anchored negated character class
ok 'abcdef' !~~ /^<-[a]>/, 'anchored negated character class';

# L<S05/Extensible metasyntax (C<< <...> >>)/"Ranges in enumerated character classes">
#### <[b..d]>		abcdef		y	character range
#?pugs todo 
ok 'abcdef' ~~ /<[b..d]>/, 'character range';

#### <[b .. d]>		c		y	character range ignores ws
#?pugs todo 
ok 'c' ~~ /<[b .. d]>/, 'character range ignores ws';

#### <[b..d]>		abxxef		y	character range
#?pugs todo 
ok 'abxxef' ~~ /<[b..d]>/, 'character range';

#### <[b..d]>		axcxef		y	character range
#?pugs todo 
ok 'axcxef' ~~ /<[b..d]>/, 'character range';

#### <[b..d]>		axxdef		y	character range
#?pugs todo 
ok 'axxdef' ~~ /<[b..d]>/, 'character range';

#### <[b..d]>		axxxef		n	character range
ok 'axxxef' !~~ /<[b..d]>/, 'character range';

#### <-[b..d]>		abcdef		y	negated character range
#?pugs todo 
ok 'abcdef' ~~ /<-[b..d]>/, 'negated character range';

#### <- [b..d]>		abcdef		y	negated allows ws
#?niecza skip "space between - and [ ] is a problem?"
#?pugs todo 
ok 'abcdef' ~~ /<- [b..d]>/, 'negated allows ws';

#### <-[b..d]>		bbccdd		n	negated character range
ok 'bbccdd' !~~ /<-[b..d]>/, 'negated character range';

#### <-[d..b]>		dies
#?niecza todo ""
#?pugs todo 
eval_dies_ok '/<-[d..b]>/', 'illegal character range';

#?pugs todo 
ok '-' ~~ /<[-]>/, 'unescaped hyphen is fine on its own';

#### <[\-]>			ab-def		y	escaped hyphen
#?pugs todo 
ok 'ab-def' ~~ /<[\-]>/, 'escaped hyphen';

#### <[\-]>			abcdef		n	escaped hyphen
ok 'abcdef' !~~ /<[\-]>/, 'escaped hyphen';

#### <-[\-]>			---x--		y	negated escaped hyphen
#?pugs todo 
ok '---x--' ~~ /<-[\-]>/, 'negated escaped hyphen';

#### <-[\-]>			------		n	negated escaped hyphen
ok '------' !~~ /<-[\-]>/, 'negated escaped hyphen';

#### <[\-+]>			ab-def		y	escaped hyphen in range
#?pugs todo 
ok 'ab-def' ~~ /<[\-+]>/, 'escaped hyphen in range';

#### <[\-+]>			ab+def		y	escaped hyphen in range
#?pugs todo 
ok 'ab+def' ~~ /<[\-+]>/, 'escaped hyphen in range';

#### <[\-+]>			abcdef		n	escaped hyphen in range
ok 'abcdef' !~~ /<[\-+]>/, 'escaped hyphen in range';

#### <[+\-]>			ab-def		y	escaped hyphen in range
#?pugs todo 
ok 'ab-def' ~~ /<[+\-]>/, 'escaped hyphen in range';

#### <[+\-]>			ab+def		y	escaped hyphen in range
#?pugs todo 
ok 'ab+def' ~~ /<[+\-]>/, 'escaped hyphen in range';

#### <[+\-]>			abcdef		n	escaped hyphen in range
ok 'abcdef' !~~ /<[+\-]>/, 'escaped hyphen in range';

#### <-[\-+]>		---x--		y	negated escaped hyphen in range
#?pugs todo 
ok '---x--' ~~ /<-[\-+]>/, 'negated escaped hyphen in range';

#### <-[\-+]>		------		n	negated escaped hyphen in range
ok '------' !~~ /<-[\-+]>/, 'negated escaped hyphen in range';

#### <-[+\-]>		---x--		y	negated escaped hyphen in range
#?pugs todo 
ok '---x--' ~~ /<-[+\-]>/, 'negated escaped hyphen in range';

#### <-[+\-]>		------		n	negated escaped hyphen in range
ok '------' !~~ /<-[+\-]>/, 'negated escaped hyphen in range';

#### <["\\]>			\\			y	escaped backslash
#?pugs todo 
ok '\\' ~~ /<["\\]>/, 'escaped backslash';

#### <[\]]>			]			y	escaped close bracket
#?pugs todo 
ok ']' ~~ /<[\]]>/, 'escaped close bracket';

#### <[\]>			\\]]		/parse error/	unescaped backslash (or no closing brace)
#?pugs todo 
eval_dies_ok ' /<[\]>/ ', 'unescaped backslash (or no closing brace)';

#### ^\><[<]>		><		y	lt character class
#?pugs todo 
ok '><' ~~ /^\><[<]>/, 'lt character class';

#### ^<[>]>\<		><		y	gt character class
#?pugs todo 
ok '><' ~~ /^<[>]>\</, 'gt character class';

#### ^<[><]>**{2}		><		y	gt, lt character class
#?pugs todo 
#?rakudo skip '**{}'
ok '><' ~~ /^<[><]>**{2}/, 'gt, lt character class';

#### ^<[<>]>**{2}		><		y	lt, gt  character class
#?pugs todo 
#?rakudo skip '**{}'
ok '><' ~~ /^<[<>]>**{2}/, 'lt, gt  character class';

#### ^<-[><]>		><		n	not gt, lt character class
ok '><' !~~ /^<-[><]>/, 'not gt, lt character class';

#### ^<-[<>]>		><		n	not lt, gt  character class
ok '><' !~~ /^<-[<>]>/, 'not lt, gt  character class';

#### '... --- ...'		... --- ...	y	literal match (\\\')
#?pugs todo 
ok '... --- ...' ~~ /'... --- ...'/, 'literal match (\\\')';

#### '... --- ...'		...---...	n	literal match (\\\')
ok '...---...' !~~ /'... --- ...'/, 'literal match (\\\')';

#### 'ab\'>cd'		ab\'>cd		y	literal match with quote
#?pugs todo 
ok 'ab\'>cd' ~~ /'ab\'>cd'/, 'literal match with quote';

#### 'ab\\yz'		ab\x5cyz	y	literal match with backslash
#?pugs todo 
ok "ab\x5cyz" ~~ /'ab\\yz'/, 'literal match with backslash';

#### 'ab"cd'			ab"cd		y	literal match with quote
#?pugs todo 
ok 'ab"cd' ~~ /'ab"cd'/, 'literal match with quote';

#### 'ab\\yz'		ab\x5cyz	y	literal match with backslash
#?pugs todo 
ok "ab\x5cyz" ~~ /'ab\\yz'/, 'literal match with backslash';

#### "... --- ..."		... --- ...	y	literal match (\")
#?pugs todo 
ok '... --- ...' ~~ /"... --- ..."/, 'literal match (\")';

#### "... --- ..."		...---...	n	literal match (\")
# RT #64880
ok '...---...' !~~ /"... --- ..."/, 'literal match (\")';

#### "ab<\">cd"		ab<">cd		y	literal match with quote
# RT #64880
#?pugs todo 
ok 'ab<">cd' ~~ /"ab<\">cd"/, 'literal match with quote';

#### "ab<'>cd"		ab<\'>cd		y	literal match with quote
# RT #64880
#?pugs todo 
ok 'ab<\'>cd' ~~ /"ab<'>cd"/, 'literal match with quote';

#### "ab\\cd"		ab\x5ccd	y	literal match with backslash
#?rakudo todo 'unknown'
#?niecza todo ''
#?pugs todo 
ok "ab\x5ccd" ~~ /"ab\\cd"/, 'literal match with backslash';

#### (ab)x"$0"		abxab		y	literal match with interpolation
#?rakudo todo 'unknown'
#?pugs todo 
ok 'abxab' ~~ /(ab)x"$0"/, 'literal match with interpolation';

#### (ab)"x$0"		abxab		y	literal match with interpolation
#?rakudo todo 'unknown'
#?pugs todo 
ok 'abxab' ~~ /(ab)"x$0"/, 'literal match with interpolation';

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading ? indicates">
#
#### '?'			ab<?		y	literal match with question mark
#?pugs todo 
ok 'ab<?' ~~ /'?'/, 'literal match with question mark';

#### '<'			ab<?		y	literal match with lt 
#?pugs todo 
ok 'ab<?' ~~ /'<'/, 'literal match with lt ';

#### '<?'			ab<?		y	literal match with lt and question mark
#?pugs todo 
ok 'ab<?' ~~ /'<?'/, 'literal match with lt and question mark';

#### '<?'			ab<x?		n	non-matching literal match 
ok 'ab<x?' !~~ /'<?'/, 'non-matching literal match ';

#### <[A..Z0..9]>		abcdef		n	two enumerated ranges
ok 'abcdef' !~~ /<[A..Z0..9]>/, 'two enumerated ranges';

#### <[A..Z0..9]>		abcDef		y	two enumerated ranges
#?pugs todo 
ok 'abcDef' ~~ /<[A..Z0..9]>/, 'two enumerated ranges';


# L<S05/Extensible metasyntax (C<< <...> >>)/"The special named assertions">
#
## lookarounds
#### <before .d> a.		abacad		/mob: <ad @ 4>/			lookahead <before>
#?pugs todo 
ok ('abacad' ~~ /<before .d> a./) && matchcheck($/, q/mob: <ad @ 4>/), 'lookahead <before>';

#### <before c> ....		abacad		n				lookahead <before>
ok 'abacad' !~~ /<before c> ..../, 'lookahead <before>';

#### <before> .		abcd		n				null <before>
#?pugs todo 
eval_dies_ok "'abcd' !~~ /<before> ./", 'null <before>';

#### <!before ..b> aa	aabaaa		/mob: <aa @ 3>/			negated lookahead
#?pugs todo 
ok ('aabaaa' ~~ /<!before ..b> aa/) && matchcheck($/, q/mob: <aa @ 3>/), 'negated lookahead';

#### <after a>b		ab		y				lookbehind <after>
#?pugs todo 
ok 'ab' ~~ /<after a>b/, 'lookbehind <after>';

#### <after a>b		cb		n				lookbehind <after>
ok 'cb' !~~ /<after a>b/, 'lookbehind <after>';

#### <after a>b		b		n				lookbehind <after>
ok 'b' !~~ /<after a>b/, 'lookbehind <after>';

#### <!after c>b		ab		y				lookbehind <!after>
#?pugs todo 
ok 'ab' ~~ /<!after c>b/, 'lookbehind <!after>';

#### <!after c>b		cb		n				lookbehind <!after>
ok 'cb' !~~ /<!after c>b/, 'lookbehind <!after>';

#### <!after c>b		b		y				lookbehind <!after>
#?pugs todo 
ok 'b' ~~ /<!after c>b/, 'lookbehind <!after>';

#### <!after <[cd]>>b	dbcb		n				lookbehind <!after>
ok 'dbcb' !~~ /<!after <[cd]>>b/, 'lookbehind <!after>';

#### <!after <[cd]>><[ab]>	dbaacb		y				lookbehind <!after>
#?pugs todo 
ok 'dbaacb' ~~ /<!after <[cd]>><[ab]>/, 'lookbehind <!after>';

#### <!after c|d>b		dbcb		n				lookbehind <!after>
#?niecza skip "Unsuppored elements in after list"
ok 'dbcb' !~~ /<!after c|d>b/, 'lookbehind <!after>';

#### <!after c|d><[ab]>	dbaacb		y				lookbehind <!after>
#?niecza skip "Unsuppored elements in after list"
#?pugs todo 
ok 'dbaacb' ~~ /<!after c|d><[ab]>/, 'lookbehind <!after>';

#### <!after cd><[ab]>	cbaccb		y				lookbehind <!after>
#?pugs todo 
ok 'cbaccb' ~~ /<!after cd><[ab]>/, 'lookbehind <!after>';

#### $ <after ^a>		a		y				lookbehind <after>
#?rakudo todo 'anchors and after'
#?niecza skip "Unsuppored elements in after list"
#?pugs todo 
ok 'a' ~~ /$ <after ^a>/, 'lookbehind <after>';

#### <after x+>y		axxbxxyc	y				lookbehind <after>
#?niecza skip "Unsuppored elements in after list"
#?pugs todo 
ok 'axxbxxyc' ~~ /<after x+>y/, 'lookbehind <after>';

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading + may also">

#### <[a..z]>+		az		y				metasyntax with leading + (<+...>)
#?pugs todo 
ok 'az' ~~ /<[a..z]>+/, 'metasyntax with leading + (<+...>)';

#### <+[a..z]>+		az		y				metasyntax with leading + (<+...>)
#?pugs todo 
ok 'az' ~~ /<+[a..z]>+/, 'metasyntax with leading + (<+...>)';

#### <+alpha>+		az		y				metasyntax with leading + (<+...>)
#?pugs todo 
ok 'az' ~~ /<+alpha>+/, 'metasyntax with leading + (<+...>)';


#### a[b}		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/rule error/	mismatched close
#?pugs todo 
eval_dies_ok '/a[b}/', 'mismatched close';


#### c <before .d>		abacad		/mob: <c @ 3>/				one character and lookahead <before>
#?pugs todo 
ok ('abacad' ~~ /c <before .d>/) && matchcheck($/, q/mob: <c @ 3>/), 'one character and lookahead <before>';

#### .* <before .d>		abacad		/mob: <abac @ 0>/			multiple characters and lookahead <before>
#?pugs todo 
ok ('abacad' ~~ /.* <before .d>/) && matchcheck($/, q/mob: <abac @ 0>/), 'multiple characters and lookahead <before>';

#### .* <before .\<>		abaca<d		/mob: <abac @ 0>/			multiple characters and lookahead <before> with a \'<\'
#?pugs todo 
ok ('abaca<d' ~~ /.* <before .\<>/) && matchcheck($/, q/mob: <abac @ 0>/), 'multiple characters and lookahead <before> with a \'<\'';

#### .* <before \<>		aba<ca<d		/mob: <aba<ca @ 0>/		greedy any character and lookahead <before> with a \'<\'
#?pugs todo 
ok ('aba<ca<d' ~~ /.* <before \<>/) && matchcheck($/, q/mob: <aba<ca @ 0>/), 'greedy any character and lookahead <before> with a \'<\'';

#### .*? <before \<>		aba<ca<d		/mob: <aba @ 0>/		non-greedy any character and lookahead <before> with a \'<\'
#?pugs todo 
ok ('aba<ca<d' ~~ /.*? <before \<>/) && matchcheck($/, q/mob: <aba @ 0>/), 'non-greedy any character and lookahead <before> with a \'<\'';


##   Metacharacter tests
#### .			a		y	dot (.)
#?pugs todo 
ok 'a' ~~ /./, 'dot (.)';

#### .			\n		y	dot (.)
#?pugs todo 
ok '\n' ~~ /./, 'dot (.)';

#### .			''		n	dot (.)
ok '' !~~ /./, 'dot (.)';

#### a\s+f			abcdef		n	whitespace (\s)
ok 'abcdef' !~~ /a\s+f/, 'whitespace (\s)';

#### ab\s+cdef		ab  cdef	y	whitespace (\s)
#?pugs todo 
ok 'ab  cdef' ~~ /ab\s+cdef/, 'whitespace (\s)';

#### a\S+f			abcdef		y	not whitespace (\S)
#?pugs todo 
ok 'abcdef' ~~ /a\S+f/, 'not whitespace (\S)';

#### a\S+f			ab cdef		n	not whitespace (\S)
ok 'ab cdef' !~~ /a\S+f/, 'not whitespace (\S)';

#### ^ abc			abcdef		y	start and end of string (^)
#?pugs todo 
ok 'abcdef' ~~ /^ abc/, 'start and end of string (^)';

#### ^ abc			abc\ndef	y	start and end of string (^)
#?pugs todo 
ok "abc\ndef" ~~ /^ abc/, 'start and end of string (^)';

#### ^ abc			def\nabc	n	start and end of string (^)
ok "def\nabc" !~~ /^ abc/, 'start and end of string (^)';

#### def \n ^ abc		def\nabc	n	start and end of string (^)
ok "def\nabc" !~~ /def \n ^ abc/, 'start and end of string (^)';

#### def $			abcdef		y	start and end of string ($)
#?pugs todo 
ok 'abcdef' ~~ /def $/, 'start and end of string ($)';

#### def $			abc\ndef	y	start and end of string ($)
#?pugs todo 
ok "abc\ndef" ~~ /def $/, 'start and end of string ($)';

#### def $			def\nabc	n	start and end of string ($)
ok "def\nabc" !~~ /def $/, 'start and end of string ($)';

#### def $ \n abc		def\nabc	n	start and end of string (^)
ok "def\nabc" !~~ /def $ \n abc/, 'start and end of string (^)';

#### abc \n $		abc\n		y	end of string ($)
#?pugs todo 
ok "abc\n" ~~ /abc \n $/, 'end of string ($)';

#### abc $			abc\n		n	end of string ($)
ok "abc\n" !~~ /abc $/, 'end of string ($)';

#### <<def			abc-def		y	left word boundary, beginning of word
#?pugs todo 
ok 'abc-def' ~~ /<<def/, 'left word boundary, beginning of word';

#### <<bc			abc-def		n	left word boundary, mid-word
ok 'abc-def' !~~ /<<bc/, 'left word boundary, mid-word';

#### c<<			abc-def		n	left word boundary, end of word
ok 'abc-def' !~~ /c<</, 'left word boundary, end of word';

#### <<abc			abc-def		y	left word boundary, BOS
#?pugs todo 
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
#?pugs todo 
ok 'abc-def' ~~ /c>>/, 'right word boundary, end of word';

#### >>abc			abc-def		n	right word boundary, BOS
ok 'abc-def' !~~ />>abc/, 'right word boundary, BOS';

#### def>>			abc-def		y	right word boundary, EOS
#?pugs todo 
ok 'abc-def' ~~ /def>>/, 'right word boundary, EOS';

#### >>			-------		n	right word boundary, no word chars
ok '-------' !~~ />>/, 'right word boundary, no word chars';


#### c \n d			abc\ndef	y	logical newline (\n)
#?pugs todo 
ok "abc\ndef" ~~ /c \n d/, 'logical newline (\n)';

#### c \n d			abc\rdef	y	logical newline matches \r
#?pugs todo 
ok "abc\rdef" ~~ /c \n d/, 'logical newline matches \r';

#### c \n+ d			abc\n\ndef	y	logical newline quantified
#?pugs todo 
ok "abc\n\ndef" ~~ /c \n+ d/, 'logical newline quantified';

#### a\n+f			abcdef		n	logical newline (\n)
ok 'abcdef' !~~ /a\n+f/, 'logical newline (\n)';

#### c \n d			abc\n\rdef	n	logical newline matches \n\r
ok "abc\n\rdef" !~~ /c \n d/, 'logical newline matches \n\r';

#### c \n d			abc\r\ndef	y	logical newline matches \r\n
#?pugs todo 
ok "abc\r\ndef" ~~ /c \n d/, 'logical newline matches \r\n';

#### b \n c			abc\ndef	n	logical newline (\n)
ok "abc\ndef" !~~ /b \n c/, 'logical newline (\n)';

#### \N			a		y	not logical newline (\N)
#?pugs todo 
ok 'a' ~~ /\N/, 'not logical newline (\N)';

#### a \N c			abc		y	not logical newline (\N)
#?pugs todo 
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
#?pugs todo 
ok 'abcdef' ~~ /a\N+f/, 'not logical newline (\N)';

#### c \N d			abc\n\rdef	n	not logical newline (\N)
ok "abc\n\rdef" !~~ /c \N d/, 'not logical newline (\N)';

#### c \N d			abc\r\ndef	n	not logical newline (\N)
ok "abc\r\ndef" !~~ /c \N d/, 'not logical newline (\N)';

#### b \N \n			abc\ndef	y	not logical newline (\N)
#?pugs todo 
ok "abc\ndef" ~~ /b \N \n/, 'not logical newline (\N)';

#### \Aabc			Aabc		/reserved/	retired metachars (\A)
#?pugs todo 
eval_dies_ok '/\Aabc/', 'retired metachars (\A)';

#### \Aabc			abc\ndef	/reserved/	retired metachars (\A)
#?pugs todo 
eval_dies_ok '/\Aabc/', 'retired metachars (\A)';

#### abc\Z			abcZ		/reserved/	retired metachars (\Z)
#?pugs todo 
eval_dies_ok '/abc\Z/', 'retired metachars (\Z)';

#### abc\Z			abc\ndef	/reserved/	retired metachars (\Z)
#?pugs todo 
eval_dies_ok '/abc\Z/', 'retired metachars (\Z)';

#### abc\z			abcz		/reserved/	retired metachars (\z)
#?pugs todo 
eval_dies_ok '/abc\z/', 'retired metachars (\z)';

#### def\z			abc\ndef	/reserved|Obsolete|Unsupported/	retired metachars (\z)
#?pugs todo 
eval_dies_ok '/def\z/', 'retired metachars (\z)';

#### abc # def		abc#def		y	comments (#)
#?pugs todo 
ok 'abc#def' ~~ /abc # def
/, 'comments (#)';

#### abc # xyz		abc#def		y	comments (#)
#?pugs todo 
ok 'abc#def' ~~ /abc # xyz
/, 'comments (#)';

#### abc # def \n \$		abc#def		y	comments (#)
#?pugs todo 
ok 'abc#def' ~~ /abc # def \n \$
/, 'comments (#)';

#### abc '#' def		abc#def		y	comments (#)
#?pugs todo 
ok 'abc#def' ~~ /abc '#' def
/, 'comments (#)';

#### abc '#' xyz		abc#def		n	comments (#)
ok 'abc#def' !~~ /abc '#' xyz
/, 'comments (#)';

#### ^ abc '#' def $		abc#def		y	comments (#)
#?pugs todo 
ok 'abc#def' ~~ /^ abc '#' def $
/, 'comments (#)';

#### ^^ abc \n ^^ def	abc\ndef	y	line beginnings and endings (^^)
#?pugs todo 
ok "abc\ndef" ~~ /^^ abc \n ^^ def/, 'line beginnings and endings (^^)';

#### ^^ abc \n ^^ def \n ^^	abc\ndef\n	n	line beginnings and endings (^^)
ok "abc\ndef\n" !~~ /^^ abc \n ^^ def \n ^^/, 'line beginnings and endings (^^)';

#### ^^ \n			\n		y	line beginnings and endings (^^)
#?pugs todo 
ok "\n" ~~ /^^ \n/, 'line beginnings and endings (^^)';

#### \n ^^			\n		n	line beginnings and endings (^^)
ok "\n" !~~ /\n ^^/, 'line beginnings and endings (^^)';

#### abc $$ \n def $$	abc\ndef	y	line beginnings and endings ($$)
#?pugs todo 
ok "abc\ndef" ~~ /abc $$ \n def $$/, 'line beginnings and endings ($$)';

#### abc $$ \n def $$ \n $$	abc\ndef\n	n	line beginnings and endings ($$)
ok "abc\ndef\n" !~~ /abc $$ \n def $$ \n $$/, 'line beginnings and endings ($$)';

#### $$ \n			\n		y	line beginnings and endings ($$)
#?pugs todo 
ok "\n" ~~ /$$ \n/, 'line beginnings and endings ($$)';

#### \n $$			\n		n	line beginnings and endings ($$)
ok "\n" !~~ /\n $$/, 'line beginnings and endings ($$)';

#### <[a..d]> | <[b..e]>	c		y	alternation (|)
#?pugs todo 
ok 'c' ~~ /<[a..d]> | <[b..e]>/, 'alternation (|)';

#### <[a..d]> | <[d..e]>	c		y	alternation (|)
#?pugs todo 
ok 'c' ~~ /<[a..d]> | <[d..e]>/, 'alternation (|)';

#### <[a..b]> | <[b..e]>	c		y	alternation (|)
#?pugs todo 
ok 'c' ~~ /<[a..b]> | <[b..e]>/, 'alternation (|)';

#### <[a..b]> | <[d..e]>	c		n	alternation (|)
ok 'c' !~~ /<[a..b]> | <[d..e]>/, 'alternation (|)';

#### <[a..d]>+ | <[b..e]>+	bcd		y	alternation (|)
#?pugs todo 
ok 'bcd' ~~ /<[a..d]>+ | <[b..e]>+/, 'alternation (|)';

#### ^ [ <[a..d]>+ | <[b..e]>+ ] $	bcd		y	alternation (|)
#?pugs todo 
ok 'bcd' ~~ /^ [ <[a..d]>+ | <[b..e]>+ ] $/, 'alternation (|)';

#### ^ [ <[a..c]>+ | <[b..e]>+ ] $	bcd		y	alternation (|)
#?pugs todo 
ok 'bcd' ~~ /^ [ <[a..c]>+ | <[b..e]>+ ] $/, 'alternation (|)';

#### ^ [ <[a..d]>+ | <[c..e]>+ ] $	bcd		y	alternation (|)
#?pugs todo 
ok 'bcd' ~~ /^ [ <[a..d]>+ | <[c..e]>+ ] $/, 'alternation (|)';

#### b|			bcd		/rule error/	alternation (|) - null right arg illegal
#?pugs todo 
eval_dies_ok '/b|/', 'alternation (|) - null right arg illegal';

#### |b			bcd		y	alternation (|) - null left arg ignored
#?pugs todo 
ok 'bcd' ~~ /|b/, 'alternation (|) - null left arg ignored';

#### |			bcd		/rule error/	alternation (|) - null both args illegal
#?pugs todo 
eval_dies_ok '/|/', 'alternation (|) - null both args illegal';

#### \|			|		y	alternation (|) - literal must be escaped
#?pugs todo 
ok '|' ~~ /\|/, 'alternation (|) - literal must be escaped';

#### |			|		/rule error/	alternation (|) - literal must be escaped
#?pugs todo 
eval_dies_ok '/|/', 'alternation (|) - literal must be escaped';

#### <[a..d]> & <[b..e]>	c		y	conjunction (&)
#?niecza todo ''
#?pugs todo 
ok 'c' ~~ /<[a..d]> & <[b..e]>/, 'conjunction (&)';

#### <[a..d]> & <[d..e]>	c		n	conjunction (&)
ok 'c' !~~ /<[a..d]> & <[d..e]>/, 'conjunction (&)';

#### <[a..b]> & <[b..e]>	c		n	conjunction (&)
ok 'c' !~~ /<[a..b]> & <[b..e]>/, 'conjunction (&)';

#### <[a..b]> & <[d..e]>	c		n	conjunction (&)
ok 'c' !~~ /<[a..b]> & <[d..e]>/, 'conjunction (&)';

#### <[a..d]>+ & <[b..e]>+	bcd		y	conjunction (&)
#?pugs todo 
ok 'bcd' ~~ /<[a..d]>+ & <[b..e]>+/, 'conjunction (&)';

#### ^ [ <[a..d]>+ & <[b..e]>+ ] $	bcd		y	conjunction (&)
#?pugs todo 
ok 'bcd' ~~ /^ [ <[a..d]>+ & <[b..e]>+ ] $/, 'conjunction (&)';

#### <[a..c]>+ & <[b..e]>+	bcd		y	conjunction (&)
#?pugs todo 
ok 'bcd' ~~ /<[a..c]>+ & <[b..e]>+/, 'conjunction (&)';

#### <[a..d]>+ & <[c..e]>+	bcd		y	conjunction (&)
#?pugs todo 
ok 'bcd' ~~ /<[a..d]>+ & <[c..e]>+/, 'conjunction (&)';

#### b&			bcd		/rule error/	conjunction (&) - null right arg illegal
#?pugs todo 
eval_dies_ok '/b&/', 'conjunction (&) - null right arg illegal';

#### &b			bcd		/rule error/	conjunction (&) - null left arg illegal
#?rakudo todo 'infix:<S&>'
#?niecza todo ''
#?pugs todo 
eval_dies_ok '/&b/', 'conjunction (&) - null left arg illegal';

#### &			bcd		/rule error/	conjunction (&) - null both args illegal
#?pugs todo 
eval_dies_ok '/&/', 'conjunction (&) - null both args illegal';

#### \&			&		y	conjunction (&) - literal must be escaped
#?pugs todo 
ok '&' ~~ /\&/, 'conjunction (&) - literal must be escaped';

#### &			&		/rule error/	conjunction (&) - literal must be escaped
#?pugs todo 
eval_dies_ok '/&/', 'conjunction (&) - literal must be escaped';

# todo :pge<leading |>
#### a&|b			a&|b		/rule error/	alternation and conjunction (&|) - parse error
#?pugs todo 
eval_dies_ok '/a&|b/', 'alternation and conjunction (&|) - parse error';

#### a|&b			a|&b		/rule error/	alternation and conjunction (|&) - parse error
#?pugs todo 
#?rakudo todo 'regression - RT 111796'
eval_dies_ok '/a|&b/', 'alternation and conjunction (|&) - parse error';

#### |d|b			abc		y	leading alternation ignored
#?pugs todo 
ok 'abc' ~~ /|d|b/, 'leading alternation ignored';

####  |d|b			abc		y	leading alternation ignored
#?pugs todo 
ok 'abc' ~~ / |d|b/, 'leading alternation ignored';

#### |d |b			abc		y	leading alternation ignored
#?pugs todo 
ok 'abc' ~~ /|d |b/, 'leading alternation ignored';

####  | d | b		abc		y	leading alternation ignored
#?pugs todo 
ok 'abc' ~~ / | d | b/, 'leading alternation ignored';

####  b |  | d		abc		n	null pattern invalid
#?rakudo todo 'nom regression'
#?pugs todo 
eval_dies_ok '/ b |  | d/', 'null pattern invalid';

#### \pabc			pabc		/reserved/	retired metachars (\p)
#?pugs todo 
eval_dies_ok '/\pabc/', 'retired metachars (\p)';

#### \p{InConsonant}		a		/reserved/	retired metachars (\p)
#?pugs todo 
eval_dies_ok '/\p{InConsonant}/', 'retired metachars (\p)';

#### \Pabc			Pabc		/reserved/	retired metachars (\P)
#?pugs todo 
eval_dies_ok '/\Pabc/', 'retired metachars (\P)';

#### \P{InConsonant}		a		/reserved/	retired metachars (\P)
#?pugs todo 
eval_dies_ok '/\P{InConsonant}/', 'retired metachars (\P)';

#### \Labc\E			LabcE		/reserved/	retired metachars (\L...\E)
#?pugs todo 
eval_dies_ok '/\Labc\E/', 'retired metachars (\L...\E)';

#### \LABC\E			abc		/reserved/	retired metachars (\L...\E)
#?pugs todo 
eval_dies_ok '/\LABC\E/', 'retired metachars (\L...\E)';

#### \Uabc\E			UabcE		/reserved/	retired metachars (\U...\E)
#?pugs todo 
eval_dies_ok '/\Uabc\E/', 'retired metachars (\U...\E)';

#### \Uabc\E			ABC		/reserved/	retired metachars (\U...\E)
#?pugs todo 
eval_dies_ok '/\Uabc\E/', 'retired metachars (\U...\E)';

#### \Qabc\E			QabcE		/reserved/	retired metachars (\Q...\E)
#?pugs todo 
eval_dies_ok '/\Qabc\E/', 'retired metachars (\Q...\E)';

#### \Qabc d?\E		abc d		/reserved/	retired metachars (\Q...\E)
#?pugs todo 
eval_dies_ok '/\Qabc d?\E/', 'retired metachars (\Q...\E)';

#### \Gabc			Gabc		/reserved/	retired metachars (\G)
#?pugs todo 
eval_dies_ok '/\Gabc/', 'retired metachars (\G)';

#### \1abc			1abc		/reserved/	retired metachars (\1)
#?pugs todo 
eval_dies_ok '/\1abc/', 'retired metachars (\1)';

#### ^ \s+ $			\x0009\x0020\x00a0\x000a\x000b\x000c\x000d\x0085	y	0-255 whitespace (\s)
#?pugs todo 
ok "\x0009\x0020\x00a0\x000a\x000b\x000c\x000d\x0085" ~~ /^ \s+ $/, '0-255 whitespace (\s)';

#### ^ \h+ $			\x0009\x0020\x00a0	y	0-255 horizontal whitespace (\h)
#?pugs todo 
ok "\x0009\x0020\x00a0" ~~ /^ \h+ $/, '0-255 horizontal whitespace (\h)';

#### ^ \V+ $			\x0009\x0020\x00a0	y	0-255 horizontal whitespace (\V)
#?pugs todo 
ok "\x0009\x0020\x00a0" ~~ /^ \V+ $/, '0-255 horizontal whitespace (\V)';

#### ^ \v+ $			\x000a\x000b\x000c\x000d\x0085	y	0-255 vertical whitespace (\v)
#?pugs todo 
ok "\x000a\x000b\x000c\x000d\x0085" ~~ /^ \v+ $/, '0-255 vertical whitespace (\v)';

#### ^ \h+ $			\x000a\x000b\x000c\x000d\x0085	n	0-255 horizontal whitespace (\h)
ok "\x000a\x000b\x000c\x000d\x0085" !~~ /^ \h+ $/, '0-255 horizontal whitespace (\h)';

#### ^ \v+ $			\x0009\x0020\x00a0	n	0-255 vertical whitespace (\v)
ok "\x0009\x0020\x00a0" !~~ /^ \v+ $/, '0-255 vertical whitespace (\v)';

#### ^ \s+ $			\x1680\x180e\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000	y	unicode whitespace (\s)
#?pugs todo 
ok "\x1680\x180e\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000" ~~ /^ \s+ $/, 'unicode whitespace (\s)';

#### ^ \h+ $			\x1680\x180e\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000	y	unicode whitespace (\h)
#?pugs todo 
ok "\x1680\x180e\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000" ~~ /^ \h+ $/, 'unicode whitespace (\h)';

#### ^ \V+ $			\x1680\x180e\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000	y	unicode whitespace (\V)
#?pugs todo 
ok "\x1680\x180e\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000" ~~ /^ \V+ $/, 'unicode whitespace (\V)';

#### ^ \v+ $			\x1680\x180e\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000	n	unicode whitespace (\v)
ok "\x1680\x180e\x2000\x2001\x2002\x2003\x2004\x2005\x2006\x2007\x2008\x2008\x2009\x200a\x202f\x205f\x3000" !~~ /^ \v+ $/, 'unicode whitespace (\v)';

#### c \t d			abc\tdef	y	horizontal tab (\t)
#?pugs todo 
ok "abc\tdef" ~~ /c \t d/, 'horizontal tab (\t)';

#### c \t+ d			abc\t\tdef	y	horizontal tab (\t)
#?pugs todo 
ok "abc\t\tdef" ~~ /c \t+ d/, 'horizontal tab (\t)';

#### a \t+ f			abcdef		n	horizontal tab (\t)
ok 'abcdef' !~~ /a \t+ f/, 'horizontal tab (\t)';

#### b \t c			abc\tdef	n	horizontal tab (\t)
ok "abc\tdef" !~~ /b \t c/, 'horizontal tab (\t)';

#### \T			a		y	not horizontal tab (\T)
#?pugs todo 
ok 'a' ~~ /\T/, 'not horizontal tab (\T)';

#### a \T c			abc		y	not horizontal tab (\T)
#?pugs todo 
ok 'abc' ~~ /a \T c/, 'not horizontal tab (\T)';

#### \T			''		n	not horizontal tab (\T)
ok '' !~~ /\T/, 'not horizontal tab (\T)';

#### c \T d			abc\tdef	n	not horizontal tab (\T)
ok "abc\tdef" !~~ /c \T d/, 'not horizontal tab (\T)';

#### c \T+ d			abc\t\tdef	n	not horizontal tab (\T)
ok "abc\t\tdef" !~~ /c \T+ d/, 'not horizontal tab (\T)';

#### a \T+ f			abcdef		y	not horizontal tab (\T)
#?pugs todo 
ok "abcdef" ~~ /a \T+ f/, 'not horizontal tab (\T)';

#### c \r d			abc\rdef	y	return (\r)
#?pugs todo 
ok "abc\rdef" ~~ /c \r d/, 'return (\r)';

#### c \r+ d			abc\r\rdef	y	return (\r)
#?pugs todo 
ok "abc\r\rdef" ~~ /c \r+ d/, 'return (\r)';

#### a \r+ f			abcdef		n	return (\r)
ok 'abcdef' !~~ /a \r+ f/, 'return (\r)';

#### b \r c			abc\rdef	n	return (\r)
ok "abc\rdef" !~~ /b \r c/, 'return (\r)';

#### \R			a		y	not return (\R)
#?pugs todo 
ok 'a' ~~ /\R/, 'not return (\R)';

#### a \R c			abc		y	not return (\R)
#?pugs todo 
ok 'abc' ~~ /a \R c/, 'not return (\R)';

#### \R			''		n	not return (\R)
ok '' !~~ /\R/, 'not return (\R)';

#### c \R d			abc\rdef	n	not return (\R)
ok "abc\rdef" !~~ /c \R d/, 'not return (\R)';

#### c \R+ d			abc\r\rdef	n	not return (\R)
ok "abc\r\rdef" !~~ /c \R+ d/, 'not return (\R)';

#### a \R+ f			abcdef		y	not return (\R)
#?pugs todo 
ok 'abcdef' ~~ /a \R+ f/, 'not return (\R)';

#### c \f d			abc\fdef	y	formfeed (\f)
#?pugs todo 
ok "abc\fdef" ~~ /c \f d/, 'formfeed (\f)';

#### c \f+ d			abc\f\fdef	y	formfeed (\f)
#?pugs todo 
ok "abc\f\fdef" ~~ /c \f+ d/, 'formfeed (\f)';

#### a \f+ f			abcdef		n	formfeed (\f)
ok 'abcdef' !~~ /a \f+ f/, 'formfeed (\f)';

#### b \f c			abc\fdef	n	formfeed (\f)
ok "abc\fdef" !~~ /b \f c/, 'formfeed (\f)';

#### \F			a		y	not formfeed (\F)
#?pugs todo 
ok 'a' ~~ /\F/, 'not formfeed (\F)';

#### a \F c			abc		y	not formfeed (\F)
#?pugs todo 
ok 'abc' ~~ /a \F c/, 'not formfeed (\F)';

#### \F			''		n	not formfeed (\F)
ok '' !~~ /\F/, 'not formfeed (\F)';

#### c \F d			abc\fdef	n	not formfeed (\F)
ok "abc\fdef" !~~ /c \F d/, 'not formfeed (\F)';

#### c \F+ d			abc\f\fdef	n	not formfeed (\F)
ok "abc\f\fdef" !~~ /c \F+ d/, 'not formfeed (\F)';

#### a \F+ f			abcdef		y	not formfeed (\F)
#?pugs todo 
ok 'abcdef' ~~ /a \F+ f/, 'not formfeed (\F)';

#### c \e d			abc\edef	y	escape (\e)
#?pugs todo 
ok "abc\edef" ~~ /c \e d/, 'escape (\e)';

#### c \e+ d			abc\e\edef	y	escape (\e)
#?pugs todo 
ok "abc\e\edef" ~~ /c \e+ d/, 'escape (\e)';

#### a \e+ f			abcdef		n	escape (\e)
ok 'abcdef' !~~ /a \e+ f/, 'escape (\e)';

#### b \e c			abc\edef	n	escape (\e)
ok "abc\edef" !~~ /b \e c/, 'escape (\e)';

#### \E			a		y	not escape (\E)
#?pugs todo 
ok 'a' ~~ /\E/, 'not escape (\E)';

#### a \E c			abc		y	not escape (\E)
#?pugs todo 
ok 'abc' ~~ /a \E c/, 'not escape (\E)';

#### \E			''		n	not escape (\E)
ok '' !~~ /\E/, 'not escape (\E)';

#### c \E d			abc\edef	n	not escape (\E)
ok "abc\edef" !~~ /c \E d/, 'not escape (\E)';

#### c \E+ d			abc\e\edef	n	not escape (\E)
ok "abc\e\edef" !~~ /c \E+ d/, 'not escape (\E)';

#### a \E+ f			abcdef		y	not escape (\E)
#?pugs todo 
ok 'abcdef' ~~ /a \E+ f/, 'not escape (\E)';

#### c \x0021 d		abc!def	y	hex (\x)
#?pugs todo 
ok 'abc!def' ~~ /c \x0021 d/, 'hex (\x)';

#### c \x0021+ d		abc!!def	y	hex (\x)
#?pugs todo 
ok 'abc!!def' ~~ /c \x0021+ d/, 'hex (\x)';

#### a \x0021+ f		abcdef		n	hex (\x)
ok 'abcdef' !~~ /a \x0021+ f/, 'hex (\x)';

#### b \x0021 c		abc!def		n	hex (\x)
ok 'abc!def' !~~ /b \x0021 c/, 'hex (\x)';

#### c \x[0021] d		abc!def		y	hex (\x[])
#?pugs todo 
ok 'abc!def' ~~ /c \x[0021] d/, 'hex (\x[])';

#### c \x[0021]+ d		abc!!def	y	hex (\x[])
#?pugs todo 
ok 'abc!!def' ~~ /c \x[0021]+ d/, 'hex (\x[])';

#### c \x[21,21] d		abc!!def	y	hex (\x[])
#?pugs todo 
ok 'abc!!def' ~~ /c \x[21,21] d/, 'hex (\x[])';

#### a \x[0021]+ f		abcdef		n	hex (\x[])
ok 'abcdef' !~~ /a \x[0021]+ f/, 'hex (\x[])';

#### b \x[0021] c		abc!def		n	hex (\x[])
ok 'abc!def' !~~ /b \x[0021] c/, 'hex (\x[])';

#### \X0021			a		y	not hex (\X)
#?pugs todo 
ok 'a' ~~ /\X0021/, 'not hex (\X)';

#### a \X0021 c		abc		y	not hex (\X)
#?pugs todo 
ok 'abc' ~~ /a \X0021 c/, 'not hex (\X)';

#### \X0021			''		n	not hex (\X)
ok '' !~~ /\X0021/, 'not hex (\X)';

#### c \X0021 d		abc!def		n	not hex (\X)
ok 'abc!def' !~~ /c \X0021 d/, 'not hex (\X)';

#### c \X0021+ d		abc!!def	n	not hex (\X)
ok 'abc!!def' !~~ /c \X0021+ d/, 'not hex (\X)';

#### a \X0021+ f		abcdef		y	not hex (\X)
#?pugs todo 
ok 'abcdef' ~~ /a \X0021+ f/, 'not hex (\X)';

#### \X[0021]		a		y	not hex (\X[])
#?pugs todo 
ok 'a' ~~ /\X[0021]/, 'not hex (\X[])';

#### a \X[0021] c		abc		y	not hex (\X[])
#?pugs todo 
ok 'abc' ~~ /a \X[0021] c/, 'not hex (\X[])';

#### \X[0021]		''		n	not hex (\X[])
ok '' !~~ /\X[0021]/, 'not hex (\X[])';

#### c \X[0021] d		abc!def		n	not hex (\X[])
ok 'abc!def' !~~ /c \X[0021] d/, 'not hex (\X[])';

#### c \X[0021]+ d		abc!!def	n	not hex (\X[])
ok 'abc!!def' !~~ /c \X[0021]+ d/, 'not hex (\X[])';

#### a \X[0021]+ f		abcdef		y	not hex (\X[])
#?pugs todo 
ok 'abcdef' ~~ /a \X[0021]+ f/, 'not hex (\X[])';

#### c \o041 d		abc!def		y	octal (\o)
#?pugs todo 
ok 'abc!def' ~~ /c \o041 d/, 'octal (\o)';

#### c \o41+ d		abc!!def	y	octal (\o)
#?pugs todo 
ok 'abc!!def' ~~ /c \o41+ d/, 'octal (\o)';

#### a \o41+ f		abcdef		n	octal (\o)
ok 'abcdef' !~~ /a \o41+ f/, 'octal (\o)';

#### b \o41 c		abc!def		n	octal (\o)
ok 'abc!def' !~~ /b \o41 c/, 'octal (\o)';

#### c \o[41] d		abc!def		y	octal (\o[])
#?pugs todo 
ok 'abc!def' ~~ /c \o[41] d/, 'octal (\o[])';

#### c \o[41]+ d		abc!!def	y	octal (\o[])
#?pugs todo 
ok 'abc!!def' ~~ /c \o[41]+ d/, 'octal (\o[])';

#### c \o[41,41] d		abc!!def	y	octal (\o[])
#?pugs todo 
ok 'abc!!def' ~~ /c \o[41,41] d/, 'octal (\o[])';

#### a \o[41]+ f		abcdef		n	octal (\o[])
ok 'abcdef' !~~ /a \o[41]+ f/, 'octal (\o[])';

#### b \o[41] c		abc!def		n	octal (\o[])
ok 'abc!def' !~~ /b \o[41] c/, 'octal (\o[])';

#### \O41			a		y	not octal (\O)
#?pugs todo 
ok 'a' ~~ /\O41/, 'not octal (\O)';

#### a \O41 c		abc		y	not octal (\O)
#?pugs todo 
ok 'abc' ~~ /a \O41 c/, 'not octal (\O)';

#### \O41			''		n	not octal (\O)
ok '' !~~ /\O41/, 'not octal (\O)';

#### c \O41 d		abc!def		n	not octal (\O)
ok 'abc!def' !~~ /c \O41 d/, 'not octal (\O)';

#### c \O41+ d		abc!!def	n	not octal (\O)
ok 'abc!!def' !~~ /c \O41+ d/, 'not octal (\O)';

#### a \O41+ f		abcdef		y	not octal (\O)
#?pugs todo 
ok 'abcdef' ~~ /a \O41+ f/, 'not octal (\O)';

#### \O[41]			a		y	not octal (\O[])
#?pugs todo 
ok 'a' ~~ /\O[41]/, 'not octal (\O[])';

#### a \O[41] c		abc		y	not octal (\O[])
#?pugs todo 
ok 'abc' ~~ /a \O[41] c/, 'not octal (\O[])';

#### \O[41]			''		n	not octal (\O[])
ok '' !~~ /\O[41]/, 'not octal (\O[])';

#### c \O[41] d		abc!def		n	not octal (\O[])
ok 'abc!def' !~~ /c \O[41] d/, 'not octal (\O[])';

#### c \O[41]+ d		abc!!def	n	not octal (\O[])
ok 'abc!!def' !~~ /c \O[41]+ d/, 'not octal (\O[])';

#### a \O[41]+ f		abcdef		y	not octal (\O[])
#?pugs todo 
ok 'abcdef' ~~ /a \O[41]+ f/, 'not octal (\O[])';

#### a\w+f			a=[ *f		n	word character
ok 'a=[ *f' !~~ /a\w+f/, 'word character';

#### a\w+f			abcdef		y	word character
#?pugs todo 
ok 'abcdef' ~~ /a\w+f/, 'word character';

#### a\W+f			a&%- f		y	not word character
#?pugs todo 
ok 'a&%- f' ~~ /a\W+f/, 'not word character';

#### a\W+f			abcdef		n	not word character
ok 'abcdef' !~~ /a\W+f/, 'not word character';

#### a\d+f			abcdef		n	digit
ok 'abcdef' !~~ /a\d+f/, 'digit';

#### ab\d+cdef		ab42cdef	y	digit
#?pugs todo 
ok 'ab42cdef' ~~ /ab\d+cdef/, 'digit';

#### a\D+f			abcdef		y	not digit
#?pugs todo 
ok 'abcdef' ~~ /a\D+f/, 'not digit';

#### a\D+f			ab0cdef		n	not digit
ok 'ab0cdef' !~~ /a\D+f/, 'not digit';


##  modifiers
#### :i bcd			abcdef	y	ignorecase (:i)
#?pugs todo 
ok 'abcdef' ~~ /:i bcd/, 'ignorecase (:i)';

#### :i bcd			aBcdef	y	ignorecase (:i)
#?pugs todo 
ok 'aBcdef' ~~ /:i bcd/, 'ignorecase (:i)';

#### :i bcd			abCdef	y	ignorecase (:i)
#?pugs todo 
ok 'abCdef' ~~ /:i bcd/, 'ignorecase (:i)';

#### :i bcd			abcDef	y	ignorecase (:i)
#?pugs todo 
ok 'abcDef' ~~ /:i bcd/, 'ignorecase (:i)';

#### :i bcd			abc-ef	n	ignorecase (:i)
ok 'abc-ef' !~~ /:i bcd/, 'ignorecase (:i)';

#### :ignorecase bcd		abcdef	y	ignorecase (:ignorecase)
#?pugs todo 
ok 'abcdef' ~~ /:ignorecase bcd/, 'ignorecase (:ignorecase)';

#### :ignorecase bcd		aBCDef	y	ignorecase (:ignorecase)
#?pugs todo 
ok 'aBCDef' ~~ /:ignorecase bcd/, 'ignorecase (:ignorecase)';

#### :ignorecase bcd		abc-ef	n	ignorecase (:ignorecase)
ok 'abc-ef' !~~ /:ignorecase bcd/, 'ignorecase (:ignorecase)';

#### :i(0) bcd		abcdef	y	ignorecase, repetition (:i(0))
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'abcdef' ~~ /:i(0) bcd/, 'ignorecase, repetition (:i(0))';

#### :i(0) bcd		abCdef	n	ignorecase, repetition (:i(0))
#?niecza skip "Action method mod_arg not yet implemented"
ok 'abCdef' !~~ /:i(0) bcd/, 'ignorecase, repetition (:i(0))';

#### :i(1) bcd		abcdef	y	ignorecase, repetition (:i(1))
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'abcdef' ~~ /:i(1) bcd/, 'ignorecase, repetition (:i(1))';

#### :i(1) bcd		abCdef	y	ignorecase, repetition (:i(1))
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'abCdef' ~~ /:i(1) bcd/, 'ignorecase, repetition (:i(1))';

#### :i(1) bcd		aBxDef	n	ignorecase, repetition (:i(1))
#?niecza skip "Action method mod_arg not yet implemented"
ok 'aBxDef' !~~ /:i(1) bcd/, 'ignorecase, repetition (:i(1))';

#### :0i bcd			abcdef	y	ignorecase, repetition (:0i)
#?pugs todo 
ok 'abcdef' ~~ /:0i bcd/, 'ignorecase, repetition (:0i)';

#### :0i bcd			abCdef	n	ignorecase, repetition (:0i)
#?niecza todo ""
ok 'abCdef' !~~ /:0i bcd/, 'ignorecase, repetition (:0i)';

#### :1i bcd			abcdef	y	ignorecase, repetition (:1i)
#?pugs todo 
ok 'abcdef' ~~ /:1i bcd/, 'ignorecase, repetition (:1i)';

#### :1i bcd			abCdef	y	ignorecase, repetition (:1i)
#?pugs todo 
ok 'abCdef' ~~ /:1i bcd/, 'ignorecase, repetition (:1i)';

#### :1i bcd			aBCDef	y	ignorecase, repetition (:1i)
#?pugs todo 
ok 'aBCDef' ~~ /:1i bcd/, 'ignorecase, repetition (:1i)';

#### :1i bcd			aBxDef	n	ignorecase, repetition (:1i)
ok 'aBxDef' !~~ /:1i bcd/, 'ignorecase, repetition (:1i)';

#### ab [:i cd ] ef		abcdef	y	ignorecase, lexical (:i)
#?pugs todo 
ok 'abcdef' ~~ /ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### ab [:i cd ] ef		abCdef	y	ignorecase, lexical (:i)
#?pugs todo 
ok 'abCdef' ~~ /ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### ab [:i cd ] ef		abcDef	y	ignorecase, lexical (:i)
#?pugs todo 
ok 'abcDef' ~~ /ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### ab [:i cd ] ef		abCDef	y	ignorecase, lexical (:i)
#?pugs todo 
ok 'abCDef' ~~ /ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### ab [:i cd ] ef		aBCDef	n	ignorecase, lexical (:i)
ok 'aBCDef' !~~ /ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### ab [:i cd ] ef		abCDEf	n	ignorecase, lexical (:i)
ok 'abCDEf' !~~ /ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### :i ab [:i cd ] ef	abCDef	y	ignorecase, lexical (:i)
#?pugs todo 
ok 'abCDef' ~~ /:i ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### :i ab [:i cd ] ef	AbCDeF	y	ignorecase, lexical (:i)
#?pugs todo 
ok 'AbCDeF' ~~ /:i ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### :i ab [:i cd ] ef	AbcdeF	y	ignorecase, lexical (:i)
#?pugs todo 
ok 'AbcdeF' ~~ /:i ab [:i cd ] ef/, 'ignorecase, lexical (:i)';

#### :i a [:i(0) b [:i(1) c [:0i d [:1i e [:i(0) f ] ] ] ] ]		AbCdEf		y	ignorecase, lexical (:i)
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'AbCdEf' ~~ /:i a [:i(0) b [:i(1) c [:0i d [:1i e [:i(0) f ] ] ] ] ]/, 'ignorecase, lexical (:i)';

#### :i aa [:i(0) bb [:i(1) cc [:0i dd [:1i ee [:i(0) ff ] ] ] ] ]	AabbCcddEeff	y	ignorecase, lexical (:i)
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'AabbCcddEeff' ~~ /:i aa [:i(0) bb [:i(1) cc [:0i dd [:1i ee [:i(0) ff ] ] ] ] ]/, 'ignorecase, lexical (:i)';

#### :i a [:i(0) b [:i(1) c [:0i d [:1i e [:i(0) f ] ] ] ] ]		AbCdEF		n	ignorecase, lexical (:i)
#?niecza skip "Action method mod_arg not yet implemented"
ok 'AbCdEF' !~~ /:i a [:i(0) b [:i(1) c [:0i d [:1i e [:i(0) f ] ] ] ] ]/, 'ignorecase, lexical (:i)';

#### :i aa [:i(0) bb [:i(1) cc [:0i dd [:1i ee [:i(0) ff ] ] ] ] ]	AabbCcddEeFf	n	ignorecase, lexical (:i)
#?niecza skip "Action method mod_arg not yet implemented"
ok 'AabbCcddEeFf' !~~ /:i aa [:i(0) bb [:i(1) cc [:0i dd [:1i ee [:i(0) ff ] ] ] ] ]/, 'ignorecase, lexical (:i)';

#### :i ab [:i(0) cd ] ef	AbcdeF	y	ignorecase, lexical repetition (:i)
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'AbcdeF' ~~ /:i ab [:i(0) cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :i ab [:!i cd ] ef	AbcdeF	y	ignorecase, lexical repetition (:i)
#?pugs todo 
ok 'AbcdeF' ~~ /:i ab [:!i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :i ab [:0i cd ] ef	AbcdeF	y	ignorecase, lexical repetition (:i)
#?pugs todo 
ok 'AbcdeF' ~~ /:i ab [:0i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :0i ab [:1i cd ] ef	abCDef	y	ignorecase, lexical repetition (:i)
#?pugs todo 
ok 'abCDef' ~~ /:0i ab [:1i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :0i ab [:1i cd ] ef	AbCDeF	n	ignorecase, lexical repetition (:i)
#?niecza todo ""
ok 'AbCDeF' !~~ /:0i ab [:1i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :0i ab [:1i cd ] ef	AbcdeF	n	ignorecase, lexical repetition (:i)
#?niecza todo ""
ok 'AbcdeF' !~~ /:0i ab [:1i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :0i ab [:i(0) cd ] ef	abcdef	y	ignorecase, lexical repetition (:i)
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'abcdef' ~~ /:0i ab [:i(0) cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :0i ab [:1i cd ] ef	AbcdeF	n	ignorecase, lexical repetition (:i)
#?niecza todo ""
ok 'AbcdeF' !~~ /:0i ab [:1i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :i(1) ab [:1i cd ] ef	AbCdeF	y	ignorecase, lexical repetition (:i)
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'AbCdeF' ~~ /:i(1) ab [:1i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :i(1) ab [:i(0) cd ] ef	AbcdeF	y	ignorecase, lexical repetition (:i)
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'AbcdeF' ~~ /:i(1) ab [:i(0) cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :i(1) ab [:i(0) cd ] ef	AbcDeF	n	ignorecase, lexical repetition (:i)
#?niecza skip "Action method mod_arg not yet implemented"
ok 'AbcDeF' !~~ /:i(1) ab [:i(0) cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :i(2) ab [:i(999) cd ] ef	ABCDEF	y	ignorecase, lexical repetition (:i)
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'ABCDEF' ~~ /:i(2) ab [:i(999) cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :1i ab [:i(1) cd ] ef		ABCDEF	y	ignorecase, lexical repetition (:i)
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'ABCDEF' ~~ /:1i ab [:i(1) cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :0i ab [:1i cd ] ef		abcDeF	n	ignorecase, lexical repetition (:i)
#?niecza todo ""
ok 'abcDeF' !~~ /:0i ab [:1i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### :2i ab [:999i cd ] ef		ABCDEF	y	ignorecase, lexical repetition (:i)
#?pugs todo 
ok 'ABCDEF' ~~ /:2i ab [:999i cd ] ef/, 'ignorecase, lexical repetition (:i)';

#### ab [:ignorecase cd ] ef		abCDef	y	ignorecase, lexical (:ignorecase)
#?pugs todo 
ok 'abCDef' ~~ /ab [:ignorecase cd ] ef/, 'ignorecase, lexical (:ignorecase)';

#### ab [:ignorecase cd ] ef		aBCDef	n	ignorecase, lexical (:ignorecase)
ok 'aBCDef' !~~ /ab [:ignorecase cd ] ef/, 'ignorecase, lexical (:ignorecase)';

#### :1ignorecase ab [:ignorecase(1) cd ] ef	ABCDEF	y	ignorecase, lexical repetition (:ignorecase)
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'ABCDEF' ~~ /:1ignorecase ab [:ignorecase(1) cd ] ef/, 'ignorecase, lexical repetition (:ignorecase)';

#### :s bcd			a bcdef		y	sigspace (:s)
#?pugs todo 
ok 'a bcdef' ~~ /:s bcd/, 'sigspace (:s)';

#### :s bcd			a bcd ef	y	sigspace (:s)
#?pugs todo 
ok 'a bcd ef' ~~ /:s bcd/, 'sigspace (:s)';

#### :s bcd			abcdef		n	sigspace (:s)
ok 'abcdef' !~~ /:s bcd/, 'sigspace (:s)';

#### :s bcd			abcd ef		n	sigspace (:s)
ok 'abcd ef' !~~ /:s bcd/, 'sigspace (:s)';

#### :s bcd			ab cdef		n	sigspace (:s)
ok 'ab cdef' !~~ /:s bcd/, 'sigspace (:s)';

#### :s b c d		a b c d ef	y	sigspace (:s)
#?pugs todo 
ok 'a b c d ef' ~~ /:s b c d/, 'sigspace (:s)';

#### :s b c d		a b c def	y	sigspace (:s)
#?pugs todo 
ok 'a b c def' ~~ /:s b c d/, 'sigspace (:s)';

#### :s b c d		ab c d ef	n	sigspace (:s)
ok 'ab c d ef' !~~ /:s b c d/, 'sigspace (:s)';

#### :s b c d		a bcdef		n	sigspace (:s)
ok 'a bcdef' !~~ /:s b c d/, 'sigspace (:s)';

#### :s b c d		abcdef		n	sigspace (:s)
ok 'abcdef' !~~ /:s b c d/, 'sigspace (:s)';

#### :sigspace bcd		a bcdef		y	sigspace (:sigspace)
#?pugs todo 
ok 'a bcdef' ~~ /:sigspace bcd/, 'sigspace (:sigspace)';

#### :sigspace bcd		a bcd ef	y	sigspace (:sigspace)
#?pugs todo 
ok 'a bcd ef' ~~ /:sigspace bcd/, 'sigspace (:sigspace)';

#### :sigspace bcd		abcdef		n	sigspace (:sigspace)
ok 'abcdef' !~~ /:sigspace bcd/, 'sigspace (:sigspace)';

#### :sigspace b c d		a b c d ef	y	sigspace (:sigspace)
#?pugs todo 
ok 'a b c d ef' ~~ /:sigspace b c d/, 'sigspace (:sigspace)';

#### :sigspace b c d		a b c def	y	sigspace (:sigspace)
#?pugs todo 
ok 'a b c def' ~~ /:sigspace b c d/, 'sigspace (:sigspace)';

#### :sigspace b c d		ab c d ef	n	sigspace (:sigspace)
ok 'ab c d ef' !~~ /:sigspace b c d/, 'sigspace (:sigspace)';

#### :s(1) b c [:s(0) d e f ]	a b c def	y	sigspace, lexical repetition (:s)
#?niecza skip "Action method mod_arg not yet implemented"
#?pugs todo 
ok 'a b c def' ~~ /:s(1) b c [:s(0) d e f ]/, 'sigspace, lexical repetition (:s)';

#### :s b c [:!s d e f ]	a b c def	y	sigspace, lexical repetition (:s)
#?pugs todo 
ok 'a b c def' ~~ /:s b c [:!s d e f ]/, 'sigspace, lexical repetition (:s)';

#### :s(0) b c [:s(1) d e f ]	a b c def	n	sigspace, lexical repetition (:s)
#?niecza skip "Action method mod_arg not yet implemented"
ok 'a b c def' !~~ /:s(0) b c [:s(1) d e f ]/, 'sigspace, lexical repetition (:s)';

# todo :pge<feature>
#### :!s b c [:s d e f ]	a b c def	n	sigspace, lexical repetition (:s)
ok 'a b c def' !~~ /:!s b c [:s d e f ]/, 'sigspace, lexical repetition (:s)';

#### :s(0) b c [:s(0) d e f ]	a b c def	n	sigspace, lexical repetition (:s)
#?niecza skip "Action method mod_arg not yet implemented"
ok 'a b c def' !~~ /:s(0) b c [:s(0) d e f ]/, 'sigspace, lexical repetition (:s)';

# todo :pge<feature>
#### :!s b c [:!s d e f ]	a b c def	n	sigspace, lexical repetition (:s)
ok 'a b c def' !~~ /:!s b c [:!s d e f ]/, 'sigspace, lexical repetition (:s)';

#### :s ab 				ab		y	sigspace, trailing ws
#?pugs todo 
ok 'ab' ~~ /:s ab /, 'sigspace, trailing ws';

#### foo\s*'-'?\s*bar		foo\t \n-\n\t bar	y	basic match
#?pugs todo 
ok "foo\t \n-\n\t bar" ~~ /foo\s*'-'?\s*bar/, 'basic match';

#### foo\s*'-'?\s*bar		foo - bar	y	basic match
#?pugs todo 
ok 'foo - bar' ~~ /foo\s*'-'?\s*bar/, 'basic match';

#### foo\s+'-'?\s*bar		foo   bar	y	basic match \s+ \s*
#?pugs todo 
ok 'foo   bar' ~~ /foo\s+'-'?\s*bar/, 'basic match \s+ \s*';

#### foo\s+'-'?\s*bar		foo  -bar	y	basic match \s+ \s*
#?pugs todo 
ok 'foo  -bar' ~~ /foo\s+'-'?\s*bar/, 'basic match \s+ \s*';

#### foo\s*'-'?\s+bar		foo-  bar	y	basic match \s* \s+
#?pugs todo 
ok 'foo-  bar' ~~ /foo\s*'-'?\s+bar/, 'basic match \s* \s+';

#### foo '-'? bar			foo-bar		y	basic match \s* \s*
#?pugs todo 
ok 'foo-bar' ~~ /foo '-'? bar/, 'basic match \s* \s*';

#### foo '-'? bar			foobar		y	basic match
#?pugs todo 
ok 'foobar' ~~ /foo '-'? bar/, 'basic match';

#### foo '-'? bar			foo - bar	n	basic non-match
ok 'foo - bar' !~~ /foo '-'? bar/, 'basic non-match';

#### :s foo '-'? bar			foo\n \t- \t\t\nbar	y	basic ws match
#?pugs todo 
ok "foo\n \t- \t\t\nbar" ~~ /:s foo '-'? bar/, 'basic ws match';

#### :s foo '-'? bar			foo - bar	y	basic ws match
#?pugs todo 
ok 'foo - bar' ~~ /:s foo '-'? bar/, 'basic ws match';

#### :s foo '-'? bar			foo   bar	y	basic ws match \s+ \s*
#?pugs todo 
ok 'foo   bar' ~~ /:s foo '-'? bar/, 'basic ws match \s+ \s*';

#### :s foo '-'? bar			foo  -bar	y	basic ws match \s+ \s*
#?pugs todo 
ok 'foo  -bar' ~~ /:s foo '-'? bar/, 'basic ws match \s+ \s*';

#### :s foo '-'? bar			foo-  bar	y	basic ws match \s* \s+
#?pugs todo 
ok 'foo-  bar' ~~ /:s foo '-'? bar/, 'basic ws match \s* \s+';

#### :s foo '-'? bar			foo-bar		y	basic ws match \s* \s*
#?pugs todo 
ok 'foo-bar' ~~ /:s foo '-'? bar/, 'basic ws match \s* \s*';

#### :s foo '-'? bar			foobar		n	basic ws non-match
ok 'foobar' !~~ /:s foo '-'? bar/, 'basic ws non-match';

#### :s()foo '-'? bar		foo - bar	n	basic ws match
#?rakudo skip ':s()'
#?niecza skip "Action method mod_arg not yet implemented"
ok 'foo - bar' !~~ /:s()foo '-'? bar/, 'basic ws match';

#### :s[]foo '-'? bar		foo - bar	y	basic ws match
#?pugs todo 
ok 'foo - bar' ~~ /:s foo '-'? bar/, 'basic ws match';

#### :s<?wb>foo '-'? bar		foo - bar	y	basic ws match with boundary modifier separation
#?niecza skip "Unable to resolve method wb in class Cursor"
#?pugs todo 
ok 'foo - bar' ~~ /:s<?wb>foo '-'? bar/, 'basic ws match with boundary modifier separation';

#### :s::foo '-'? bar			foo - bar	y	basic ws match with backtrack no-op modifier separation
#?rakudo skip ':: NYI'
#?pugs todo 
ok 'foo - bar' ~~ /:s::foo '-'? bar/, 'basic ws match with backtrack no-op modifier separation';

#### :s::(\w+) ':=' (\S+)		dog := spot	/mob 0: <dog @ 0>/	sigspace and capture together
#?rakudo skip ':: NYI'
#?pugs todo 
ok ('dog := spot' ~~ /:s::(\w+) ':=' (\S+)/) && matchcheck($/, q/mob 0: <dog @ 0>/), 'sigspace and capture together';

#### :s::(\w+) ':=' (\S+)		dog := spot	/mob 1: <spot @ 7>/	sigspace and capture together
#?rakudo skip ':: NYI'
#?pugs todo 
ok ('dog := spot' ~~ /:s::(\w+) ':=' (\S+)/) && matchcheck($/, q/mob 1: <spot @ 7>/), 'sigspace and capture together';

#### :perl5 \A.*? bcd\Q$\E..\z	a bcd$ef	y	perl5 syntax (:perl5)
#?rakudo skip 'parse error'
#?niecza skip 'Autoloading NYI'
ok 'a bcd$ef' ~~ m:Perl5/\A.*? bcd\Q$\E..\z/, 'perl5 syntax (:Perl5)';

#### :s^[\d+ ]* abc			11 12 13 abc	y	<?ws> before closing bracket
#?pugs todo 
ok '11 12 13 abc' ~~ /:s^[\d+ ]* abc/, '<?ws> before closing bracket';


##  Quantifiers

#### xa*			xaaaay		/<xaaaa @ 0>/	star 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa*/) && matchcheck($/, q/<xaaaa @ 0>/), 'star 2+';

#### xa*			xay		/<xa @ 0>/	star 1
#?pugs todo 
ok ('xay' ~~ /xa*/) && matchcheck($/, q/<xa @ 0>/), 'star 1';

#### xa*			xy		/<x @ 0>/	star 0
#?pugs todo 
ok ('xy' ~~ /xa*/) && matchcheck($/, q/<x @ 0>/), 'star 0';

#### xa*y			xaaaay		/<xaaaay @ 0>/	star 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa*y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star 2+';

#### xa*y			xay		/<xay @ 0>/	star 1
#?pugs todo 
ok ('xay' ~~ /xa*y/) && matchcheck($/, q/<xay @ 0>/), 'star 1';

#### xa*y			xy		/<xy @ 0>/	star 0
#?pugs todo 
ok ('xy' ~~ /xa*y/) && matchcheck($/, q/<xy @ 0>/), 'star 0';


#### xa+			xaaaay		/<xaaaa @ 0>/	plus 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa+/) && matchcheck($/, q/<xaaaa @ 0>/), 'plus 2+';

#### xa+			xay		/<xa @ 0>/	plus 1
#?pugs todo 
ok ('xay' ~~ /xa+/) && matchcheck($/, q/<xa @ 0>/), 'plus 1';

#### xa+			xy		n		plus 0
ok 'xy' !~~ /xa+/, 'plus 0';

#### xa+y			xaaaay		/<xaaaay @ 0>/	plus 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa+y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus 2+';

#### xa+y			xay		/<xay @ 0>/	plus 1
#?pugs todo 
ok ('xay' ~~ /xa+y/) && matchcheck($/, q/<xay @ 0>/), 'plus 1';

#### xa+y			xy		n		plus 0
ok 'xy' !~~ /xa+y/, 'plus 0';


#### xa?			xaaaay		/<xa @ 0>/	ques 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa?/) && matchcheck($/, q/<xa @ 0>/), 'ques 2+';

#### xa?			xay		/<xa @ 0>/	ques 1
#?pugs todo 
ok ('xay' ~~ /xa?/) && matchcheck($/, q/<xa @ 0>/), 'ques 1';

#### xa?			xy		/<x @ 0>/	ques 0
#?pugs todo 
ok ('xy' ~~ /xa?/) && matchcheck($/, q/<x @ 0>/), 'ques 0';

#### xa?y			xaaaay		n		ques 2+
ok 'xaaaay' !~~ /xa?y/, 'ques 2+';

#### xa?y			xay		/<xay @ 0>/	ques 1
#?pugs todo 
ok ('xay' ~~ /xa?y/) && matchcheck($/, q/<xay @ 0>/), 'ques 1';

#### xa?y			xy		/<xy @ 0>/	ques 0
#?pugs todo 
ok ('xy' ~~ /xa?y/) && matchcheck($/, q/<xy @ 0>/), 'ques 0';


#### xa*!			xaaaay		/<xaaaa @ 0>/	star greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa*!/) && matchcheck($/, q/<xaaaa @ 0>/), 'star greedy 2+';

#### xa*!			xay		/<xa @ 0>/	star greedy 1
#?pugs todo 
ok ('xay' ~~ /xa*!/) && matchcheck($/, q/<xa @ 0>/), 'star greedy 1';

#### xa*!			xy		/<x @ 0>/	star greedy 0
#?pugs todo 
ok ('xy' ~~ /xa*!/) && matchcheck($/, q/<x @ 0>/), 'star greedy 0';

#### xa*!y			xaaaay		/<xaaaay @ 0>/	star greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa*!y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star greedy 2+';

#### xa*!y			xay		/<xay @ 0>/	star greedy 1
#?pugs todo 
ok ('xay' ~~ /xa*!y/) && matchcheck($/, q/<xay @ 0>/), 'star greedy 1';

#### xa*!y			xy		/<xy @ 0>/	star greedy 0
#?pugs todo 
ok ('xy' ~~ /xa*!y/) && matchcheck($/, q/<xy @ 0>/), 'star greedy 0';


#### xa+!			xaaaay		/<xaaaa @ 0>/	plus greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa+!/) && matchcheck($/, q/<xaaaa @ 0>/), 'plus greedy 2+';

#### xa+!			xay		/<xa @ 0>/	plus greedy 1
#?pugs todo 
ok ('xay' ~~ /xa+!/) && matchcheck($/, q/<xa @ 0>/), 'plus greedy 1';

#### xa+!			xy		n		plus greedy 0
ok 'xy' !~~ /xa+!/, 'plus greedy 0';

#### xa+!y			xaaaay		/<xaaaay @ 0>/	plus greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa+!y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus greedy 2+';

#### xa+!y			xay		/<xay @ 0>/	plus greedy 1
#?pugs todo 
ok ('xay' ~~ /xa+!y/) && matchcheck($/, q/<xay @ 0>/), 'plus greedy 1';

#### xa+!y			xy		n		plus greedy 0
ok 'xy' !~~ /xa+!y/, 'plus greedy 0';


#### xa?!			xaaaay		/<xa @ 0>/	ques greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa?!/) && matchcheck($/, q/<xa @ 0>/), 'ques greedy 2+';

#### xa?!			xay		/<xa @ 0>/	ques greedy 1
#?pugs todo 
ok ('xay' ~~ /xa?!/) && matchcheck($/, q/<xa @ 0>/), 'ques greedy 1';

#### xa?!			xy		/<x @ 0>/	ques greedy 0
#?pugs todo 
ok ('xy' ~~ /xa?!/) && matchcheck($/, q/<x @ 0>/), 'ques greedy 0';

#### xa?!y			xaaaay		n		ques greedy 2+
ok 'xaaaay' !~~ /xa?!y/, 'ques greedy 2+';

#### xa?!y			xay		/<xay @ 0>/	ques greedy 1
#?pugs todo 
ok ('xay' ~~ /xa?!y/) && matchcheck($/, q/<xay @ 0>/), 'ques greedy 1';

#### xa?!y			xy		/<xy @ 0>/	ques greedy 0
#?pugs todo 
ok ('xy' ~~ /xa?!y/) && matchcheck($/, q/<xy @ 0>/), 'ques greedy 0';


#### xa*:!			xaaaay		/<xaaaa @ 0>/	star :greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa*:!/) && matchcheck($/, q/<xaaaa @ 0>/), 'star :greedy 2+';

#### xa*:!			xay		/<xa @ 0>/	star :greedy 1
#?pugs todo 
ok ('xay' ~~ /xa*:!/) && matchcheck($/, q/<xa @ 0>/), 'star :greedy 1';

#### xa*:!			xy		/<x @ 0>/	star :greedy 0
#?pugs todo 
ok ('xy' ~~ /xa*:!/) && matchcheck($/, q/<x @ 0>/), 'star :greedy 0';

#### xa*:!y			xaaaay		/<xaaaay @ 0>/	star :greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa*:!y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star :greedy 2+';

#### xa*:!y			xay		/<xay @ 0>/	star :greedy 1
#?pugs todo 
ok ('xay' ~~ /xa*:!y/) && matchcheck($/, q/<xay @ 0>/), 'star :greedy 1';

#### xa*:!y			xy		/<xy @ 0>/	star :greedy 0
#?pugs todo 
ok ('xy' ~~ /xa*:!y/) && matchcheck($/, q/<xy @ 0>/), 'star :greedy 0';


#### xa+:!			xaaaay		/<xaaaa @ 0>/	plus :greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa+:!/) && matchcheck($/, q/<xaaaa @ 0>/), 'plus :greedy 2+';

#### xa+:!			xay		/<xa @ 0>/	plus :greedy 1
#?pugs todo 
ok ('xay' ~~ /xa+:!/) && matchcheck($/, q/<xa @ 0>/), 'plus :greedy 1';

#### xa+:!			xy		n		plus :greedy 0
ok 'xy' !~~ /xa+:!/, 'plus :greedy 0';

#### xa+:!y			xaaaay		/<xaaaay @ 0>/	plus :greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa+:!y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus :greedy 2+';

#### xa+:!y			xay		/<xay @ 0>/	plus :greedy 1
#?pugs todo 
ok ('xay' ~~ /xa+:!y/) && matchcheck($/, q/<xay @ 0>/), 'plus :greedy 1';

#### xa+:!y			xy		n		plus :greedy 0
ok 'xy' !~~ /xa+:!y/, 'plus :greedy 0';


#### xa?:!			xaaaay		/<xa @ 0>/	ques :greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa?:!/) && matchcheck($/, q/<xa @ 0>/), 'ques :greedy 2+';

#### xa?:!			xay		/<xa @ 0>/	ques :greedy 1
#?pugs todo 
ok ('xay' ~~ /xa?:!/) && matchcheck($/, q/<xa @ 0>/), 'ques :greedy 1';

#### xa?:!			xy		/<x @ 0>/	ques :greedy 0
#?pugs todo 
ok ('xy' ~~ /xa?:!/) && matchcheck($/, q/<x @ 0>/), 'ques :greedy 0';

#### xa?:!y			xaaaay		n		ques :greedy 2+
ok 'xaaaay' !~~ /xa?:!y/, 'ques :greedy 2+';

#### xa?:!y			xay		/<xay @ 0>/	ques :greedy 1
#?pugs todo 
ok ('xay' ~~ /xa?:!y/) && matchcheck($/, q/<xay @ 0>/), 'ques :greedy 1';

#### xa?:!y			xy		/<xy @ 0>/	ques :greedy 0
#?pugs todo 
ok ('xy' ~~ /xa?:!y/) && matchcheck($/, q/<xy @ 0>/), 'ques :greedy 0';


#### xa*?			xaaaay		/<x @ 0>/	star eager 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa*?/) && matchcheck($/, q/<x @ 0>/), 'star eager 2+';

#### xa*?			xay		/<x @ 0>/	star eager 1
#?pugs todo 
ok ('xay' ~~ /xa*?/) && matchcheck($/, q/<x @ 0>/), 'star eager 1';

#### xa*?			xy		/<x @ 0>/	star eager 0
#?pugs todo 
ok ('xy' ~~ /xa*?/) && matchcheck($/, q/<x @ 0>/), 'star eager 0';

#### xa*?y			xaaaay		/<xaaaay @ 0>/	star eager 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa*?y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star eager 2+';

#### xa*?y			xay		/<xay @ 0>/	star eager 1
#?pugs todo 
ok ('xay' ~~ /xa*?y/) && matchcheck($/, q/<xay @ 0>/), 'star eager 1';

#### xa*?y			xy		/<xy @ 0>/	star eager 0
#?pugs todo 
ok ('xy' ~~ /xa*?y/) && matchcheck($/, q/<xy @ 0>/), 'star eager 0';


#### xa+?			xaaaay		/<xa @ 0>/	plus eager 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa+?/) && matchcheck($/, q/<xa @ 0>/), 'plus eager 2+';

#### xa+?			xay		/<xa @ 0>/	plus eager 1
#?pugs todo 
ok ('xay' ~~ /xa+?/) && matchcheck($/, q/<xa @ 0>/), 'plus eager 1';

#### xa+?			xy		n		plus eager 0
ok 'xy' !~~ /xa+?/, 'plus eager 0';

#### xa+?y			xaaaay		/<xaaaay @ 0>/	plus eager 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa+?y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus eager 2+';

#### xa+?y			xay		/<xay @ 0>/	plus eager 1
#?pugs todo 
ok ('xay' ~~ /xa+?y/) && matchcheck($/, q/<xay @ 0>/), 'plus eager 1';

#### xa+?y			xy		n		plus eager 0
ok 'xy' !~~ /xa+?y/, 'plus eager 0';


#### xa??			xaaaay		/<x @ 0>/	ques eager 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa??/) && matchcheck($/, q/<x @ 0>/), 'ques eager 2+';

#### xa??			xay		/<x @ 0>/	ques eager 1
#?pugs todo 
ok ('xay' ~~ /xa??/) && matchcheck($/, q/<x @ 0>/), 'ques eager 1';

#### xa??			xy		/<x @ 0>/	ques eager 0
#?pugs todo 
ok ('xy' ~~ /xa??/) && matchcheck($/, q/<x @ 0>/), 'ques eager 0';

#### xa??y			xaaaay		n		ques eager 2+
ok 'xaaaay' !~~ /xa??y/, 'ques eager 2+';

#### xa??y			xay		/<xay @ 0>/	ques eager 1
#?pugs todo 
ok ('xay' ~~ /xa??y/) && matchcheck($/, q/<xay @ 0>/), 'ques eager 1';

#### xa??y			xy		/<xy @ 0>/	ques eager 0
#?pugs todo 
ok ('xy' ~~ /xa??y/) && matchcheck($/, q/<xy @ 0>/), 'ques eager 0';


#### xa*:?			xaaaay		/<x @ 0>/	star :eager 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa*:?/) && matchcheck($/, q/<x @ 0>/), 'star :eager 2+';

#### xa*:?			xay		/<x @ 0>/	star :eager 1
#?pugs todo 
ok ('xay' ~~ /xa*:?/) && matchcheck($/, q/<x @ 0>/), 'star :eager 1';

#### xa*:?			xy		/<x @ 0>/	star :eager 0
#?pugs todo 
ok ('xy' ~~ /xa*:?/) && matchcheck($/, q/<x @ 0>/), 'star :eager 0';

#### xa*:?y			xaaaay		/<xaaaay @ 0>/	star :eager 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa*:?y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star :eager 2+';

#### xa*:?y			xay		/<xay @ 0>/	star :eager 1
#?pugs todo 
ok ('xay' ~~ /xa*:?y/) && matchcheck($/, q/<xay @ 0>/), 'star :eager 1';

#### xa*:?y			xy		/<xy @ 0>/	star :eager 0
#?pugs todo 
ok ('xy' ~~ /xa*:?y/) && matchcheck($/, q/<xy @ 0>/), 'star :eager 0';


#### xa+:?			xaaaay		/<xa @ 0>/	plus :eager 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa+:?/) && matchcheck($/, q/<xa @ 0>/), 'plus :eager 2+';

#### xa+:?			xay		/<xa @ 0>/	plus :eager 1
#?pugs todo 
ok ('xay' ~~ /xa+:?/) && matchcheck($/, q/<xa @ 0>/), 'plus :eager 1';

#### xa+:?			xy		n		plus :eager 0
ok 'xy' !~~ /xa+:?/, 'plus :eager 0';

#### xa+:?y			xaaaay		/<xaaaay @ 0>/	plus :eager 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa+:?y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus :eager 2+';

#### xa+:?y			xay		/<xay @ 0>/	plus :eager 1
#?pugs todo 
ok ('xay' ~~ /xa+:?y/) && matchcheck($/, q/<xay @ 0>/), 'plus :eager 1';

#### xa+:?y			xy		n		plus :eager 0
ok 'xy' !~~ /xa+:?y/, 'plus :eager 0';


#### xa?:?			xaaaay		/<x @ 0>/	ques :eager 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa?:?/) && matchcheck($/, q/<x @ 0>/), 'ques :eager 2+';

#### xa?:?			xay		/<x @ 0>/	ques :eager 1
#?pugs todo 
ok ('xay' ~~ /xa?:?/) && matchcheck($/, q/<x @ 0>/), 'ques :eager 1';

#### xa?:?			xy		/<x @ 0>/	ques :eager 0
#?pugs todo 
ok ('xy' ~~ /xa?:?/) && matchcheck($/, q/<x @ 0>/), 'ques :eager 0';

#### xa?:?y			xaaaay		n		ques :eager 2+
ok 'xaaaay' !~~ /xa?:?y/, 'ques :eager 2+';

#### xa?:?y			xay		/<xay @ 0>/	ques :eager 1
#?pugs todo 
ok ('xay' ~~ /xa?:?y/) && matchcheck($/, q/<xay @ 0>/), 'ques :eager 1';

#### xa?:?y			xy		/<xy @ 0>/	ques :eager 0
#?pugs todo 
ok ('xy' ~~ /xa?:?y/) && matchcheck($/, q/<xy @ 0>/), 'ques :eager 0';


#### xa*:y			xaaaay		/<xaaaay @ 0>/	star cut 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa*: y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star cut 2+';

#### xa*:y			xay		/<xay @ 0>/	star cut 1
#?pugs todo 
ok ('xay' ~~ /xa*: y/) && matchcheck($/, q/<xay @ 0>/), 'star cut 1';

#### xa*:y			xy		/<xy @ 0>/	star cut 0
#?pugs todo 
ok ('xy' ~~ /xa*: y/) && matchcheck($/, q/<xy @ 0>/), 'star cut 0';

#### xa*:a			xaaaay		n		star cut 2+
ok 'xaaaay' !~~ /xa*: a/, 'star cut 2+';

#### xa*:a			xay		n		star cut 1
ok 'xay' !~~ /xa*: a/, 'star cut 1';


#### xa+:y			xaaaay		/<xaaaay @ 0>/	plus cut 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa+: y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus cut 2+';

#### xa+:y			xay		/<xay @ 0>/	plus cut 1
#?pugs todo 
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
#?pugs todo 
ok ('xay' ~~ /xa?: y/) && matchcheck($/, q/<xay @ 0>/), 'ques cut 1';

#### xa?:y			xy		/<xy @ 0>/	ques cut 0
#?pugs todo 
ok ('xy' ~~ /xa?: y/) && matchcheck($/, q/<xy @ 0>/), 'ques cut 0';

#### xa?:a			xaaaay		/<xaa @ 0>/	ques cut 2+
#?pugs todo 
ok ('xaaaay' ~~ /xa?: a/) && matchcheck($/, q/<xaa @ 0>/), 'ques cut 2+';

#### xa?:a			xay		n		ques cut 1
ok 'xay' !~~ /xa?: a/, 'ques cut 1';


#### :ratchet xa*y			xaaaay		/<xaaaay @ 0>/	star ratchet 2+
#?pugs todo 
ok ('xaaaay' ~~ /:ratchet xa*y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star ratchet 2+';

#### :ratchet xa*y			xay		/<xay @ 0>/	star ratchet 1
#?pugs todo 
ok ('xay' ~~ /:ratchet xa*y/) && matchcheck($/, q/<xay @ 0>/), 'star ratchet 1';

#### :ratchet xa*y			xy		/<xy @ 0>/	star ratchet 0
#?pugs todo 
ok ('xy' ~~ /:ratchet xa*y/) && matchcheck($/, q/<xy @ 0>/), 'star ratchet 0';

#### :ratchet xa*a			xaaaay		n		star ratchet 2+
ok 'xaaaay' !~~ /:ratchet xa*a/, 'star ratchet 2+';

#### :ratchet xa*a			xay		n		star ratchet 1
ok 'xay' !~~ /:ratchet xa*a/, 'star ratchet 1';


#### :ratchet xa+y			xaaaay		/<xaaaay @ 0>/	plus ratchet 2+
#?pugs todo 
ok ('xaaaay' ~~ /:ratchet xa+y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus ratchet 2+';

#### :ratchet xa+y			xay		/<xay @ 0>/	plus ratchet 1
#?pugs todo 
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
#?pugs todo 
ok ('xay' ~~ /:ratchet xa?y/) && matchcheck($/, q/<xay @ 0>/), 'ques ratchet 1';

#### :ratchet xa?y			xy		/<xy @ 0>/	ques ratchet 0
#?pugs todo 
ok ('xy' ~~ /:ratchet xa?y/) && matchcheck($/, q/<xy @ 0>/), 'ques ratchet 0';

#### :ratchet xa?a			xaaaay		/<xaa @ 0>/	ques ratchet 2+
#?pugs todo 
ok ('xaaaay' ~~ /:ratchet xa?a/) && matchcheck($/, q/<xaa @ 0>/), 'ques ratchet 2+';

#### :ratchet xa?a			xay		n		ques ratchet 1
ok 'xay' !~~ /:ratchet xa?a/, 'ques ratchet 1';


#### :ratchet xa*!y			xaaaay		/<xaaaay @ 0>/	star ratchet greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /:ratchet xa*!y/) && matchcheck($/, q/<xaaaay @ 0>/), 'star ratchet greedy 2+';

#### :ratchet xa*!y			xay		/<xay @ 0>/	star ratchet greedy 1
#?pugs todo 
ok ('xay' ~~ /:ratchet xa*!y/) && matchcheck($/, q/<xay @ 0>/), 'star ratchet greedy 1';

#### :ratchet xa*!y			xy		/<xy @ 0>/	star ratchet greedy 0
#?pugs todo 
ok ('xy' ~~ /:ratchet xa*!y/) && matchcheck($/, q/<xy @ 0>/), 'star ratchet greedy 0';

#### :ratchet xa*!a			xaaaay		/<xaaaa @ 0>/	star ratchet greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /:ratchet xa*!a/) && matchcheck($/, q/<xaaaa @ 0>/), 'star ratchet greedy 2+';

#### :ratchet xa*!a			xay		/<xa @ 0>/	star ratchet greedy 1
#?pugs todo 
ok ('xay' ~~ /:ratchet xa*!a/) && matchcheck($/, q/<xa @ 0>/), 'star ratchet greedy 1';


#### :ratchet xa+!y			xaaaay		/<xaaaay @ 0>/	plus ratchet greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /:ratchet xa+!y/) && matchcheck($/, q/<xaaaay @ 0>/), 'plus ratchet greedy 2+';

#### :ratchet xa+!y			xay		/<xay @ 0>/	plus ratchet greedy 1
#?pugs todo 
ok ('xay' ~~ /:ratchet xa+!y/) && matchcheck($/, q/<xay @ 0>/), 'plus ratchet greedy 1';

#### :ratchet xa+!y			xy		n		plus ratchet greedy 0
ok 'xy' !~~ /:ratchet xa+!y/, 'plus ratchet greedy 0';

#### :ratchet xa+!a			xaaaay		/<xaaaa @ 0>/	plus ratchet greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /:ratchet xa+!a/) && matchcheck($/, q/<xaaaa @ 0>/), 'plus ratchet greedy 2+';

#### :ratchet xa+!a			xay		n		plus ratchet greedy 1
ok 'xay' !~~ /:ratchet xa+!a/, 'plus ratchet greedy 1';


#### :ratchet xa?!y			xaaaay		n		ques ratchet greedy 2+
ok 'xaaaay' !~~ /:ratchet xa?!y/, 'ques ratchet greedy 2+';

#### :ratchet xa?!y			xay		/<xay @ 0>/	ques ratchet greedy 1
#?pugs todo 
ok ('xay' ~~ /:ratchet xa?!y/) && matchcheck($/, q/<xay @ 0>/), 'ques ratchet greedy 1';

#### :ratchet xa?!y			xy		/<xy @ 0>/	ques ratchet greedy 0
#?pugs todo 
ok ('xy' ~~ /:ratchet xa?!y/) && matchcheck($/, q/<xy @ 0>/), 'ques ratchet greedy 0';

#### :ratchet xa?!a			xaaaay		/<xaa @ 0>/	ques ratchet greedy 2+
#?pugs todo 
ok ('xaaaay' ~~ /:ratchet xa?!a/) && matchcheck($/, q/<xaa @ 0>/), 'ques ratchet greedy 2+';

#### :ratchet xa?!a			xay		/<xa @ 0>/	ques ratchet greedy 1
#?pugs todo 
ok ('xay' ~~ /:ratchet xa?!a/) && matchcheck($/, q/<xa @ 0>/), 'ques ratchet greedy 1';



## Quantifier closure
#### .**{2}			a			n	only one character
#?rakudo skip '**{}'
ok 'a' !~~ /.**{2}/, 'only one character';

#### .**{2}			ab			y	two characters
#?pugs todo 
#?rakudo skip '**{}'
ok 'ab' ~~ /.**{2}/, 'two characters';

#### a**{2}			foobar		n	only one "a" character
#?rakudo skip '**{}'
ok 'foobar' !~~ /a**{2}/, 'only one "a" character';

#### a**{2}			baabaa		y	two "a" characters
#?pugs todo 
#?rakudo skip '**{}'
ok 'baabaa' ~~ /a**{2}/, 'two "a" characters';

#### a**{0..4}		bbbbbbb		y	no "a" characters
#?rakudo skip '**{}'
#?pugs todo 
ok 'bbbbbbb' ~~ /a**{0..4}/, 'no "a" characters';

#### a**{2..4}		bababab		n	not two consecutive "a" characters
#?rakudo skip '**{}'
ok 'bababab' !~~ /a**{2..4}/, 'not two consecutive "a" characters';

#### a**{2..4}		baabbbb		y	two "a" characters
#?pugs todo 
#?rakudo skip '**{}'
ok 'baabbbb' ~~ /a**{2..4}/, 'two "a" characters';

#### a**{2..4}		baaabbb		y	three "a" characters
#?pugs todo 
#?rakudo skip '**{}'
ok 'baaabbb' ~~ /a**{2..4}/, 'three "a" characters';

#### a**{2..4}		baaaabb		y	four "a" characters
#?pugs todo 
#?rakudo skip '**{}'
ok 'baaaabb' ~~ /a**{2..4}/, 'four "a" characters';

#### a**{2..4}		baaaaaa		y	four "a" characters
#?pugs todo 
#?rakudo skip '**{}'
ok 'baaaaaa' ~~ /a**{2..4}/, 'four "a" characters';

#### a**{2..*}		baaaaaa		y	six "a" characters
#?pugs todo 
#?rakudo skip '**{}'
ok 'baaaaaa' ~~ /a**{2..*}/, 'six "a" characters';

#### a**?{2..*}		baaaaaa		y	two "a" characters (non-greedy)
#?pugs todo 
#?rakudo skip '**{}'
ok 'baaaaaa' ~~ /a**?{2..*}/, 'two "a" characters (non-greedy)';

#### a**:?{2..*}		baaaaaa		y	two "a" characters (non-greedy)
#?pugs todo 
#?rakudo skip '**{}'
ok 'baaaaaa' ~~ /a**:?{2..*}/, 'two "a" characters (non-greedy)';

#### a**!{2..*}		baaaaaa		y	six "a" characters (explicit greed)
#?pugs todo 
#?rakudo skip '**{}'
ok 'baaaaaa' ~~ /a**!{2..*}/, 'six "a" characters (explicit greed)';

#### a**:!{2..*}		baaaaaa		y	six "a" characters (explicit greed)
#?pugs todo 
#?rakudo skip '**{}'
ok 'baaaaaa' ~~ /a**:!{2..*}/, 'six "a" characters (explicit greed)';

#### a**?{2..4}		baaabbb		y	two "a" characters (non-greedy)
#?pugs todo 
#?rakudo skip '**{}'
ok 'baaabbb' ~~ /a**?{2..4}/, 'two "a" characters (non-greedy)';

#### a**:?{2..4}		baaabbb		y	two "a" characters (non-greedy)
#?pugs todo 
#?rakudo skip '**{}'
ok 'baaabbb' ~~ /a**:?{2..4}/, 'two "a" characters (non-greedy)';

#### a**!{2..4}		baaabbb		y	three "a" characters (explicit greed)
#?pugs todo 
#?rakudo skip '**{}'
ok 'baaabbb' ~~ /a**!{2..4}/, 'three "a" characters (explicit greed)';

#### a**:!{2..4}		baaabbb		y	three "a" characters (explicit greed)
#?pugs todo 
#?rakudo skip '**{}'
ok 'baaabbb' ~~ /a**:!{2..4}/, 'three "a" characters (explicit greed)';


## Quantifier bare range
#### .**2			a			n	only one character
ok 'a' !~~ /.**2/, 'only one character';

#### .**2			ab			y	two characters
#?pugs todo 
ok 'ab' ~~ /.**2/, 'two characters';

#### a**2			foobar		n	only one "a" character
ok 'foobar' !~~ /a**2/, 'only one "a" character';

#### a**2			baabaa		y	two "a" characters
#?pugs todo 
ok 'baabaa' ~~ /a**2/, 'two "a" characters';

#### a**0..4			bbbbbbb		y	no "a" characters
#?pugs todo 
ok 'bbbbbbb' ~~ /a**0..4/, 'no "a" characters';

#### a**2..4			bababab		n	not two consecutive "a" characters
ok 'bababab' !~~ /a**2..4/, 'not two consecutive "a" characters';

#### a**2..4			baabbbb		y	two "a" characters
#?pugs todo 
ok 'baabbbb' ~~ /a**2..4/, 'two "a" characters';

#### a**2..4			baaabbb		y	three "a" characters
#?pugs todo 
ok 'baaabbb' ~~ /a**2..4/, 'three "a" characters';

#### a**2..4			baaaabb		y	four "a" characters
#?pugs todo 
ok 'baaaabb' ~~ /a**2..4/, 'four "a" characters';

#### a**2..4			baaaaaa		y	four "a" characters
#?pugs todo 
ok 'baaaaaa' ~~ /a**2..4/, 'four "a" characters';

#### a**2..*			baaaaaa		y	six "a" characters
#?pugs todo 
ok 'baaaaaa' ~~ /a**2..*/, 'six "a" characters';

#### a**?2..*		baaaaaa		y	two "a" characters (non-greedy)
#?pugs todo 
ok 'baaaaaa' ~~ /a**?2..*/, 'two "a" characters (non-greedy)';

#### a**:?2..*		baaaaaa		y	two "a" characters (non-greedy)
#?pugs todo 
ok 'baaaaaa' ~~ /a**:?2..*/, 'two "a" characters (non-greedy)';

#### a**!2..*		baaaaaa		y	six "a" characters (explicit greed)
#?pugs todo 
ok 'baaaaaa' ~~ /a**!2..*/, 'six "a" characters (explicit greed)';

#### a**:!2..*		baaaaaa		y	six "a" characters (explicit greed)
#?pugs todo 
ok 'baaaaaa' ~~ /a**:!2..*/, 'six "a" characters (explicit greed)';

#### a**?2..4		baaabbb		y	two "a" characters (non-greedy)
#?pugs todo 
ok 'baaabbb' ~~ /a**?2..4/, 'two "a" characters (non-greedy)';

#### a**:?2..4		baaabbb		y	two "a" characters (non-greedy)
#?pugs todo 
ok 'baaabbb' ~~ /a**:?2..4/, 'two "a" characters (non-greedy)';

#### a**!2..4		baaabbb		y	three "a" characters (explicit greed)
#?pugs todo 
ok 'baaabbb' ~~ /a**!2..4/, 'three "a" characters (explicit greed)';

#### a**:!2..4		baaabbb		y	three "a" characters (explicit greed)
#?pugs todo 
ok 'baaabbb' ~~ /a**:!2..4/, 'three "a" characters (explicit greed)';

# RT 112450
{
    ok 'foooo' ~~ /^ f o ** 4 $/, 'RT 112450 sanity';
    my $rt112450 = 4;
    #?rakudo 2 skip 'RT 112450'
    #?niecza 2 skip 'Dubious test, http://irclog.perlgeek.de/perl6/2012-05-27#i_5643089'
    ok 'foooo' ~~ /^ f o **  $rt112450  $/, 'RT 112450 interpolation';
    ok 'foooo' ~~ /^ f o ** {$rt112450} $/, 'RT 112450 closure interpolation';
}

# RT 112454
{
    my $rt112454 = 3;
    my $ten_x = 'x' x 10;

    ok $ten_x ~~ / x ** 3 /, 'RT 112454 match sanity';
    is $/.Str, 'x' x 3, 'RT 112454 quantifier sanity';

    #?rakudo 2 skip 'RT 112454'
    ok $ten_x ~~ / x ** {$rt112454} /, 'Simple match (RT 112454)';
    is $/.Str, 'x' x $rt112454, '** quantifier with braces (RT 112454)';
}

#### <ident>			2+3 ab2		/mob<ident>: <ab2 @ 4>/		capturing builtin <ident>
#?pugs todo 
ok ('2+3 ab2' ~~ /<ident>/) && matchcheck($/, q/mob<ident>: <ab2 @ 4>/), 'capturing builtin <ident>';

#### <name>			ab::cd::x3::42	/mob<name>: <ab::cd::x3 @ 0>/	capturing builtin <name>
#?rakudo skip 'regex <name>'
#?niecza skip "Unable to resolve method name in class Cursor"
#?pugs todo 
ok ('ab::cd::x3::42' ~~ /<name>/) && matchcheck($/, q/mob<name>: <ab::cd::x3 @ 0>/), 'capturing builtin <name>';


#### <.ident>			2+3 ab2		y		non-capturing builtin <.ident>
#?pugs todo 
ok '2+3 ab2' ~~ /<.ident>/, 'non-capturing builtin <.ident>';

#### <.name>			ab::cd::x3::42	y	non-capturing builtin <.name>
#?rakudo skip 'regex <name>'
#?niecza skip "Unable to resolve method name in class Cursor"
#?pugs todo 
ok 'ab::cd::x3::42' ~~ /<.name>/, 'non-capturing builtin <.name>';

#?niecza 12 skip "Unable to resolve method wb in class Cursor"

#### <?wb>def		abc\ndef\n-==\nghi	y	word boundary \W\w
#?pugs todo 
ok "abc\ndef\n-==\ngh" ~~ /<?wb>def/, 'word boundary \W\w';

#### abc<?wb>		abc\ndef\n-==\nghi	y	word boundary \w\W
#?pugs todo 
ok "abc\ndef\n-==\nghi" ~~ /abc<?wb>/, 'word boundary \w\W';

#### <?wb>abc		abc\ndef\n-==\nghi	y	BOS word boundary
#?pugs todo 
ok "abc\ndef\n-==\nghi" ~~ /<?wb>abc/, 'BOS word boundary';

#### ghi<?wb>		abc\ndef\n-==\nghi	y	EOS word boundary
#?pugs todo 
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
#?pugs todo 
ok "abc\ndef\n-==\nghi" ~~ /a<!wb>/, '\w\w nonword boundary';

#### \-<!wb>			abc\ndef\n-==\nghi	y	\W\W nonword boundary
#?pugs todo 
ok "abc\ndef\n-==\nghi" ~~ /\-<!wb>/, '\W\W nonword boundary';


#### <upper>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<upper>: <A @ 45>/		<upper>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<upper>/) && matchcheck($/, q/mob<upper>: <A @ 45>/), '<upper>';

#### <+upper>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <A @ 45>/			<+upper>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+upper>/) && matchcheck($/, q/mob: <A @ 45>/), '<+upper>';

#### <+upper>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <ABCDEFGHIJ @ 45>/	<+upper>+
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+upper>+/) && matchcheck($/, q/mob: <ABCDEFGHIJ @ 45>/), '<+upper>+';


#### <lower>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<lower>: <a @ 55>/		<lower>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<lower>/) && matchcheck($/, q/mob<lower>: <a @ 55>/), '<lower>';

#### <+lower>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <a @ 55>/			<+lower>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+lower>/) && matchcheck($/, q/mob: <a @ 55>/), '<+lower>';

#### <+lower>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <abcdefghij @ 55>/	<+lower>+
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+lower>+/) && matchcheck($/, q/mob: <abcdefghij @ 55>/), '<+lower>+';

#### <alpha>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<alpha>: <A @ 45>/		<alpha>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<alpha>/) && matchcheck($/, q/mob<alpha>: <A @ 45>/), '<alpha>';

#### <+alpha>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <A @ 45>/			<+alpha>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+alpha>/) && matchcheck($/, q/mob: <A @ 45>/), '<+alpha>';

#### <+alpha>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <ABCDEFGHIJabcdefghij @ 45>/	<+alpha>+
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+alpha>+/) && matchcheck($/, q/mob: <ABCDEFGHIJabcdefghij @ 45>/), '<+alpha>+';


#### <digit>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<digit>: <0 @ 35>/		<digit>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<digit>/) && matchcheck($/, q/mob<digit>: <0 @ 35>/), '<digit>';

#### <+digit>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <0 @ 35>/			<+digit>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+digit>/) && matchcheck($/, q/mob: <0 @ 35>/), '<+digit>';

#### <+digit>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <0123456789 @ 35>/	<+digit>+
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+digit>+/) && matchcheck($/, q/mob: <0123456789 @ 35>/), '<+digit>+';


#### <xdigit>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<xdigit>: <0 @ 35>/		<xdigit>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<xdigit>/) && matchcheck($/, q/mob<xdigit>: <0 @ 35>/), '<xdigit>';

#### <+xdigit>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <0 @ 35>/			<+xdigit>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+xdigit>/) && matchcheck($/, q/mob: <0 @ 35>/), '<+xdigit>';

#### <+xdigit>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <0123456789ABCDEF @ 35>/	<+xdigit>+
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+xdigit>+/) && matchcheck($/, q/mob: <0123456789ABCDEF @ 35>/), '<+xdigit>+';


#### <space>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<space>: <\t @ 0>/		<space>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<space>/) && matchcheck($/, q/mob<space>: <\t @ 0>/), '<space>';

#### <+space>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <\t @ 0>/		<+space>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+space>/) && matchcheck($/, q/mob: <\t @ 0>/), '<+space>';

#### <+space>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <\t\n\r  @ 0>/		<+space>+
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+space>+/) && matchcheck($/, q/mob: <\t\n\r  @ 0>/), '<+space>+';


#### <blank>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<blank>: <\t @ 0>/		<blank>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<blank>/) && matchcheck($/, q/mob<blank>: <\t @ 0>/), '<blank>';

#### <+blank>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <\t @ 0>/			<+blank>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+blank>/) && matchcheck($/, q/mob: <\t @ 0>/), '<+blank>';

#### <+blank>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <\t @ 0>/			<+blank>+
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+blank>+/) && matchcheck($/, q/mob: <\t @ 0>/), '<+blank>+';

#?niecza 3 todo "Unable to resolve method cntrl in class Cursor"

#### <cntrl>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<cntrl>: <\t @ 0>/		<cntrl>
#?rakudo todo '<cntrl>'
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<cntrl>/) && matchcheck($/, q/mob<cntrl>: <\t @ 0>/), '<cntrl>';

#### <+cntrl>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <\t @ 0>/			<+cntrl>
#?rakudo todo '<cntrl>'
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+cntrl>/) && matchcheck($/, q/mob: <\t @ 0>/), '<+cntrl>';

#### <+cntrl>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <\t\n\r @ 0>/		<+cntrl>+
#?rakudo todo '<cntrl>'
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+cntrl>+/) && matchcheck($/, q/mob: <\t\n\r @ 0>/), '<+cntrl>+';


#### <punct>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<punct>: <! @ 4>/		<punct>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<punct>/) && matchcheck($/, q/mob<punct>: <! @ 4>/), '<punct>';

#### <+punct>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <! @ 4>/			<+punct>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+punct>/) && matchcheck($/, q/mob: <! @ 4>/), '<+punct>';

#### <+punct>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <!"#$%&/		<+punct>+
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+punct>+/) && matchcheck($/, q/mob: <!"#$%&/), '<+punct>+';


#### <alnum>		\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob<alnum>: <0 @ 35>/		<alnum>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<alnum>/) && matchcheck($/, q/mob<alnum>: <0 @ 35>/), '<alnum>';

#### <+alnum>	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <0 @ 35>/	<+alnum>
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+alnum>/) && matchcheck($/, q/mob: <0 @ 35>/), '<+alnum>';

#### <+alnum>+	\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij	/mob: <0123456789ABCDEFGHIJabcdefghij @ 35>/	<+alnum>+
#?pugs todo 
ok ('\t\n\r !"#$%&\'()*+,-./:;<=>?@[\]^`_{|}0123456789ABCDEFGHIJabcdefghij' ~~ /<+alnum>+/) && matchcheck($/, q/mob: <0123456789ABCDEFGHIJabcdefghij @ 35>/), '<+alnum>+';

#### <+alnum+[_]>	ident_1				y	union of character classes
#?pugs todo 
ok 'ident_1' ~~ /<+alnum+[_]>/, 'union of character classes';

#### <+[ab]+[\-]>+	aaa-bbb				y	enumerated character classes
#?pugs todo 
ok 'aaa-bbb' ~~ /<+[ab]+[\-]>+/, 'enumerated character classes';

#### <+  [ a  b ]+[\-]>+		aaa-bbb		y	whitespace is ignored within square brackets and after the initial +
#?niecza skip "+  [ ] fails"
#?pugs todo 
ok 'aaa-bbb' ~~ /<+  [ a  b ]+[\-]>+/, 'whitespace is ignored within square brackets and after the initial +';

#### <+[ab]+[\-]>+	-ab-				y	enumerated character classes variant
#?pugs todo 
ok '-ab-' ~~ /<+[ab]+[\-]>+/, 'enumerated character classes variant';

#### <+[ab]+[\-]>+	----				y	enumerated character classes variant
#?pugs todo 
ok '----' ~~ /<+[ab]+[\-]>+/, 'enumerated character classes variant';

#### <+[ab]+[\-]>+	-				y	enumerated character classes variant
#?pugs todo 
ok '-' ~~ /<+[ab]+[\-]>+/, 'enumerated character classes variant';

#### <-[ab]+[cd]>+	ccdd				y	enumerated character classes variant
#?pugs todo 
ok 'ccdd' ~~ /<-[ab]+[cd]>+/, 'enumerated character classes variant';

#### ^<-[ab]+[cd]>+$	caad				n	enumerated character classes variant
ok 'caad' !~~ /^<-[ab]+[cd]>+$/, 'enumerated character classes variant';

#### <-  [ a  b ]+[cd]>+	ccdd			y	whitespace is ignored within square brackets and after the initial -
#?niecza skip "+  [ ] fails"
#?pugs todo 
ok 'ccdd' ~~ /<-  [ a  b ]+[cd]>+/, 'whitespace is ignored within square brackets and after the initial -';

#### ^<-upper>dent	ident_1				y	inverted character class
#?pugs todo 
ok 'ident_1' ~~ /^<-upper>dent/, 'inverted character class';

#### ^<-upper>dent	Ident_1				n	inverted character class
ok 'Ident_1' !~~ /^<-upper>dent/, 'inverted character class';

#### <+alpha-[Jj]>+	abc				y	character class with no j
#?pugs todo 
ok 'abc' ~~ /<+alpha-[Jj]>+/, 'character class with no j';

#### <+ alpha - [ Jj ]>	abc			y	character class with no j with ws
#?niecza skip "Unable to resolve method alpha in class Cursor"
#?pugs todo 
ok 'abc' ~~ /<+ alpha - [ Jj ]>/, 'character class with no j with ws';

#### ^<+alpha-[Jj]>+$	aJc			n	character class with no j fail
ok 'aJc' !~~ /^<+alpha-[Jj]>+$/, 'character class with no j fail';


##  syntax errors

#### {{		abcdef		/Missing closing braces/	unterminated closure
#?pugs todo 
eval_dies_ok '/{{/', 'unterminated closure';

#### \1		abcdef		/reserved/			back references
#?pugs todo 
eval_dies_ok '/\1/', 'back references';

#### \x[		abcdef		/Missing close bracket/		unterminated \x[..]
#?pugs todo 
eval_dies_ok '/\x[/', 'unterminated \x[..]';

#### \X[		abcdef		/Missing close bracket/		unterminated \X[..]
#?pugs todo 
eval_dies_ok '/\X[/', 'unterminated \X[..]';


#### * abc		abcdef		/Quantifier follows nothing/	bare * at start
#?pugs todo 
eval_dies_ok '/* abc/', 'bare * at start';

####   * abc		abcdef		/Quantifier follows nothing/	bare * after ws
#?pugs todo 
eval_dies_ok '/  * abc/', 'bare * after ws';

#### [*|a]		abcdef		/Quantifier follows nothing/	bare * after [
#?pugs todo 
eval_dies_ok '/[*|a]/', 'bare * after [';

#### [ *|a]		abcdef		/Quantifier follows nothing/	bare * after [+sp
#?pugs todo 
eval_dies_ok '/[ *|a]/', 'bare * after [+sp';

#### [a|*]		abcdef		/Quantifier follows nothing/	bare * after |
#?pugs todo 
eval_dies_ok '/[a|*]/', 'bare * after |';

#### [a| *]		abcdef		/Quantifier follows nothing/	bare * after |+sp
#?pugs todo 
eval_dies_ok '/[a| *]/', 'bare * after |+sp';


#### + abc		abcdef		/Quantifier follows nothing/	bare + at start
#?pugs todo 
eval_dies_ok '/+ abc/', 'bare + at start';

####   + abc		abcdef		/Quantifier follows nothing/	bare + after ws
#?pugs todo 
eval_dies_ok '/  + abc/', 'bare + after ws';

#### [+|a]		abcdef		/Quantifier follows nothing/	bare + after [
#?pugs todo 
eval_dies_ok '/[+|a]/', 'bare + after [';

#### [ +|a]		abcdef		/Quantifier follows nothing/	bare + after [+sp
#?pugs todo 
eval_dies_ok '/[ +|a]/', 'bare + after [+sp';

#### [a|+]		abcdef		/Quantifier follows nothing/	bare + after |
#?pugs todo 
eval_dies_ok '/[a|+]/', 'bare + after |';

#### [a| +]		abcdef		/Quantifier follows nothing/	bare + after |+sp
#?pugs todo 
eval_dies_ok '/[a| +]/', 'bare + after |+sp';


#### ? abc		abcdef		/Quantifier follows nothing/	bare ? at start
#?pugs todo 
eval_dies_ok '/? abc/', 'bare ? at start';

####   ? abc		abcdef		/Quantifier follows nothing/	bare ? after ws
#?pugs todo 
eval_dies_ok '/  ? abc/', 'bare ? after ws';

#### [?|a]		abcdef		/Quantifier follows nothing/	bare ? after [
#?pugs todo 
eval_dies_ok '/[?|a]/', 'bare ? after [';

#### [ ?|a]		abcdef		/Quantifier follows nothing/	bare ? after [+sp
#?pugs todo 
eval_dies_ok '/[ ?|a]/', 'bare ? after [+sp';

#### [a|?]		abcdef		/Quantifier follows nothing/	bare ? after |
#?pugs todo 
eval_dies_ok '/[a|?]/', 'bare ? after |';

#### [a| ?]		abcdef		/Quantifier follows nothing/	bare ? after |+sp
#?pugs todo 
eval_dies_ok '/[a| ?]/', 'bare ? after |+sp';

# L<S05/Nothing is illegal/"The empty pattern is now illegal">

#### 		abcdef		/Null pattern illegal/		null pattern
eval_dies_ok '//', '';

####   		abcdef		/Null pattern illegal/		ws null pattern
#?pugs todo 
eval_dies_ok '/  /', 'ws null pattern';

#?rakudo todo 'RT 70606'
#?pugs todo 
eval_dies_ok '"b" ~~ /b| /', 'null pattern after alternation';

# RT #70007
# undefined captures should fail to match
# note the use of $1 (and not $0)
#?niecza todo 'undefined capture'
nok 'aa' ~~ /(.)$1/, 'undefined captures do not match';

# RT #71702
#?niecza todo 'allows them'
eval_dies_ok '"foo" ~~ /<[d..b]>? foo/', 'no reversed char ranges';

done;
# vim: ft=perl6 sw=4 expandtab
