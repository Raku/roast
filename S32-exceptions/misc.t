use v6;
use Test;

#?DOES 1
throws_like { Buf.new().Str }, X::Buf::AsStr, method => 'Str';;
throws_like 'pack("B",  1)',       X::Buf::Pack, directive => 'B';
throws_like 'Buf.new.unpack("B")', X::Buf::Pack, directive => 'B';
throws_like 'pack "A2", "mÄ"',     X::Buf::Pack::NonASCII, char => 'Ä';
throws_like 'my class Foo { method a() { $!bar } }', X::Attribute::Undeclared,
            symbol => '$!bar', package-name => 'Foo', package-kind => 'class',
            what => 'attribute';
throws_like 'sub f() { $^x }', X::Signature::Placeholder,
            line => 1,
            placeholder => '$^x',
            ;

throws_like 'qr/a/', X::Obsolete, old => rx/<<qr>>/, replacement => rx/<<rx>>/;
throws_like '"a" . "b"', X::Obsolete, replacement => '~';
throws_like 's/a/b/i', X::Obsolete;
# RT #112470
throws_like 'my ${a} = 5', X::Obsolete;

throws_like 'do    { $^x }', X::Placeholder::Block, placeholder => '$^x';
throws_like 'do    { @_  }', X::Placeholder::Block, placeholder => '@_';
throws_like 'class { $^x }', X::Placeholder::Block, placeholder => '$^x';
# RT #76956
throws_like '$^x',           X::Placeholder::Mainline, placeholder => '$^x';
# RT #73502
throws_like '@_',            X::Placeholder::Mainline, placeholder => '@_';
# RT #85942
throws_like '"foo".{ say $^a }', X::Placeholder::Mainline;


throws_like 'sub f(*@ = 2) { }', X::Parameter::Default, how => 'slurpy', parameter => *.not;
throws_like 'sub f($x! = 3) { }', X::Parameter::Default, how => 'required', parameter => '$x';
throws_like 'sub f(:$x! = 3) { }', X::Parameter::Default, how => 'required';
throws_like 'sub f($:x) { }',  X::Parameter::Placeholder,
        parameter => '$:x',
        right     => ':$x';
throws_like 'sub f($?x) { }',  X::Parameter::Twigil,
        parameter => '$?x',
        twigil    => '?';
throws_like 'sub (Int Str $x) { }', X::Parameter::MultipleTypeConstraints;



# some of these redeclaration errors take different code
# paths in rakudo, so we over-test a bit to catch them all,
# even if the tests look rather boring;
throws_like 'sub a { }; sub a { }',X::Redeclaration, symbol => 'a', what => 'routine';
# RT #78370
throws_like 'my &a; multi a { }', X::Redeclaration, symbol => 'a', what => 'routine';
throws_like 'sub a { }; multi sub a { }',X::Redeclaration, symbol => 'a', what => 'routine';
throws_like 'my class A { }; my class A { }',  X::Redeclaration, symbol => 'A';
throws_like 'my class B { }; my subset B of Any;', X::Redeclaration, symbol => 'B';
throws_like 'CATCH { }; CATCH { }', X::Phaser::Multiple, block => 'CATCH';
# multiple return types
throws_like 'sub f(--> List) returns Str { }', X::Redeclaration;
throws_like 'my Int sub f(--> Str) { }', X::Redeclaration;
# RT #115356
throws_like 'my class F { }; role F { }', X::Redeclaration, symbol => 'F';

throws_like 'my class A { my @a; @a!List::foo() }',
    X::Method::Private::Permission,
    method          => 'foo',
    calling-package => 'A',
    source-package  => 'List';

throws_like '1!foo()',
    X::Method::Private::Unqualified,
    method          => 'foo';

throws_like 'sub f() { }; f() := 2', X::Bind;
throws_like 'OUTER := 5', X::Bind, target => /OUTER/;
throws_like 'my int $x := 2', X::Bind::NativeType, name => '$x';
throws_like 'my @a; @a[] := <foo bar baz>', X::Bind::ZenSlice, type => Array;
throws_like 'my %a; %a{} := foo=>1, bar=>2, baz=>3', X::Bind::ZenSlice, type => Hash;
throws_like 'my @a; @a[0, 1] := (2, 3)', X::Bind::Slice, type => Array;
throws_like 'my %a; %a<a b> := (2, 3)', X::Bind::Slice, type => Hash;


throws_like 'for (1; 1; 1) { }', X::Obsolete,
    old         => rx/<<for>>/,
    replacement => rx/<<loop>>/;
throws_like 'foreach (1..10) { }', X::Obsolete,
    old         => "'foreach'",
    replacement => "'for'";
throws_like 'undef', X::Obsolete,
    old         => rx/<<undef>>/;
# RT #77118
{
    throws_like '<>', X::Obsolete, old => "<>";
}
# RT #92408
throws_like 'my ($a, $b); $a . $b', X::Obsolete;

throws_like 'my $a::::b', X::Syntax::Name::Null;
throws_like 'unless 1 { } else { }', X::Syntax::UnlessElse;
throws_like 'for my $x (1, 2, 3) { }', X::Syntax::P5;
throws_like ':!foo(3)', X::Syntax::NegatedPair, key => 'foo';
throws_like 'my $0', X::Syntax::Variable::Numeric;
throws_like 'my sub f($0) { }', X::Syntax::Variable::Numeric, what => 'parameter';
throws_like 'my $<a>', X::Syntax::Variable::Match;
throws_like 'my class A { my $!foo }', X::Syntax::Variable::Twigil, twigil => '!', scope => 'my';
#RT #86880
throws_like 'role Breakable { my $!broken = Bool::False; }; class Frobnitz does Breakable {};',
    X::Syntax::Variable::Twigil, twigil => '!', scope => 'my';
throws_like 'my $?FILE', X::Syntax::Variable::Twigil, twigil => '?', scope => 'my';
throws_like 'my $::("foo")', X::Syntax::Variable::IndirectDeclaration;
throws_like '@a', X::Undeclared, symbol => '@a';
# RT #115396
throws_like '"@a[]"', X::Undeclared, symbol => '@a';
throws_like 'augment class Any { }', X::Syntax::Augment::WithoutMonkeyTyping;
throws_like 'use MONKEY_TYPING; augment role Positional { }', X::Syntax::Augment::Illegal;
throws_like 'use MONKEY_TYPING; enum Weekday <Mon Tue>; augment class Weekday { }', X::Syntax::Augment::Illegal;
throws_like 'sub postbla:sym<foo>() { }', X::Syntax::Extension::Category, category => 'postbla';
# RT #73938
throws_like 'sub twigil:<@>() { }', X::Syntax::Extension::Category, category => 'twigil';
throws_like 'sub infix:sym< >() { }', X::Syntax::Extension::Null;
# RT #83992
throws_like 'my @a = 1, => 2', X::Syntax::InfixInTermPosition, infix => '=>';
throws_like 'sub f(:in(:$in)) { }', X::Signature::NameClash, name => 'in';
throws_like '(my $foo) does Int', X::Does::TypeObject;
throws_like '(my $foo) does Int, Bool', X::Does::TypeObject;
# RT #76742
#?rakudo.jvm 5 todo "?"
throws_like 'Bool does role { method Str() { $.perl } };', X::Does::TypeObject;
throws_like 'my role R { }; 99 but R("wrong");', X::Role::Initialization;
throws_like 'my role R { has $.x; has $.y }; 99 but R("wrong");', X::Role::Initialization;
throws_like 'my role R { }; 99 does R("wrong");', X::Role::Initialization;
throws_like 'my role R { has $.x; has $.y }; 99 does R("wrong");', X::Role::Initialization;
# RT #73806
throws_like q[if() {}], X::Comp::Group, sorrows => sub (@s) { @s[0] ~~ X::Syntax::KeywordAsFunction};

# RT #78404
throws_like q[my grammar G { regex foo { } }], X::Syntax::Regex::NullRegex;
throws_like q[/ /], X::Syntax::Regex::NullRegex;
throws_like q[/ a | /], X::Syntax::Regex::NullRegex;
throws_like q[/ a || /], X::Syntax::Regex::NullRegex;
throws_like q[/ a & /], X::Syntax::Regex::NullRegex;
# RT 67554
throws_like q{/ [] /}, X::Syntax::Regex::NullRegex;
throws_like q{/ | /}, X::Syntax::Regex::NullRegex;
# RT #82142
throws_like q{s//b/}, X::Syntax::Regex::NullRegex;


throws_like 'sub f($a?, $b) { }', X::Parameter::WrongOrder,
    misplaced   => 'required',
    after       => 'optional';
throws_like 'sub f(*@a, $b) { }', X::Parameter::WrongOrder,
    misplaced   => 'required',
    after       => 'variadic';
throws_like 'sub f(*@a, $b?) { }', X::Parameter::WrongOrder,
    misplaced   => 'optional positional',
    after       => 'variadic';

#?rakudo todo 'parsing regression'
throws_like '#`', X::Syntax::Comment::Embedded;
# RT #71814
throws_like "=begin\n", X::Syntax::Pod::BeginWithoutIdentifier, line => 1, filename => rx/EVAL/;

for <
  $ @ % &
  $^A $^B $^C $^D $^E $^F $^G $^H $^I $^J $^K $^L $^M
  $^N $^O $^P $^Q $^R $^S $^T $^U $^V $^W $^X $^Y $^Z
  $* $" $$ $) $; $& $` $' $| $? $@ $[ $]
  $: $- $+ $= $% $^ $~ @- @+ %- %+ %!
> {
    throws_like $_, X::Syntax::Perl5Var;
}

#?rakudo 2 todo 'still handled by <special_var>'
throws_like '$<', X::Syntax::Perl5Var;
throws_like '$#', X::Syntax::Perl5Var;
throws_like '$>', X::Syntax::Perl5Var;

eval_lives_ok 'class frob { has @!bar; method test { return $@!bar } }', 'uses of $@!bar not wrongfully accused of using old $@ variable';

throws_like '1∞', X::Syntax::Confused;
throws_like 'for 1, 2', X::Syntax::Missing, what => 'block';
throws_like 'my @a()', X::Syntax::Reserved, reserved => /shape/ & /array/;
throws_like 'my &a()', X::Syntax::Reserved, instead  => /':()'/;

# RT #115922
throws_like '"\u"', X::Backslash::UnrecognizedSequence, sequence => 'u';
throws_like '"$"', X::Backslash::NonVariableDollar;

throws_like 'm:i(@*ARGS[0])/foo/', X::Value::Dynamic;

throws_like 'self', X::Syntax::Self::WithoutObject;
throws_like 'class { has $.x = $.y }', X::Syntax::VirtualCall, call => '$.y';
throws_like '$.a', X::Syntax::NoSelf, variable => '$.a';
# RT #59118
throws_like 'my class B0Rk { $.a }',  X::Syntax::NoSelf, variable => '$.a';

throws_like 'has $.x', X::Attribute::NoPackage;
throws_like 'my module A { has $.x }', X::Attribute::Package, package-kind => 'module';

throws_like 'has sub a() { }', X::Declaration::Scope, scope => 'has', declaration => 'sub';
throws_like 'has package a { }', X::Declaration::Scope, scope => 'has', declaration => 'package';
throws_like 'our multi a() { }', X::Declaration::Scope::Multi, scope => 'our';
throws_like 'multi sub () { }', X::Anon::Multi, multiness => 'multi';
throws_like 'proto sub () { }', X::Anon::Multi, multiness => 'proto';
throws_like 'class { multi method () { }}', X::Anon::Multi, routine-type => 'method';
throws_like 'use MONKEY_TYPING; augment class { }', X::Anon::Augment, package-kind => 'class';
throws_like 'use MONKEY_TYPING; augment class NoSuchClass { }', X::Augment::NoSuchType,
    package-kind => 'class',
    package => 'NoSuchClass';
throws_like 'use MONKEY_TYPING; augment class No::Such::Class { }', X::Augment::NoSuchType,
    package => 'No::Such::Class';

throws_like ':45<abcd>', X::Syntax::Number::RadixOutOfRange, radix => 45;
throws_like ':0<0>', X::Syntax::Number::RadixOutOfRange, message => rx/0/;
throws_like 'rx:g/a/',   X::Syntax::Regex::Adverb, adverb => 'g', construct => 'rx';
throws_like 'my sub f($x, $y:) { }', X::Syntax::Signature::InvocantMarker;

throws_like 'Date.new("2012-02-30")', X::OutOfRange,
    range => Range, message => rx/<<1\.\.29>>/;
throws_like 'DateTime.new(year => 2012, month => 5, day => 22, hour => 18, minute => 3, second => 60)',
            X::OutOfRange, comment => /'leap second'/;
throws_like 'use fatal; "foo"[2]', X::OutOfRange, what => rx:i/index/, range => 0..0, got => 2;

throws_like 'sub f() { }; &f.unwrap("foo")', X::Routine::Unwrap;

# X::Constructor::Positional
{
    class Foo { };
    throws_like 'Mu.new(1)',         X::Constructor::Positional, type => Mu;
    throws_like 'Foo.new(1, 2, 3);', X::Constructor::Positional, type => Foo;
}

throws_like 'my %h = 1', X::Hash::Store::OddNumber;

# TOOD: might be X::Syntax::Malformed too...
throws_like 'sub foo;', X::Syntax::Missing, what => 'block';
# RT #75776
throws_like 'my $d; my class A {method x { $d }}; for () { sub }', X::Syntax::Missing, what => 'block';
throws_like 'constant foo;', X::Syntax::Missing, what => /initializer/;
throws_like 'constant * = 3;', X::Syntax::Missing, what => /constant/;
throws_like '1 <=> 2 <=> 3', X::Syntax::NonAssociative, left => '<=>', right => '<=>';

throws_like 'my class A {...}; my grammar B { ... }', X::Package::Stubbed, packages => <A B>;

throws_like 'my sub a { PRE 0  }; a()', X::Phaser::PrePost, phaser => 'PRE', condition => /0/;
#?rakudo.jvm todo 'RT #121935'
throws_like 'my sub a { POST 0 }; a()', X::Phaser::PrePost, phaser => 'POST', condition => /0/;

throws_like 'use fatal; my $x = "5 foo" + 8;', X::Str::Numeric, source => '5 foo', pos => 1,
            reason => /trailing/;
throws_like '"a".match(:x([1, 2, 3]), /a/).Str', X::Str::Match::x, got => Array;
throws_like '"a".trans([Any.new] => [Any.new])', X::Str::Trans::IllegalKey, key => Any;
throws_like '"a".trans(rx/a/)', X::Str::Trans::InvalidArg, got => Regex;

throws_like '1.foo',  X::Method::NotFound, method => 'foo', typename => 'Int';
throws_like '1.+foo', X::Method::NotFound, method => 'foo', typename => 'Int';
throws_like 'my class Priv { method x { self!foo } }; Priv.x',
                      X::Method::NotFound,
                      method    => 'foo',
                      typename  => 'Priv',
                      private   => { $_ === True };
# RT #77582
throws_like 'my %h; %h.nosuchmethods', X::Method::NotFound, typename => 'Hash';

throws_like '1.List::join', X::Method::InvalidQualifier,
            method         => 'join',
            invocant       => 1,
            qualifier-type => List;

# RT #58558
throws_like '!!! 42', X::AdHoc, payload => 42;
throws_like 'use fatal; ... 42', X::AdHoc, payload => 42;
{
    my $c = 0;
    try {
        ??? 42;
        CONTROL { default { $c++ } }
    }
    is $c, 1, '??? with argument warns';
}

throws_like 'die "foo"', X::AdHoc, backtrace => Backtrace;
throws_like 'use fatal; ~(1, 2, 6 ... 10)', X::Sequence::Deduction;

throws_like 'my class B does Int { }', X::Composition::NotComposable, target-name => 'B', composer => Int;
throws_like 'my Str $x := 3', X::TypeCheck::Binding, got => Int, expected => Str;
throws_like 'sub f() returns Str { 5 }; f', X::TypeCheck::Return, got => Int, expected => Str;
throws_like 'my Int $x = "foo"', X::TypeCheck::Assignment, got => 'foo',
            expected => Int, symbol => '$x';

throws_like 'sub f() { 42 }; f() = 3', X::Assignment::RO;
throws_like '1.0 = 3', X::Assignment::RO;
# RT #113534
throws_like '120 = 3', X::Assignment::RO;
throws_like '1e0 = 3', X::Assignment::RO;
throws_like '"a" = 3', X::Assignment::RO;

throws_like '1.foo', X::Method::NotFound, method => 'foo', typename => 'Int';
throws_like 'my class NC { }; NC.new does NC', X::Mixin::NotComposable,
            :target(*.defined), :rolish(*.^name eq 'NC');
throws_like 'my class NC { }; NC.new but  NC', X::Mixin::NotComposable,
            :target(*.defined), :rolish(*.^name eq 'NC');

throws_like 'last', X::ControlFlow,
            illegal => 'last', enclosing => 'loop construct';
throws_like 'next', X::ControlFlow,
            illegal => 'next', enclosing => 'loop construct';
throws_like 'redo', X::ControlFlow,
            illegal => 'redo', enclosing => 'loop construct';

throws_like 'my package A { }; my class B is A { }', X::Inheritance::Unsupported;

throws_like 'my module Expo { sub f is export { }; { sub f is export { } } }',
                X::Export::NameClash, symbol => '&f';

# RT #113408
throws_like '<a b> »+« <c>', X::HyperOp::NonDWIM,
            left-elems => 2, right-elems => 1,
            operator => { .name eq 'infix:<+>' };

throws_like 'my sub f() { gather { return } }; ~f()', X::ControlFlow::Return;

throws_like 'DateTime.new("2012/04")', X::Temporal::InvalidFormat,
            invalid-str => '2012/04',
            target      => 'DateTime';

throws_like 'Date.new("2012/04")', X::Temporal::InvalidFormat,
            invalid-str => '2012/04',
            target      => 'Date';

throws_like 'EVAL("foo", :lang<no-such-language>)',
           X::Eval::NoSuchLang,
           lang => 'no-such-language';

throws_like 'DateTime.new("1998-12-31T23:59:60+0200", :timezone<Z>)', X::DateTime::TimezoneClash;

throws_like 'use fatal; (1+2i).Num',  X::Numeric::Real, target => Num;
throws_like 'use fatal; (1+2i).Real', X::Numeric::Real, target => Real;

#RT #114134
{
throws_like 'my class A {}; (-> &c, $m { A.new()(); CATCH { default { $m } } } )(A, "")', X::TypeCheck::Binding;

dies_ok {EVAL(class A{}; (-> &c, $m { A.new()(); CATCH { default { $m } } } )(A, "")) }, "Should fail type check with unbound variable";
}

# RT #75640
# cannot use dies_ok, because it puts the call in the dynamic scope of a
# dispatcher
try {
    proto a() { nextsame };
    a();
}
ok $! ~~ X::NoDispatcher, 'nextsame in proto';

# probably not quite spec, but good enough for now
# RT #79162
throws_like '["a" "b"]', X::Syntax::Confused, reason => 'Two terms in a row';

# similarly RT #79002
throws_like 'my class A { has $.a syntax error; }', X::Syntax::Confused;

# another X::Syntax::Confused, RT #115964
throws_like 'my $bar = "test"; my $foo = { given $bar { when Real { 1 } when Str { 2 } } };' , X::Syntax::Confused;

# suggestions
my $emits_suggestions = False;
{
    try EVAL('my $foo = 10; say $Foo');
    $emits_suggestions = True if $!.^can("suggestions");
}

if $emits_suggestions {
    throws_like 'my $foo = 10; say $Foo;', X::Undeclared, suggestions => '$foo';
    throws_like 'my @barf = 1, 2, 3; say $barf[2]', X::Undeclared, suggestions => '@barf';

    throws_like 'my $intergalactic-planetary = "planetary intergalactic"; say $IntergalacticPlanetary', X::Undeclared, suggestions => '$intergalactic-planetary';

    throws_like 'my class Foo is Junktion {}', X::Inheritance::UnknownParent, suggestions => 'Junction';
    throws_like 'my class Bar is junction {}', X::Inheritance::UnknownParent, suggestions => 'Junction';
    throws_like 'my class Baz is Juntcion {}', X::Inheritance::UnknownParent, suggestions => 'Junction';

    {
        try EVAL('say &huc("foo")');
        ok $! ~~ X::Undeclared::Symbols, "&huc throws X::Undeclared::Symbols";
        is $!.routine_suggestion<&huc>, ["&uc"], '&uc is a suggestion';
    }

    {
        try EVAL('say huc("foo")');
        ok $! ~~ X::Undeclared::Symbols, "huc throws X::Undeclared::Symbols";
        is $!.routine_suggestion<huc>, ["uc"], 'uc is a suggestion';
    }

    try EVAL('toolongtomatchanything()');
    is +($!.routine_suggestion<toolongtomatchanything>), 0, "no suggestions for a strange name";
    ok $!.message !~~ /Did you mean/, "doesn't show suggestions if there are none.";

    try EVAL('my class TestClassFactoryInterfaceBridgeMock is TooLongOfANameToBeConsideredGoodPerl { }');
    is +($!.suggestions), 0, "no suggestions for a strange class";
    ok $!.message !~~ /Did you mean/, "doesn't show suggestions if there are none.";

    try EVAL('$i-just-made-this-up = "yup"');
    is +($!.suggestions), 0, "no suggestions for a strange variable";
    ok $!.message !~~ /Did you mean/, "doesn't suggest if there's no suggestions.";

    throws_like 'sub yoink(Junctoin $barf) { }', X::Parameter::InvalidType, suggestions => 'Junction';

    {
        try EVAL('my cool $a');
        ok $! ~~ X::Comp::Group, 'my cool $a throws an X::Comp::Group.';
        ok $!.sorrows[0] ~~ X::Undeclared, "the first sorrow is X::Undeclared.";
        is $!.sorrows[0].suggestions, <Cool Bool>, "the suggestions are Cool and Bool";
    }

    {
        try EVAL('Ecxeption.new("wrong!")');
        ok $! ~~ X::Undeclared::Symbols, "Ecxeption.new throws X::Undeclared::Symbols";
        is $!.type_suggestion<Ecxeption>, ["Exception"], 'Exception is a suggestion';
    }
}

# RT 77270
throws_like 'sub foo(--> NoSuchType) { }; foo', X::Undeclared, what => { m/'Type'/ }, symbol => { m/'NoSuchType'/ };

throws_like 'my class Foobar is Foobar', X::Inheritance::SelfInherit, name => "Foobar";

{
    # RT #69760
    my $code = q{class GrammarUserClass { method bar { PostDeclaredGrammar.parse('OH HAI'); } }; grammar PostDeclaredGrammar { rule TOP { .* } }; GrammarUserClass.bar;};
    throws_like $code, X::Undeclared::Symbols, post_types => { .{"PostDeclaredGrammar"} :exists };
}

{
    throws_like q{if 10 > 5 { say "maths works!" } else if 10 == 5 { say "identity is weird" } else { say "math is weird" }}, X::Syntax::Malformed::Elsif;
}

{
    # RT #72958
    throws_like q{1/2.''()}, X::Method::NotFound, method => '', typename => 'Int';
}

#?rakudo.jvm todo "?"
{
    # RT #78314
    throws_like q{role Bottle[::T] { method Str { "a bottle of {T}" } }; class Wine { ... }; say Bottle[Wine].new;}, X::Package::Stubbed;
}

throws_like q[sub f() {CALLER::<$x>}; my $x; f], X::Caller::NotDynamic, symbol => '$x';

# RT #116547
{
    try EVAL('my ($abe, $ba, $abc); $abd');
    diag $!.message;
    ok $!.message ~~ /'Did you mean'/, "Doesn't explode";
}

# RT #76368
{
    throws_like q[ sub foo(Str) { }; foo 42; ], X::TypeCheck::Argument;

    throws_like q[ proto sub foo(Str) {*}; foo 42; ], X::TypeCheck::Argument, protoguilt => { $_ };

    {
        my $code = q[ sub foo($x) { }; foo; ];
        throws_like $code, X::TypeCheck::Argument, message => { m/"requires argument"/ }, objname => { m/foo/ };
    }

    {
        my $code = q[ sub foo(Str) { }; foo 42; ];
        throws_like $code, X::TypeCheck::Argument, 
            signature => rx/ 'Expected' .+ 'Str' /, 
            arguments => { .[0] eq "int" };
    }

    {
        my $code = q[ sub foo(Int $x, Str $y) { }; foo "not", 42; ];
        throws_like $code, X::TypeCheck::Argument, 
            arguments => { .[0] ~ .[1] eq "StrInt" },
            signature => rx/ 'Expected' .+ 'Int $x, Str $y' /;
    }
}

# RT #78012
throws_like 'my class A { method b { Q<b> } }; my $a = A.new; my $b = &A::b.assuming($a); $b();',
    X::Method::NotFound, method => { m/'assuming'/ }, private => { $_ === False };

# RT #98854
throws_like 'sub f { f(|$) }', X::Obsolete,
    old => { m/'$) variable'/ }, replacement => { m/'$*EGID'/ }, when => { m/'in Perl 6'/ };

# RT #66776
throws_like 'for 1,2,3, { say 3 }', X::Comp::Group, 
    sorrows => sub (@s) { @s[0] ~~ X::Syntax::BlockGobbled && @s[0].message ~~ /^Expression/ },
    panic => sub ($p) { $p ~~ X::Syntax::Missing && $p.what ~~ /^block/ }; 

# RT #66776
throws_like 'CATCH { when X::Y {} }', X::Comp::Group,
    sorrows => sub (@s) { @s[0] ~~ X::Syntax::BlockGobbled && @s[0].what ~~ /'X::Y'/ },
    panic => sub ($p) { $p ~~ X::Syntax::Missing && $p.what ~~ /^block/ };

# RT #75230
throws_like 'say 1 if 2 if 3 { say 3 }', X::Syntax::Confused, 
    reason => { m/'Missing semicolon.'/ }, pre => { m/'1 if 2 '/ }, post => { m/'if 3 { say 3 }'/ }, highexpect => @('postfix');

# RT #77522
throws_like '/\ X/', X::Syntax::Regex::Unspace, 
    message => { m/'No unspace allowed in regex' .+ '(\' \')' .+ '\x20'/ }, char => { m/' '/ };
    
# RT #77380
throws_like '/m ** 1..-1/', X::Comp::Group, 
    panic => { .payload ~~ m!'Unable to parse regex; couldn\'t find final \'/\''! },
    sorrows => { .[0] => { $_ ~~ X::Syntax::Regex::MalformedRange } and .[1] => { $_ ~~ X::Syntax::Regex::UnrecognizedMetachar } };

# RT #122502
throws_like '/m ** 1 ..2/', X::Syntax::Regex::SpacesInBareRange,
    pre => { m!'/m ** 1 ..'! },
    post => { m!'2/'! };

# RT #115726
throws_like 'sub infix:<> (){}', X::Comp::Group,
    panic => { $_ ~~ X::Syntax::Extension::Null and .pre ~~ m/'sub infix:<> '/ and .post ~~ m/'()'/ },
    worries => { .[0].payload ~~ m/'Pair with <> really means an empty list, not null string; use :(\'\') to represent the null string,' \n '  or :() to represent the empty list more accurately'/ };

done;

# vim: ft=perl6
