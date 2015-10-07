
use v6;
use Test;

plan 10;

is { sub a(Int $a)   { $a }; a Int }(), Int, 'can Int   take an Int:U';
is { sub a(Int $a)   { $a }; a 42  }(),  42, 'can Int   take an Int:D';
#?rakudo 2 skip 'Int:_ not allowed'
is { sub a(Int:_ $a) { $a }; a Int }(), Int, 'can Int:_ take an Int:U';
is { sub a(Int:_ $a) { $a }; a 42  }(),  42, 'can Int:_ take an Int:D';
is { sub a(Int:U $a) { $a }; a Int }(), Int, 'can Int:U take an Int:U';
throws-like { sub a(Int:U $a) { $a }; a 42 }, 
  X::AdHoc,                                  'can Int:U take an Int:D';
throws-like { sub a(Int:D $a) { $a }; a Int }, 
  X::AdHoc,                                  'can Int:D take an Int:U';
is { sub a(Int:D $a) { $a }; a 42  }(),  42, 'can Int:D take an Int:D';
throws-like 'sub a(Int:foo $a) { $a }', 
  X::InvalidTypeSmiley,                      'does Int:foo fail';

#?rakudo todo 'not yet checking return value definedness'
dies-ok { sub a(--> Int:D) { Int }; a }, # change to throws-like if passes
  'can --> Int:D return an Int:U';


