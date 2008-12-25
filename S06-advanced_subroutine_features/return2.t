use v6;

use Test;

# Basic &return tests
# L<S06/"The C<return> function">

plan 7;

#?rakudo skip 'lexical subs'
{
  my sub userdefinedcontrol (&block) { &block(); return 24 }
  my sub official {
    userdefinedcontrol { return 42 };
  }
  is official(), 42, "bare blocks are invisible to return";
}

#?rakudo skip 'lexical subs'
{
  my sub userdefinedcontrol (&block) { &block(); return 24 }
  my sub official {
    {
	{
	    userdefinedcontrol { return 42 };
	}
    }
  }
  is official(), 42, "nested bare blocks are invisible to return";
}

#?rakudo skip 'lexical subs'
{
  my sub userdefinedcontrol ($value, &block) { &block($value); return 24 }
  my sub official($value) {
    {
	userdefinedcontrol $value, -> $x { return $x };
    }
  }
  is official(42), 42, "pointy blocks are invisible to return";
}

# return should desugar to &?ROUTINE.leave, where &?ROUTINE is lexically scoped
#    to mean the current "official" subroutine or method.

#?rakudo skip 'lexical subs'
{
  my sub userdefinedcontrol3 (&block) { &block(); return 36 }
  my sub userdefinedcontrol2 (&block) { userdefinedcontrol3(&block); return 24 }
  my sub userdefinedcontrol1 (&block) { userdefinedcontrol2(&block); return 12 }
  my sub official {
    userdefinedcontrol1 { return 42 };
  }
  is official(), 42,
    "subcalls in user-defined control flow are invisible to return", :todo<bug>;
}

class Foo {
  method userdefinedcontrol3 (&block) { &block(); 36 }
  submethod userdefinedcontrol2 (&block) { $.userdefinedcontrol3(&block); 24 }
  method userdefinedcontrol1 (&block) { $.userdefinedcontrol2(&block); 12 }
  method officialmeth {
    $.userdefinedcontrol1({ return 42 });
  }
  submethod officialsubmeth {
    $.userdefinedcontrol1({ return 43 });
  }
  sub official {
    Foo.userdefinedcontrol1({ return 44 });
  }
}

#?pugs 3 todo 'return(), blocks and methods'
is Foo.officialmeth(), 42,
    "return correctly from official method only";
is Foo.officialmeth(), 43,
    "return correctly from official submethod only";
is Foo::official(), 44,
    "return correctly from official sub only";
