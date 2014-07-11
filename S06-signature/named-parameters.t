use v6;
use Test;

plan 93;

# L<S06/Required parameters/"Passing a named argument that cannot be bound to
# a normal subroutine is also a fatal error.">

{
    sub a($x = 4) {
        return $x;
    }
    is a(3), 3, 'Can pass positional arguments';
    dies_ok { EVAL('a(g=>7)') }, 'Dies on passing superfluous arguments';
}

{
    sub c(:$w=4){
        return $w;
    } 
    is c(w => 3), 3, 'Named argument passes an integer, not a Pair';
    my $w = 5;
    is c(:$w), 5, 'can use :$x colonpair syntax to call named arg';
    dies_ok {EVAL('my $y; c(:$y)')}, 'colonpair with wrong variable name dies';
}

{
    sub add5(:$g) {
        return $g + 5;
    }
    class A {
        has $!g = 3;
        method colonpair_private { add5(:$!g) }
    };
    class B {
        has $.g = 7;
        method colonpair_public { add5(:$.g) }
    };
    sub colonpair_positional {
        add5(:$^g);
    }

    is A.new.colonpair_private, 8, 'colonpair with a private variable';
    is B.new.colonpair_public, 12, 'colonpair with a public variable';
    #?rakudo skip 'Not enough positional parameters passed; got 0 but expected 1'
    is colonpair_positional(:g<10>), 15, 'colonpair with a positional variable';
}


# L<S06/Named parameters/marked by a prefix>
sub simple_pos_params (:$x) { $x }

is(simple_pos_params( x => 4 ), 4, "simple named param");


sub foo (:$x = 3) { $x }

is(foo(), 3, "not specifying named params that aren't mandatory works");

# part of RT 53814
dies_ok({foo(4)}, "using a named as a positional fails");

is(foo( x => 5), 5, "naming named param also works");
is(foo( :x<5> ), 5, "naming named param adverb-style also works");

sub foo2 (:$x = 3, :$y = 5) { $x + $y }

is(foo2(), 8, "not specifying named params that aren't mandatory works (foo2)");
dies_ok({foo2(4)}, "using a named as a positional fails (foo2)");
dies_ok({foo2(4, 10)}, "using a named as a positional fails (foo2)");
is(foo2( x => 5), 10, "naming named param x also works (foo2)");
is(foo2( y => 3), 6, "naming named param y also works (foo2)");
is(foo2( x => 10, y => 10), 20, "naming named param x & y also works (foo2)");
is(foo2( :x(5) ), 10, "naming named param x adverb-style also works (foo2)");
is(foo2( :y(3) ), 6, "naming named param y adverb-style also works (foo2)");
is(foo2( :x(10), :y(10) ), 20, "naming named params x & y adverb-style also works (foo2)");
is(foo2( x => 10, :y(10) ), 20, "mixing fat-comma and adverb naming styles also works for named params (foo2)");
is(foo2( :x(10), y => 10 ), 20, "mixing adverb and fat-comma naming styles also works for named params (foo2)");

sub assign_based_on_named_positional ($x, :$y = $x) { $y } 

is(assign_based_on_named_positional(5), 5, "When we don't explicitly specify, we get the original value");
is(assign_based_on_named_positional(5, y => 2), 2, "When we explicitly specify, we get our value");
is(assign_based_on_named_positional('y'=>2), ('y'=>2), "When we explicitly specify, we get our value");
my $var = "y";
is(assign_based_on_named_positional($var => 2), ("y"=>2),
   "When we explicitly specify, we get our value");

# L<S06/Named arguments/multiple same-named arguments>
#?niecza skip 'multiple same-named arguments NYI' 
    #?rakudo skip 'multiple same-named arguments NYI'
{
    sub named_array(:@x) { +«@x }

    is(named_array(:x), (1), 'named array taking one named arg');
    is(named_array(:x, :!x), (1, 0), 'named array taking two named args');
    is(named_array(:x(1), :x(2), :x(3)), (1, 2, 3), 'named array taking three named args');
}

# L<S06/Named arguments/Pairs intended as positional arguments>
#?rakudo skip 'multiple same-named arguments NYI'
#?niecza skip 'multiple same-named arguments NYI'
{
    sub named_array2(@x, :y) { (+«@x, 42, +«@y) }
    # +«(:x) is (0, 1)

    is(named_array2(:!x, :y), (0, 42, 1), 'named and unnamed args - two named');
    is(named_array2(:!x, y => 1), (0, 42, 1), 'named and unnamed args - two named - fatarrow');
    is(named_array2(:y, :!x), (0, 42, 1), 'named and unnamed args - two named - backwards');
    is(named_array2(:y, (:x)), (0, 1, 42, 1), 'named and unnamed args - one named, one pair');
    is(named_array2(1, 2), (1, 42), 'named and unnamed args - two unnamed');
    is(named_array2(:!y, 1), (1, 42, 0), 'named and unnamed args - one named, one pos');
    is(named_array2(1, :!y), (1, 42, 0), 'named and unnamed args - one named, one pos - backwards');
    is(named_array2(:y, 1, :!y), (1, 42, 1, 0), 'named and unnamed args - two named, one pos');
    
    nok(try { EVAL 'named_array2(:y, :y)'}.defined, 'named and unnamed args - two named with same name');

    is(named_array2(:y, (:x)), (0, 1, 42, 1), 'named and unnamed args - passing parenthesized pair');
    is(named_array2(:y, (:y)), (0, 1, 42, 1), 'named and unnamed args - passing parenthesized pair of same name');
    is(named_array2(:y, :z), (0, 1, 42, 1), 'named and unnamed args - passing pair of unrelated name');
    is(named_array2(:y, "x" => 1), (0, 1, 42, 1), 'named and unnamed args - passing pair with quoted fatarrow');
}

# L<S06/Named parameters/They are marked by a prefix>
# L<S06/Required parameters/declared with a trailing>
sub mandatory (:$param!) {
    return $param;
}

is(mandatory(param => 5) , 5, "named mandatory parameter is returned");
dies_ok {EVAL 'mandatory()' },  "not specifying a mandatory parameter fails";

#?niecza skip "Unhandled trait required"
{
    sub mandatory_by_trait (:$param is required) {
        return $param;
    }
    
    is(mandatory_by_trait(param => 5) , 5, "named mandatory parameter is returned");
    dies_ok( { mandatory_by_trait() }, "not specifying a mandatory parameter fails");
}


# L<S06/Named parameters/sub formalize>
sub formalize($text, :$case, :$justify) {
   return($text,$case,$justify); 
}

{
my ($text,$case,$justify)  = formalize('title', case=>'upper');
is($text,'title', "text param was positional");
nok($justify.defined, "justification param was not given");
is($case, 'upper', "case param was named, and in justification param's position");
}

{
my ($text,$case,$justify)   = formalize('title', justify=>'left');
is($text,'title', "text param was positional");
is($justify, 'left', "justify param was named");
nok($case.defined, "case was not given at all");
}

{
my  ($text,$case,$justify) = formalize("title", :justify<right>, :case<title>);

is($text,'title', "title param was positional");
is($justify, 'right', "justify param was named with funny syntax");
is($case, 'title', "case param was named with funny syntax");
}

{
sub h($a,$b,$d) { $d ?? h($b,$a,$d-1) !! $a~$b }

is(h('a','b',1),'ba',"parameters don\'t bind incorrectly");
}

# Slurpy Hash Params
{
sub slurpee(*%args) { return %args }
my %fellowship = slurpee(hobbit => 'Frodo', wizard => 'Gandalf');
is(%fellowship<hobbit>, 'Frodo', "hobbit arg was slurped");
is(%fellowship<wizard>, 'Gandalf', "wizard arg was slurped");
is(+%fellowship, 2, "exactly 2 arguments were slurped");
nok(%fellowship<dwarf>.defined, "dwarf arg was not given");
}

{
    sub named_and_slurp(:$grass, *%rest) { return($grass, %rest) }
    my ($grass, %rest) = named_and_slurp(sky => 'blue', grass => 'green', fire => 'red');
    is($grass, 'green', "explicit named arg received despite slurpy hash");
    is(+%rest, 2, "exactly 2 arguments were slurped");
    is(%rest<sky>, 'blue', "sky argument was slurped");
    is(%rest<fire>, 'red', "fire argument was slurped");
    nok(%rest<grass>.defined, "grass argument was NOT slurped");
}

{
    my $ref;
    sub setref($refin) {
        $ref = $refin;
    }
    my $aref = [0];
    setref($aref);
    $aref[0]++;
    is($aref[0], 1, "aref actually implemented");
    is($ref[0], 1, "ref is the same as aref");
}

{
    sub typed_named(Int :$x) { 1 }
    is(typed_named(:x(42)), 1,      'typed named parameters work...');
    is(typed_named(),       1,      '...when value not supplied also...');
    dies_ok({ typed_named("BBQ") }, 'and the type check is enforced');
}

{
    sub renames(:y($x)) { $x }
    is(renames(:y(42)),  42, 'renaming of parameters works');
    is(renames(y => 42), 42, 'renaming of parameters works');
    dies_ok { renames(:x(23)) }, 'old name is not available';
}

# L<S06/Parameters and arguments/"A signature containing a name collision">

#?niecza 2 todo "sub params with the same name"
eval_dies_ok 'sub rt68086( $a, $a ) { }', 'two sub params with the same name';

eval_dies_ok 'sub svn28865( :$a, :@a ) {}',
             'sub params with the same name and different types';

{
    sub svn28870( $a, @a ) { return ( $a, +@a ) }

    my $item = 'bughunt';
    my @many = ( 22, 'twenty-two', 47 );

    is( svn28870( $item, @many ), ( 'bughunt', 3 ),
        'call to sub with position params of same name and different type' );
}

# RT #68524
{
    sub rt68524( :$a! ) {}
    ok( &rt68524.signature.perl ~~ m/\!/,
        '.signature.perl with required parameter includes requirement' );
}

# RT #69516
{
    sub rt69516( :f($foo) ) { "You passed '$foo' as 'f'" }
    ok( &rt69516.signature.perl ~~ m/ ':f(' \s* '$foo' \s* ')' /,
        'parameter rename appears in .signature.perl' );
}

# L<S06/Named parameters/Bindings happen in declaration order>
#?rakudo skip 'where constraints'
{
    my $t = '';
    sub order_test($a where { $t ~= 'a' },   #OK not used
                   $b where { $t ~= 'b' },   #OK not used
                   $c where { $t ~= 'c' }) { 8 };   #OK not used
    is order_test(c => 5, a => 3, b => 2), 8,
        'can fill positional by name';
    ok $t ~~ /a.*b/, '$a was bound before $b';
    ok $t ~~ /a.*c/, '$a was bound before $c';
    ok $t ~~ /b.*c/, '$b was bound before $c';
}

# RT #67558
{
    #?niecza todo "Renaming a parameter to an existing positional should fail"
    eval_dies_ok q[sub a(:$x, :foo($x) = $x) { $x }],
        'Cannot rename a parameter to an already existing positional';
    sub a(:$x, :foo($y) = $x) { $y };
    is a(x => 2), 2, 'Can fill named parameter with default from other named';
    is a(foo => 3), 3, 'Can fill in directly even it has a default value';
    is a(x => 2, foo => 3), 3, 'direct fill takes precedence';


}

{
    sub test_positional_named(:@a) { @a.join('|'); }
    is test_positional_named(:a(3, 4, 5)), '3|4|5',
        ':a(1, 2, 3) can be passed to a :@a parameter';
    is test_positional_named(:a[3, 4, 5]), '3|4|5',
        ':a[1, 2, 3] can be passed to a :@a parameter';
    is test_positional_named(:a<3 4 5>), '3|4|5',
        ':a<1 2 3> can be passed to a :@a parameter';

}

{
    sub quoted_named(:$x = 5) { $x };
    dies_ok { quoted_named( "x" => 5 ) }, 'quoted pair key => positional parameter';
}

#?niecza skip "Abbreviated named parameter must have a name"
{
    sub named_empty(:$) {
        42
    }
    my %h = '' => 500;
    is named_empty(|%h), 42, 'can call function with empty named argument';
}

done;

# vim: ft=perl6
