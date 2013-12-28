use v6;

use Test;

# L<S32-setting-library/Str"=item split">

plan 53;

# split on empty string
#?niecza todo "split on empty string has leading empty elements"
{
    is split("", "forty-two").join(','), 'f,o,r,t,y,-,t,w,o',
      q{split "", Str};
    is "forty-two".split("").join(','), 'f,o,r,t,y,-,t,w,o',
      q{Str.split: ""};

    is split("", "forty-two", 3).join(','), 'f,o,rty-two',
      q{split "", Str};
    is "forty-two".split("",3).join(','), 'f,o,rty-two',
      q{Str.split: ""};
}

# split on a space
{
    is split(' ', 'split this string').join(','), 'split,this,string',
      q{split ' ', Str};
    is 'split this string'.split(' ').join(','), 'split,this,string',
      q{Str.split: ' '};

    is split(' ', 'split this string', 2).join(','), 'split,this string',
      q{split ' ', Str, 2};
    is 'split this string'.split(' ',2).join(','), 'split,this string',
      q{Str.split: ' ', 2};
}

# split on a single character delimiter
{
    is split('$', 'try$this$string').join(','), 'try,this,string',
      q{split '$', Str};
    is 'try$this$string'.split('$').join(','), 'try,this,string',
      q{Str.split: '$'};

    is split('$', 'try$this$string',2).join(','), 'try,this$string',
      q{split '$', Str, 2};
    is 'try$this$string'.split('$',2).join(','), 'try,this$string',
      q{Str.split: '$', 2};
}

# split on a multi-character delimiter
{
    is split(', ', "comma, separated, values").join('|'),
      'comma|separated|values', q{split ', ', Str};
    is "comma, separated, values".split(", ").join('|'),
      'comma|separated|values', q{Str.split: ', '};

    is split(', ', "comma, separated, values",2).join('|'),
      'comma|separated, values', q{split ', ', Str,2};
    is "comma, separated, values".split(", ",2).join('|'),
      'comma|separated, values', q{Str.split: ', ',2};
}

# split on a variable delimiter
{
    my $del = '::';
    is split($del, "Perl6::Camelia::Test").join(','), 'Perl6,Camelia,Test',
       q{split $del, Str};
    is 'Perl6::Camelia::Test'.split($del).join(','), 'Perl6,Camelia,Test',
       q{Str.split: $del};

    is split($del, "Perl6::Camelia::Test",2).join(','), 'Perl6,Camelia::Test',
       q{split $del, Str,2};
    is 'Perl6::Camelia::Test'.split($del,2).join(','), 'Perl6,Camelia::Test',
       q{Str.split: $del,2};
}

# split with a single char reg-exp
#?niecza skip 'rx:Perl5'
{
    is split(rx:Perl5 {,},"split,me,please").join('|'), 'split|me|please',
      'split rx:P5 {,},Str';
    is 'split,me,please'.split(rx:Perl5 {,}).join('|'), 'split|me|please',
      'Str.split: rx:P5 {,}';

    is split(rx:Perl5 {,},"split,me,please",2).join('|'), 'split|me,please',
      'split rx:P5 {,},Str,2';
    is 'split,me,please'.split(rx:Perl5 {,},2).join('|'), 'split|me,please',
      'Str.split: rx:P5 {,},2';
}

# split on regex with any whitespace
#?niecza skip 'rx:Perl5'
{
    is split(rx:Perl5 {\s+}, "Hello World    Goodbye   Mars").join(','),
      'Hello,World,Goodbye,Mars', q/split rx:Perl5 {\s+}, Str/;
    is 'Hello World    Goodbye  Mars'.split(rx:Perl5 {\s+}).join(','),
      'Hello,World,Goodbye,Mars', q/Str.split: rx:Perl5 {\s+}/;

    is split(rx:Perl5 {\s+}, "Hello World    Goodbye   Mars", 3).join(','),
      'Hello,World,Goodbye   Mars', q/split rx:Perl5 {\s+}, Str, 3/;
    is 'Hello World    Goodbye   Mars'.split(rx:Perl5 {\s+}, 3).join(','),
      'Hello,World,Goodbye   Mars', q/Str.split: rx:Perl5 {\s+}, 3/;
}

#?niecza skip 'rx:Perl5'
{
    is split(rx:Perl5 {(\s+)}, "Hello test", :all).join(','), 'Hello, ,test',
      q/split rx:Perl5 {(\s+)}, Str/;
    is "Hello test".split(rx:Perl5 {(\s+)}, :all).join(','), 'Hello, ,test',
      q/Str.split rx:Perl5 {(\s+)}/;
}

#?niecza skip 'rx:Perl5'
{
    is split(rx:Perl5 { },"this will be split").join(','), 'this,will,be,split',
      q/split(rx:Perl5 { }, Str)/;
    is "this will be split".split(rx:Perl5 { }).join(','), 'this,will,be,split',
      q/Str.split(rx:Perl5 { })/;
    is split(rx:Perl5 { },"this will be split",3).join(','),
      'this,will,be split', q/split rx:Perl5 { }, Str,3)/;
    is "this will be split".split(rx:Perl5 { },3).join(','),
      'this,will,be split', q/Str.split: rx:Perl5 { },3/;
}

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

#?rakudo skip 'No such method null for invocant of type Cursor'
#?niecza skip 'Unable to resolve method null in class Cursor'
{
    is "abcd".split(/<null>/).join(','), <a b c d>.join(','),
       q{"abcd".split(/<null>/)};()
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
    is '-a-b-c-'.split(/<.wb>/).join('|'), '-|a|-|b|-|c|-',
      'zero-width delimiter (<.wb>) (2)';
}

# vim: ft=perl6
