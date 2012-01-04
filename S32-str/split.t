use v6;

use Test;

# L<S32::Str/Str/"=item split">

# XXX - this needs to be updated when Str.split(Str) works again
# this test really wants is_deeply()
#  and got it, except for a couple of cases that fail because of Match objects
#  being returned -- Aankhen
plan 37;

# split on an empty string

my %ords = (
  1 => 'first',
  2 => 'second',
  3 => 'third',
  4 => 'fourth',
  5 => 'fifth',
  6 => 'sixth',
  7 => 'seventh',
  8 => 'eighth',
  9 => 'ninth',
);

#?niecza todo "split on empty string has leading empty elements"
is split("", "forty-two").join(','),
   <f o r t y - t w o>.join(','),
   q{split "", Str};

# split on a space
is split(' ', 'split this string').join(','),
   <split this string>.join(','),
   q{split ' ', Str};

# split on a single character delimiter
is split('$', 'try$this$string').join(','),
   <try this string>.join(','),
   q{split '$', Str};

# split on a multi-character delimiter
is split(', ', "comma, separated, values").join(','),
   <comma separated values>.join(','),
   q{split ', ', Str};

# split on a variable delimiter

my $delimiter = '::';
is split($delimiter, "Perl6::Pugs::Test").join(','),
   <Perl6 Pugs Test>.join(','),
   q{split $delimiter, Str};

# split with a reg-exp
#?rakudo skip 'rx:Perl5'
#?niecza skip 'rx:Perl5'
is split(rx:Perl5 {,}, "split,me").join(','),
   qw/split me/.join(','),
   q/split rx:Perl5 {,}, Str/;

# split on multiple space characters
#?rakudo skip 'rx:Perl5'
#?niecza skip 'rx:Perl5'
is split(rx:Perl5 {\s+}, "Hello World    Goodbye   Mars").join(','),
   qw/Hello World Goodbye Mars/.join(','),
   q/split rx:Perl5 {\s+}, Str/;

#?rakudo skip 'FixedIntegerArray: index out of bounds!'
#?niecza skip 'rx:Perl5'
is split(rx:Perl5 {(\s+)}, "Hello test", :all).join(','),
   ('Hello', ("Hello test" ~~ rx:Perl5 {(\s+)}), 'test').join(','),
   q/split rx:Perl5 {(\s+)}, Str/;

is "to be || ! to be".split(' ').join(','),
   <to be || ! to be>.join(','),
   q/Str.split(' ')/;

#?rakudo skip 'rx:Perl5'
#?niecza skip 'rx:Perl5'
is "this will be split".split(rx:Perl5 { }).join(','),
   <this will be split>.join(','),
   q/Str.split(rx:Perl5 { })/;

# split on multiple space characters
#?rakudo skip 'rx:Perl5'
#?niecza skip 'rx:Perl5'
is split(rx:Perl5 {\s+}, "Hello World    Goodbye   Mars", 3).join(','),
   ( <Hello World>, "Goodbye   Mars" ).join(','),
   q/split rx:Perl5 {\s+}, Str, limit/;

is split(" ", "Hello World    Goodbye   Mars", 3).join(','),
   ( <Hello World>, "   Goodbye   Mars" ).join(','),
   q/split " ", Str, limit/;

#?rakudo skip 'rx:Perl5'
#?niecza skip 'rx:Perl5'
is "Hello World    Goodbye   Mars".split(rx:Perl5 {\s+}, 3).join(','),
   ( <Hello World>, "Goodbye   Mars" ).join(','),
   q/Str.split(rx:Perl5 {\s+}, limit)/;

is "Hello World    Goodbye   Mars".split(" ", 3).join(','),
   ( <Hello World>, "   Goodbye   Mars" ).join(','),
   q/Str.split(" ", limit)/;

#?niecza todo 'initial empty element'
is "Word".split("", 3).join(','), <W o rd>.join(','),
   q/Str.split("", limit)/;


#L<S32::Str/Str/"no longer has a default delimiter">
dies_ok {"  abc  def  ".split()}, q/Str.split() disallowed/;

# This one returns an empty list
#?niecza todo '2 element list'
is  "".split('').elems, 0, q/"".split()/;

# ... yet this one does not (different to p5).
# blessed by $Larry at Message-ID: <20060118191046.GB32562@wall.org>
is  "".split(':').elems, 1, q/"".split(':')/;

# using /.../
is "a.b".split(/\./).join(','), <a b>.join(','),
   q{"a.b".split(/\./)};

#?rakudo skip 'loops on zero-width match'
#?niecza skip 'Unable to resolve method null in class Cursor'
{
    is "abcd".split(/<null>/).join(','), <a b c d>.join(','),
       q{"abcd".split(/<null>/)};()
}

#?rakudo skip 'Null PMC access in invoke()'
#?niecza skip 'Unable to resolve method null in class Cursor'
{
  ' ' ~~ /(\s)/;

  if $0 eq ' ' {
    is "foo bar baz".split(/<prior>/).join(','), <foo bar baz>.join(','),
       q{"foo bar baz".split(/<prior>/)};
  } else {
    skip q{' ' ~~ /\s/ did not result in ' '};
  }
}

# RT #63066
#?rakudo skip 'RT #63066 loops forever'
{
    #?niecza todo 'has initial empty element'
    is 'hello-world'.split(/<ws>/).join(','), <hello - world>.join(','),
       q{'hello-world'.split(/<ws>/)};
    #?niecza skip 'Unable to resolve method wb in class Cursor'
    is 'hello-world'.split(/<wb>/).join(','), <hello - world>.join(','),
       q{'hello-world'.split(/<wb>/)};
}

{
    my @a = "hello world".split(/<[aeiou]>/, :all);
    is +@a, 7, "split:all resulted in seven pieces";
    isa_ok @a[1], Match, "second is a Match object";
    isa_ok @a[3], Match, "fourth is a Match object";
    isa_ok @a[5], Match, "sixth is a Match object";
    is ~@a, ~("h", "e", "ll", "o", " w", "o", "rld"), "The pieces are correct";
}

{
    my @a = "hello world".split(/(<[aeiou]>)(.)/, :all);
    is +@a, 7, "split:all resulted in seven pieces";
    is ~@a, ~("h", "el", "l", "o ", "w", "or", "ld"), "The pieces are correct";
    is @a[1][0], "e", "First capture worked";
    is @a[1][1], "l", "Second capture worked";
    is @a[3][0], "o", "Third capture worked";
    is @a[3][1], " ", "Fourth capture worked";
}

# RT #63066
{
    is 'hello-world'.split(/<.ws>/).join('|'), '|hello|-|world|',
            'zero-width delimiter (<.ws>)';
    #?niecza skip 'Unable to resolve method wb in class Cursor'
    is 'hello-world'.split(/<.wb>/).join('|'), '|hello|-|world|',
            'zero-width delimiter (<.wb>)';
    #?niecza skip 'Unable to resolve method wb in class Cursor'
    is 'a-b-c'.split(/<.wb>/).join('|'), '|a|-|b|-|c|',
            'zero-width delimiter (<.wb>) (2)';
}

done;

# vim: ft=perl6
