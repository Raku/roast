use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/stdrules.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

# L<S05/Extensible metasyntax (C<< <...> >>)/"The special named assertions include">

plan 183;

#?pugs emit force_todo(9,12,13,15,16);

#?niecza 3 todo '#85'
ok("abc1_2" ~~ m/^ <ident> $/, '<ident>');
is($/<ident>, 'abc1_2', 'Captured <ident>');
ok("abc1_2" ~~ m/^ <.ident> $/, '<.ident>');
ok(!defined($/<ident>), 'Uncaptured <.ident>');
ok(!( "7abc1_2" ~~ m/^ <.ident> $/ ), 'not <.ident>');

ok("\t \n\t" ~~ m/^ <.ws> $/, '<.ws>');
ok(!defined($/<ws>), 'Uncaptured <.ws>');
ok(!( "7abc1_2" ~~ m/^ <.ws> $/ ), 'not <.ws>');

ok(" \t\t \t" ~~ m/^ (\h+) $/, '\h');
is($/, " \t\t \t", 'captured \h');
ok(!( " \t\n " ~~ m/^ (\h+) $/ ), 'not \h');

ok("\n\n" ~~ m/^ (\v+) $/, '\v');
is($/, "\n\n", 'captured \v');
ok(!( " \t\n " ~~ m/^ (\v+) $/ ), 'not \v');

# alpha

ok("A" ~~ m/^<.alpha>$/, q{Match alpha as subrule});
ok(!( "A" ~~ m/^<!alpha>.$/ ), q{Don't match negated alpha as subrule} );
ok(!( "A" ~~ m/^<-alpha>$/ ), q{Don't match inverted alpha as subrule} );
ok(!( "\x07"  ~~ m/^<.alpha>$/ ), q{Don't match unrelated alpha as subrule} );
ok("\x07"  ~~ m/^<!alpha>.$/, q{Match unrelated negated alpha as subrule});
ok("\x07"  ~~ m/^<-alpha>$/, q{Match unrelated inverted alpha as subrule});
 
ok("A" ~~ m/^<+alpha>$/, q{Match alpha as charset});
ok("A" ~~ m/^<+[A]+alpha>$/, q{Match compound alpha as charset});
ok(!( "A" ~~ m/^<-alpha>$/ ), q{Don't match inverted alpha as charset} );
ok(!( "A" ~~ m/^<+[A]-alpha>$/ ), q{Don't match compound inverted alpha as charset} );
ok(!( "\x07"  ~~ m/^<+alpha>$/ ), q{Don't match unrelated alpha as charset} );
ok("\x07"  ~~ m/^<-alpha>$/, q{Match inverted alpha as charset});
ok("\x07A" ~~ m/<+alpha>/, q{Match unanchored alpha as charset});

# space

#?niecza skip 'Unable to resolve method space in class Cursor'
{
    ok("\x[9]" ~~ m/^<.space>$/, q{Match space as subrule});
    ok(!( "\x[9]" ~~ m/^<!space>.$/ ), q{Don't match negated space as subrule} );
    ok(!( "\x[9]" ~~ m/^<-space>$/ ), q{Don't match inverted space as subrule} );
    ok(!( "("  ~~ m/^<.space>$/ ), q{Don't match unrelated space as subrule} );
    ok("("  ~~ m/^<!space>.$/, q{Match unrelated negated space as subrule});
    ok("("  ~~ m/^<-space>$/, q{Match unrelated inverted space as subrule});
    
    ok("\x[9]" ~~ m/^<+space>$/, q{Match space as charset});
    ok("\x[9]" ~~ m/^<+[A]+space>$/, q{Match compound space as charset});
    ok(!( "\x[9]" ~~ m/^<-space>$/ ), q{Don't match externally inverted space as charset} );
    ok(!( "\x[9]" ~~ m/^<+[A]-space>$/ ), q{Don't match compound inverted space as charset} );
    ok(!( "\x[9]" ~~ m/^<-space>$/ ), q{Don't match internally inverted space as charset} );
    ok(!( "("  ~~ m/^<+space>$/ ), q{Don't match unrelated space as charset} );
    ok("("  ~~ m/^<-space>$/, q{Match inverted space as charset});
    ok("(\x[9]" ~~ m/<+space>/, q{Match unanchored space as charset});
}

# digit

#?niecza skip 'Unable to resolve method digit in class Cursor'
{
    ok("0" ~~ m/^<.digit>$/, q{Match digit as subrule});
    ok(!( "0" ~~ m/^<!digit>.$/ ), q{Don't match negated digit as subrule} );
    ok(!( "0" ~~ m/^<-digit>$/ ), q{Don't match inverted digit as subrule} );
    ok(!( "\x[C]"  ~~ m/^<.digit>$/ ), q{Don't match unrelated digit as subrule} );
    ok("\x[C]"  ~~ m/^<!digit>.$/, q{Match unrelated negated digit as subrule});
    ok("\x[C]"  ~~ m/^<-digit>$/, q{Match unrelated inverted digit as subrule});
    
    ok("0" ~~ m/^<+digit>$/, q{Match digit as charset});
    ok("0" ~~ m/^<+[A]+digit>$/, q{Match compound digit as charset});
    ok(!( "0" ~~ m/^<-digit>$/ ), q{Don't match externally inverted digit as charset} );
    ok(!( "0" ~~ m/^<+[A]-digit>$/ ), q{Don't match compound inverted digit as charset} );
    ok(!( "0" ~~ m/^<-digit>$/ ), q{Don't match internally inverted digit as charset} );
    ok(!( "\x[C]"  ~~ m/^<+digit>$/ ), q{Don't match unrelated digit as charset} );
    ok("\x[C]"  ~~ m/^<-digit>$/, q{Match inverted digit as charset});
    ok("\x[C]0" ~~ m/<+digit>/, q{Match unanchored digit as charset});
}

# alnum

#?niecza skip 'Unable to resolve method alnum in class Cursor'
{
    ok("n" ~~ m/^<.alnum>$/, q{Match alnum as subrule});
    ok(!( "n" ~~ m/^<!alnum>.$/ ), q{Don't match negated alnum as subrule} );
    ok(!( "n" ~~ m/^<-alnum>$/ ), q{Don't match inverted alnum as subrule} );
    ok(!( '{'  ~~ m/^<.alnum>$/ ), q{Don't match unrelated alnum as subrule} );
    ok('{'  ~~ m/^<!alnum>.$/, q{Match unrelated negated alnum as subrule});
    ok('{'  ~~ m/^<-alnum>$/, q{Match unrelated inverted alnum as subrule});

    ok("n" ~~ m/^<+alnum>$/, q{Match alnum as charset});
    ok("n" ~~ m/^<+[A]+alnum>$/, q{Match compound alnum as charset});
    ok(!( "n" ~~ m/^<-alnum>$/ ), q{Don't match externally inverted alnum as charset} );
    ok(!( "n" ~~ m/^<+[A]-alnum>$/ ), q{Don't match compound inverted alnum as charset} );

    ok(!( "n" ~~ m/^<-alnum>$/ ), q{Don't match internally inverted alnum as charset} );
    ok(!( '{'  ~~ m/^<+alnum>$/ ), q{Don't match unrelated alnum as charset} );
    ok('{'  ~~ m/^<-alnum>$/, q{Match inverted alnum as charset});
    ok('{n' ~~ m/<+alnum>/, q{Match unanchored alnum as charset});
}

# ascii

# Unspecced
# ok("+" ~~ m/^<.ascii>$/, q{Match ascii as subrule});
# ok(!( "+" ~~ m/^<!ascii>.$/ ), q{Don't match negated ascii as subrule} );
# ok(!( "+" ~~ m/^<-ascii>$/ ), q{Don't match inverted ascii as subrule} );
#
# ok("+" ~~ m/^<+ascii>$/, q{Match ascii as charset});
# ok("+" ~~ m/^<+[A]+ascii>$/, q{Match compound ascii as charset});
# ok(!( "+" ~~ m/^<-ascii>$/ ), q{Don't match externally inverted ascii as charset} );
# ok(!( "+" ~~ m/^<+[A]-ascii>$/ ), q{Don't match compound inverted ascii as charset} );
# ok(!( "+" ~~ m/^<-ascii>$/ ), q{Don't match inverted ascii as charset} );
# ok("+" ~~ m/<+ascii>/, q{Match unanchored ascii as charset});

# blank
#?niecza skip 'Unable to resolve method blank in class Cursor'
{
    ok("\x[9]" ~~ m/^<.blank>$/, q{Match blank as subrule});
    ok(!( "\x[9]" ~~ m/^<!blank>.$/ ), q{Don't match negated blank as subrule} );
    ok(!( "\x[9]" ~~ m/^<-blank>$/ ), q{Don't match inverted blank as subrule} );
    ok(!( "&"  ~~ m/^<.blank>$/ ), q{Don't match unrelated blank as subrule} );
    ok("&"  ~~ m/^<!blank>.$/, q{Match unrelated negated blank as subrule});
    ok("&"  ~~ m/^<-blank>$/, q{Match unrelated inverted blank as subrule});
    
    ok("\x[9]" ~~ m/^<+blank>$/, q{Match blank as charset});
    ok("\x[9]" ~~ m/^<+[A]+blank>$/, q{Match compound blank as charset});
    ok(!( "\x[9]" ~~ m/^<-blank>$/ ), q{Don't match externally inverted blank as charset} );
    ok(!( "\x[9]" ~~ m/^<+[A]-blank>$/ ), q{Don't match compound inverted blank as charset} );
    ok(!( "\x[9]" ~~ m/^<-blank>$/ ), q{Don't match internally inverted blank as charset} );
    ok(!( "&"  ~~ m/^<+blank>$/ ), q{Don't match unrelated blank as charset} );
    ok("&"  ~~ m/^<-blank>$/, q{Match inverted blank as charset});
    ok("&\x[9]" ~~ m/<+blank>/, q{Match unanchored blank as charset} );
}

# cntrl

#?niecza skip 'Unable to resolve method cntrl in class Cursor'
{
    ok("\x[7F]" ~~ m/^<.cntrl>$/, q{Match cntrl as subrule});
    ok(!( "\x[7F]" ~~ m/^<!cntrl>.$/ ), q{Don't match negated cntrl as subrule} );
    ok(!( "\x[7F]" ~~ m/^<-cntrl>$/ ), q{Don't match inverted cntrl as subrule} );
    ok(!( "="  ~~ m/^<.cntrl>$/ ), q{Don't match unrelated cntrl as subrule} );
    ok("="  ~~ m/^<!cntrl>.$/, q{Match unrelated negated cntrl as subrule});
    ok("="  ~~ m/^<-cntrl>$/, q{Match unrelated inverted cntrl as subrule});
    
    ok("\x[7F]" ~~ m/^<+cntrl>$/, q{Match cntrl as charset} );
    ok("\x[7F]" ~~ m/^<+[A]+cntrl>$/, q{Match compound cntrl as charset});
    ok(!( "\x[7F]" ~~ m/^<-cntrl>$/ ), q{Don't match externally inverted cntrl as charset} );
    ok(!( "\x[7F]" ~~ m/^<+[A]-cntrl>$/ ), q{Don't match compound inverted cntrl as charset} );
    ok(!( "\x[7F]" ~~ m/^<-cntrl>$/ ), q{Don't match internally inverted cntrl as charset} );
    ok(!( "="  ~~ m/^<+cntrl>$/ ), q{Don't match unrelated cntrl as charset} );
    ok("="  ~~ m/^<-cntrl>$/, q{Match inverted cntrl as charset});
    ok("=\x[7F]" ~~ m/<+cntrl>/, q{Match unanchored cntrl as charset} );
}

# graph

#?niecza skip 'Unable to resolve method cntrl in class Cursor'
#?rakudo skip '<.graph>'
{
    ok("V" ~~ m/^<.graph>$/, q{Match graph as subrule});
    ok(!( "V" ~~ m/^<!graph>.$/ ), q{Don't match negated graph as subrule} );
    ok(!( "V" ~~ m/^<-graph>$/ ), q{Don't match inverted graph as subrule} );
    ok(!( "\x[7F]"  ~~ m/^<.graph>$/ ), q{Don't match unrelated graph as subrule} );
    ok("\x[7F]"  ~~ m/^<!graph>.$/, q{Match unrelated negated graph as subrule});
    ok("\x[7F]"  ~~ m/^<-graph>$/, q{Match unrelated inverted graph as subrule});
 
    ok("V" ~~ m/^<+graph>$/, q{Match graph as charset} );
    ok("V" ~~ m/^<+[A]+graph>$/, q{Match compound graph as charset});
    ok(!( "V" ~~ m/^<-graph>$/ ), q{Don't match externally inverted graph as charset} );
    ok(!( "V" ~~ m/^<+[A]-graph>$/ ), q{Don't match compound inverted graph as charset} );
    ok(!( "V" ~~ m/^<-graph>$/ ), q{Don't match internally inverted graph as charset} );
    ok(!( "\x[7F]"  ~~ m/^<+graph>$/ ), q{Don't match unrelated graph as charset} );
    ok("\x[7F]"  ~~ m/^<-graph>$/, q{Match inverted graph as charset});
    ok("\x[7F]V" ~~ m/<+graph>/, q{Match unanchored graph as charset} );
}

# lower

#?niecza skip 'Unable to resolve method lower in class Cursor'
{
    ok("a" ~~ m/^<.lower>$/, q{Match lower as subrule});
    ok(!( "a" ~~ m/^<!lower>.$/ ), q{Don't match negated lower as subrule} );
    ok(!( "a" ~~ m/^<-lower>$/ ), q{Don't match inverted lower as subrule} );
    ok(!( "\x[1E]"  ~~ m/^<.lower>$/ ), q{Don't match unrelated lower as subrule} );
    ok("\x[1E]"  ~~ m/^<!lower>.$/, q{Match unrelated negated lower as subrule});
    ok("\x[1E]"  ~~ m/^<-lower>$/, q{Match unrelated inverted lower as subrule});

    ok("a" ~~ m/^<+lower>$/, q{Match lower as charset} );
    ok("a" ~~ m/^<+[A]+lower>$/, q{Match compound lower as charset});
    ok(!( "a" ~~ m/^<-lower>$/ ), q{Don't match externally inverted lower as charset} );
    ok(!( "a" ~~ m/^<+[A]-lower>$/ ), q{Don't match compound inverted lower as charset} );
    ok(!( "a" ~~ m/^<-lower>$/ ), q{Don't match internally inverted lower as charset} );
    ok(!( "\x[1E]"  ~~ m/^<+lower>$/ ), q{Don't match unrelated lower as charset} );
    ok("\x[1E]"  ~~ m/^<-lower>$/, q{Match inverted lower as charset});
    ok("\x[1E]a" ~~ m/<+lower>/, q{Match unanchored lower as charset} );
}

# print

#?niecza skip 'Unable to resolve method lower in class Cursor'
#?rakudo skip '<.print>'
{
    ok("M" ~~ m/^<.print>$/, q{Match print as subrule});
    ok(!( "M" ~~ m/^<!print>.$/ ), q{Don't match negated print as subrule} );
    ok(!( "M" ~~ m/^<-print>$/ ), q{Don't match inverted print as subrule} );
    ok(!( "\x[7F]"  ~~ m/^<.print>$/ ), q{Don't match unrelated print as subrule} );
    ok("\x[7F]"  ~~ m/^<!print>.$/, q{Match unrelated negated print as subrule});
    ok("\x[7F]"  ~~ m/^<-print>$/, q{Match unrelated inverted print as subrule});

    ok("M" ~~ m/^<+print>$/, q{Match print as charset} );
    ok("M" ~~ m/^<+[A]+print>$/, q{Match compound print as charset});
    ok(!( "M" ~~ m/^<-print>$/ ), q{Don't match externally inverted print as charset} );
    ok(!( "M" ~~ m/^<+[A]-print>$/ ), q{Don't match compound inverted print as charset} );
    ok(!( "M" ~~ m/^<-print>$/ ), q{Don't match internally inverted print as charset} );
    ok(!( "\x[7F]"  ~~ m/^<+print>$/ ), q{Don't match unrelated print as charset} );
    ok("\x[7F]"  ~~ m/^<-print>$/, q{Match inverted print as charset});
    ok("\x[7F]M" ~~ m/<+print>/, q{Match unanchored print as charset} );
}

# punct

#?niecza skip 'Unable to resolve method punct in class Cursor'
{
    ok("[" ~~ m/^<.punct>$/, q{Match punct as subrule});
    ok(!( "[" ~~ m/^<!punct>.$/ ), q{Don't match negated punct as subrule} );
    ok(!( "[" ~~ m/^<-punct>$/ ), q{Don't match inverted punct as subrule} );
    ok(!( "F"  ~~ m/^<.punct>$/ ), q{Don't match unrelated punct as subrule} );
    ok("F"  ~~ m/^<!punct>.$/, q{Match unrelated negated punct as subrule});
    ok("F"  ~~ m/^<-punct>$/, q{Match unrelated inverted punct as subrule});

    ok("[" ~~ m/^<+punct>$/, q{Match punct as charset} );
    ok("[" ~~ m/^<+[A]+punct>$/, q{Match compound punct as charset});
    ok(!( "[" ~~ m/^<-punct>$/ ), q{Don't match externally inverted punct as charset} );
    ok(!( "[" ~~ m/^<+[A]-punct>$/ ), q{Don't match compound inverted punct as charset} );
    ok(!( "[" ~~ m/^<-punct>$/ ), q{Don't match internally inverted punct as charset} );
    ok(!( "F"  ~~ m/^<+punct>$/ ), q{Don't match unrelated punct as charset} );
    ok("F"  ~~ m/^<-punct>$/, q{Match inverted punct as charset});
    ok("F[" ~~ m/<+punct>/, q{Match unanchored punct as charset} );
}

# upper

#?niecza skip 'Unable to resolve method upper in class Cursor'
{
    ok("A" ~~ m/^<.upper>$/, q{Match upper as subrule});
    ok(!( "A" ~~ m/^<!upper>.$/ ), q{Don't match negated upper as subrule} );
    ok(!( "A" ~~ m/^<-upper>$/ ), q{Don't match inverted upper as subrule} );
    ok(!( "\x[5F]"  ~~ m/^<.upper>$/ ), q{Don't match unrelated upper as subrule} );
    ok("\x[5F]"  ~~ m/^<!upper>.$/, q{Match unrelated negated upper as subrule});
    ok("\x[5F]"  ~~ m/^<-upper>$/, q{Match unrelated inverted upper as subrule});

    ok("A" ~~ m/^<+upper>$/, q{Match upper as charset} );
    ok("A" ~~ m/^<+[A]+upper>$/, q{Match compound upper as charset});
    
    ok(!( "A" ~~ m/^<-upper>$/ ), q{Don't match externally inverted upper as charset} );
    ok(!( "A" ~~ m/^<+[A]-upper>$/ ), q{Don't match compound inverted upper as charset} );
    ok(!( "A" ~~ m/^<-upper>$/ ), q{Don't match internally inverted upper as charset} );
    ok(!( "\x[5F]"  ~~ m/^<+upper>$/ ), q{Don't match unrelated upper as charset} );
    ok("\x[5F]"  ~~ m/^<-upper>$/, q{Match inverted upper as charset});
    ok("\x[5F]A" ~~ m/<+upper>/, q{Match unanchored upper as charset} );
}

# word
# unspecced
# ok("b" ~~ m/^<.word>$/, q{Match word as subrule});
# ok(!( "b" ~~ m/^<!word>.$/ ), q{Don't match negated word as subrule} );
# ok(!( "b" ~~ m/^<-word>$/ ), q{Don't match inverted word as subrule} );
# ok(!( '{'  ~~ m/^<.word>$/ ), q{Don't match unrelated word as subrule} );
# ok('{'  ~~ m/^<!word>.$/, q{Match unrelated negated word as subrule} );
# ok('{'  ~~ m/^<-word>$/, q{Match unrelated inverted word as subrule});
# 
# ok("b" ~~ m/^<+word>$/, q{Match word as charset} );
# ok("b" ~~ m/^<+[A]+word>$/, q{Match compound word as charset});
# ok(!( "b" ~~ m/^<-word>$/ ), q{Don't match externally inverted word as charset} );
# ok(!( "b" ~~ m/^<+[A]-word>$/ ), q{Don't match compound inverted word as charset} );
# ok(!( "b" ~~ m/^<-word>$/ ), q{Don't match internally inverted word as charset} );
# ok(!( '{'  ~~ m/^<+word>$/ ), q{Don't match unrelated word as charset} );
# ok('{'  ~~ m/^<-word>$/, q{Match inverted word as charset});
# ok('{b' ~~ m/<+word>/, q{Match unanchored word as charset} );

# xdigit

#?niecza skip 'Unable to resolve method xdigit in class Cursor'
{
    ok("0" ~~ m/^<.xdigit>$/, q{Match xdigit as subrule});
    ok(!( "0" ~~ m/^<!xdigit>.$/ ), q{Don't match negated xdigit as subrule} );
    ok(!( "0" ~~ m/^<-xdigit>$/ ), q{Don't match inverted xdigit as subrule} );
    ok(!( "}"  ~~ m/^<.xdigit>$/ ), q{Don't match unrelated xdigit as subrule} );
    ok("}"  ~~ m/^<!xdigit>.$/, q{Match unrelated negated xdigit as subrule});
    ok("}"  ~~ m/^<-xdigit>$/, q{Match unrelated inverted xdigit as subrule});

    ok("0" ~~ m/^<+xdigit>$/, q{Match xdigit as charset} );
    ok("0" ~~ m/^<+[A]+xdigit>$/, q{Match compound xdigit as charset});
    ok(!( "0" ~~ m/^<-xdigit>$/ ), q{Don't match externally inverted xdigit as charset} );
    ok(!( "0" ~~ m/^<+[A]-xdigit>$/ ), q{Don't match compound inverted xdigit as charset} );
    ok(!( "0" ~~ m/^<-xdigit>$/ ), q{Don't match internally inverted xdigit as charset} );
    ok(!( "}"  ~~ m/^<+xdigit>$/ ), q{Don't match unrelated xdigit as charset} );
    ok("}"  ~~ m/^<-xdigit>$/, q{Match inverted xdigit as charset});
    ok("}0" ~~ m/<+xdigit>/, q{Match unanchored xdigit as charset} );
}

# L<S05/Predefined Subrules/always returns false>

#?rakudo 2 skip '<!>'
ok 'abc' !~~ /a <!>/, '<!> fails';
ok '' !~~ /<!>/, '<!> fails (empty string)';

# vim: ft=perl6
