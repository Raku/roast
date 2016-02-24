use v6.c;
# http://rosettacode.org/wiki/Greatest_element_of_a_list#Perl_6

use Test;

plan 1;

my $rosetta-code = {

#### RC-begin
say [max] 17, 13, 50, 56, 28, 63, 62, 66, 74, 54;

say [max] 'my', 'dog', 'has', 'fleas';

sub max2 (*@a) { reduce -> $x, $y { $y after $x ?? $y !! $x }, @a }
say max2 17, 13, 50, 56, 28, 63, 62, 66, 74, 54;
#### RC-end

}

my $output;
{
    temp $*OUT = class {
	method print(*@args) {
	    $output ~= @args.join;
	}
    }

    $rosetta-code.();
}

my $expected = "74
my
74
";

is($output.subst("\r\n", "\n", :g), $expected.subst("\r\n", "\n", :g), "Greatest element of a list");
