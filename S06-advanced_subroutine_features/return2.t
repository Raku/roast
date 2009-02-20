use v6;

use Test;

# Basic &return tests
# L<S06/"The C<return> function">

plan 7;

{
  sub userdefinedcontrol_a (&block) { block(); return 24 }
  sub official_a {
    userdefinedcontrol_a { return 42 };
  }
  is official_a(), 42, "bare blocks are invisible to return";
}

{
  sub userdefinedcontrol_b (&block) { block(); return 24 }
  sub official_b {
    {
        {
            userdefinedcontrol_b { return 42 };
        }
    }
  }
  is official_b(), 42, "nested bare blocks are invisible to return";
}

{
  sub userdefinedcontrol_c ($value, &block) { block($value); return 24 }
  sub official_c($value) {
    {
        userdefinedcontrol_c $value, -> $x { return $x };
    }
  }
  is official_c(42), 42, "pointy blocks are invisible to return";
}

# return should desugar to &?ROUTINE.leave, where &?ROUTINE is lexically scoped
#    to mean the current "official" subroutine or method.

#?rakudo todo 'tie return() to lexical scope'
{
  sub userdefinedcontrol3 (&block) { block(); return 36 }
  sub userdefinedcontrol2 (&block) { userdefinedcontrol3(&block); return 24 }
  sub userdefinedcontrol1 (&block) { userdefinedcontrol2(&block); return 12 }
  sub official_d {
    userdefinedcontrol1 { return 42 };
  }
  is official_d(), 42,
    "subcalls in user-defined control flow are invisible to return", :todo<bug>;
}

class Foo {
  method userdefinedcontrol3 (&block) { block(); 36 }
  submethod userdefinedcontrol2 (&block) { self.userdefinedcontrol3(&block); 24 }
  method userdefinedcontrol1 (&block) { self.userdefinedcontrol2(&block); 12 }
  method officialmeth {
    self.userdefinedcontrol1({ return 42 });
  }
  submethod officialsubmeth {
    self.userdefinedcontrol1({ return 43 });
  }
  sub official {
    Foo.new.userdefinedcontrol1({ return 44 });
  }
}

#?pugs 3 todo 'return(), blocks and methods'
#?rakudo 3 todo 'tie return() to lexical scope'
is Foo.new.officialmeth(), 42,
    "return correctly from official method only";
is Foo.new.officialsubmeth(), 43,
    "return correctly from official submethod only";
is Foo::official(), 44,
    "return correctly from official sub only";
