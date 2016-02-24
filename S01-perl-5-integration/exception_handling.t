use v6.c;

use Test;


BEGIN {
plan 3;
unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest('no perl 5 support'); exit;
}
}

use Carp:from<Perl5>;

my $err;
lives-ok({ try { Carp.croak() }; $err = $! }, "Perl 5 exception (die) caught");
like($err.Str, rx:P5/Carp/, "Exception is propagated to Perl 6 land");

EVAL(q[
package Foo;

sub new {
	bless {}, __PACKAGE__;
}

sub error {
	my $error = Foo->new;
	die $error;
}

sub test { "1" }
], :lang<Perl5>);

my $foo = EVAL("Foo->new",:lang<Perl5>);
try { $foo.error };
lives-ok( {
    my $err = $!;
    $err.payload.test;
}, "Accessing Perl5 method doesn't die");

# vim: ft=perl6
