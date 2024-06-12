use v6;

# This is base on rakudo bug #4730

use Test;

plan 2;

sub foo(Str :@foo) {
	return 
}

my $c = \();
ok ?&foo.cando($c);
lives-ok { foo(|$c) }
