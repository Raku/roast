use v6;
use Test;

plan 63;

my Int:D $j = 256;
MY::<$j> = 111;
is $j, 111, 'instance assignment to Int:D via MY:: pseudo package works';

try MY::<$j> = Int;
is $j, 111, 'typeobject assignment to Int:D via MY:: pseudo package fails';

try $j = Int;
is $j, 111, 'typeobject assignment to Int:D fails';

is { my Int   $a       }(),   Int, 'can Int   be on its own';
is { my Int   $a = Int }(),   Int, 'can Int   take an Int:U';
is { my Int   $a =  42 }(),    42, 'can Int   take an Int:D';

is { my Int:_ $a       }(),   Int, 'can Int:_ be on its own';
is { my Int:_ $a = Int }(),   Int, 'can Int:_ take an Int:U';
is { my Int:_ $a = 42  }(),    42, 'can Int:_ take an Int:D';

#?rakudo.jvm todo "got '?.?' RT #128031"
is { my Int:U $a       }(), Int:U, 'can Int:U be on its own';
is { my Int:U $a = Int }(),   Int, 'can Int:U take an Int:U';
throws-like { my Int:U $a = 42 }, 
  X::TypeCheck::Assignment,
  symbol => '$a',                  'can Int:U take an Int:D';

throws-like 'my Int:D $a', 
  X::Syntax::Variable::MissingInitializer,
  type => 'Int:D',                 'can Int:D be on its own';
throws-like { my Int:D $a = Int }, 
  X::TypeCheck::Assignment,
  symbol => '$a',                  'can Int:D take an Int:U';
is { my Int:D $a = 42  }(),    42, 'can Int:D take an Int:D';

{
    use variables :_;
    is { my Int   $a       }(),   Int, 'with :_, can Int   be on its own';
    is { my Int   $a = Int }(),   Int, 'with :_, can Int   take an Int:U';
    is { my Int   $a =  42 }(),    42, 'with :_, can Int   take an Int:D';

    is { my Int:_ $a       }(),   Int, 'with :_, can Int:_ be on its own';
    is { my Int:_ $a = Int }(),   Int, 'with :_, can Int:_ take an Int:U';
    is { my Int:_ $a = 42  }(),    42, 'with :_, can Int:_ take an Int:D';

    #?rakudo.jvm todo "got '?.?' RT #128031"
    is { my Int:U $a       }(), Int:U, 'with :_, can Int:U be on its own';
    is { my Int:U $a = Int }(),   Int, 'with :_, can Int:U take an Int:U';
    throws-like { my Int:U $a = 42 }, 
      X::TypeCheck::Assignment,
      symbol => '$a',                  'with :_, can Int:U take an Int:D';

    throws-like 'my Int:D $a', 
      X::Syntax::Variable::MissingInitializer,
      type => 'Int:D',               'with :_, can Int:D be on its own';
    throws-like { my Int:D $a = Int }, 
      X::TypeCheck::Assignment,
      symbol => '$a',                'with :_, can Int:D take an Int:U';
    is { my Int:D $a = 42  }(),  42, 'with :_, can Int:D take an Int:D';
}

{
    use variables :U;
    #?rakudo.jvm todo "got '?.?' RT #128031"
    is { my Int   $a       }(), Int:U, 'with :U, can Int   be on its own';
    is { my Int   $a = Int }(),   Int, 'with :U, can Int   take an Int:U';
    throws-like { my Int   $a = 42 }, 
      X::TypeCheck::Assignment,
      symbol => '$a',                'with :U, can Int   take an Int:D';

    is { my Int:_ $a       }(),   Int, 'with :U, can Int:_ be on its own';
    is { my Int:_ $a = Int }(),   Int, 'with :U, can Int:_ take an Int:U';
    is { my Int:_ $a = 42  }(),    42, 'with :U, can Int:_ take an Int:D';

    #?rakudo.jvm todo "got '?.?' RT #128031"
    is { my Int:U $a       }(), Int:U, 'with :U, can Int:U be on its own';
    is { my Int:U $a = Int }(),   Int, 'with :U, can Int:U take an Int:U';
    throws-like { my Int:U $a = 42 }, 
      X::TypeCheck::Assignment,
      symbol => '$a',                  'with :U, can Int:U take an Int:D';

    throws-like 'use variables :U; my Int:D $a', # XXX pragma's not seen in EVAL
      X::Syntax::Variable::MissingInitializer,
      type => 'Int:D',                 'with :U, can Int:D be on its own';
    throws-like { my Int:D $a = Int }, 
      X::TypeCheck::Assignment,
      symbol => '$a',                  'with :U, can Int:D take an Int:U';
    is { my Int:D $a = 42  }(),    42, 'with :U, can Int:D take an Int:D';
}

{
    use variables :D;
    throws-like 'use variables :D; my Int $a',  # XXX pragma's not seen in EVAL
      X::Syntax::Variable::MissingInitializer,
      type => 'Int:D', implicit => ':D by pragma',
                                       'with :D, can Int   be on its own';
    throws-like { my Int   $a = Int }, 
      X::TypeCheck::Assignment,
      symbol => '$a',                  'with :D, can Int   take an Int:U';
    is { my Int   $a =  42 }(),    42, 'with :D, can Int   take an Int:D';

    is { my Int:_ $a       }(),   Int, 'with :D, can Int:_ be on its own';
    is { my Int:_ $a = Int }(),   Int, 'with :D, can Int:_ take an Int:U';
    is { my Int:_ $a = 42  }(),    42, 'with :D, can Int:_ take an Int:D';

    #?rakudo.jvm todo "got '?.?' RT #128031"
    is { my Int:U $a       }(), Int:U, 'with :D, can Int:U be on its own';
    is { my Int:U $a = Int }(),   Int, 'with :D, can Int:U take an Int:U';
    throws-like { my Int:U $a = 42 }, 
      X::TypeCheck::Assignment,
      symbol => '$a',                  'with :D, can Int:U take an Int:D';

    throws-like 'use variables :D; my Int:D $a', # XXX pragma's not seen in EVAL
      X::Syntax::Variable::MissingInitializer,
      type => 'Int:D',                 'with :D, can Int:D be on its own';
    throws-like { my Int:D $a = Int }, 
      X::TypeCheck::Assignment,
      symbol => '$a',                  'with :D, can Int:D take an Int:U';
    is { my Int:D $a = 42  }(),    42, 'with :D, can Int:D take an Int:D';
}

throws-like 'my Int:foo $a', 
  X::InvalidTypeSmiley,          'does Int:foo fail';

throws-like 'use variables', 
  X::Pragma::MustOneOf,
  name => "variables",
  'does use variables fail';
throws-like 'no variables', 
  X::Pragma::CannotWhat,
  what => "no",
  name => "variables",
  'does no variables fail';
throws-like 'use variables "bar"', 
  X::Pragma::UnknownArg,
  name => "variables",
  arg  => "bar",
  'does use variables "bar" fail';
throws-like 'use variables :U, :D', 
  X::Pragma::OnlyOne,
  name => 'variables',
  'does use variables :U, :D fail';
throws-like 'use variables :foo', 
  X::InvalidTypeSmiley,
  name => 'foo',
  'does use variables :foo fail';

# RT #126291
{
    my Int:D $x is default(0);
    is $x, 0, 'Int:D with default value via trait';

    my Int:D @array is default(0); @array[0] = Nil;
    is @array[0], 0, 'Int:D array with default value via trait';

    throws-like { @array[0] = Int },
        X::TypeCheck::Assignment,
        symbol => '@array', 'type check happens for Int:D array';
}

# RT #127958
{
    # At the time of writing these thrown at runtime. Though they
    # could/should be thrown at compile time in the future so EVAL is used.
    # See ticket for discussion.
    throws-like { EVAL q|my Int:D $x = Nil| },
    X::TypeCheck::Assignment,'Int:D $x = Nil; throws a typecheck';

    throws-like { EVAL q|my Int:D @x = Nil| },
    X::TypeCheck::Assignment,'Int:D @x = Nil; throws a typecheck';

    throws-like { EVAL q|my Int:D %x = foo => Nil| },
    X::TypeCheck::Assignment,'Int:D %x = foo => Nil; throws a typecheck';
}

# vim: ft=perl6
