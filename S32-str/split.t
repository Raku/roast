use v6;

use Test;

# L<S32-setting-library/Str"=item split">

plan 106;

# split on empty string
{
    is split("", "forty-two").join(','), ',f,o,r,t,y,-,t,w,o,',
      q{split "", Str};
    is "forty-two".split("").join(','), ',f,o,r,t,y,-,t,w,o,',
      q{Str.split: ""};

    is split("", "forty-two", 3).join(','), ',f,orty-two',
      q{split "", Str};
    is "forty-two".split("",3).join(','), ',f,orty-two',
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

# split on start/end of string
{

    is split('|', '|life|universe|everything|').join("-"), "-life-universe-everything-",
        "Splitting string where delimiter occurs at start/end has null strings at start/end of list";

    is split('|', '|life|universe|the third thing|', 5).join("-"), "-life-universe-the third thing-",
        "Splitting string where delimiter occurs at start/end with limit on number of splits";
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
    is split(rx:Perl5 {(\s+)}, "Hello test", :all).flat.join(','), 'Hello, ,test',
      q/split rx:Perl5 {(\s+)}, Str/;
    is "Hello test".split(rx:Perl5 {(\s+)}, :all).flat.join(','), 'Hello, ,test',
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
dies-ok {"  abc  def  ".split()}, q/Str.split() disallowed/;

# This one returns an empty list
#?niecza todo '2 element list'
is  "".split('').elems, 0, q/"".split()/;

# ... yet this one does not (different to p5).
# blessed by $Larry at Message-ID: <20060118191046.GB32562@wall.org>
is  "".split(':').elems, 1, q/"".split(':')/;

# using /.../
is "a.b".split(/\./).join(','), <a b>.join(','),
   q{"a.b".split(/\./)};

#?rakudo skip 'No such method null for invocant of type Cursor RT #124685'
#?niecza skip 'Unable to resolve method null in class Cursor'
{
    is "abcd".split(/<null>/).join(','), <a b c d>.join(','),
       q{"abcd".split(/<null>/)};()
}

{
    my @a = "hello world".split(/<[aeiou]>/, :all);
    is +@a, 7, "split:all resulted in seven pieces";
    isa-ok @a[1], Match, "second is a Match object";
    isa-ok @a[3], Match, "fourth is a Match object";
    isa-ok @a[5], Match, "sixth is a Match object";
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

{
    my $str = "foobarbaz";
    is $str.split(<a o>), <<f "" b rb z>>,
      "split '$str' on a o";
    is $str.split(<a o>,2), <<f obarbaz>>,
      "split '$str' on a o for 2";
    is $str.split(<a o>,:k), <<f 1 "" 1 b 0 rb 0 z>>,
      "split '$str' on a o with :k";
    is $str.split(<a o>,2,:k), <<f 1 obarbaz>>,
      "split '$str' on a o for 2 with :k";
    is $str.split(<a o>,:v), <<f o "" o b a rb a z>>,
      "split '$str' on a o with :v";
    is $str.split(<a o>,2,:v), <<f o obarbaz>>,
      "split '$str' on a o for 2 with :v";
    is $str.split(<a o>,:kv), <<f 1 o "" 1 o b 0 a rb 0 a z>>,
      "split '$str' on a o with :kv";
    is $str.split(<a o>,2,:kv), <<f 1 o obarbaz>>,
      "split '$str' on a o for 2 with :kv";
    is $str.split(<a o>,:p), ('f',1=>'o',"",1=>'o','b',0=>'a','rb',0=>'a','z'),
      "split '$str' on a o with :p";
    is $str.split(<a o>,2,:p), ('f',1=>'o','obarbaz'),
      "split '$str' on a o for 2 with :p";

    is $str.split(<a o>, :skip-empty), <f b rb z>,
      "split '$str' on a o with :skip-empty";
    is $str.split(<a o>,:k, :skip-empty), <<f 1 1 b 0 rb 0 z>>,
      "split '$str' on a o with :k with :skip-empty";
    is $str.split(<a o>,:v, :skip-empty), <<f o o b a rb a z>>,
      "split '$str' on a o with :v with :skip-empty";
    is $str.split(<a o>,:kv, :skip-empty), <<f 1 o 1 o b 0 a rb 0 a z>>,
      "split '$str' on a o with :kv with skip-empty";
    is $str.split(<a o>,:p, :skip-empty),
      ('f',1=>'o',1=>'o','b',0=>'a','rb',0=>'a','z'),
      "split '$str' on a o with :p with skip-empty";

    throws-like { $str.split(<a o>,:k, :v) }, X::Adverb,
      what   => 'split',
      source => 'Str',
      nogo   => <k v>,
      'clashing named parameters';
    throws-like { $str.split(<a o>, 3, :skip-empty) }, X::AdHoc,
      "cannot combine limit with :skip-empty";
    throws-like { $str.split((/a/,/o/), :k) }, X::AdHoc,
      "Can only :k, :kv, :p when using multiple Cool needles";

    is $str,"foobarbaz", "no changes made to $str";
}

{
    my $str = "zzzzzzzzzzzzzzzzzz";
    is $str.split(<a o>),       ($str), "split '$str' on a o";
    is $str.split(<a o>,2),     ($str), "split '$str' on a o for 2";
    is $str.split(<a o>,:k),    ($str), "split '$str' on a o with :k";
    is $str.split(<a o>,2,:k),  ($str), "split '$str' on a o for 2 with :k";
    is $str.split(<a o>,:v),    ($str), "split '$str' on a o with :v";
    is $str.split(<a o>,2,:v),  ($str), "split '$str' on a o for 2 with :v";
    is $str.split(<a o>,:kv),   ($str), "split '$str' on a o with :kv";
    is $str.split(<a o>,2,:kv), ($str), "split '$str' on a o for 2 with :kv";
    is $str.split(<a o>,:p),    ($str), "split '$str' on a o with :p";
    is $str.split(<a o>,2,:p),  ($str), "split '$str' on a o for 2 with :p";

    is $str.split(<a o>, :skip-empty), ($str),
      "split '$str' on a o with :skip-empty";
    is $str.split(<a o>,:k, :skip-empty), ($str),
      "split '$str' on a o with :k with :skip-empty";
    is $str.split(<a o>,:v, :skip-empty), ($str),
      "split '$str' on a o with :v with :skip-empty";
    is $str.split(<a o>,:kv, :skip-empty), ($str),
      "split '$str' on a o with :kv with skip-empty";
    is $str.split(<a o>,:p, :skip-empty), ($str),
      "split '$str' on a o with :p with skip-empty";

    is $str,"zzzzzzzzzzzzzzzzzz", "no changes made to $str";
}

{
    my $str = "oooo";
    is $str.split(<a o>),       <<"" "" "" "" "">>,
      "split '$str' on a o";
    is $str.split(<a o>,2),     <<"" ooo>>,
      "split '$str' on a o for 2";
    is $str.split(<a o>,:k),    <<"" 1 "" 1 "" 1 "" 1 "">>,
      "split '$str' on a o with :k";
    is $str.split(<a o>,2,:k),  <<"" 1 ooo>>,
      "split '$str' on a o for 2 with :k";
    is $str.split(<a o>,:v),    <<"" o "" o "" o "" o "">>,
      "split '$str' on a o with :v";
    is $str.split(<a o>,2,:v),  <<"" o ooo>>,
      "split '$str' on a o for 2 with :v";
    is $str.split(<a o>,:kv),   <<"" 1 o "" 1 o "" 1 o "" 1 o "">>,
      "split '$str' on a o with :kv";
    is $str.split(<a o>,2,:kv), <<"" 1 o ooo>>,
      "split '$str' on a o for 2 with :kv";
    is $str.split(<a o>,:p),    ("",1=>"o","",1=>"o","",1=>"o","",1=>"o",""),
      "split '$str' on a o with :p";
    is $str.split(<a o>,2,:p),  ("",1=>"o","ooo"),
      "split '$str' on a o for 2 with :p";

    is $str.split(<a o>, :skip-empty),     (),
      "split '$str' on a o with :skip-empty";
    is $str.split(<a o>,:k, :skip-empty),  (1,1,1,1),
      "split '$str' on a o with :k with :skip-empty";
    is $str.split(<a o>,:v, :skip-empty),  <o o o o>,
      "split '$str' on a o with :v with :skip-empty";
    is $str.split(<a o>,:kv, :skip-empty), <<1 o 1 o 1 o 1 o>>,
      "split '$str' on a o with :kv with skip-empty";
    is $str.split(<a o>,:p, :skip-empty), (1=>"o",1=>"o",1=>"o",1=>"o"),
      "split '$str' on a o with :p with skip-empty";

    is $str,"oooo", "no changes made to $str";
}

# vim: ft=perl6
