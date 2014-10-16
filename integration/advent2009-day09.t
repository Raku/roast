# http://perl6advent.wordpress.com/2009/12/09/day-9-having-beautiful-arguments-and-parameters/

use v6;
use Test;
plan 17;

sub sum {
    [+] @_ ;
}

sub grade_essay(Str $essay, Int $grade where 0..5) { #Type Essay replace w/ Str to avoid extraneous programming.
    my %grades;
    %grades{$essay} = $grade;
}

sub entreat($message = 'Pretty please, with sugar on top!', $times = 1) {
    $message x $times
}

sub xml_tag ($tag, $endtag = ($tag ~ ">") ) {
    $tag ~ $endtag;
}

sub deactivate(Str $plant, Str $comment?) {   #OK not used
    return 1 if $comment;
}

sub drawline($x1,$x2,$y1,$y2) {
    $x1,$x2,$y1,$y2;
}
sub drawline2(:$x1,:$x2,:$y1,:$y2) {
    $x1,$x2,$y1,$y2;
}

sub varsum(*@terms) {
    [+] @terms
}

sub detector(:$foo!, *%bar) {
    %bar.keys.fmt("'%s'", ', ');
}
sub up1($n) {
    ++$n;
}
sub up1_2($n is rw) {
    ++$n;
}
sub up1_3($n is copy) {
    ++$n;
}
sub namen($x, $y, $z) {
    $x,$y,$z;
}

is (sum 100,20,3), 123, 'Parameter handling in subroutines (@_)';
is grade_essay("How to eat a Fish", 0), 0, 'P6 auto unpacking/verification';
ok (entreat()), 'Default values for parameters works';
is (xml_tag("hi")), "hihi>", 'Default values using previously supplied arguments';
nok deactivate("Rakudo Quality Fission"), 'optional parameters';
throws_like {drawline2(1,2,3,4)},
  Exception,
  'wrong number of parameters, no exception object';
ok (drawline2(:x1(3))), 'When you force naming, they are not all required.';
#the required & must-be named (:$var!) test not here, its opposite is 1 up
is (varsum(100,200,30,40,5)), 375, 'Parameters with a * in front can take as many items as you wish';
#?niecza todo 'Capturing arbitrary named parameters'
is detector(:foo(1), :bar(2), :camel(3)), ("'bar', 'camel'"|"'camel', 'bar'"), 'Capturing arbitrary named parameters';
#?niecza todo 'Capturing arbitrary named parameters as hash'
is (detector(foo => 1, bar => 2, camel => 3)), ("'bar', 'camel'"|"'camel', 'bar'"), 'Same as above test, only passed as hash';
my $t = 3;
throws_like {up1($t)},
  Exception,
  "Can't modify parameters within by default, no exception object.";
up1_2($t);
is $t, 4, 'Set a parameter to "is rw", and then you can modify';
up1_3($t);
is $t, 4, '"is copy" leaves original alone"';
my @te = <a b c>;
throws_like {EVAL 'namen(@te)' },
  Exception,
  'Autoflattening doesnt exist, no exception object';
is (namen(|@te)), ('a','b','c'), "Put a | in front of the variable, and you're ok!";

is <734043054508967647390469416144647854399310>.comb(/.**7/).join('|') , '7340430|5450896|7647390|4694161|4464785|4399310' , 'Test one liner at end of post (part1)';
{
	is '7340430'.fmt("%b").trans("01" => " #") , '###           ##   ### ' , 'Test one liner at end of post (part2)';
}

#type constraint on parameters skipped, due to that part of Day 9 being just a caution

#test done, below is the day's one-liner (in case you wish to enable it :) )
#.fmt("%b").trans("01" => " #").say for <734043054508967647390469416144647854399310>.comb(/.**7/)
