use v6;

use Test;

plan 27;

=begin pod

Basic C<kv> tests, see S32::Containers.

=end pod

# L<S32::Containers/"Hash"/=item kv>
{ # check the invocant form
    my %hash = (a => 1, b => 2, c => 3, d => 4);
    my @kv = %hash.kv;
    is(+@kv, 8, '%hash.kv returns the correct number of elems');
    #?niecza todo 'wrong sort order'
    is(~@kv.sort, "1 2 3 4 a b c d",  '%hash.kv has no inner list');
}

{ # check the non-invocant form
    my %hash = (a => 1, b => 2, c => 3, d => 4);
    my @kv = kv(%hash);
    is(+@kv, 8, 'kv(%hash) returns the correct number of elems');
    #?niecza todo 'wrong sort order'
    is(~@kv.sort, "1 2 3 4 a b c d",  'kv(%hash) has no inner list');
}

# See "Questions about $pair.kv" thread on perl-6 lang
{
    my $pair  = (a => 1);
    my @kv = $pair.kv;
    is(+@kv, 2, '$pair.kv returned one elem');
    is(+@kv, 2, '$pair.kv inner list has two elems');
    is(~@kv, "a 1", '$pair.kv inner list matched expectation');
}

#?niecza todo 'kv()'
{
    my $sub  = sub (Hash $hash) { $hash.kv };
    my %hash = (a => 1, b => 2);
    is ~kv(%hash).sort,   "1 2 a b", ".kv works with normal hashes (sanity check)";
    is ~$sub(%hash).sort, "1 2 a b", ".kv works with constant hash references";
}

#?niecza todo '%$hash'
{
    # "%$hash" is not idiomatic Perl, but should work nevertheless.
    my $sub  = sub (Hash $hash) { %$hash.kv };
    my %hash = (a => 1, b => 2);
    is ~kv(%hash).sort,   "1 2 a b", ".kv works with normal hashes (sanity check)";
    is ~$sub(%hash).sort, "1 2 a b", ".kv works with dereferenced constant hash references";
}

# test3 and test4 illustrate a bug 

#?DOES 2
sub test1{
    my $pair = boo=>'baz'; 
    my $type = $pair.WHAT.gist;
    for $pair.kv -> $key, $value {
        is($key, 'boo', "test1: $type \$pair got the right \$key");
        is($value, 'baz', "test1: $type \$pair got the right \$value");
    }
}
test1;

#?DOES 2
sub test2{
    my %pair = boo=>'baz'; 
    my $type = %pair.WHAT.gist;
    my $elems= +%pair;
    for %pair.kv -> $key, $value {
        is($key, 'boo', "test2: $elems elem $type \%pair got the right \$key");
        is($value, 'baz', "test2: $elems elem $type \%pair got the right \$value");
    }
}
test2;

my %hash  = ('foo' => 'baz');
#?DOES 2
sub test3 (%h){
  for %h.kv -> $key, $value {
        is($key, 'foo', "test3:  from {+%h}-elem {%h.WHAT.gist} \%h got the right \$key");
        is($value, 'baz', "test3: from {+%h}-elem {%h.WHAT.gist} \%h got the right \$value");
  }
}
test3 %hash;

sub test4 (%h){
    for 0..%h.kv.end -> $idx {
        is(%h.kv[$idx], %hash.kv[$idx], "test4: elem $idx of {%h.kv.elems}-elem {%h.kv.WHAT.gist} \%hash.kv correctly accessed");
    }
}
#?DOES 2
#?niecza skip '.end NYI'
test4 %hash;

# sanity
for %hash.kv -> $key, $value {
    is($key, 'foo', "for(): from {+%hash}-elem {%hash.WHAT.gist} \%hash got the right \$key");
    is($value, 'baz', "for(): from {+%hash}-elem {%hash.WHAT.gist} \%hash got the right \$value");
}

# The things returned by .kv should be aliases
{
    my %hash = (:a(1), :b(2), :c(3));

    #?pugs todo 'feature'
    lives_ok { for %hash.kv -> $key, $value is rw {
        $value += 100;
    } }, 'aliases returned by %hash.kv should be rw (1)';

    #?pugs todo 'feature'
    is %hash<b>, 102, 'aliases returned by %hash.kv should be rw (2)';
}

{
    my @array = (17, 23, 42);

    #?pugs todo 'feature'
    lives_ok { for @array.kv -> $key, $value is rw {
        $value += 100;
    } }, 'aliases returned by @array.kv should be rw (1)';

    #?pugs todo 'feature'
    is @array[1], 123, 'aliases returned by @array.kv should be rw (2)';
}

{
    my $pair = (a => 42);

    #?pugs todo 'feature'
    #?niecza todo 'aliases should be rw'
    lives_ok { for $pair.kv -> $key, $value is rw {
        $value += 100;
    } }, 'aliases returned by $pair.kv should be rw (1)';

    #?pugs todo 'feature'
    #?niecza todo 'aliases should be rw'
    is $pair.value, 142, 'aliases returned by $pair.kv should be rw (2)';
}


# vim: ft=perl6
