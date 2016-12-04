use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;
use Test::Idempotence;
plan 133;

# L<S06/Signature Introspection>

sub j(*@i) {
    @i.map({ $_ ?? '1' !! '0' }).join(' ');
}

{
    sub a($x, Int $y?, :$z) { };   #OK not used
    ok &a.signature.params ~~ Positional, '.params does Positional';
    my @l = &a.signature.params;
    ok ?(all(@l >>~~>> Parameter)), 'And all items are Parameters';
    is +@l, 3, 'we have three of them';
    is ~(@l>>.name), '$x $y $z', 'can get the names with sigils';
    ok @l[0].type === Any, 'Could get first type';
    ok @l[1].type === Int, 'Could get second type';

    is j(@l>>.readonly), '1 1 1', 'they are all read-only';
    is j(@l>>.rw),       '0 0 0', '... none rw';
    is j(@l>>.copy),     '0 0 0', '... none copy';
    is j(@l>>.raw),      '0 0 0', '... none raw';
    is j(@l>>.slurpy),   '0 0 0', '... none slurpy';
    is j(@l>>.optional), '0 1 1', '... some optional';
    is j(@l>>.invocant), '0 0 0', '... none invocant';
    is j(@l>>.named),    '0 0 1', '... one named';
}

#?niecza skip "Unhandled trait rwt"
{
    sub b(:x($a)! is rw, :$y is raw, :$z is copy) { };   #OK not used
    my @l = &b.signature.params;
    is j(@l>>.readonly), '0 0 0', '(second sig) none are all read-only';
    is j(@l>>.rw),       '1 0 0', '... one rw';
    is j(@l>>.raw),   '0 1 0', '... one raw';
    is j(@l>>.copy),     '0 0 1', '... one copy';
    is j(@l>>.slurpy),   '0 0 0', '... none slurpy';
    is j(@l>>.optional), '0 1 1', '... some optional';
    is j(@l>>.invocant), '0 0 0', '... none invocant';
    is j(@l>>.named),    '1 1 1', '... all named';

    is ~@l[0].named_names, 'x',   'named_names work';
    is ~@l[0].name,      '$a',    '.name works for renamed params';
}

{
    sub d(*@pos, *%named) { };   #OK not used
    my @l = &d.signature.params;
    #?niecza todo
    is j(@l>>.named),    '0 1', '.named for slurpies';
    is j(@l>>.slurpy),   '1 1', '.slurpy';
    is ~(@l>>.name),     '@pos %named', '.name for slurpies';
}


{
    sub d(:x(:y(:z($a)))) { };   #OK not used
    is ~&d.signature.params.[0].named_names.sort, 'x y z', 'multi named_names';
    is ~&d.signature.params.[0].name, '$a',    '... and .name still works';
    #?rakudo todo 'needs/find RT: Logic to make :a($a) into :$a makes :a(:b($a) into ::b(:$a)'
    is :(:a(:b($a))).perl, :(:b($a)).perl, '... and .perl abbreviates separated name/named_name';
}

#?niecza skip "Parameter separator ;  NYI"
{
    sub e($x = 3; $y = { 2 + $x }) { };   #OK not used
    my @l = &e.signature.params>>.default;
    ok ?( all(@l >>~~>> Code) ), '.default returns closure';
    is @l[0].(),    3, 'first closure works';
    # XXX The following test is very, very dubious...
    #?rakudo skip 'expected Any but got Mu instead'
    is @l[1].().(), 5, 'closure as default value captured outer default value';
}

#?niecza skip "Unable to resolve method constraints in class Parameter"
{
    sub f(Int $x where { $_ % 2 == 0 }) { };   #OK not used
    my $p = &f.signature.params[0];
    ok 4  ~~ $p.constraints, '.constraints (+)';
    ok 5 !~~ $p.constraints, '.constraints (-)';
    ok 5 ~~ (-> $x { }).signature.params[0].constraints,
       '.constraints on unconstraint param should still smartmatch truely';
    sub g(Any $x where Int) { };   #OK not used
    ok 3 ~~ &g.signature.params[0].constraints,
       'smartmach against non-closure constraint (+)';
    ok !(3.5 ~~ &g.signature.params[0].constraints),
       'smartmach against non-closure constraint (-)';
}

# RT #70720
#?niecza skip "Action method fakesignature not yet implemented"
{
    is :(3).params[0].constraints, 3, ':(3) contains the 3';
    ok :(3).params[0].type === Int,   ':(3) has a parameter of type Int';
}

#?niecza skip "GLOBAL::T does not name any package"
{
    sub h(::T $x, T $y) { };   #OK not used
    my @l = &h.signature.params;
    is @l[0].type_captures, 'T', '.type_captures';
    lives-ok { @l[1].type }, "can access a type_capture'd type";
}

{
    sub i(%h ($a, $b)) { };   #OK not used
    my $s = &i.signature.perl;
    #?niecza 2 todo
    ok $s ~~ /'$a' >> /, '.perl on a nested signature contains variables of the subsignature (1)';
    ok $s ~~ /'$b' >> /, '.perl on a nested signature contains variables of the subsignature (2)';
}

#?niecza skip "Action method fakesignature not yet implemented"
{
    my $x;
    ok :(|x).params[0].capture, 'prefix | makes .capture true';
    ok :(|x).perl  ~~ / '|' /,  'prefix | appears in .perl output';

    ok :(\x).params[0].raw, 'prefix \\ makes .raw true';
    ok :(\x).perl ~~ / '\\' /, 'prefix \\ appears in .perl output';
}

# RT #69492
#?niecza skip "Abbreviated named parameter must have a name"
{
    sub foo(:$) {};
    ok &foo.signature.perl ~~ / ':($)' /, '.perl of a signature with anonymous named parameter';
}

# Capture param introspection
{
    sub xyz(|c) {};
    is &xyz.signature.params[0].name,       'c' , '.name of |c is "c"';
    #?niecza todo "Does this test make sense?"
    is &xyz.signature.params[0].positional, False, '.positional on Capture param is False';
    is &xyz.signature.params[0].capture,    True , '.capture on Capture param is True';
    is &xyz.signature.params[0].named,      False, '.named on Capture param is True';
}

{
    is-perl-idempotent(:($a, :$b),:eqv);
    is-perl-idempotent(:(@a, :@b), :eqv);
    is-perl-idempotent(:(%a, :%b), :eqv);
    is-perl-idempotent(:(:a(:b($c))), :eqv);
    is-perl-idempotent(:(|a), :eqv);
    is-perl-idempotent(:(&a, :&b), :eqv);
    is-perl-idempotent(:(\a), :eqv);
    is-perl-idempotent(:(\a, $b, &c, %d, |e), :eqv);
    is-perl-idempotent(:($a = 2, :$b = 2), :eqv);
    is-perl-idempotent(:(@a = [2, 3], :@b = [2,3]), :eqv);
    is-perl-idempotent(:(%a = {:a(2)}, :%b = {:a(2)}), :eqv);
    is-perl-idempotent(:(&a = &say, :&b = &say), Nil, { '= { ... }' => '= &say' },:eqv);
    is-perl-idempotent(:($a is raw = 2), :eqv);
    is-perl-idempotent(:(@a is raw = [2]), :eqv);
    is-perl-idempotent(:(%a is raw = {:a(2)}), :eqv);
    is-perl-idempotent(:(&a is raw = &say), :eqv);
    is-perl-idempotent(:(\a = 2), :eqv);
    is-perl-idempotent(:(Int $a, Int :$b), :eqv);
    is-perl-idempotent(:(Int @a, Int :@b), :eqv);
    is-perl-idempotent(:(Int %a, Int :%b), :eqv);
    is-perl-idempotent(:(Int :a(:b($c))), :eqv);
    is-perl-idempotent(:(|a ($a)), :eqv);
    is-perl-idempotent(:(Sub &a, Sub :&b), :eqv);
    is-perl-idempotent(:(Int \a), :eqv);
    is-perl-idempotent(:(Int \a, Int $b, Sub &c, Int :$d, |e), :eqv);
    is-perl-idempotent(:(Int $a = 2, Int :$b = 2), Nil, { '= { ... }' => '= 2' }, :eqv);
    is-perl-idempotent(:(Int @a = [2, 3], Int :@b = [2,3]), Nil, { '= { ... }' => '= [2,3]' }, :eqv);
    is-perl-idempotent(:(Int %a = :a(2), Int :%b = :a(2)), Nil, { '= { ... }' => '= {:a(2)}' }, :eqv);
    is-perl-idempotent(:(Sub &a = &say, Sub :&b = &say), Nil, { '= { ... }' => '= &say' },:eqv);
    is-perl-idempotent(:(@a ($a) = [2]), :eqv);
    is-perl-idempotent(:(%a (:a($b)) = {:a(2)}, %b (:c(:d($e))) = {:c(2)}), :eqv);

    is-perl-idempotent(:($, :a($)),:eqv);
    is-perl-idempotent(:(@, :a(@)), :eqv);
    is-perl-idempotent(:(%, :a(%)), :eqv);
    is-perl-idempotent(:(:a(:b($))), :eqv);
    is-perl-idempotent(:(|), :eqv);
    is-perl-idempotent(:(&, :a(&)), :eqv);
    is-perl-idempotent(:(\), :eqv);
    is-perl-idempotent(:(\, $, &, %, |), :eqv);
    is-perl-idempotent(:($ = 2, :a($) = 2), :eqv);
    is-perl-idempotent(:(@ = [2, 3], :a(@) = [2,3]), :eqv);
    is-perl-idempotent(:(% = {:a(2)}, :a(%) = {:a(2)}), :eqv);
    is-perl-idempotent(:(& = &say, :a(&) = &say), Nil, { '= { ... }' => '= &say' },:eqv);
    is-perl-idempotent(:($ is raw = 2), :eqv);
    is-perl-idempotent(:(@ is raw = [2]), :eqv);
    is-perl-idempotent(:(% is raw = {:a(2)}), :eqv);
    is-perl-idempotent(:(& is raw = &say), :eqv);
    is-perl-idempotent(:(Int $, Int :a($)), :eqv);
    is-perl-idempotent(:(Int @, Int :a(@)), :eqv);
    is-perl-idempotent(:(Int %, Int :a(%)), :eqv);
    is-perl-idempotent(:(Int :a(:b($))), :eqv);
    is-perl-idempotent(:(|a ($)), :eqv);
    is-perl-idempotent(:(Sub &, Sub :a(&)), :eqv);
    is-perl-idempotent(:(Int \), :eqv);
    is-perl-idempotent(:(Int \, Int $, Sub &, Int %, |), :eqv);
    is-perl-idempotent(:(Int $ = 2, Int :a($) = 2), Nil, { '= { ... }' => '= 2' }, :eqv);
    is-perl-idempotent(:(Int @ = [2, 3], Int :a(@) = [2,3]), Nil, { '= { ... }' => '= [2,3]' }, :eqv);
    is-perl-idempotent(:(Int % = :a(2), Int :a(%) = :a(2)), Nil, { '= { ... }' => '= {:a(2)}' }, :eqv);
    is-perl-idempotent(:(Sub & = &say, Sub :a(&) = &say), Nil, { '= { ... }' => '= &say' },:eqv);
    is-perl-idempotent(:(@ ($a) = [2]), :eqv);
    is-perl-idempotent(:(% (:a($)) = {:a(2)}, % (:c(:d($))) = {:c(2)}), :eqv);
    is-perl-idempotent(:($ is raw, & is raw, % is raw, | is raw), :eqv);

    is-perl-idempotent(:(::T $a, T $b), :eqv);
    # Not sure if this one makes much sense.
    is-perl-idempotent(:(::T T $a, T $b), :eqv);

    my $f;
    is-perl-idempotent($f = -> $a { }, Nil,
                       :{ rx/Block\|\d+/ => '' });
    is-perl-idempotent(-> { }, Nil,
                       :{ rx/Block\|\d+/ => '' });
    is-perl-idempotent(-> ($a) { }, Nil,
                       :{ rx/Block\|\d+/ => '' });
    is-perl-idempotent(-> $ { }, Nil,
                       :{ rx/Block\|\d+/ => '' });
    is-perl-idempotent(-> $a ($b) { }, Nil,
                       :{ rx/Block\|\d+/ => '' });

}

role A { sub a ($a, $b, ::?CLASS $c) { }; method foo { &a } };
class C does A {  };
my $rolesig = try C.foo.signature.perl;
is $rolesig, ':($a, $b, ::?CLASS $c)', ".perl of a sigature that has ::?CLASS";

# RT #123895
{
    is_run q[sub wtvr(|) {}; &wtvr.perl], { err => "", out => "" }, ".perl on unnamed | parameters doesn't err";
    is_run q[sub prcl(\\) {}; &prcl.perl], { err => "", out => "" }, ".perl on unnamed \\ parameters doesn't err";
}

# RT #125482
{
    sub rt125482($a;; $b) { 42 };
    is &rt125482.signature.gist, '($a;; $b)',
        '";;" in signature stringifies correctly using .gist';
    is &rt125482.signature.perl, ':($a;; $b)',
        '";;" in signature stringifies correctly using .perl';
}

# RT #128392
{
    is :(Callable $a).perl, ':(Callable $a)',
        'Callable in signature stringifies correctly using .perl';
    is :(Callable $a).gist, '(Callable $a)',
        'Callable in signature stringifies correctly using .gist';


    is :(Callable).perl, ':(Callable $)', 'perl on :(Callable)';
    is :(Array of Callable).perl, ':(Array[Callable] $)',
        '.perl on :(Array of Callable)';
    is :(Hash of Callable).perl, ':(Hash[Callable] $)',
        '.perl on :(Hash of Callable)';
}

# https://github.com/rakudo/rakudo/commit/219f527d4a
is-deeply sub ($,$,$,$){}.signature.gist, '($, $, $, $)',
    '.gist does not strip typeless anon sigils';

# vim: ft=perl6
