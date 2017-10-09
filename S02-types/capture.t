use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;
plan 43;

{
    my $capture = \(1,2,3);

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo1 ($a, $b, $c) { "$a!$b!$c" }
    is foo1(|$capture), "1!2!3",
        'simply capture creation with \\( works (1)';
}

{
    my $capture = \(1,2,3,'too','many','args');

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo2 ($a, $b, $c) { "$a!$b!$c" }
    throws-like { foo2(|$capture) },
      Exception,
      'simply capture creation with \\( works (2)';
}

{
    my $capture = \(1, named => "arg");

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo3 ($a, :$named) { "$a!$named" }
    is foo3(|$capture), "1!arg",
        'simply capture creation with \\( works (3)';
}

{
    my $capture = \(1, 'positional' => "pair");

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo4 ($a, $pair) { "$a!$pair" }
    is foo4(|$capture), "1!positional\tpair",
        'simply capture creation with \\( works (4)';
}

{
    my @array   = <a b c>;
    my $capture = \(@array);

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo5 (@arr) { ~@arr }
    is foo5(|$capture), "a b c",
        'capture creation with \\( works';
}

# L<S06/Argument list binding/single scalar parameter marked>
{
    sub bar6 ($a, $b, $c) { "$a!$b!$c" }
    sub foo6 (|capture)  { bar6(|capture) }

    is foo6(1,2,3), "1!2!3",
        'capture creation with \\$ works (1)';
    throws-like { foo6(1,2,3,4) },
      Exception,  # too many args
      'capture creation with \\$ works (2)';
    throws-like { foo6(1,2) },
      Exception,  # too few args
      'capture creation with \\$ works (3)';
}

# Arglists are first-class objects
{
    my $capture;
    sub foo7 (|args) { $capture = args }

    lives-ok { foo7(1,2,3,4) }, "captures are first-class objects (1)";
    ok $capture,               "captures are first-class objects (2)";

    my $old_capture = $capture;
    lives-ok { foo7(5,6,7,8) }, "captures are first-class objects (3)";
    ok $capture,               "captures are first-class objects (4)";
    ok !($capture === $old_capture), "captures are first-class objects (5)";
}

{
    my $capture1;
    sub foo8 ($args) { $capture1 = $args }

    my $capture2 = \(1,2,3);
    try { foo8 $capture2 };  # note: no |$args here

    ok $capture1 eqv $capture2,
        "unflattened captures can be passed to subs";
}

# Mixing ordinary args with captures
{
    my $capture = \(:foo<bar>, :baz<grtz>);
    sub foo9 ($a,$b, :$foo, :$baz) { "$a!$b!$foo!$baz" }

    throws-like { foo9(|$capture) },
      Exception,  # too few args
      "mixing ordinary args with captures (1)";
    is foo9(1, 2, |$capture), "1!2!bar!grtz",
        "mixing ordinary args with captures (2)";
}

{
    my @a = 1, 2;
    my $capture = \(|@a,3);
    sub foo10 ($a, $b, $c) { "$a!$b!$c" }
    is foo10(|$capture), "1!2!3",
        '|@a interpolation into \(...) works';
}

{
    my %h = named => 'arg';
    my $capture = \(1, |%h);

    sub foo11 ($a, :$named) { "$a!$named" }
    is foo11(|$capture), "1!arg",
        '|%h interpolation into \(...) works';
}

{
    # RT #78496
    my $c = ('OH' => 'HAI').Capture;
    is $c<key>,   'OH',  '.<key> of Pair.Capture';
    is $c<value>, 'HAI', '.<value> of Pair.Capture';
}

# RT #89766
nok (defined  \()[0]), '\()[0] is not defined';

# RT #116002
{
    class RT116002 {
        method foo (Int) {}
    }
    my @a = 42;

    ok \(RT116002, 42) ~~ RT116002.^find_method("foo").signature,
        'capture with scalar matches signature';
    nok \(RT116002, @a) ~~ RT116002.^find_method("foo").signature,
        'capture with one element array does not match signature';
    ok \(RT116002, |@a) ~~ RT116002.^find_method("foo").signature,
        'capture with infix:<|> on one element array matches signature';
}

# RT #75850
{
    is @(\( (:a(2)) )).elems, 1, 'Parens around a colonpair in \(...) make a positional (1)';
    is %(\( (:a(2)) )).elems, 0, 'Parens around a colonpair in \(...) make a positional (2)';
}

# RT #114100
{
    sub f(|everything) { everything.perl };
    my %h = :a, :b, :!c;
    ok f(%h) ~~ /'\(' \s* '{'/, 'Hashes not flattened into capture list';
}

# RT #125505
{
    my $a = 41;
    my $c = \($a);
    $c[0]++;
    is $a, 42, 'Can modify Capture positional elements';
}
{
    my $a = 41;
    my $c = \(:$a);
    $c<a>++;
    is $a, 42, 'Can modify Capture associative elements';
}

lives-ok { (1..*).Capture.perl }, '.perl of Capture formed from Range does not explode';

# RT #123581
throws-like '(1..*).list.Capture', X::Cannot::Lazy, :action('create a Capture from');
throws-like '(my @ = 1..*).Capture', X::Cannot::Lazy, :action('create a Capture from');

{ # coverage; 2016-09-26
    my $antipairs = \(42, [1, 2], %(:42a), :72a, :x[3, 4], :y{:42a}).antipairs;
    is-deeply ($antipairs[0..2], $antipairs[3..*].sort).flat,
    (
        42 => 0,        ([1, 2]) => 1, ({:a(42)}) => 2,
        ([3, 4]) => "x", 72 => "a",    ({:a(42)}) => "y",
    ), '.antipairs returns correct result';
}

# RT #128977 and #130954
{
	my $c1 = \(42);
	is $c1.WHICH, "Capture|(Int|42)";

	my $a = 42;
	my $c2 = \($a);
	like $c2.WHICH, /'Capture|(Scalar|' \d+ ')'/;

	cmp-ok $c1, &[eqv], $c2;
	cmp-ok $c1, {$^a !=== $^b}, $c2;
}

# RT#131351
subtest 'non-Str-key Pairs in List' => {
    plan 3;
    quietly is-deeply (Mu => Any,).Capture, \(:Mu(Any)), '(Mu => Any,)';
    is-deeply (class {method Str {'foo'}} => 42,).Capture,
        \(:foo(42)), '( custom class => 432,)';

    # use a Hash as a proxy in expected, 'cause we don't know the sort order
    is-deeply (<10> => <20>, 30 => 40, 1.5 => 1.5).Capture,
        %('10' => <20>, '30' => 40, '1.5' => 1.5).Capture, 'numerics and allomorphs';
}

is-deeply .Capture, $_, 'Capture.Capture returns self',
    with do { my $a = 42; my $b := 70; (\($a, :$b)).Capture };

is-deeply .Capture, $_, 'Match.Capture returns self',
    with 'x'.match: /./;

subtest 'types whose .Capture throws' => {
    # https://irclog.perlgeek.de/perl6/2017-03-07#i_14221839
    plan 14;
    throws-like  { True  .Capture }, X::Cannot::Capture, 'Bool';
    throws-like  { 'x'   .Capture }, X::Cannot::Capture, 'Str';
    throws-like  { 42    .Capture }, X::Cannot::Capture, 'Int';

    throws-like  { 42e0  .Capture }, X::Cannot::Capture, 'Num';
    throws-like  { <42>  .Capture }, X::Cannot::Capture, 'IntStr';
    throws-like  { <42e0>.Capture }, X::Cannot::Capture, 'NumStr';

    throws-like  { -> $a, :$b {}.Capture }, X::Cannot::Capture, 'Callable';
    throws-like  { ((*)).Capture }, X::Cannot::Capture, 'Whatever';
    throws-like  { ((**)).Capture }, X::Cannot::Capture, 'HyperWhatever';

    throws-like  { ((*.so)).Capture }, X::Cannot::Capture, 'WhateverCode';
    throws-like  { :(\SELF: $a, :$b).Capture }, X::Cannot::Capture, 'Signature';
    throws-like  { (v42).Capture }, X::Cannot::Capture, 'Version';
    throws-like  { rx/./.Capture }, X::Cannot::Capture, 'Regex';

    subtest 'Failure' => {
        plan 3;

        throws-like { Failure.Capture }, X::Cannot::Capture, ':U';
        throws-like {
            given Failure.new { .so; .Capture }
        }, X::Cannot::Capture, 'handled';

        my class X::Meows is Exception {}
        throws-like { sub { X::Meows.new.fail }().Capture }, X::Meows,
            'unhandled';
    }
}

subtest 'types whose .Capture behaves like List.Capture' => {
    # Pair contents become nameds; rest become positionals;
    plan 18;

    is-deeply Blob.new(1, 2, 42).Capture, \(1, 2, 42), 'Blob';
    is-deeply Buf .new(1, 2, 42).Capture, \(1, 2, 42), 'Buf';
    is-deeply utf8.new(1, 2, 42).Capture, \(1, 2, 42), 'utf8';


    with Channel.new -> $c {
        $c.send: $_ for |<a b c>, :42z;
        $c.close;
        is-deeply $c.Capture, \('a', 'b', 'c', :42z), 'Channel';
    }

    is-deeply .Capture, \('a', 'b', 'c', :42z), 'Supply'
        with supply { .emit for |<a b c>, :42z };

    is-deeply (42, :42a).Seq.Capture, \(42, :42a), 'Seq';
    is-deeply (42, :42a)    .Capture, \(42, :42a), 'List';
    is-deeply [42, :42a]    .Capture, \(42, :42a), 'Array';
    is-deeply Slip.new(42, :42a.Pair).Capture, \(42, :42a), 'Slip';

    is-deeply Map.new((:42a)).Capture, \(:42a), 'Map';
    is-deeply {:42a}.Capture, \(:42a), 'Hash';

    # Expected to stringify non-Str keys
    is-deeply :{42 => 70, <70> => 100, a => 42}.Capture,
        ("42" => 70, "70" => 100, :42a).Capture, 'Object Hash';

    # Expected to stringify non-Str keys
    is-deeply set(42, <70>).Capture,
        ("42" => True, "70" => True).Capture, 'Set';
    is-deeply SetHash.new(42, <70>).Capture,
        ("42" => True, "70" => True).Capture, 'SetHash';

    # Expected to stringify non-Str keys
    is-deeply bag('a', 'a',  'b', 42, <70>, <70>).Capture,
        (:2a, :1b, "42" => 1, "70" => 2).Capture, 'Bag';
    is-deeply BagHash.new('a', 'a',  'b', 42, <70>, <70>).Capture,
        (:2a, :1b, "42" => 1, "70" => 2).Capture, 'BagHash';

    # Expected to stringify non-Str keys
    is-deeply mix('a', 'a',  'b', 42, <70>, <70>).Capture,
        (:2a, :1b, "42" => 1, "70" => 2).Capture, 'Bag';
    is-deeply MixHash.new('a', 'a',  'b', 42, <70>, <70>).Capture,
        (:2a, :1b, "42" => 1, "70" => 2).Capture, 'BagHash';
}

subtest 'types whose .Capture behaves like Mu.Capture' => {
    # Here we specifically test only the contents we know about, in case
    # in the future we add more attributes to these objects...
    plan 17;
    sub has-nameds (\what, %wanted, Str:D $desc = what.^name) {
        subtest "$desc.Capture has named argument..." => {
            plan +%wanted;
            my %has = what.Capture.Hash;
            is-deeply %has{.key}, .value, .key for %wanted;
        }
    }

    (1..^Inf).&has-nameds:
      %(:1min, :max(Inf), :excludes-max, :!excludes-min, :!is-int);

            <42+1i>.&has-nameds: %(:re(42e0), :im(1e0));
          < 42+1i >.&has-nameds: %(:re(42e0), :im(1e0));
              <1/2>.&has-nameds: %(:1numerator, :2denominator);
            < 1/2 >.&has-nameds: %(:1numerator, :2denominator);
    FatRat.new(1,2).&has-nameds: %(:1numerator, :2denominator);

    do { try +'x'; $! }.&has-nameds: %(:source<x>);
    :42foo.&has-nameds: %(:key<foo>, :42value), 'Pair';

    DateTime.new(|$_).&has-nameds: $_ with %(:2015year, :12month, :25day);
        Date.new(|$_).&has-nameds: $_ with %(:2015year, :12month, :25day);

    Duration.new(42).&has-nameds: %(:tai(42.0));

    DateTime.new(:2015year).Instant.&has-nameds: %(:tai(1420070435.0));

    (start {sleep .5}).&has-nameds: %(:status(PromiseStatus::Planned));
    .&has-nameds: %(:path(.path), :CWD(.CWD)) with make-temp-file;
    .&has-nameds: %(:command(.command), :exitcode(.exitcode), :signal(.signal))
        with run «"$*EXECUTABLE" -e ' '»;

    with %(:chomp, :encoding("utf8"), :nl-out("\n")) {
        make-temp-file.open(:w).&has-nameds: $_;
        IO::CatHandle.new(make-temp-file :content<foo>).&has-nameds: $_;
    }
}

# vim: ft=perl6
