use v6;

use Test;

plan 52;

sub try_eval($str) { try eval $str }

# L<S02/"Unicode Semantics"/"Unicode horizontal whitespace">

is(try_eval('
my	@x	=	<a	b	c>;	sub	y	(@z)	{	@z[1]	};	y(@x)
'), "b", "CHARACTER TABULATION");

is(try_eval('
my
@x
 =
<a
b
c>;
sub
y
(@z)
{
@z[1]
};
y(@x)
'), "b", "LINE FEED (LF)");

is(try_eval('
my@x=<abc>;suby(@z){@z[1]};y(@x)
'), "b", "LINE TABULATION");

#?niecza todo 'Malformed my'
is(try_eval('
my@x =<abc>;suby(@z){@z[1]};y(@x)
'), "b", "FORM FEED (FF)");

is(try_eval('
my@x =<abc>;suby(@z){@z[1]};y(@x)
'), "b", "CARRIAGE RETURN (CR)");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "SPACE");

#?niecza todo 'Malformed my'
is(try_eval('
my@x =<abc>;suby(@z){@z[1]};y(@x)
'), "b", "NEXT LINE (NEL)");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "NO-BREAK SPACE");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "OGHAM SPACE MARK");

#?niecza todo 'Malformed my'
is(try_eval('
my᠎@x᠎=᠎<a᠎b᠎c>;᠎sub᠎y᠎(@z)᠎{᠎@z[1]᠎};᠎y(@x)
'), "b", "MONGOLIAN VOWEL SEPARATOR");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EN QUAD");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EM QUAD");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EN SPACE");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EM SPACE");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "THREE-PER-EM SPACE");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "FOUR-PER-EM SPACE");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "SIX-PER-EM SPACE");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "FIGURE SPACE");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "PUNCTUATION SPACE");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "THIN SPACE");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "HAIR SPACE");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "LINE SEPARATOR");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "PARAGRAPH SEPARATOR");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "NARROW NO-BREAK SPACE");

#?niecza todo 'Malformed my'
is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "MEDIUM MATHEMATICAL SPACE");

is(try_eval('
my　@x　=　<a　b　c>;　sub　y　(@z)　{　@z[1]　};　y(@x)
'), "b", "IDEOGRAPHIC SPACE");

#Long dot whitespace tests
#These currently get different results than the above

#This makes 'foo.lc' and 'foo .lc' mean different things
multi foo() { 'a' }
multi foo($x) { $x }

$_ = 'b';

# L<S02/"Unicode Semantics"/"Unicode horizontal whitespace">
is(try_eval('foo\	.lc'), 'a', 'long dot with CHARACTER TABULATION');
is(try_eval('foo\
.lc'), 'a', 'long dot with LINE FEED (LF)');
is(try_eval('foo\.lc'), 'a', 'long dot with LINE TABULATION');
#?niecza todo 'Confused'
is(try_eval('foo\.lc'), 'a', 'long dot with FORM FEED (FF)');
is(try_eval('foo\.lc'), 'a', 'long dot with CARRIAGE RETURN (CR)');
is(try_eval('foo\ .lc'), 'a', 'long dot with SPACE');
#?niecza todo 'Confused'
is(try_eval('foo\.lc'), 'a', 'long dot with NEXT LINE (NEL)');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with NO-BREAK SPACE');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with OGHAM SPACE MARK');
#?niecza todo 'Confused'
is(try_eval('foo\᠎.lc'), 'a', 'long dot with MONGOLIAN VOWEL SEPARATOR');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with EN QUAD');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with EM QUAD');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with EN SPACE');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with EM SPACE');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with THREE-PER-EM SPACE');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with FOUR-PER-EM SPACE');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with SIX-PER-EM SPACE');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with FIGURE SPACE');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with PUNCTUATION SPACE');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with THIN SPACE');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with HAIR SPACE');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with LINE SEPARATOR');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with PARAGRAPH SEPARATOR');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with NARROW NO-BREAK SPACE');
#?niecza todo 'Confused'
is(try_eval('foo\ .lc'), 'a', 'long dot with MEDIUM MATHEMATICAL SPACE');
is(try_eval('foo\　.lc'), 'a', 'long dot with IDEOGRAPHIC SPACE');

# vim: ft=perl6
