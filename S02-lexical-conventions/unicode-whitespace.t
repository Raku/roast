use v6;

use Test;

plan 52;

# L<S02/"Unicode Semantics"/"Unicode horizontal whitespace">

is(eval('
my	@x	=	<a	b	c>;	sub	y	(@z)	{	@z[1]	};	y(@x)
'), "b", "CHARACTER TABULATION");

is(eval('
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

is(eval('
my@x=<abc>;suby(@z){@z[1]};y(@x)
'), "b", "LINE TABULATION");

#?niecza skip 'Malformed my'
is(eval('
my@x =<abc>;suby(@z){@z[1]};y(@x)
'), "b", "FORM FEED (FF)");

is(eval('
my@x =<abc>;suby(@z){@z[1]};y(@x)
'), "b", "CARRIAGE RETURN (CR)");

is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "SPACE");

#?niecza skip 'Malformed my'
is(eval('
my@x =<abc>;suby(@z){@z[1]};y(@x)
'), "b", "NEXT LINE (NEL)");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "NO-BREAK SPACE");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "OGHAM SPACE MARK");

#?niecza skip 'Malformed my'
is(eval('
my᠎@x᠎=᠎<a᠎b᠎c>;᠎sub᠎y᠎(@z)᠎{᠎@z[1]᠎};᠎y(@x)
'), "b", "MONGOLIAN VOWEL SEPARATOR");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EN QUAD");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EM QUAD");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EN SPACE");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EM SPACE");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "THREE-PER-EM SPACE");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "FOUR-PER-EM SPACE");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "SIX-PER-EM SPACE");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "FIGURE SPACE");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "PUNCTUATION SPACE");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "THIN SPACE");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "HAIR SPACE");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "LINE SEPARATOR");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "PARAGRAPH SEPARATOR");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "NARROW NO-BREAK SPACE");

#?niecza skip 'Malformed my'
is(eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "MEDIUM MATHEMATICAL SPACE");

is(eval('
my　@x　=　<a　b　c>;　sub　y　(@z)　{　@z[1]　};　y(@x)
'), "b", "IDEOGRAPHIC SPACE");

#Long dot whitespace tests
#These currently get different results than the above

#This makes 'foo.lc' and 'foo .lc' mean different things
multi foo() { 'a' }
multi foo($x) { $x }

$_ = 'b';

# L<S02/"Unicode Semantics"/"Unicode horizontal whitespace">
#?niecza skip 'System.NullReferenceException: Object reference not set to an instance of an object'
is(eval('foo\	.lc'), 'a', 'long dot with CHARACTER TABULATION');
#?niecza skip 'System.NullReferenceException: Object reference not set to an instance of an object'
is(eval('foo\
.lc'), 'a', 'long dot with LINE FEED (LF)');
#?niecza skip 'System.NullReferenceException: Object reference not set to an instance of an object'
is(eval('foo\.lc'), 'a', 'long dot with LINE TABULATION');
#?niecza skip 'Confused'
is(eval('foo\.lc'), 'a', 'long dot with FORM FEED (FF)');
#?niecza skip 'System.NullReferenceException: Object reference not set to an instance of an object'
is(eval('foo\.lc'), 'a', 'long dot with CARRIAGE RETURN (CR)');
#?niecza skip 'System.NullReferenceException: Object reference not set to an instance of an object'
is(eval('foo\ .lc'), 'a', 'long dot with SPACE');
#?niecza skip 'Confused'
is(eval('foo\.lc'), 'a', 'long dot with NEXT LINE (NEL)');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with NO-BREAK SPACE');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with OGHAM SPACE MARK');
#?niecza skip 'Confused'
is(eval('foo\᠎.lc'), 'a', 'long dot with MONGOLIAN VOWEL SEPARATOR');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with EN QUAD');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with EM QUAD');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with EN SPACE');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with EM SPACE');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with THREE-PER-EM SPACE');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with FOUR-PER-EM SPACE');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with SIX-PER-EM SPACE');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with FIGURE SPACE');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with PUNCTUATION SPACE');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with THIN SPACE');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with HAIR SPACE');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with LINE SEPARATOR');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with PARAGRAPH SEPARATOR');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with NARROW NO-BREAK SPACE');
#?niecza skip 'Confused'
is(eval('foo\ .lc'), 'a', 'long dot with MEDIUM MATHEMATICAL SPACE');
#?niecza skip 'Confused'
is(eval('foo\　.lc'), 'a', 'long dot with IDEOGRAPHIC SPACE');

# vim: ft=perl6
