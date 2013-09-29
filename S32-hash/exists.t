use v6;
use Test;

plan 21;

=begin description

Basic C<exists> tests on hashes, see S32::Containers.

=end description

# L<S32::Containers/"Hash"/=item exists>

sub gen_hash {
    my %h;
    %h = (
        a => 1,
        b => 2,
        c => 3,
        d => 4,

        x => 24,
        y => 25,
        Z => 26,
    );
    return %h;
};

{
    my %h1 = gen_hash;
    my %h2 = gen_hash;

    my $b = %h1<b>;
    #?rakudo skip 'unspecced'
    #?niecza skip 'Invocant handling is NYI'
    is (exists %h1: 'a'), True, "Test existence for single key. (Indirect notation)";
    is (%h1.exists_key('a')), True, "Test existence for single key. (method)";
    is (%h1{'a'}:exists), True, "Test existence for single key. (adverb)";
    is (%h1<a>:exists), True, "Test existence for single key. (adverb 2)";
};

{
    my %h;
    %h<none> = 0;
    %h<one> = 1;
    %h<nothing> = Mu;
    ok %h.exists_key('none'),    "Existence of single key with 0 as value: none";
    ok %h.exists_key('one'),     "Existence of single key: one";
    ok %h.exists_key('nothing'), "Existence of single key with undefined as value: nothing";
    ok defined(%h<none>),     "Defined 0 value for key: none";
    ok defined(%h<one>),      "Defined 1 value for key: one";
    ok !defined(%h<nothing>), "NOT Defined value for key: nothing";
}

my %hash = (a => 1, b => 2, c => 3, d => 4);
ok %hash.exists_key("a"),   "exists_key on hashes (1)";
ok !%hash.exists_key("42"), "exists_key on hashes (2)";

# This next group added by Darren Duncan following discovery while debugging ext/Locale-KeyedText:
# Not an exists() test per se, but asserts that elements shouldn't be added to
# (exist in) a hash just because there was an attempt to read nonexistent elements.
{
  sub foo( $any ) {}   #OK not used
  sub bar( $any is copy ) {}   #OK not used

  my $empty_hash = hash();
  is( $empty_hash.pairs.sort.join( ',' ), '', "empty hash stays same when read from (1)" );
  $empty_hash{'z'};
  is( $empty_hash.pairs.sort.join( ',' ), '', "empty hash stays same when read from (2)" );
  bar( $empty_hash{'y'} );
  is( $empty_hash.pairs.sort.join( ',' ), '', "empty hash stays same when read from (3)" );
  my $ref = \( $empty_hash{'z'} );
  is( $empty_hash.pairs.sort.join( ',' ), '', "taking a reference to a hash element does not auto-vivify the element");
  foo( $empty_hash{'x'} );
  #?pugs todo 'bug'
  is( $empty_hash.pairs.sort.join( ',' ), '', "empty hash stays same when read from (4)" );

  my $popul_hash = hash(('a'=>'b'),('c'=>'d'));
  my sub popul_hash_contents () {
    $popul_hash.pairs.sort.map({ $_.key ~ ":" ~ $_.value }).join( ',' );
  }

  is( popul_hash_contents, "a:b,c:d", "populated hash stays same when read from (1)" );
  $popul_hash{'z'};
  is( popul_hash_contents, "a:b,c:d", "populated hash stays same when read from (2)" );
  bar( $popul_hash{'y'} );
  is( popul_hash_contents, "a:b,c:d", "populated hash stays same when read from (3)" );
  foo( $popul_hash{'x'} );
  #?pugs todo 'bug'
  is( popul_hash_contents, "a:b,c:d", "populated hash stays same when read from (4)" );
}

# vim: syn=perl6
