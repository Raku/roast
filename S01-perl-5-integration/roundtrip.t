use v6;

use Test;

plan(5);

unless eval 'eval("1", :lang<perl5>)' {
    skip_rest;
    exit;
}

eval(q/
package Id;
sub new {
    my ($class, $ref) = @_;
    bless \$ref, $class;
}
sub identity {
    my $self = shift;
    return $$self;
}
/, :lang<perl5>);

my $japh    = { "Just another $_ hacker" };
my $japh2   = -> $name { "Just another $name hacker" };
my $id      = eval('sub { Id->new($_[0]) }', :lang<perl5>);

#?pugs 2 todo
is($id($japh).identity('Pugs'), 'Just another Pugs hacker', "Closure roundtrips");
is($id($japh2).identity('Pugs'), 'Just another Pugs hacker', "Closure roundtrips");

my $keys_p5 = eval('sub {keys %{$_[0]}}', :lang<perl5>);
my $tohash_p5 = eval('sub { return {map {$_ => 1} @_ } }', :lang<perl5>);
my %hash = (foo => 'bar', hate => 'software');
{
    my $foo = $tohash_p5.(keys %hash);
    cmp_ok($foo, &infix:<cmp>, %hash);
    is_deeply([$foo.keys].sort, [%hash.keys].sort);
}

#?niecza skip 'VAR undeclared'
#?pugs todo
{
    is_deeply([%hash.keys].sort, [$keys_p5(VAR %hash)].sort);
}

# vim: ft=perl6
