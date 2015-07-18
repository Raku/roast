use v6;

use Test;

plan(13);

unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest;
    exit;
}

EVAL(q/
#line 16 method.t
package FooBar;
our $VERSION = '6.0';
print '';

sub new {
    bless {}, __PACKAGE__;
}

sub foo {
    return 'foo';
}

sub echo {
    my ($self, $what) = @_;
#print "==> echo got $what\n";
    return $what;
}

sub callcode {
    my ($self, $code) = @_;
#print "==> callcode got $code\n";
    return eval { $code->($self) };
}

sub asub {
    return sub { return "asub" };
}

sub submany {
    return sub { ("many", "return") };
}

sub many {
    return ("many", "return") ;
}

sub modify_array {
    my ($class, $val) = @_;
    $val->[0] = 99;
}

# takes an object and invoke me on that
sub invoke {
    my ($class, $obj) = @_;
    $obj->me ('invoking');
}

/, :lang<Perl5>);

{
    my $r = EVAL("FooBar->VERSION", :lang<Perl5>);
    is($r, '6.0', "class method");
}

my $obj;

{
    $obj = EVAL("FooBar->new", :lang<Perl5>);
    #?rakudo todo "P5 classes not yet shadowed in P6"
    {
        isa-ok($obj, 'FooBar', "blessed");
    }
    {
        #?rakudo skip "Probably bogus test. Tests if the P5 object stringifies to something containing the class name, like FooBar=HASH(0x12345678)"
        like($obj, rx:Perl5/FooBar/, "blessed");
    }
}

{
    is($obj.foo, 'foo', 'invoke method');
}

{
    my $r = $obj.echo("bar");
    is($r, 'bar', 'invoke method with perl6 arg');
}

{
    my $r = $obj.asub;

    ok($r does Callable, "returning a coderef");

    is($r.(), 'asub', 'invoking p5 coderef');
    my $rr = $obj.callcode($r);
    is($rr, 'asub', 'invoke with p5 coderef');
}

{
    my @r = $obj.many;
    is(@r.elems, 2);
}

{
    my $r = $obj.submany;
    my @r = $r.();
    is(@r.elems, 2);
}

{
    my $callback = { "baz" };
    my $r = $obj.callcode($callback);
    is($r, 'baz', 'invoke method with callback');
}

{
    class Foo6 {
        method me ($class: $arg) { 'Foo6'~$arg };    #OK not used
    };
    my $obj6 = Foo6.new;
    $obj = EVAL("FooBar->new", :lang<Perl5>);
    is($obj.invoke($obj6), 'Foo6invoking', 'invoke p6 method from p5');
}

{
    my @rw = (1, 2, 3);
    $obj.modify_array(VAR @rw);
    #?rakudo todo "doesn't work yet due to copying of arrays"
    {
        is(@rw[0], 99, 'modify a scalar ref');
    }
}

# vim: ft=perl6
