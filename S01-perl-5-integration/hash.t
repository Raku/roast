use Test;

plan(6);

unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest;
    exit;
}

die unless
EVAL(q/
package My::Hash;
use strict;

sub new {
    my ($class, $ref) = @_;
    bless \$ref, $class;
}

sub hash {
    my $self = shift;
    return $$self;
}

sub my_keys {
    my $self = shift;
    return keys %{$$self};
}

sub my_exists {
    my ($self, $idx) = @_;
    return exists $$self->{$idx};
}

sub fetch {
    my ($self, $idx) = @_;
    return $$self->{$idx};
}

sub store {
    my ($self, $idx, $val) = @_;
    $$self->{$idx} = $val;
}

sub push {
    my ($self, $val) = @_;
}

1;
/, :lang<Perl5>);

my $p5ha = EVAL('sub { My::Hash->new($_[0]) }', :lang<Perl5>);
my %hash = (5 => 'a', 6 => 'b', 7 => 'c', 8 => 'd');
my $p5hash = $p5ha($%hash);

my $rethash = $p5hash.hash;
my @keys = %hash.keys.sort;
my @p5keys = $p5hash.my_keys;
@p5keys .= sort;

is("{ @keys }", "{ @p5keys }");

ok($p5hash.store(9, 'e'), 'can store');
is(%hash{9}, 'e', 'store result');

is($p5hash.fetch(5), 'a', 'fetch result');
is($p5hash.my_exists(5), +(%hash<5>:exists), 'exists');
is($p5hash.my_exists(12), +(%hash<12>:exists), 'nonexists fail');

# vim: expandtab shiftwidth=4
