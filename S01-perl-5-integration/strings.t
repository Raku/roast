use Test;

plan 6;

is(EVAL("'Yet Another Perl Hacker'",:lang<perl5>),"Yet Another Perl Hacker");
is(EVAL('"Yet Ano\0ther P\0erl Hacker"',:lang<perl5>),"Yet Ano\0ther P\0erl Hacker","Null Bytes in the middle of a converted string");
is(EVAL('use utf8;"ąęóśćż"',:lang<perl5>),"ąęóśćż","utf8 in literals");


my &test1 := EVAL('sub {$_[0] eq "Yet Another Perl Hacker"}',:lang<perl5>);

my &test2 := EVAL('sub {$_[0] eq "Yet Ano\0ther P\0erl Hacker"}',:lang<perl5>);
my &test3 := EVAL('sub {$_[0] eq "\x{105}\x{119}\x{f3}\x{15b}\x{107}\x{17c}"}',:lang<perl5>);

ok(test1("Yet Another Perl Hacker"),"Passing simple strings to p5 land");
ok(test2("Yet Ano\0ther P\0erl Hacker"),"Passing strings with null bytes to p5 land");
ok(test3("ąęóśćż"),"Passing strings with unicode to p5 land");
