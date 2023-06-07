use Test;
plan 98;
my ($r, $s);

my $p = 0;

=begin pod
    =begin code :allow<B>
    =end code
=end pod

$r = $=pod[$p++].contents[0];
isa-ok $r, Pod::Block::Code;
is $r.config<allow>, 'B';

=begin pod
    =config head2  :like<head1> :formatted<I>
=end pod

$r = $=pod[$p++].contents[0];
isa-ok $r, Pod::Config;
is $r.type, 'head2';
is $r.config<like>, 'head1';
is $r.config<formatted>, 'I';

=begin pod
    =for pod :number(42) :zebras :!sheep :feist<1 2 3 4>
=end pod

$r = $=pod[$p++].contents[0];
is $r.config<number>, 42;

{ # https://github.com/Raku/old-issue-tracker/issues/4958
  is-deeply $r.config<zebras>, True, 'bool config uses Bool type (True)';
  is-deeply $r.config<sheep>, False, 'bool config uses Bool type (False)';
}


#?rakudo todo 'https://github.com/Raku/old-issue-tracker/issues/3778'
is-deeply $r.config<feist>, <1 2 3 4>;


=begin pod
=for DESCRIPTION :title<presentation template>
=                :author<John Brown> :pubdate(2011)
=end pod

$r = $=pod[$p++].contents[0];
is $r.config<title>, 'presentation template';
is $r.config<author>, 'John Brown';
is $r.config<pubdate>, 2011;

=begin pod
=for table :caption<Table of contents>
    foo bar
=end pod

$r = $=pod[$p++].contents[0];
isa-ok $r, Pod::Block::Table;
is $r.config<caption>, 'Table of contents';

=begin pod
    =begin code :allow<B>
    These words have some B<importance>.
    =end code
=end pod

$r = $=pod[$p++].contents[0].contents[1];
isa-ok $r, Pod::FormattingCode;

#  Value is...       Specify with...           Or with...            Or with...
#  ===============   =======================   =================   ===========
#  List              :key[$e1,$e2,...]         :key($e1,$e2,...)
#  Hash              :key{$k1=>$v1,$k2=>$v2}
#  Boolean (true)    :key                      :key(True)
#  Boolean (false)   :!key                     :key(False)
#  String            :key<str>                 :key('str')         :key("str")
#  Number            :key(42)                  :key(2.3)

#  Where '$e1,$e2,...' are list elements of type Str, Int, Num, or
#  Bool.  Lists may have mixed element types. Note that one-element
#  lists are converted to the type of their element (Str, Int, Num, or
#  Bool).
#
#  For hashes, '$k1,$k2,...' are keys of type Str and '$v1,$2,...'
#  are values of type Str, Int, Num, or Bool.

#  Strings may use any of the single Q/q quote constructs, e.g.,
#  :key(Q[str]), which is equivalent to the :key<str> format and
#  results in an uninterpreted string literal.

# tests for fixes for bugs:
#   colonpairs in POD config options always produce strings: https://github.com/Raku/old-issue-tracker/issues/3778
#   config items should not include quotes for string values: https://github.com/Raku/old-issue-tracker/issues/4789
#
#   Pod config parses colopairs but simply stringifies whatever it matched: https://github.com/Raku/old-issue-tracker/issues/5962
#
#   List and hash configuration value formats are not yet implemented (NYI): https://github.com/Raku/old-issue-tracker/issues/6652

#====================================================
#=== strings
#====================================================
=begin table :k1<str> :k2('str') :k3("str") :k4["str"] :k5(Q[str])
foo
=end table

$r = $=pod[$p++];
say "=== testing strings";
isa-ok $r.config<k1>, Str;
isa-ok $r.config<k2>, Str;
isa-ok $r.config<k3>, Str;
isa-ok $r.config<k4>, Str;
isa-ok $r.config<k5>, Str;

$s = 'str';
is $r.config<k1>, $s, Q|<str>|;
is $r.config<k2>, $s, Q|'str'|;
is $r.config<k3>, $s, Q|"str"|;
is $r.config<k4>, $s, Q|"str"|;
is $r.config<k4>, $s, Q|using a Q/q quote|;

#====================================================
#=== ints
#====================================================
#   max val int (int32): +2_147_483_647 <= 10 digits
#   max val int (int64): +9_223_372_036_854_775_807 <= 19 digits
# TODO make a dynamic test that changes config test with hardware int bit size
=begin table :k1<1> :k2(2) :k3[2] :k4[+2000000000] :k5[-2000000000] :k6[+99999999999999999] :k7[-99999999999999999]
foo
=end table

$r = $=pod[$p++];
say "=== testing string and ints";
isa-ok $r.config<k1>, Str;
isa-ok $r.config<k2>, Int;
isa-ok $r.config<k3>, Int;
isa-ok $r.config<k4>, Int;
isa-ok $r.config<k5>, Int;
isa-ok $r.config<k6>, Int;
isa-ok $r.config<k7>, Int;

is $r.config<k1>, '1', Q|'1'|;
is $r.config<k2>, 2, Q|2|;
is $r.config<k3>, 2, Q|2|;
is $r.config<k4>, 2_000_000_000, Q|+2000000000|;
is $r.config<k5>, -2_000_000_000, Q|-2000000000|;
# bigints with 18 digits each:
is $r.config<k6>, +99999999999999999, Q|+99999999999999999|;
is $r.config<k7>, -99999999999999999, Q|-99999999999999999|;

#====================================================
#=== nums
#====================================================

=begin table :k1(2.3) :k2[-2.3] :k3[+1e4] :k4(3.1e+04) :k5[-3.1E-04]
foo
=end table

$r = $=pod[$p++];
say "=== testing nums";
#?rakudo 2 todo '2.3 and -2.3 are Rats, not Nums'
isa-ok $r.config<k1>, Rat;
isa-ok $r.config<k2>, Rat;
isa-ok $r.config<k3>, Num;
isa-ok $r.config<k4>, Num;
isa-ok $r.config<k5>, Num;

is $r.config<k1>, 2.3, Q|2.3|;
is $r.config<k2>, -2.3, Q|-2.3|;
is $r.config<k3>, +1e4, Q|+1e4|;
is $r.config<k4>, 3.1e+04, Q|3.1e+04|;
is $r.config<k5>, -3.1E-04, Q|-3.1E-04|;

#====================================================
#=== bools
#====================================================
=begin table :k1 :!k2 :k3(True) :k4[True] :k5(False) :k6[False]
foo
=end table

$r = $=pod[$p++];
say "=== testing booleans";
isa-ok $r.config<k1>, Bool;
isa-ok $r.config<k2>, Bool;
isa-ok $r.config<k3>, Bool;
isa-ok $r.config<k4>, Bool;
isa-ok $r.config<k5>, Bool;
isa-ok $r.config<k6>, Bool;

ok $r.config<k1>, Q|:key|;
nok $r.config<k2>, Q|:!key|;
ok $r.config<k3>, Q|:key(True)|;
ok $r.config<k4>, Q|:key[True]|;
nok $r.config<k5>, Q|:key(False)|;
nok $r.config<k6>, Q|:key[False]|;

#====================================================
#=== lists
#====================================================
say "=== testing lists";
=begin table :k1(1, 'b c', 2.3, True, False) :k2[1, 'b c', 2.3, True, False]
foo
=end table

$r = $=pod[$p++];
isa-ok $r.config<k1>, List;
isa-ok $r.config<k2>, List;

is $r.config<k1>[0], 1, Q|1|;
is $r.config<k1>[1], "b c", Q|'b c'|;
is $r.config<k1>[2], 2.3, Q|2.3|;
ok $r.config<k1>[3], Q|True|;
nok $r.config<k1>[4], Q|False|;

is $r.config<k2>[0], 1, Q|1|;
is $r.config<k2>[1], "b c", Q|'b c'|;
is $r.config<k2>[2], 2.3, Q|2.3|;
ok $r.config<k2>[3], Q|True|;
nok $r.config<k2>[4], Q|False|;

#====================================================
#=== hashes
#====================================================
say "=== testing hashes";
=begin table :k1{a => 1, 2 => 'b', c => True, d => 2.3, e => False}
foo
=end table

$r = $=pod[$p++];
isa-ok $r.config<k1>, Map;

is $r.config<k1><a>, 1, Q|1|;
is $r.config<k1><2>, 'b', Q|'b'|;
ok $r.config<k1><c>, Q|True|;
is $r.config<k1><d>, 2.3, Q|2.3|;
nok $r.config<k1><e>, Q|False|;

#====================================================
#=== troublesome hashes
#====================================================
say "=== testing troublesome hashes";
=begin table :k1{2 => 'b => ?', c => ",", d => 2.3}
foo
=end table

$r = $=pod[$p++];
isa-ok $r.config<k1>, Map;

is $r.config<k1><2>, 'b => ?', Q|'b => ?'|;
is $r.config<k1><c>, ",", Q|","|;
is $r.config<k1><d>, 2.3, Q|2.3|;

=begin table :k1{2 , 'b => "', d => '"', 4 => "\""}
foo
=end table

$r = $=pod[$p++];
isa-ok $r.config<k1>, Map;

is $r.config<k1><2>, 'b => "', Q|'b => "'|;
is $r.config<k1><d>, '"', Q|'"'|;
is $r.config<k1><4>, "\"", Q|"\""|;

#====================================================
#=== bigints
#====================================================

# 30 digits
=begin table :k6[+999999999999999999999999999999] :k7[-999999999999999999999999999999]
foo
=end table
$r = $=pod[$p++];
say "=== testing string and ints";
# bigints with 30 digits each:
isa-ok $r.config<k6>, Int;
isa-ok $r.config<k7>, Int;
is $r.config<k6>,  999_999_999_999_999_999_999_999_999_999, Q|+9 ** 30|;
is $r.config<k7>, -999_999_999_999_999_999_999_999_999_999, Q|-9 ** 30|;

#=====================================
# GH issue #2793
=for info :034foo
:034foo

$r = $=pod[$p++];
isa-ok $r.config<foo>, Int, '034foo: foo => 34';
is $r.config<foo>, 34, 'foo => 34';

=for info :0foo
:0foo

$r = $=pod[$p++];
isa-ok $r.config<foo>, Int, '0foo: foo => 0';
is $r.config<foo>, 0, 'foo => 0';

=for info :1foo
:0foo

$r = $=pod[$p++];
isa-ok $r.config<foo>, Int, '1foo: foo => 1';
is $r.config<foo>, 1, 'foo => 1';

# vim: expandtab shiftwidth=4
