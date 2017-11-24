#! http://perl6advent.wordpress.com/2011/12/10/documenting-perl-6/

use v6;
use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;
plan 5;

=begin pod

    Some pod content

=end pod

is $=pod[0].contents[0].contents, 'Some pod content', '$=pod';

#| it's a sheep! really!
class Sheep {

    #| produces a funny sound
    method bark {
	say "Actually, I don't think sheeps bark"
    }
}

is Sheep.WHY.contents, "it's a sheep! really!", "class .WHY";
is Sheep.^find_method('bark').WHY.contents, "produces a funny sound", "method .WHY";

my $main = q:to"END";
    =begin pod

    =head1 A Heading!

    A paragraph! With many lines!

	An implicit code block!
	my $a = 5;

    =item A list!
    =item Of various things!

    =end pod

    #| it's a sheep! really!
    class Sheep {
        
        #| produces a funny sound
        method bark {
            say "Actually, I don't think sheeps bark"
        }
    }
    END

my $expected-pod = rx/'A Heading!'
           .*? "An implicit code block!"
           .*? "A list!"
           .*? "class Sheep" .*? "it's a sheep! really!"
           .*? "method bark" .*? "produces a funny sound"/;

is_run( $main,  %( out => $expected-pod,
                  err => ''), :compiler-args['--doc'], '--doc');

my $main2 = $main ~ q:to"--END--";

DOC INIT {
    use Pod::To::Text;
    pod2text($=pod);
}
--END--

is_run( $main2,  { out => $expected-pod,
                  err => ''}, :compiler-args['--doc'], '--doc + DOC INIT {}');

