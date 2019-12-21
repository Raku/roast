use v6;

use MONKEY-TYPING;

use Test;

plan 110;

# L<S02/"Unspaces"/This is known as the "unspace">

ok(4\       .sqrt == 2, 'unspace with numbers');
is(4\#`(quux).sqrt, 2, 'unspace with comments');
is("x"\     .chars, 1, 'unspace with strings');
is("x"\     .chars(), 1, 'unspace with strings + parens');

{
my $foo = 4;
is($foo.++, 4, '(short) unspace with postfix inc');
is($foo, 5, '(short) unspace with postfix inc really postfix');
is($foo\       .++, 5, 'unspace with postfix inc');
is($foo, 6, 'unspace with postfix inc really postfix');
is($foo\       .--, 6, 'unspace with postfix dec');
is($foo, 5, 'unspace with postfix dec really postfix');
}

is("xxxxxx"\.chars, 6, 'unspace without spaces');
is("xxxxxx"\
    .chars, 6, 'unspace with newline');

is((:foo\ ("bar")), ('foo' => "bar"), 'unspace with adverb');

is( ~([1,2,3]\ .[2,1,0]), "3 2 1", 'unspace on postfix subscript');

{
    my @array = 1,2,3;

    @array\    .>>++;
    @array\     .»++;
    is( ~@array, "3 4 5", 'unspace with postfix pre-dot hyperops');
}

{
    my @array = 1,2,3;

    @array>>\    .++;
    @array\ .>>\ .++;
    @array»\     .++;
    @array\ .»\  .++;
    is( ~@array, "5 6 7", 'unspace with postfix pre- and/or post-dot hyperops');
}

# Test the "unspace" and unspace syntax


# This makes 'foo.lc' and 'foo .lc' mean different things
multi foo() { 'a' }
multi foo($x) { $x }

# This should do the same, but currently doesn't
sub bar($x? = 'a') { $x }

$_ = 'b';

is((foo.lc   ), 'a', 'sanity - foo.lc');
is((foo .lc  ), 'b', 'sanity - foo .lc');
is((bar.lc   ), 'a', 'sanity - bar.lc');
is((bar .lc  ), 'b', 'sanity - bar .lc');
is((foo\.lc  ), 'a', 'short unspace');
is((foo\ .lc ), 'a', 'unspace');
is((foo\ ('x')), 'x', "unspace before arguments");
is((foo \ .lc), 'b', 'not a unspace');
throws-like { EVAL 'fo\ o.lc' },
  X::Comp,
  'unspace not allowed in identifier';
is((foo\    .lc), 'a', 'longer dot');
is((foo\#`( comment ).lc), 'a', 'unspace with embedded comment');
#?rakudo todo 'NYI RT #125072'
throws-like { EVAL 'foo\#\ ( comment ).lc' },
  Exception,
  'unspace can\'t hide space between # and opening bracket';
is((foo\ # comment
    .lc), 'a', 'unspace with end-of-line comment');
is((:foo\ <bar>), (:foo<bar>), 'unspace in colonpair');
is((&foo\ .\ ("x")), 'x', 'unspace is allowed both before and after method .');
is((foo\
=begin comment
blah blah blah
=end comment
    .lc), 'a', 'unspace with pod =begin/=end comment');
{
is((foo\
=for comment
blah
blah
blah

    .lc), 'a', 'unspace with pod =for comment');
}
is(EVAL('foo\
=comment blah blah blah
    .lc'), 'a', 'unspace with pod =comment');
# This is pretty strange: according to Perl-6.0.0-STD.pm (Perl),
# unspace is allowed after a pod = ... which means pod is
# syntactically recursive, i.e., you can put pod comments
# inside pod directives recursively!
#?rakudo skip 'pod and unspace: RT #122343'
is(EVAL('foo\
=\ begin comment
blah blah blah
=\ end comment
    .lc'), 'a', 'unspace with pod =begin/=end comment w/ pod unspace');
#?rakudo skip '=for pod NYI (in STD.pm, from Perl): RT #122343'
{
is(EVAL('foo\
=\ for comment
blah
blah
blah

    .lc'), 'a', 'unspace with pod =for comment w/ pod unspace');
}
#?rakudo skip 'pod and unspace: RT #122343'
is(EVAL('foo\
=\ comment blah blah blah
    .lc'), 'a', 'unspace with pod =comment w/ pod unspace');
#?rakudo skip 'pod and unspace: RT #122343'
is(EVAL('foo\
=\
=begin nested_pod
blah blah blah
=end nested_pod
begin comment
blah blah blah
=\
=begin nested_pod
blah blah blah
=end nested_pod
end comment
    .lc'), 'a', 'unspace with pod =begin/=end comment w/ pod-in-pod');
#?rakudo skip '=for pod NYI (in STD.pm, from Perl): RT #122343'
{
is(EVAL('foo\
=\
=for nested pod
blah
blah
blah

for comment
blah
blah
blah

    .lc'), 'a', 'unspace with pod =for commenti w/ pod-in-pod');
is(EVAL('foo\
=\
=nested pod blah blah blah
comment blah blah blah
    .lc'), 'a', 'unspace with pod =comment w/ pod-in-pod');
is(EVAL('foo\
=\			#1
=\			#2
=\			#3
=comment blah blah blah
for comment		#3
blah
blah
blah

begin comment		#2
blah blah blah
=\			#4
=comment blah blah blah
end comment		#4
begin comment		#1
blah blah blah
=\			#5
=\			#6
=for comment
blah
blah
blah

comment blah blah blah	#6
end comment		#5
    .lc'), 'a', 'hideous nested pod torture test');

}

# L<S04/"Statement-ending blocks"/"Because subroutine declarations are expressions">
#XXX probably shouldn't be in this file...

throws-like { EVAL 'sub f { 3 } sub g { 3 }' },
  X::Syntax::Confused,
  'semicolon or newline required between blocks';

# L<S06/"Blocks"/"unless followed immediately by a comma">
#
{
    sub baz(Code $x, *@y) { $x.(@y) }

    is((baz { @^x }, 1, 2, 3), (1, 2, 3), 'comma immediately following arg block');
    is((baz { @^x } , 1, 2, 3), (1, 2, 3), 'comma not immediately following arg block');
    is((baz { @^x }\ , 1, 2, 3), (1, 2, 3), 'unspace then comma following arg block');
}

{
    augment class Block {
        method xyzzy(Code $x: *@y) { $x.(@y) }
    }

    is((xyzzy { @^x }: 1, 2, 3), (1, 2, 3), 'colon immediately following arg block');
    is((xyzzy { @^x } : 1, 2, 3), (1, 2, 3), 'colon not immediately following arg block');
    is((xyzzy { @^x }\ : 1, 2, 3), (1, 2, 3), 'unspace then colon following arg block');
}

# L<S02/"Optional Whitespace and Exclusions"/"natural conflict between postfix operators and infix operators">
#This creates syntactic ambiguity between
# ($n) ++ ($m)
# ($n++) $m
# ($n) (++$m)
# ($n) + (+$m)

{
    my $n = 1;
    my $m = 2;
    sub infix:<++>($x, $y) { 42 }    #OK not used

    #'$n++$m' should be a syntax error
    throws-like { EVAL '$n++$m' },
      X::Syntax::Confused,
      'infix requires space when ambiguous with postfix';
    is($n, 1, 'check $n');
    is($m, 2, 'check $m');

    #'$n ++$m' should be infix:<++>
    #no, really: http://irclog.perlgeek.de/perl6/2007-05-09#id_l328
    $n = 1; $m = 2;
    is(EVAL('$n ++$m'), 42, '$n ++$m with infix:<++> is $n ++ $m');
    is($n, 1, 'check $n');
    is($m, 2, 'check $m');

    #'$n ++ $m' should be infix:<++>
    $n = 1; $m = 2;
    is(EVAL('$n ++ $m'), 42, 'postfix requires no space w/ infix ambiguity');
    is($n, 1, 'check $n');
    is($m, 2, 'check $m');

    #These should all be postfix syntax errors
    $n = 1; $m = 2;
    throws-like { EVAL '$n.++ $m' },
      X::Syntax::Confused,
      'postfix dot w/ infix ambiguity';
    throws-like { EVAL '$n\ ++ $m' },
      X::Comp,
      'postfix unspace w/ infix ambiguity';
    throws-like { EVAL '$n\ .++ $m' },
      X::Comp,
      'postfix unspace w/ infix ambiguity';
    is($n, 1, 'check $n');
    is($m, 2, 'check $m');

    #Unspace inside operator splits it
    $n = 1; $m = 2;
    is(($n+\ +$m), 3, 'unspace inside operator splits it');
    is($n, 1, 'check $n');
    is($m, 2, 'check $m');

    $n = 1;
    throws-like { EVAL '$n ++' },
      X::Comp,
      'postfix requires no space';
    is($n, 1, 'check $n');

    $n = 1;
    is($n.++, 1, 'postfix dot');
    is($n, 2, 'check $n');

    $n = 1;
    is($n\ ++, 1, 'postfix unspace');
    is($n, 2, 'check $n');

    $n = 1;
    is($n\ .++, 1, 'postfix unspace');
    is($n, 2, 'check $n');

    # L<S02/"Bracketing Characters"/"U+301D codepoint has two closing alternatives">
    is((foo\#`〝 comment 〞.lc), 'a', 'unspace with U+301D/U+301E comment');
    throws-like { EVAL 'foo\#`〝 comment 〟.id' },
      X::Comp,
      'unspace with U+301D/U+301F is invalid';

    # L<S02/"Implicit Topical Method Calls"/".123">
    # .123 is equal to 0.123
    is ( .123), 0.123, ' .123 is equal to 0.123';
    is (.123), 0.123, '.123 is equal to 0.123';
}

# Was a nasty niecza bug
is 5.Str\.Str, "5", 'unspaced postfix after method call not misparsed';

# RT #92826
is((foo\  ("x")\  .\  lc), 'x', 'unspace between parameter and before and after method .');

# RT #79340
is &infix:<+>(5, 5), 10, 'sanity';
is &infix:<+>(\ 5, 5), 10, 'unspace between method and first argument';
is &infix:<+>( \ 5, 5), 10, 'unspace between method and first argument with leading space';
is &infix:<+>( 5\ , 5), 10, 'unspace between first and second argument';
is &infix:<+>( 5 \ , 5), 10, 'unspace between first and second argument with leading space';

# RT #117465
is "foo".\ \ perl, "foo".perl, 'two unspace in a row after . for method call';
is "foo"\ \ .perl, "foo".perl, 'two unspace in a row before . for method call';

# \# okay within a regex
ok '#' ~~ /\#/, 'Unspace restriction in regex does not apply to \#';

# bareword calls and postcircumfix
is abs\ (42), 42, "bareword call with unspace";
is abs\(42), 42, "bareword call with degenerate unspace";
class A { our sub foo ($a) { $a }; our @a = 1,2; our %a = :a,:b(2); };
is A::foo\ (42), 42, "bare longname call with unspace";
is A::foo\(42), 42, "bare longname call with degenerate unspace";
is @A::a\ [1], 2, "longname array subscript with unspace";
is @A::a\[1], 2, "longname array subscript with degenerate unspace";
is %A::a\ {"b"}, 2, "longname hash subscript with unspace";
is %A::a\{"b"}, 2, "longname hash subscript with degenerate unspace";
is %A::a\ <b>, 2, "longname pointy hash subscript with unspace";
is %A::a\<b>, 2, "longname pointy hash subscript with degenerate unspace";
is IO::Path\ .^name, "IO::Path", "bare longname metamethod call with unspace";
is IO::Path\.^name, "IO::Path", "bare longname metamethod call with degenerate unspace";

# sigilless variables/constants
# RT #128462
eval-lives-ok 'my \term = 42; uc term\   .Str; term == 42 or die;',
    'unspace with method calls detached from sigiless terms works';
eval-lives-ok 'my \term = [1,2]; my $v = term\   [1]; $v == 2 or die;',
    'unspace with array subscript detached from sigiless terms works';
eval-lives-ok 'my \term = {:a(1),:b(2)}; my $v = term\   {"b"}; $v == 2 or die;',
    'unspace with hash subscript detached from sigiless terms works';
eval-lives-ok 'my \term = {:a(1),:b(2)}; my $v = term\   <b>; $v == 2 or die;',
    'unspace with pointy hash subscript detached from sigiless terms works';
eval-lives-ok 'my \term = 42; my $v = term\.Str; $v == 42 or die;',
    'degenerate unspace with method calls detached from sigiless terms works';
eval-lives-ok 'my \term = [1,2]; my $v = term\[1]; $v == 2 or die;',
    'degenerate unspace with array subscript detached from sigiless terms works';
eval-lives-ok 'my \term = {:a(1),:b(2)}; my $v = term\{"b"}; $v == 2 or die;',
    'degenerate unspace with hash subscript detached from sigiless terms works';
eval-lives-ok 'my \term = {:a(1),:b(2)}; my $v = term\<b>; $v == 2 or die;',
    'degenerate unspace with pointy hash subscript detached from sigiless terms works';

is 'a'.parse-base\   \   (16), 10, 'unspace can recurse';

# RT #125985
{
    eval-lives-ok 'constant nums = 1; my \fizzbuzz = nums\ .map({ $_ });',
        'unspace combined with map and a constant';
    eval-lives-ok 'constant nums = 1; constant fizzbuzz = nums\ .map({ $_ })',
        'unspace combined with map and constants';
}

# vim: ft=perl6
