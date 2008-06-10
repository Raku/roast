use v6;

use Test;

=begin pod

String transliteration

L<S05/Transliteration>

=end pod

plan 17;

is("ABC".trans( ('A'=>'a'), ('B'=>'b'), ('C'=>'c') ),"abc",
        "Each side can be individual characters");

is("XYZ".trans( ('XYZ' => 'xyz') ),"xyz",
           "The two sides of the any pair can be strings interpreted as tr/// would multichar");

is("ABC".trans( ('A..C' => 'a..c') ),"abc",
           "The two sides of the any pair can be strings interpreted as tr/// would range");

is("ABC-DEF".trans(("- AB..Z" => "_ a..z")),"abc_def",
           "If the first character is a dash it isn't part of a range");

is("ABC-DEF".trans(("A..YZ-" => "a..z_")),"abc_def",
           "If the last character is a dash it isn't part of a range");


is("ABCDEF".trans( ('A B .. E' => 'ab..e') ), "abcdeF",
                  "The two sides can consists of both chars and ranges");

is("ABCDEFGH".trans( ('A..CE..G' => ' a..c e..g ') ),"abcDefgH",
                  "The two sides can consist of multiple ranges");

# These will need the way the hashses deal with pairs.

# This works by accident.
is("ABCXYZ".trans( (['A'..'C'] => ['a'..'c']), (<X Y Z> => <x y z>) ),"abcxyz",
           "The two sides of each pair may also be array references" );

# We're probally unable to "fix" these two as long as the left hand of => gets stringified
is("abcde".trans( ('a .. e' => ['A' .. 'E']) ), "ABCDE",
	   "Using string range on one side and array reference on the other");


is("ABCDE".trans( (['A' .. 'E'] => "a .. e") ), "abcde",
	   "Using array reference on one side and string range on the other");

is(" <>&".trans( (['<',    '>',    '&',    ] => 
                  ["&lt;", "&gt;", "&amp;" ]))," &lt;&gt;&amp;",
         "The array version can map one characters to one-or-more characters except spaces");

is(" <>&".trans( ([' ',      '<',    '>',    '&'    ] => 
                  ['&nbsp;', '&lt;', '&gt;', '&amp;' ])),"&nbsp;&lt;&gt;&amp;",
         "The array version can map one-or-more characters to one-or-more characters");

#?rakudo skip 'unimpl: tr///, Ranges '
skip(5, 'unimpl: tr///, Ranges');
#{
#is(eval('"abc".trans(<== "a" => "A")'), "Abc",
#    "you're allowed to leave off the (...) named arg parens when you use <==");
#
## Make sure the tr/// version works, too.  
#
#$_ = "ABC";
#tr/ABC/abc/;
#is($_, 'abc', 'tr/// on $_ with explicit character lists');
#
#$_ = "abc";
#tr|a..c|A..C|;
#is($_, 'ABC', 'tr||| on $_ with character range');
#
#{
#my $japh = "Whfg nabgure Crey unpxre";
#$japh ~~ tr[a..z A..Z][n..z a..m  N..Z A..M];
#is($japh, "Just another Perl hacker", 'tr[][] on lexical var via ~~');
#}
#
#$_ = '$123';
#tr/$123/X\x20\o40\t/;
#is($_, "X  \t", 'tr/// on $_ with explicit character lists');
#
#}
