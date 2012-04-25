use v6;

use Test;

# L<S02/Arrays/As with Perl 5 array interpolation>
# See L<http://www.nntp.perl.org/group/perl.perl6.language/23224>:
#   In a private conversation with Larry this afternoon, he said that by
#   default "$foo" and ~$foo and $foo.as(Str) all give the same result
#   (assuming scalar context, etc.).  And that "@foo[]" and ~[at]foo and
#   @foo.as(Str) are the same as join(' ', @foo) where join is effectively:

plan 12;

{
  my @array = <a b c d>;

  is ~@array, "a b c d",
    "arrays whose elements don't contain whitespace stringify correctly (1)";
  is "@array[]", "a b c d", "arrays whose elements don't contain whitespace stringify correctly (2)";
  is "@array.[]", "a b c d", '@array.[] interpolates';
  is "@array", "@array", '@array (without brackets) doesnt interpolate';
}

{
  my @array = <a b c d>;
  push @array, [<e f g h>];

  is ~@array, "a b c d e f g h",
    "arrays with embedded array references stringify correctly (1)";
  is "@array[]", "a b c d e f g h", "arrays with embedded array references stringify correctly (2)";
}

{
  my @array = ("a", "b ", "c");

  is ~@array, "a b  c",
    "array whose elements do contain whitespace stringify correctly (1-1)";
  is "@array[]", "a b  c", "array whose elements do contain whitespace stringify correctly (1-2)";
}

{
  my @array = ("a\t", "b ", "c");

  is ~@array, "a\t b  c",
    "array whose elements do contain whitespace stringify correctly (2-1)";
  is "@array[]", "a\t b  c", "array whose elements do contain whitespace stringify correctly (2-2)";
}

{
  my @array = ("a\t", " b ", "c");

  is ~@array, "a\t  b  c",
    "array whose elements do contain whitespace stringify correctly (3-1)";
  is "@array[]", "a\t  b  c", "array whose elements do contain whitespace stringify correctly (3-2)";
}

# vim: ft=perl6
