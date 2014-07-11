use v6;
use Test;

# L<S29/"Type Declarations">

=begin pod

Test for some type declarations for built-in functions. 

=end pod

plan 9;

# Maybe this test should be modified to run with rakudo

my sub ok_eval1($code) {
    &Test::ok.nextwith(EVAL($code),$code)
}

ok_eval1('AnyChar.isa(Str)');
ok_eval1('Char.isa(Str)');
ok_eval1('Codepoint =:= Uni');
ok_eval1('CharLingua.isa(AnyChar)');
ok_eval1('Grapheme.isa(AnyChar)');
ok_eval1('Codepoint.isa(AnyChar)');
ok_eval1('Byte.isa(AnyChar)');
ok_eval1('Byte.isa(Num)');
ok_eval1('subset MatchTest of Item | junction;');

# vim: ft=perl6
