use v6;
use Test;
plan 68;
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

# RT#127085
{
  isa-ok $r.config<zebras>, Bool;
  isa-ok $r.config<sheep>, Bool;
  is $r.config<zebras>, True;
  is $r.config<sheep>, False;
}

#?rakudo todo 'non-string colonpair pod options RT #124281'
{
  isa-ok $r.config<feist>, Str;
}

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
#  List              :key[$e1,$e2,...]         :key($e1,$e2,...)   # NYI
#  Hash              :key{$k1=>$v1,$k2=>$v2}                       # NYI
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
#   RT #124281 - colonpairs in POD config options always produce strings
#   RT #126742 - config items should not include quotes for string values
#
#   RT #130477 - Pod config parses colopairs but simply stringifies
#                whatever it matched
#
#   RT #132632 - List and hash configuration value formats are not yet
#                implemented (NYI)

#=== strings
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

#=== nums and ints
=begin table :k1<1> :k2(2) :k3[2] :k4(2.3) :k5[2.3]
foo
=end table

$r = $=pod[$p++];
say "=== testing string, ints, and nums";
isa-ok $r.config<k1>, Str;
isa-ok $r.config<k2>, Int;
isa-ok $r.config<k3>, Int;
isa-ok $r.config<k4>, Num;
isa-ok $r.config<k5>, Num;

is $r.config<k1>, '1', Q|'1'|;
is $r.config<k2>, 2, Q|2|;
is $r.config<k3>, 2, Q|2|;
is $r.config<k4>, 2.3, Q|2.3|;
is $r.config<k5>, 2.3, Q|2.3|;

#=== bools
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

#=== hashes
say "=== testing hashes";
=begin table :k1{a => 1, 2 => 'b', c => True, d => 2.3, e => False}
foo
=end table

$r = $=pod[$p++];
isa-ok $r.config<k1>, Hash;

is $r.config<k1><a>, 1, Q|1|;
is $r.config<k1><2>, 'b', Q|'b'|;
ok $r.config<k1><c>, Q|True|;
is $r.config<k1><d>, 2.3, Q|2.3|;
nok $r.config<k1><e>, Q|False|;

#=== lists
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
