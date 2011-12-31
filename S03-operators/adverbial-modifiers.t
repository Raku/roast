use v6;

use Test;

plan 42;

# L<S03/Invocant marker/"will apply the :xxx adverb">
sub prefix:<blub> (Str $foo, Int :$times = 1) {
  ("BLUB" x $times) ~ $foo;
}

is prefix:<blub>("bar"), 'BLUBbar', 'user-defined prefix operator, long name';
is prefix:<blub>("bar", times => 2), 'BLUBBLUBbar', 'user-defined prefix operator, long name, optional parameter';
is prefix:<blub>(:times(2), "bar"), 'BLUBBLUBbar', 'user-defined prefix operator, long name, :times adverb, leading';
is prefix:<blub>("bar", :times(2)), 'BLUBBLUBbar', 'user-defined prefix operator, long name, :times adverb, trailing';
is blub "bar", 'BLUBbar', 'user-defined prefix operator, basic call';
is blub "bar" :times(2), 'BLUBBLUBbar', 'user-defined prefix operator, :times adverb, space';
is blub "bar":times(2), 'BLUBBLUBbar', 'user-defined prefix operator, :times adverb, no space';

{
  # These basic adverb tests are copied from a table in A12.
  my $bar = 123;
  my @many = (4,5);
  sub dostuff(){"stuff"}
  my ($v,$e);
  $e = (foo => $bar);
  $v = :foo($bar);
  is ~$v, ~$e, ':foo($bar)';

  $e = (foo => [1,2,3,@many]);
  $v = :foo[1,2,3,@many];
  is ~$v, ~$e, ':foo[1,2,3,@many]';

  $e = (foo => «alice bob charles»);
  $v = :foo«alice bob charles»;
  is ~$v, ~$e, ':foo«alice bob charles»';

  $e = (foo => 'alice');
  $v = :foo«alice»;
  is ~$v, ~$e, ':foo«alice»';

  $e = (foo => { a => 1, b => 2 });
  $v = eval ':foo{ a => 1, b => 2 }';
  is ~$v, ~$e, ':foo{ a => 1, b => 2 }';

  $e = (foo => { dostuff() });
  $v = :foo{ dostuff() };
  is ~$v, ~$e, ':foo{ dostuff() }';

  $e = (foo => 0);
  $v = :foo(0);
  is ~$v, ~$e, ':foo(0)';

  $e = (foo => Bool::True);
  $v = :foo;
  is ~$v, ~$e, ':foo';
}

# Exercise various mixes of "fiddle", parens "()",
# and adverbs with "X' and without "x" an argument.
sub violin($x) { 
    if $x ~~ Bool {
        $x ?? "1" !! "0";
    } else {
        $x;
    }
}
sub fiddle(:$x,:$y){ violin($x) ~ violin($y) }

#?niecza skip 'Multi colonpair syntax not yet understood'
{
  # fiddle(XY) fiddle(YX) fiddle(xY) fiddle(Xy)

  is fiddle(:x("a"):y("b")), "ab", 'fiddle(:x("a"):y("b"))';
  is fiddle(:y("b"):x("a")), "ab", 'fiddle(:y("b"):x("a"))';
  is fiddle(:x:y("b")), "1b", 'fiddle(:x:y("b"))';
  is fiddle(:x("a"):y), "a1", 'fiddle(:x("a"):y)';
}

{
  # fiddle(X)Y fiddle(Y)X fiddle(x)Y fiddle(X)y fiddle(x)y

  is fiddle(:x("a")):y("b"), "ab", 'fiddle(:x("a")):y("b")';
  is fiddle(:y("b")):x("a"), "ab", 'fiddle(:y("b")):x("a")';
  is fiddle(:x):y("b"), "1b", 'fiddle(:x("a")):y("b")';
  is fiddle(:x("a")):y, "a1", 'fiddle(:x("a")):y';
  is fiddle(:x):y, "11", 'fiddle(:x):y';
}

{
  # fiddle()XY fiddle()YX fiddle()xY fiddle()Xy  fiddle()xy

  is fiddle():x("a"):y("b"), "ab", 'fiddle():x("a"):y("b")';
  is fiddle():y("b"):x("a"), "ab", 'fiddle():y("b"):x("a")';
  is fiddle():x:y("b"), "1b", 'fiddle():x:y("b")';
  is fiddle():x("a"):y, "a1", 'fiddle():x("a"):y';
  is fiddle():x:y, "11", 'fiddle():x:y';
}

{
  # f_X(Y) f_X_Y() f_X_Y_() f_XY_() f_XY() fXY ()

  # $v = fiddle :x("a")(:y("b"));
  # is $v, "ab", 'fiddle :x("a")(:y("b"))';
  # Since the demagicalizing of pairs, this test shouldn't and doesn't work any
  # longer.

#  $v = 'eval failed';
#  eval '$v = fiddle :x("a") :y("b")()';
#  #?pugs todo 'bug'
#  is $v, "ab", 'fiddle :x("a") :y("b")()';

#  $v = 'eval failed';
#  eval '$v = fiddle :x("a") :y("b") ()';
#  #?pugs todo 'bug'
#  is $v, "ab", 'fiddle :x("a") :y("b") ()';

#  $v = 'eval failed';
#  eval '$v = fiddle :x("a"):y("b") ()';
#  #?pugs todo 'bug'
#  is $v, "ab", 'fiddle :x("a"):y("b") ()';

#  $v = 'eval failed';
#  eval '$v = fiddle :x("a"):y("b")()';
#  #?pugs todo 'bug'
#  is $v, "ab", 'fiddle :x("a"):y("b")()';

#  $v = fiddle:x("a"):y("b") ();
#  is $v, "ab", 'fiddle:x("a"):y("b") ()';
}

{
  # Exercise mixes of adverbs and positional arguments.

  my $v;
  my sub f($s,:$x) { violin($x) ~ violin($s) }
  my sub g($s1,$s2,:$x) {$s1~$x~$s2}
  my sub h(*@a) {@a.perl}
  my sub i(*%h) {%h.perl}
  my sub j($s1,$s2,*%h) {$s1~%h.perl~$s2}

  # f(X s) f(Xs) f(s X) f(sX) f(xs) f(sx)

  is f(:x("a"), "b"), "ab", 'f(:x("a") "b")';
  is f(:x("a"),"b"), "ab", 'f(:x("a")"b")';
  is f("b", :x("a")), "ab", 'f("b" :x("a"))';
  is f("b",:x("a")), "ab", 'f("b":x("a"))';
  is f(:x, "b"), "1b", 'f(:x "b")';
  is f("b", :x), "1b", 'f("b" :x)';

  # f(s)X

  is f("b"):x("a"), "ab", 'f("b"):x("a")';

  # fs X  fsX  fs x  fsx

#  $v = f "b" :x("a");
#  is $v, "ab", 'f "b" :x("a")';

#  $v = f "b":x("a");
#  is $v, "ab", 'f "b":x("a")';

#  $v = f "b" :x;
#  is $v, "1b", 'f "b" :x';

#  $v = f "b":x;
#  is $v, "1b", 'f "b":x';

  # add more tests...

}

#?niecza skip 'Multi colonpair syntax not yet understood'
{ # adverbs as pairs

  my sub f1($s,:$x){$s.perl~$x}
  is f1(\:bar :x("b")), '("bar" => Bool::True)b', 'f1(\:bar :x("b"))';
}

{
  # adverbs as pairs, cont.
  my sub f2(Pair $p){$p.perl}
  is f2((:bar)), ("bar" => Bool::True).perl, 'f2((:bar))';

  my sub f3(Pair $p1, Pair $p2){$p1.perl~" - "~$p2.perl}
  is f3((:bar),(:hee(3))), "{(bar => Bool::True).perl} - {(hee => 3).perl}", 'f3((:bar),(:hee(3)))';
}


{
  # Exercise adverbs on operators.

  sub prefix:<zpre>($a,:$x){join(",",$a,$x)}
  is (zpre 4 :x(5)), '4,5', '(zpre 4 :x(5))';

  sub postfix:<zpost>($a,:$x){join(",",$a,$x)}
  is (4zpost :x(5)), '4,5', '(4 zpost :x(5))';

  sub infix:<zin>($a,$b,:$x){join(",",$a,$b,$x)}
  is (3 zin 4 :x(5)), '3,4,5', '(3 zin 4 :x(5))';

}

# vim: ft=perl6
