use v6;
use Test;

plan 54;

is class { has Int   $.a       }.new.a,   Int, 'can Int   be on its own';
is class { has Int   $.a = Int }.new.a,   Int, 'can Int   take an Int:U';
is class { has Int   $.a =  42 }.new.a,    42, 'can Int   take an Int:D';

is class { has Int:_ $.a       }.new.a,   Int, 'can Int:_ be on its own';
is class { has Int:_ $.a = Int }.new.a,   Int, 'can Int:_ take an Int:U';
is class { has Int:_ $.a = 42  }.new.a,    42, 'can Int:_ take an Int:D';

is class { has Int:U $.a       }.new.a, Int:U, 'can Int:U be on its own';
is class { has Int:U $.a = Int }.new.a,   Int, 'can Int:U take an Int:U';
throws-like { class { has Int:U $.a = 42 }.new.a }, 
  X::TypeCheck::Assignment,
  symbol => '$!a',                             'can Int:U take an Int:D';

throws-like 'class { has Int:D $.a }', 
  X::Syntax::Variable::MissingInitializer,
  type => 'Int:D',                             'can Int:D be on its own';
throws-like { class { has Int:D $.a = Int }.new.a }, 
  X::TypeCheck::Assignment,
  symbol => '$!a',                             'can Int:D take an Int:U';
is class { has Int:D $.a = 42  }.new.a,    42, 'can Int:D take an Int:D';

{
    use attributes :_;
    is class { has Int   $.a       }.new.a,   Int, 'with :_, can Int   be on its own';
    is class { has Int   $.a = Int }.new.a,   Int, 'with :_, can Int   take an Int:U';
    is class { has Int   $.a =  42 }.new.a,    42, 'with :_, can Int   take an Int:D';

    is class { has Int:_ $.a       }.new.a,   Int, 'with :_, can Int:_ be on its own';
    is class { has Int:_ $.a = Int }.new.a,   Int, 'with :_, can Int:_ take an Int:U';
    is class { has Int:_ $.a = 42  }.new.a,    42, 'with :_, can Int:_ take an Int:D';

    is class { has Int:U $.a       }.new.a, Int:U, 'with :_, can Int:U be on its own';
    is class { has Int:U $.a = Int }.new.a,   Int, 'with :_, can Int:U take an Int:U';
    throws-like { class { has Int:U $.a = 42 }.new }, 
      X::TypeCheck::Assignment,
      symbol => '$!a',                             'with :_, can Int:U take an Int:D';

    throws-like 'class { has Int:D $.a }', 
      X::Syntax::Variable::MissingInitializer,
      type => 'Int:D',                             'with :_, can Int:D be on its own';
    throws-like { class { has Int:D $.a = Int }.new }, 
      X::TypeCheck::Assignment,
      symbol => '$!a',                             'with :_, can Int:D take an Int:U';
    is class { has Int:D $.a = 42  }.new.a,    42, 'with :_, can Int:D take an Int:D';
}

{
    use attributes :U;
    is class { has Int   $.a       }.new.a, Int:U, 'with :U, can Int   be on its own';
    is class { has Int   $.a = Int }.new.a,   Int, 'with :U, can Int   take an Int:U';
    throws-like { class { has Int $a = 42 }.new }, 
      X::TypeCheck::Assignment,
      symbol => '$!a',                             'with :U, can Int   take an Int:D';

    is class { has Int:_ $.a       }.new.a,   Int, 'with :U, can Int:_ be on its own';
    is class { has Int:_ $.a = Int }.new.a,   Int, 'with :U, can Int:_ take an Int:U';
    is class { has Int:_ $.a = 42  }.new.a,    42, 'with :U, can Int:_ take an Int:D';

    is class { has Int:U $.a       }.new.a, Int:U, 'with :U, can Int:U be on its own';
    is class { has Int:U $.a = Int }.new.a,   Int, 'with :U, can Int:U take an Int:U';
    throws-like { class { has Int:U $.a = 42 }.new }, 
      X::TypeCheck::Assignment,
      symbol => '$!a',                             'with :U, can Int:U take an Int:D';

    throws-like 'use attributes :U; class { has Int:D $a }', # XXX pragma's not seen in EVAL
      X::Syntax::Variable::MissingInitializer,
      type => 'Int:D',                             'with :U, can Int:D be on its own';
    throws-like { class { has Int:D $.a = Int }.new }, 
      X::TypeCheck::Assignment,
      symbol => '$!a',                             'with :U, can Int:D take an Int:U';
    is class { has Int:D $.a = 42  }.new.a,    42, 'with :U, can Int:D take an Int:D';
}

{
    use attributes :D;
    throws-like 'use attributes :D; class { has Int $a }',  # XXX pragma's not seen in EVAL
      X::Syntax::Variable::MissingInitializer,
      type => 'Int:D', implicit => ':D by pragma', 'with :D, can Int   be on its own';
    throws-like { class { has Int $a = Int }.new }, 
      X::TypeCheck::Assignment,
      symbol => '$!a',                             'with :D, can Int   take an Int:U';
    is class { my Int    $.a =  42 }.new.a,    42, 'with :D, can Int   take an Int:D';

    is class { has Int:_ $.a       }.new.a,   Int, 'with :D, can Int:_ be on its own';
    is class { has Int:_ $.a = Int }.new.a,   Int, 'with :D, can Int:_ take an Int:U';
    is class { has Int:_ $.a =  42 }.new.a,    42, 'with :D, can Int:_ take an Int:D';

    is class { has Int:U $.a       }.new.a, Int:U, 'with :D, can Int:U be on its own';
    is class { has Int:U $.a = Int }.new.a,   Int, 'with :D, can Int:U take an Int:U';
    throws-like { class { has Int:U $.a = 42 }.new }, 
      X::TypeCheck::Assignment,
      symbol => '$!a',                             'with :D, can Int:U take an Int:D';

    throws-like 'use attributes :D; class { has Int:D $.a }', # XXX pragma's not seen in EVAL
      X::Syntax::Variable::MissingInitializer,
      type => 'Int:D',                             'with :D, can Int:D be on its own';
    throws-like { class { has Int:D $.a = Int }.new }, 
      X::TypeCheck::Assignment,
      symbol => '$!a',                             'with :D, can Int:D take an Int:U';
    is class { has Int:D $.a = 42  }.new.a,    42, 'with :D, can Int:D take an Int:D';
}

throws-like 'my Int:foo $a', 
  X::InvalidTypeSmiley,          'does Int:foo fail';

throws-like 'use attributes', 
  X::Pragma::MustOneOf,
  name => "attributes",
  'does use attributes fail';
throws-like 'no attributes', 
  X::Pragma::CannotNo,
  name => "attributes",
  'does no attributes fail';
throws-like 'use attributes "bar"', 
  X::Pragma::UnknownArg,
  name => "attributes",
  arg  => "bar",
  'does use attributes "bar" fail';
throws-like 'use attributes :U, :D', 
  X::Pragma::OnlyOne,
  name => 'attributes',
  'does use attributes :U, :D fail';
throws-like 'use attributes :foo', 
  X::InvalidTypeSmiley,
  name => 'foo',
  'does use attributes :foo fail';

# vim: ft=perl6

