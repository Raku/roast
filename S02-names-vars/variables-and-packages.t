use v6;

use Test;

plan 38;

# L<S02/Names/"The following pseudo-package names are reserved">
{
    throws-like { EVAL 'module MY;' },
      X::PseudoPackage::InDeclaration,
      'MY is an out of scope name';
    throws-like { EVAL 'module OUR;' },
      X::PseudoPackage::InDeclaration,
      'OUR is an out of scope name';
    throws-like { EVAL 'module GLOBAL;' },
      Exception,
      'GLOBAL is an out of scope name';
    throws-like { EVAL 'module PROCESS;' },
      X::PseudoPackage::InDeclaration,
      'PROCESS is an out of scope name';
    throws-like { EVAL 'module OUTER;' },
      X::PseudoPackage::InDeclaration,
      'OUTER is an out of scope name';
    throws-like { EVAL 'module CALLER;' },
      X::PseudoPackage::InDeclaration,
      'CALLER is an out of scope name';
    throws-like { EVAL 'module DYNAMIC;' },
      X::PseudoPackage::InDeclaration,
      'DYNAMIC is an out of scope name';
    throws-like { EVAL 'module COMPILING;' },
      X::PseudoPackage::InDeclaration,
      'COMPILING is an out of scope name';
}

# L<S02/Names/The current lexical symbol table is now accessible>

{ my $a = 1; {
   my $a=2; {
      my $a=3;
      is($a, 3,               'get regular a');
      is($OUTER::a, 2,        'get $OUTER::a');
      is($OUTER::OUTER::a, 1, 'get $OUTER::OUTER::a');
}}}

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
  is-deeply foo(), 0, "get variable not yet declared using a sub (1)";
  is-deeply foo(), 1, "get variable not yet declared using a sub (2)";
  is-deeply foo(), 2, "get variable not yet declared using a sub (3)";

  my $a;
  sub foo { $a++ }
}

{
  is-deeply bar(), 0, "runtime part of my not yet executed (1)";
  is-deeply bar(), 1, "runtime part of my not yet executed (2)";
  is-deeply bar(), 2, "runtime part of my not yet executed (3)";

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

{
  {
    my $a = 3;
    our sub grtz { $a++ }
  }

  is &OUR::grtz(), 3, "get real hidden var using a sub (1)";
  is &OUR::grtz(), 4, "get real hidden var using a sub (1)";
  is &OUR::grtz(), 5, "get real hidden var using a sub (1)";
}

{
  my $a;
  sub rmbl { $a++ }

  is-deeply rmbl(), 0, "var captured by sub is the right var (1)";
  $a++;
  is-deeply rmbl(), 2, "var captured by sub is the right var (2)";
}

{
  throws-like { EVAL q/
    sub s($i is copy) {
        my @array;
        for 1..3 {
            @array.push($i);
            my $i = 1;
        }
    };
    s(9);/ },
    X::Redeclaration::Outer,
    "can't redeclare something with an implicit outer binding";
}

{
    # RT #74076
    my $t;
    for 'a' {
        $t = sub { $OUTER::_ };
    }
    is $t(), 'a', '$OUTER::_ can access a $_';
}

# vim: ft=perl6
