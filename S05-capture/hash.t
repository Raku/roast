use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/hash_cap.t.

=end pod

plan 116;

# L<S05/Hash aliasing/An alias can also be specified using a hash>

ok("  a b\tc" ~~ m/%<chars>=( \s+ \S+ )/, 'Named unrepeated hash capture');
ok($/<chars>{'  a'}:exists, 'One key captured');
ok(!defined($/<chars>{'  a'}), 'One value undefined');
ok($/<chars>.keys == 1, 'No extra unrepeated captures');

ok("  a b\tc" ~~ m/%<chars>=( \s+ \S+ )+/, 'Named simple hash capture');
ok($/<chars>{'  a'}:exists, 'First simple key captured');
ok(!defined($/<chars>{'  a'}), 'First simple value undefined');
ok($/<chars>{' b'}:exists, 'Second simple key captured');
ok(!defined($/<chars>{' b'}), 'Second simple value undefined');
ok($/<chars>{"\tc"}:exists, 'Third simple key captured');
ok(!defined($/<chars>{"\tc"}), 'Third simple value undefined');
ok($/<chars>.keys == 3, 'No extra simple captures');

ok("  a b\tc" ~~ m/%<first>=( \s+ \S+ )+ %<last>=( \s+ \S+)+/, 'Sequential simple hash capture');
ok($/<first>{'  a'}:exists, 'First sequential key captured');
ok(!defined($/<first>{'  a'}), 'First sequential value undefined');
ok($/<first>{' b'}:exists, 'Second sequential key captured');
ok(!defined($/<first>{' b'}), 'Second sequential value undefined');
ok($/<last>{"\tc"}:exists, 'Third sequential key captured');
ok(!defined($/<last>{"\tc"}), 'Third sequential value undefined');
ok($/<first>.keys == 2, 'No extra first sequential captures');
ok($/<last>.keys == 1, 'No extra last sequential captures');

ok("abcxyd" ~~ m/a  %<foo>=(.(.))+ d/, 'Repeated nested hash capture');
ok($/<foo>{'c'}:exists, 'Nested key 1 captured');
ok(!defined($/<foo><c>), 'No nested value 1 captured');
ok($/<foo>{'y'}:exists, 'Nested key 2 captured');
ok(!defined($/<foo><y>), 'No nested value 2 captured');
ok($/<foo>.keys == 2, 'No extra nested captures');

ok("abcd" ~~ m/a  %<foo>=(.(.))  d/, 'Unrepeated nested hash capture');
ok($/<foo>{'c'}:exists, 'Unrepeated key captured');
ok(!defined($/<foo><c>), 'Unrepeated value not captured');
ok($/<foo>.keys == 1, 'No extra unrepeated nested captures');

ok("abcd" ~~ m/a  %<foo>=((.)(.))  d/, 'Unrepeated nested hash multicapture');
ok($/<foo>{'b'}:exists, 'Unrepeated key multicaptured');
ok(~$/<foo><b>, 'c', 'Unrepeated value not multicaptured');
ok($/<foo>.keys == 1, 'No extra unrepeated nested multicaptures');

ok("abcxyd" ~~ m/a  %<foo>=((.)(.))+ d/, 'Repeated nested hash multicapture');
ok($/<foo>{'b'}:exists, 'Nested key 1 multicaptured');
ok($/<foo><b>, 'c', 'Nested value 1 multicaptured');
ok($/<foo>{'x'}:exists, 'Nested key 2 multicaptured');
ok($/<foo><x>, 'y', 'Nested value 2 multicaptured');
ok($/<foo>.keys == 2, 'No extra nested multicaptures');

our %foo;
ok("abcxyd" ~~ m/a  %foo=(.(.))+  d/, 'Package hash capture');
ok(%foo{'c'}:exists, 'Package hash key 1 captured');
ok(!defined(%foo<c>), 'Package hash value 1 not captured');
ok(%foo{'y'}:exists, 'Package hash key 2 captured');
ok(!defined(%foo<y>), 'Package hash value 2 not captured');
ok(%foo.keys == 2, 'No extra package hash captures');

regex two {..}

ok("abcd" ~~ m/a  %<foo>=[<two>]  d/, 'Compound hash capture');
is($/<two>, "bc", 'Implicit subrule variable captured');
ok($/<foo>.keys == 0, 'Explicit hash variable not captured');

ok("  a b\tc" ~~ m/%<chars>=( %<spaces>=[\s+] (\S+))+/, 'Nested multihash capture');
ok($/<chars>{'a'}:exists, 'Outer hash capture key 1');
ok(!defined($/<chars><a>), 'Outer hash no capture value 1');
ok($/<chars>{'b'}:exists, 'Outer hash capture key 2');
ok(!defined($/<chars><b>), 'Outer hash no capture value 2');
ok($/<chars>{'c'}:exists, 'Outer hash capture key 3');
ok(!defined($/<chars><c>), 'Outer hash no capture value 3');
ok($/<chars>.keys == 3, 'Outer hash no extra captures');

ok($/<spaces>{'  '}:exists, 'Inner hash capture key 1');
ok(!defined($/<spaces>{'  '}), 'Inner hash no capture value 1');
ok($/<spaces>{' '}:exists, 'Inner hash capture key 2');
ok(!defined($/<spaces>{' '}), 'Inner hash no capture value 2');
ok($/<spaces>{"\t"}:exists, 'Inner hash capture key 3');
ok(!defined($/<spaces>{"\t"}), 'Inner hash no capture value 3');
ok($/<spaces>.keys == 3, 'Inner hash no extra captures');

regex spaces { @<spaces>=[\s+] }

ok("  a b\tc" ~~ m/%<chars>=( <spaces> (\S+))+/, 'Subrule hash capture');

ok($/<chars>{'a'}:exists, 'Outer subrule hash capture key 1');
ok(!defined($/<chars><a>), 'Outer subrule hash no capture value 1');
ok($/<chars>{'b'}:exists, 'Outer subrule hash capture key 2');
ok(!defined($/<chars><b>), 'Outer subrule hash no capture value 2');
ok($/<chars>{'c'}:exists, 'Outer subrule hash capture key 3');
ok(!defined($/<chars><c>), 'Outer subrule hash no capture value 3');
ok($/<chars>.keys == 3, 'Outer subrule hash no extra captures');
is($/<spaces>, "\t", 'Final subrule hash capture');


ok("  a b\tc" ~~ m/%<chars>=( %<spaces>=[<?spaces>] (\S+))+/, 'Nested subrule hash multicapture');
ok($/<chars>{'a'}:exists, 'Outer rule nested hash key multicapture');
ok(!defined($/<chars><a>), 'Outer rule nested hash value multicapture');
ok($/<chars>{'b'}:exists, 'Outer rule nested hash key multicapture');
ok(!defined($/<chars><b>), 'Outer rule nested hash value multicapture');
ok($/<chars>{'c'}:exists, 'Outer rule nested hash key multicapture');
ok(!defined($/<chars><c>), 'Outer rule nested hash value multicapture');
ok($/<chars>.keys == 3, 'Outer subrule hash no extra multicaptures');

ok($/<spaces>{'  '}:exists, 'Inner rule nested hash key multicapture');
ok(!defined($/<spaces>{'  '}), 'Inner rule nested hash value multicapture');
ok($/<spaces>{' '}:exists, 'Inner rule nested hash key multicapture');
ok(!defined($/<spaces>{' '}), 'Inner rule nested hash value multicapture');
ok($/<spaces>{"\t"}:exists, 'Inner rule nested hash key multicapture');
ok(!defined($/<spaces>{"\t"}), 'Inner rule nested hash value multicapture');
ok($/<spaces>.keys == 3, 'Inner subrule hash no extra multicaptures');

ok("  a b\tc" ~~ m/%<chars>=( (<?spaces>) (\S+))+/, 'Nested multiple hash capture');
is($/<chars>{'  '}, 'a', 'Outer rule nested hash value multicapture');
is($/<chars>{' '},  'b', 'Outer rule nested hash value multicapture');
is($/<chars>{"\t"}, 'c', 'Outer rule nested hash value multicapture');
ok($/<chars>.keys == 3, 'Outer subrule hash no extra multicaptures');

my %bases = ();
ok("Gattaca" ~~ m:i/ %bases=(A|C|G|T)+ /, 'All your bases...');
ok(%bases{'a'}:exists, 'a key');
ok(!defined(%bases<a>), 'No a value');
ok(%bases{'c'}:exists, 'c key');
ok(!defined(%bases<c>), 'No c value');
ok(!%bases{'g'}:exists, 'No g key');
ok(%bases{'G'}:exists, 'G key');
ok(!defined(%bases<G>), 'No G value');
ok(%bases{'t'}:exists, 't key');
ok(!defined(%bases<t>), 'No t value');
ok(%bases.keys == 4, 'No other bases');

%bases = ();
my %aca = ('aca' => 1);;
ok("Gattaca" ~~ m:i/ %bases=(A|C|G|T)**{4} (%aca) /, 'Hash interpolation');
ok(%bases{'a'}:exists, 'a key');
ok(!defined(%bases<a>), 'No a value');
ok(!%bases{'c'}:exists, 'No c key');
ok(!%bases{'g'}:exists, 'No g key');
ok(%bases{'G'}:exists, 'G key');
ok(!defined(%bases<G>), 'No G value');
ok(%bases{'t'}:exists, 't key');
ok(!defined(%bases<t>), 'No t value');
ok(%bases.keys == 3, 'No other bases');
is("$1", "aca", 'Trailing aca');


# vim: ft=perl6
