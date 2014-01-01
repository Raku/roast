use v6;

use Test;

plan 52;

sub try_eval($str) { try EVAL $str }

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

is(try_eval('
my@x =<abc>;suby(@z){@z[1]};y(@x)
'), "b", "FORM FEED (FF)");

is(try_eval('
my@x =<abc>;suby(@z){@z[1]};y(@x)
'), "b", "CARRIAGE RETURN (CR)");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "SPACE");

is(try_eval('
my@x =<abc>;suby(@z){@z[1]};y(@x)
'), "b", "NEXT LINE (NEL)");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "NO-BREAK SPACE");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "OGHAM SPACE MARK");

is(try_eval('
my᠎@x᠎=᠎<a᠎b᠎c>;᠎sub᠎y᠎(@z)᠎{᠎@z[1]᠎};᠎y(@x)
'), "b", "MONGOLIAN VOWEL SEPARATOR");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EN QUAD");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EM QUAD");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EN SPACE");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "EM SPACE");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "THREE-PER-EM SPACE");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "FOUR-PER-EM SPACE");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "SIX-PER-EM SPACE");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "FIGURE SPACE");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "PUNCTUATION SPACE");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "THIN SPACE");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "HAIR SPACE");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "LINE SEPARATOR");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "PARAGRAPH SEPARATOR");

is(try_eval('
my @x = <a b c>; sub y (@z) { @z[1] }; y(@x)
'), "b", "NARROW NO-BREAK SPACE");

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
is(try_eval('foo\.lc'), 'a', 'long dot with FORM FEED (FF)');
is(try_eval('foo\.lc'), 'a', 'long dot with CARRIAGE RETURN (CR)');
is(try_eval('foo\ .lc'), 'a', 'long dot with SPACE');
is(try_eval('foo\.lc'), 'a', 'long dot with NEXT LINE (NEL)');
is(try_eval('foo\ .lc'), 'a', 'long dot with NO-BREAK SPACE');
is(try_eval('foo\ .lc'), 'a', 'long dot with OGHAM SPACE MARK');
is(try_eval('foo\᠎.lc'), 'a', 'long dot with MONGOLIAN VOWEL SEPARATOR');
is(try_eval('foo\ .lc'), 'a', 'long dot with EN QUAD');
is(try_eval('foo\ .lc'), 'a', 'long dot with EM QUAD');
is(try_eval('foo\ .lc'), 'a', 'long dot with EN SPACE');
is(try_eval('foo\ .lc'), 'a', 'long dot with EM SPACE');
is(try_eval('foo\ .lc'), 'a', 'long dot with THREE-PER-EM SPACE');
is(try_eval('foo\ .lc'), 'a', 'long dot with FOUR-PER-EM SPACE');
is(try_eval('foo\ .lc'), 'a', 'long dot with SIX-PER-EM SPACE');
is(try_eval('foo\ .lc'), 'a', 'long dot with FIGURE SPACE');
is(try_eval('foo\ .lc'), 'a', 'long dot with PUNCTUATION SPACE');
is(try_eval('foo\ .lc'), 'a', 'long dot with THIN SPACE');
is(try_eval('foo\ .lc'), 'a', 'long dot with HAIR SPACE');
is(try_eval('foo\ .lc'), 'a', 'long dot with LINE SEPARATOR');
is(try_eval('foo\ .lc'), 'a', 'long dot with PARAGRAPH SEPARATOR');
is(try_eval('foo\ .lc'), 'a', 'long dot with NARROW NO-BREAK SPACE');
is(try_eval('foo\ .lc'), 'a', 'long dot with MEDIUM MATHEMATICAL SPACE');
is(try_eval('foo\　.lc'), 'a', 'long dot with IDEOGRAPHIC SPACE');

# vim: ft=perl6
