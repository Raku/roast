use v6;

use Test;

plan 33;

# L<S04/The Relationship of Blocks and Declarations/function has been renamed>
{
  my $a = 42;
  {
    is((temp $a = 23; $a), 23, "temp() changed the variable (1)");
  }
  is $a, 42, "temp() restored the variable (1)";
}

# Test that temp() restores the variable at scope exit, not at subroutine
# entry.
{
  my $a     = 42;
  my $get_a = { $a };
  {
    is((temp $a = 23; $a),       23, "temp() changed the variable (2-1)");
    is $get_a(), 23, "temp() changed the variable (2-2)";
  }
  is $a, 42, "temp() restored the variable (2)";
}

# temp() shouldn't change the variable containers
{
  my $a     = 42;
  my $get_a = { $a };
  {
    ok((temp $a = 23; $a =:= $get_a()), "temp() shouldn't change the variable containers");
  }
}

{
  our $pkgvar = 42;
  {
    is((temp $pkgvar = 'not 42'; $pkgvar), 'not 42', "temp() changed the package variable (3-1)");
  }
  is $pkgvar, 42, "temp() restored the package variable (3-2)";
}

# Test that temp() restores variable even when not exited regularly (using a
# (possibly implicit) call to return()), but when left because of an exception.
{
  my $a = 42;
  try {
    is((temp $a = 23; $a), 23, "temp() changed the variable in a try block");
    die 57;
  };
  is $a, 42, "temp() restored the variable, the block was exited using an exception";
}

eval('
{
  my @array = (0, 1, 2);
  {
    temp @array[1] = 42; 
    is @array[1], 42, "temp() changed our array element";
  }
    is @array[1], 1, "temp() restored our array element";
}
"1 - delete this line when the parsefail eval() is removed";
') or skip("parsefail: temp \@array[1]", 2);

{
  my %hash = (:a(1), :b(2), :c(3));
  {
    temp %hash<b> = 42;
    is %hash<b>, 42, "temp() changed our hash element";
  }
  is %hash<b>, 2, "temp() restored our array element";
}

{
  my $struct = [
    "doesnt_matter",
    {
      doesnt_matter => "doesnt_matter",
      key           => [
        "doesnt_matter",
        42,
      ],
    },
  ];

  {
    temp $struct[1]<key>[1] = 23;
    is $struct[1]<key>[1], 23, "temp() changed our nested arrayref/hashref element";
  }
  is $struct[1]<key>[1], 42, "temp() restored our nested arrayref/hashref element";
}

# Block TEMP{}
# L<S06/Temporization/You can also modify the behaviour of temporized code structures>
# (Test is more or less directly from S06.)
#?niecza 2 skip 'spec clarification needed'
#?rakudo 2 skip 'TEMP phasers NYI'
{
  my $next    = 0;

  # Here is the real implementation of &advance.
  sub advance() {
    my $curr = $next++;
    TEMP {{ $next = $curr }}  # TEMP block returns the closure { $next = $curr }
    return $curr;
  };

  # and later...

  is advance(), 0, "TEMP{} block (1)";
  is advance(), 1, "TEMP{} block (2)";
  is advance(), 2, "TEMP{} block (3)";
  is $next,     3, "TEMP{} block (4)";

  #?pugs 4 todo 'feature'
  flunk "TEMP{} block (5)";
  flunk "TEMP{} block (6)";
  flunk "TEMP{} block (7)";
  flunk "TEMP{} block (8)";

  # Following does parse, but isn't executed (don't know why).
  # If the "{" on the following line is changed to "if 1 {", it is executed,
  # too, but then it dies complaining about not finding a matching temp()
  # function.  So, for now, we just comment the following block and add
  # unconditional flunk()s.
  # {
  #  #?pugs 4 todo 'feature'
  #  is temp(advance()), 3, "TEMP{} block (5)";
  #  is $next,           4, "TEMP{} block (6)";
  #  is temp(advance()), 4, "TEMP{} block (7)";
  #  is temp(advance()), 5, "TEMP{} block (8)";
  # }  # $next = 3

  is $next,     3, "TEMP{} block (9)";
  is advance(), 3, "TEMP{} block (10)";
  is $next,     4, "TEMP{} block (11)";
}

# Following are OO tests, but I think they fit better in var/temp.t than in
# oo/.
# L<S06/Temporization/temp invokes its argument's .TEMP method.>
{
  my $was_in_own_temp_handler = 0;

  class WierdTemp is Int {
    method TEMP {
      $was_in_own_temp_handler++;
      return { $was_in_own_temp_handler++ };
    }
  }

  my $a = WierdTemp.new();
  ok defined($a), "instantiating a WierdTemp worked";
  is $was_in_own_temp_handler, 0, ".TEMP method wasn't yet executed";

  {
    is((temp $a; $was_in_own_temp_handler), 1, ".TEMP method was executed on temporization");
  }
  is $was_in_own_temp_handler, 2, ".TEMP method was executed on restoration";
}

{
  my $depth = 0;
  my $c = 1;
  sub a {
    ++temp $c;
    a() if ++$depth < 3;
  }
  a();
  is $c, 1, 'recursive nested temps are restored properly';
}

{
  my $a=1;
  {
    temp $a=2;
    temp $a=3;
  }
  is $a, 1, 'multiple temps in the same scope are restored properly';
}

# vim: ft=perl6
