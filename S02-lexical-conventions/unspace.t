use v6;

use MONKEY_TYPING;

use Test;

plan 75;

# L<S02/"Unspaces"/This is known as the "unspace">


ok(4\       .sqrt == 2, 'unspace with numbers');
is(4\#`(quux).sqrt, 2, 'unspace with comments');
is("x"\     .chars, 1, 'unspace with strings');
is("x"\     .chars(), 1, 'unspace with strings + parens');

#?rakudo skip 'unspace with postfix operators'
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

#?rakudo skip 'unimplemented postfix forms'
{
    my @array = 1,2,3;

    @array\    .>>++;
    @array>>\    .++;
    @array\ .>>\ .++;
    @array\     .»++;
    @array»\     .++;
    @array\ .»\  .++;
    is( ~@array, "7 8 9", 'unspace with postfix hyperops');
}


#Test the "unspace" and unspace syntax


#This makes 'foo.lc' and 'foo .lc' mean different things
multi foo() { 'a' }
multi foo($x) { $x }

#This should do the same, but currently doesn't
sub bar($x? = 'a') { $x }

$_ = 'b';

is((foo.lc   ), 'a', 'sanity - foo.lc');
is((foo .lc  ), 'b', 'sanity - foo .lc');
is((bar.lc   ), 'a', 'sanity - bar.lc');
is((bar .lc  ), 'b', 'sanity - bar .lc');
is((foo\.lc  ), 'a', 'short unspace');
is((foo\ .lc ), 'a', 'unspace');
#?rakudo skip 'parse fail'
is((foo \ .lc), 'b', 'not a unspace');
eval_dies_ok('fo\ o.lc', 'unspace not allowed in identifier');
is((foo\    .lc), 'a', 'longer dot');
is((foo\#`( comment ).lc), 'a', 'unspace with embedded comment');
eval_dies_ok('foo\#\ ( comment ).lc', 'unspace can\'t hide space between # and opening bracket');
is((foo\ # comment
    .lc), 'a', 'unspace with end-of-line comment');
is((:foo\ <bar>), (:foo<bar>), 'unspace in colonpair');
#?rakudo skip 'unimplemented'
#?niecza skip 'Unable to resolve method postcircumfix:<( )> in class Str'
is((foo\ .\ ("x")), 'x', 'unspace is allowed both before and after method .');
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
is(eval('foo\
=comment blah blah blah
    .lc'), 'a', 'unspace with pod =comment');
#This is pretty strange: according to Perl-6.0.0-STD.pm,
#unspace is allowed after a pod = ... which means pod is
#syntactically recursive, i.e. you can put pod comments
#inside pod directives recursively!
#?rakudo skip 'pod and unspace'
is(eval('foo\
=\ begin comment
blah blah blah
=\ end comment
    .lc'), 'a', 'unspace with pod =begin/=end comment w/ pod unspace');
#?rakudo skip '=for pod not implemented (in STD.pm)'
{
is(eval('foo\
=\ for comment
blah
blah
blah

    .lc'), 'a', 'unspace with pod =for comment w/ pod unspace');
}
#?rakudo skip 'pod and unspace'
is(eval('foo\
=\ comment blah blah blah
    .lc'), 'a', 'unspace with pod =comment w/ pod unspace');
#?rakudo skip 'pod and unspace'
is(eval('foo\
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
#?rakudo skip '=for pod not implemented (in STD.pm)'
{
is(eval('foo\
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
is(eval('foo\
=\
=nested pod blah blah blah
comment blah blah blah
    .lc'), 'a', 'unspace with pod =comment w/ pod-in-pod');
is(eval('foo\
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

eval_dies_ok('sub f { 3 } sub g { 3 }', 'semicolon or newline required between blocks');

# L<S06/"Blocks"/"unless followed immediately by a comma">
#
#?rakudo skip 'parse error'
{
    sub baz(Code $x, *@y) { $x.(@y) }

    is((baz { @^x }, 1, 2, 3), (1, 2, 3), 'comma immediately following arg block');
    is((baz { @^x } , 1, 2, 3), (1, 2, 3), 'comma not immediately following arg block');
    is((baz { @^x }\ , 1, 2, 3), (1, 2, 3), 'unspace then comma following arg block');
}

#?rakudo skip 'indirect method calls'
#?niecza skip "Invocant handling is NYI"
{
    augment class Code{
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

#?rakudo skip 'defining new operators'
{
    my $n = 1;
    my $m = 2;
    sub infix:<++>($x, $y) { 42 }    #OK not used

    #'$n++$m' should be a syntax error
    eval_dies_ok('$n++$m', 'infix requires space when ambiguous with postfix');
    is($n, 1, 'check $n');
    is($m, 2, 'check $m');

    #'$n ++$m' should be infix:<++>
    #no, really: http://irclog.perlgeek.de/perl6/2007-05-09#id_l328
    $n = 1; $m = 2;
    is(eval('$n ++$m'), 42, '$n ++$m with infix:<++> is $n ++ $m');
    is($n, 1, 'check $n');
    is($m, 2, 'check $m');

    #'$n ++ $m' should be infix:<++>
    $n = 1; $m = 2;
    is(eval('$n ++ $m'), 42, 'postfix requires no space w/ infix ambiguity');
    is($n, 1, 'check $n');
    is($m, 2, 'check $m');

    #These should all be postfix syntax errors
    $n = 1; $m = 2;
    eval_dies_ok('$n.++ $m',   'postfix dot w/ infix ambiguity');
    eval_dies_ok('$n\ ++ $m',  'postfix unspace w/ infix ambiguity');
    eval_dies_ok('$n\ .++ $m', 'postfix unspace w/ infix ambiguity');
    is($n, 1, 'check $n');
    is($m, 2, 'check $m');

    #Unspace inside operator splits it
    $n = 1; $m = 2;
    is(($n+\ +$m), 3, 'unspace inside operator splits it');
    is($n, 1, 'check $n');
    is($m, 2, 'check $m');

    $n = 1;
    eval_dies_ok('$n ++', 'postfix requires no space');
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
    #?niecza skip 'Unable to resolve method id in class Str'
    is((foo\#`〝 comment 〞.id), 'a', 'unspace with U+301D/U+301E comment');
    eval_dies_ok('foo\#`〝 comment 〟.id', 'unspace with U+301D/U+301F is invalid');

    # L<S02/"Implicit Topical Method Calls"/".123">
    # .123 is equal to 0.123

    is ( .123), 0.123, ' .123 is equal to 0.123';
    is (.123), 0.123, '.123 is equal to 0.123';
}

# vim: ft=perl6
