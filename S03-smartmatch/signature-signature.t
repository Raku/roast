use v6;
use Test;
plan 5;

#L<S03/Smart matching/Signature-signature>
{
	ok  (:(Str)      ~~ :(Str)),           'signature :(Str) is the same as :(Str)';
	ok !(:(Str)      ~~ :(Int)),           'signature :(Str) is not the same as :(Int)';
	ok  (:(Str, Int) ~~ :(Str, Int)),      'signature :(Str, Int) is the same as :(Str, Int)';
	ok !(:(Str, Int) ~~ :(Int, Str)),      'signature :(Str, Int) is not the same as :(Int, Str)';
	ok !(:(Str, Int) ~~ :(Str, Int, Str)), 'signature :(Str, Int) is not the same as :(Str, Int, Str)';
}

done;

# vim: ft=perl6
