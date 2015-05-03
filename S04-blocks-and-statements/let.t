use v6;

use Test;

plan 12;

# L<S04/The Relationship of Blocks and Declarations/There is also a let function>
# L<S04/Definition of Success>
# let() should not restore the variable if the block exited successfully
# (returned a true value).
{
  my $a = 42;
  {
    is($(let $a = 23; $a), 23, "let() changed the variable (1)");
    1;
  }
  is $a, 23, "let() should not restore the variable, as our block exited successfully (1)";
}

# let() should restore the variable if the block failed (returned a false
# value).
{
  my $a = 42;
  {
    is($(let $a = 23; $a), 23, "let() changed the variable (1)");
    Mu;
  }
  is $a, 42, "let() should restore the variable, as our block failed";
}

# Test that let() restores the variable at scope exit, not at subroutine
# entry.  (This might be a possibly bug.)
{
  my $a     = 42;
  my $get_a = { $a };
  {
    is($(let $a = 23; $a),       23, "let() changed the variable (2-1)");
    is $get_a(), 23, "let() changed the variable (2-2)";
    1;
  }
  is $a, 23, "let() should not restore the variable, as our block exited successfully (2)";
}

# Test that let() restores variable even when not exited regularly (using a
# (possibly implicit) call to return()), but when left because of an exception.
{
  my $a = 42;
  try {
    is($(let $a = 23; $a), 23, "let() changed the variable in a try block");
    die 57;
  };
  #?rakudo.jvm todo 'let restore on exception, RT #121647'
  is $a, 42, "let() restored the variable, the block was exited using an exception";
}

{
  my @array = (0, 1, 2);
  {
    is($(let @array[1] = 42; @array[1]), 42, "let() changed our array element");
    Mu;
  }
  is @array[1], 1, "let() restored our array element";
}

#?niecza skip "'fail' used at line 68"
{
    my $x = 5;
    sub f() {
        let $x = 10;
        fail 'foo';
    }
    my $sink = f(); #OK
    is $x, 5, 'fail() resets let variables';
}

# vim: ft=perl6
