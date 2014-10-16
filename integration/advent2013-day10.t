use v6;
use Test;
plan 44;

sub is-on(:$adverb) {
    is $adverb, True, 'adverb on';
}

sub is-off(:$adverb) {
    is $adverb, False, 'adverb off';
}

is-on( :adverb );
is-on( :adverb(True) );
is-off( :!adverb );
is-off( :adverb(False) );

sub test-strings(:$greet!, :$person) {
    is $greet, 'Hello', 'greeting';
    is $person, 'lue', 'person';
}

my $user = 'lue';

test-strings(:greet('Hello')
	     :person("$user"));

test-strings(:greet<Hello> :person«$user»);
test-strings(:greet<Hello> :person<<$user>>);

sub test-abbrev(:$foo) {
    is $foo, 'bar', 'abbrev';
}

{
    my $foo = 'bar';
    test-abbrev(:foo($foo));
    test-abbrev(:$foo);
}

# 'nth' modifier test adapted from S05-modifier/counted.t

my $data = "f fo foo fooo foooo fooooo foooooo";
{
    ok($data ~~ m:nth(4)/fo+/, 'Match nth(4)');
    is($/, 'foooo', 'Matched value for nth(4)');
}
{
    ok($data ~~ m:4th/fo+/, 'Match nth(4)');
    is($/, 'foooo', 'Matched value for nth(4)');
}

sub foo($z, :$bar, :$baz) {
    is $z, 'zzz', 'positional arg';
    ok $bar, 'adverb 1';
    ok $baz, 'adverb 2';
}
sub foo2($z, :$bar, :$baz) {
    is $z, 'zzz', 'positional arg';
    ok $bar, 'adverb 1';
#?rakudo.jvm todo 'adverb stacking'
#?rakudo.moar todo 'adverb stacking'
    ok $baz, 'adverb 2';
}
{
    my $z = 'zzz';
    my $y = 42;

    foo($z, :bar, :baz);
    foo2($z, :bar :baz);
    foo($z) :bar :baz;

    my $applies-to = 'zilch';

    sub infix:</>($a, $b, :$round){
	$applies-to = '/:round'
	    if $round;
    }

    1 / 3 :round;       # applies to /
    is $applies-to, '/:round', ':round applied to /';

    sub infix:<&>($a, $b, :$adverb){
	$applies-to = '&:adverb'
	    if $adverb;
    }
    $z & $y :adverb;    # applies to &
    is $applies-to, '&:adverb', ':adverb applied to &';
}

## Todo test adverbs && ||
#1 || 2 && 3 :adv;   # applies to ||
#1 || (2 && 3 :adv) # applies to &&

{
    our $applies-to = 'zilch';

    class Foo {
	method bar(:$adv) {
	    $applies-to = '.bar()'
		if $adv;
	}
    }

    my $foo = Foo.new;
    sub prefix:<!>($a, :$adv){
	$applies-to = '!'
	    if $adv;
    }

    !$foo.bar() :adv; # applies to !
    is $applies-to, '!', 'applies to !';

    !($foo.bar() :adv); # applies to .bar()
    is $applies-to, '.bar()', 'applies to .bar()';

    my @a = 10, 20, 30, 40, 50;
    is_deeply @a[0..2] :kv, (0, 10, 1, 20, 2, 30), 'applies to []';

    sub infix:<+>($a, $b, :$adv){
	$applies-to = "...+{$b}"
	    if $adv;
    }

    sub infix:<->($a, $b, :$adv){
	$applies-to = "...-{$b}"
	    if $adv;
    }

    sub infix:<**>($a, $b, :$adv) {
	$applies-to = "{$a}**..."
	    if $adv;
    }

    1 + 2 - 3 :adv;     # applies to -
    is $applies-to, '...-3', "1 + 2 - 3: applies to '-'";

    1 ** 2 ** 3 :adv;   #applies to the leftmost **
    is $applies-to, '1**...', "1 ** 2 ** 3: applies to leftmost ***";
}

my @msgs = (1..12).map({'blah'});
my $name = 'fred';

my $greeting = q:c 'Hello, $name. You have { +@msgs } messages.';
ok $greeting.match(/12/), 'closure interpolation';
ok $greeting.match(/\$name/), 'variabled non-interpolation';

my $greeting2 = qq:!s 'Hello, $name. You have { +@msgs } messages.';
ok $greeting2.match(/12/), 'closure interpolation';
ok $greeting2.match(/\$name/), 'variabled non-interpolation';

lives_ok {EVAL '$data ~~ m:nth(5)/fo+/'}, 'Round parens ok';
throws_like {EVAL '$data ~~ m:nth[5]/fo+/'},
  X::Comp::Group,
  'Square parens not ok';

sub root4($num, :$adv1 = 42, :$adv2, :$adv3!) {
    is $num, 10, 'positional param';
    is $adv1, 42, 'adverb default value';
    ok !defined($adv2), 'adverb missing value';
    is $adv3, 'hi', 'adverb passed value';
}

throws_like {root4(10)}, Exception, 'missing required adverb - dies';
root4(10, :adv3<hi>);

sub root3($num, *%advs) {
    is_deeply %advs, {"foo" => False, "bar" => True, "baz" => True, "qux" => "blah"}, 'adverb catch all';
}

root3(42, :!foo, :bar, :baz(True), :qux<blah>);
