use v6;

use Test;

plan 37;

# L<S02/Names/"The following pseudo-package names are reserved">
ok !eval('module MY; 1'), 'MY is an out of scope name';
ok !eval('module OUR; 1'), 'OUR is an out of scope name';
ok !eval('module GLOBAL; 1'), 'GLOBAL is an out of scope name';
ok !eval('module PROCESS; 1'), 'PROCESS is an out of scope name';
ok !eval('module OUTER; 1'), 'OUTER is an out of scope name';
ok !eval('module CALLER; 1'), 'CALLER is an out of scope name';
ok !eval('module CONTEXT; 1'), 'CONTEXT is an out of scope name';
ok !eval('module SUPER; 1'), 'SUPER is an out of scope name';
ok !eval('module COMPILING; 1'), 'COMPILING is an out of scope name';


# L<S02/Names/The current lexical symbol table is now accessible>

# XXX -- dunno why test test fails, but the next outer test works. --iblech
#?rakudo skip 'OUTER::'
{ my $a = 1; {
   my $a=2; {
      my $a=3;
      is($a, 3,               'get regular a');
      is($OUTER::a, 2,        'get $OUTER::a');
      is($OUTER::OUTER::a, 1, 'get $OUTER::OUTER::a');
}}}

#?rakudo skip 'OUTER::'
{
  my $a = 1;
  is $a, 1, 'get regular $a (1)';

  {
    my $a = 2;
    is $a, 2, 'get new regular $a (1)';

    {
      my $a = 3;

      is $a,               3, 'get very new regular $a';
      is $OUTER::a,        2, 'get $OUTER::a';
      is $OUTER::OUTER::a, 1, 'get $OUTER::OUTER::a';
    }
  }
}

# TODO: more smartlinks

{
  my $a = 3;
  my $sub = { $a++ };

  {
    my $a = -10;
    is $a, -10,   'get regular $a';
    is $sub(), 3, 'get hidden $a (1)';
    is $sub(), 4, 'get hidden $a (2)';
    is $sub(), 5, 'get hidden $a (3)';
  }
}

{
  my $sub = -> $stop {
    my $x = 3;
    if $stop {
      $x++;
    } else {
      $sub(1);
      $x;
    }
  };

  is $sub(0), 3,
    "recursively called subref shouldn't stomp on the lexical vars of other instances";
}

{
  sub stomptest ($stop) {
    my $x = 3;
    if $stop {
      $x++;
    } else {
      stomptest 1;
      $x;
    }
  };

  is stomptest(0), 3,
    "recursively called sub shouldn't stomp on the lexical vars of other instances";
}

{
  #?rakudo todo 'nom regression'
  nok foo().defined, "get variable not yet declared using a sub (1)";
  is foo(), 1, "get variable not yet declared using a sub (2)";
  is foo(), 2, "get variable not yet declared using a sub (3)";

  my $a;
  sub foo { $a++ }
}

{
  #?rakudo todo 'nom regression'
  nok bar().defined, "runtime part of my not yet executed (1)";
  is bar(), 1, "runtime part of my not yet executed (2)";
  is bar(), 2, "runtime part of my not yet executed (3)";

  my $a = 3;
  sub bar { $a++ }
}

{
  is baz(), 3, "initilization from BEGIN block (1)";
  is baz(), 4, "initilization from BEGIN block (2)";
  is baz(), 5, "initilization from BEGIN block (3)";

  my $a; BEGIN { $a = 3 };
  sub baz { $a++ }
}

#?rakudo skip 'nom regression'
{
  {
    my $a = 3;
    our sub grtz { $a++ }
  }

  is grtz(), 3, "get real hidden var using a sub (1)";
  is grtz(), 4, "get real hidden var using a sub (1)";
  is grtz(), 5, "get real hidden var using a sub (1)";
}

{
  my $a;
  sub rmbl { $a++ }

  #?rakudo todo 'nom regression'
  nok rmbl().defined, "var captured by sub is the right var (1)";
  $a++;
  is rmbl(), 2, "var captured by sub is the right var (2)";
}

# vim: ft=perl6
