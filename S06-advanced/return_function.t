use Test; plan 4;

# L<S06/The C<return> function/prints 1 via named argument>

{
    sub f () { return :x<1> }
    sub g ($x) { $x }

    my $x := |(f);  # binds 1 to $x, via a named argument
    #?pugs todo 'bug'
    is $x, 1, 'binds 1 to $x, via a named argument';
    is( g(|(f)), 1, "prints 1, via a named argument");
}

{
  # return two positional Pair objects
  sub t2 () { return( (:x<1>), (:y<2>) ) }
  my ($rv1, $rv2);
  try { ($rv1, $rv2) := |(t2) };
  #?pugs 2 todo 'bug'
  is($rv1, Pair, "returned Pair object 1");
  is($rv2, Pair, "returned Pair object 2");
}

# vim: ft=perl6
