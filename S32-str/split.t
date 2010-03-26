use v6;

use Test;

# L<S32::Str/Str/"=item split">

# XXX - this needs to be updated when Str.split(Str) works again
# this test really wants is_deeply()
#  and got it, except for a couple of cases that fail because of Match objects
#  being returned -- Aankhen
plan 25;

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

#?rakudo skip 'named arguments to split()'
is split(:input("fiSMBoC => fREW is Station's Most Bodacious Creation"), " ").join(','),
   qw/fiSMBoC => fREW is Station's Most Bodacious Creation/.join(','),
   q{split(:input(Str), " "};

#?rakudo skip 'named arguments to split()'
is split(:input("UNIFICATIONS => Unions Normally Identified From Initial Characters; Aesthetically Tailored to Infer Other Notions Subconsciously"), /\s+/).join(','),
   qw/UNIFICATIONS => Unions Normally Identified From Initial Characters; Aesthetically Tailored to Infer Other Notions Subconsciously/.join(','),
   q{split(:input(Str), /\s+/};

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
is split(rx:Perl5 {,}, "split,me").join(','),
   qw/split me/.join(','),
   q/split rx:Perl5 {,}, Str/;

# split on multiple space characters
#?rakudo skip 'rx:Perl5'
is split(rx:Perl5 {\s+}, "Hello World    Goodbye   Mars").join(','),
   qw/Hello World Goodbye Mars/.join(','),
   q/split rx:Perl5 {\s+}, Str/;

#?rakudo skip 'FixedIntegerArray: index out of bounds!'
is split(rx:Perl5 {(\s+)}, "Hello test", :all).join(','),
   ('Hello', ("Hello test" ~~ rx:Perl5 {(\s+)}), 'test').join(','),
   q/split rx:Perl5 {(\s+)}, Str/;

is "to be || ! to be".split(' ').join(','),
   <to be || ! to be>.join(','),
   q/Str.split(' ')/;

#?rakudo skip 'rx:Perl5'
is "this will be split".split(rx:Perl5 { }).join(','),
   <this will be split>.join(','),
   q/Str.split(rx:Perl5 { })/;

# split on multiple space characters
#?rakudo skip 'rx:Perl5'
is split(rx:Perl5 {\s+}, "Hello World    Goodbye   Mars", 3).join(','),
   ( <Hello World>, "Goodbye   Mars" ).join(','),
   q/split rx:Perl5 {\s+}, Str, limit/;

is split(" ", "Hello World    Goodbye   Mars", 3).join(','),
   ( <Hello World>, "   Goodbye   Mars" ).join(','),
   q/split " ", Str, limit/;

#?rakudo skip 'rx:Perl5'
is "Hello World    Goodbye   Mars".split(rx:Perl5 {\s+}, 3).join(','),
   ( <Hello World>, "Goodbye   Mars" ).join(','),
   q/Str.split(rx:Perl5 {\s+}, limit)/;

is "Hello World    Goodbye   Mars".split(" ", 3).join(','),
   ( <Hello World>, "   Goodbye   Mars" ).join(','),
   q/Str.split(" ", limit)/;

is "Word".split("", 3).join(','), <W o rd>.join(','),
   q/Str.split("", limit)/;


#L<S32::Str/Str/"no longer has a default delimiter">
dies_ok {"  abc  def  ".split()}, q/Str.split() disallowed/;

# This one returns an empty list
#?rakudo todo "Empty split on empty yields a single result"
is  "".split('').elems, 0, q/"".split()/;

# ... yet this one does not (different to p5).
# blessed by $Larry at Message-ID: <20060118191046.GB32562@wall.org>
is  "".split(':').elems, 1, q/"".split(':')/;

# using /.../
is "a.b".split(/\./).join(','), <a b>.join(','),
   q{"a.b".split(/\./)};

#?rakudo skip 'loops on zero-width match'
{
    is "abcd".split(/<null>/).join(','), <a b c d>.join(','),
       q{"abcd".split(/<null>/)};()
}

#?rakudo skip 'Null PMC access in invoke()'
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
    is 'hello-world'.split(/<ws>/).join(','), <hello - world>.join(','),
       q{'hello-world'.split(/<ws>/)};
    is 'hello-world'.split(/<wb>/).join(','), <hello - world>.join(','),
       q{'hello-world'.split(/<wb>/)};
}

# vim: ft=perl6
