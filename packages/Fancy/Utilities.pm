module Fancy::Utilities {
 our sub lolgreet($who) is export(:lolcat, :greet) {
  return "O HAI " ~ uc $who;
 }
 sub nicegreet($who) is export(:greet, :DEFAULT) {
  return "Good morning, $who!"; # Always morning?
 }
 sub shortgreet is export(:greet) {
  return "Hi!";
 }
 sub lolrequest($item) is export(:lolcat) {
  return "I CAN HAZ A {uc $item}?";
 }
 sub allgreet() is export {
     'hi all';
 }
 multi sub greet(Str $who) { return "Good morning, $who!" }
 multi sub greet() { return "Hi!" }
}
