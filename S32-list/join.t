use v6;
use Test;
plan 38;

# L<S32::Containers/"List"/"=item join">

# test all variants of join()

is join(),  '', 'empty join is empty string (sub)';
is ().join, '', 'empty join is empty string (method)';

is(["a", "b", "c"].join("|"), "a|b|c", '[].join("|") works');

my @list = ("a", "b", "c");

is(@list.join("|"), "a|b|c", '@list.join("|") works');

my $joined2 = join("|", @list);
is($joined2, "a|b|c", 'join("|", @list) works');

my $joined3 = join("|", "a", "b", "c");
is($joined3, "a|b|c", 'join("|", 1, 2, 3) works');

my $joined4 = join("|", $[ "a", "b", "c" ]);
is($joined4, "a b c", 'join("|", $[]) should not join anything');

my $joined5 = join("|", [ "a", "b", "c" ]);
is($joined5, "a|b|c", 'join("|", ["a", "b", "c"]) works');

# join() without a separator (defaults to '', per S32)
is(<a b c>.join, 'abc', 'join() separator defaults to "".');

# join() with $sep as a variable

my $sep = ", ";

is(["a", "b", "c"].join($sep), "a, b, c", '[].join($sep) works');

is(@list.join($sep), "a, b, c", '@list.join($sep) works');

my $joined2a = join($sep, @list);
is($joined2a, "a, b, c", 'join($sep, @list) works');

my $joined3a = join($sep, "a", "b", "c");
is($joined3a, "a, b, c", 'join($sep, "a", "b", "c") works');

my $joined4a = join($sep, [ "a", "b", "c" ]);
is($joined4a, "a, b, c", 'join($sep, ["a", "b", "c"]) works');

# join ... without parens

my $joined2b = join $sep, @list;
is($joined2b, "a, b, c", 'join $sep, @list works');

my $joined2c = join ":", @list;
is($joined2c, "a:b:c", 'join ":", @list works');

my $joined3b = join $sep, "a", "b", "c";
is($joined3b, "a, b, c", 'join $sep, "a", "b", "c" works');

my $joined3c = join ":", "a", "b", "c";
is($joined3c, "a:b:c", 'join(":", "a", "b", "c") works');

my $joined4b = join $sep, $[ "a", "b", "c" ];
is($joined4b, "a b c", 'join $sep, $["a", "b", "c"] should not join anything');

my $joined4c = join ":", $[ "a", "b", "c" ];
is($joined4c, "a b c", 'join ":", $["a", "b", "c"] should not join anything');

my $joined5b = join $sep, [ "a", "b", "c" ];
is($joined5b, "a, b, c", 'join $sep, ["a", "b", "c"] works');

my $joined5c = join ":", [ "a", "b", "c" ];
is($joined5c, "a:b:c", 'join ":", ["a", "b", "c"] works');

# join() with empty string as separator

is(["a", "b", "c"].join(''), "abc", '[].join("") works');

@list = ("a", "b", "c");

is(@list.join(''), "abc", '@list.join("") works');

my $joined2d = join('', @list);
is($joined2d, "abc", 'join("", @list) works');

my $joined3d = join('', "a", "b", "c");
is($joined3d, "abc", 'join("", 1, 2, 3) works');

my $joined4d = join("", $[ "a", "b", "c" ]);
is($joined4d, "a b c", 'join("", $["a", "b", "c"]) should not join anything');

my $joined5d = join("", [ "a", "b", "c" ]);
is($joined5d, "abc", 'join("", ["a", "b", "c"]) works');

# some odd edge cases

my $undefined;
my @odd_list1 = (1, $undefined, 2, $undefined, 3);

my $joined2e = join(':', @odd_list1);
is($joined2e, "1::2::3", 'join(":", @odd_list1) works');

my @odd_list2 = (1, Mu, 2, Mu, 3);

my $joined2f = join(':', @odd_list2);
is($joined2f, "1::2::3", 'join(":", @odd_list2) works');

# should these even be tests ???

my $joined1d = ("a", "b", "c").join('');
is($joined1d, "abc", '().join("") should dwim');

my $joined1 = ("a", "b", "c").join("|");
is($joined1, "a|b|c", '().join("|") should dwim');

my $joined1a = ("a", "b", "c").join($sep);
is($joined1a, "a, b, c", '().join($sep) should dwim');

is(join("!", "hi"),   "hi", "&join works with one-element lists (1)");
is(join("!", <hi>),   "hi", "&join works with one-element lists (2)");
is(("hi",).join("!"), "hi", "&join works with one-element lists (3)");


# Similar as with .kv: (42).kv should die, but (42,).kv should work.

   ## <pmichaud>:  I think the following two tests are likely incorrect.
   ##   Prior to r20722 S32::Containers gave the following definitions for C<join>:
   ##     our Str multi method join ( $separator: @values )
   ##     our Str multi join ( Str $separator = ' ', *@values )
   ##   Neither of these allows C< @list.join('sep') > to work.
   ##   In r20722 I changed S32::Containers to read
   ##     our Str multi method join ( @values: $separator = ' ' )
   ##     our Str multi join ( Str $separator = ' ', *@values )
   ##   This enables C< @list.join('sep') > to work, but now
   ##   C< 'foo'.join(':') > through method fallback is equivalent
   ##   to C< join('foo', ':') >, which results in ':' and not 'foo'.
   ##   Same is true for C< ('foo').join(':') >.
#
## from http://www.nntp.perl.org/group/perl.perl6.language/2008/06/msg29283.html
#
# Larry Wall writes:
#
## On Sat, Jun 14, 2008 at 01:46:10PM +0200, Moritz Lenz wrote:
## : Fallback semantics in S12 suggest that since no matching multi method is
## : found, subs are tried - that is, the expression is interpreted as
## :    join('str', 'other_str')
## : yielding 'other_str'. S32::Containers-list/join.t disagrees, and wants the
## : result to be 'str'.
##
## I want the result to be 'str'.

is('hi'.join(':'), 'hi', '"foo".join(":") should be the same as join(":", "foo")');
is(('hi').join(':'), 'hi', '("foo").join(":") should be the same as join(":", "foo")');

# vim: ft=perl6
