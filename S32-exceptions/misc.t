use v6;

use lib "t/spec/packages";

use Test;
use Test::Util;

plan 406;

throws-like '42 +', Exception, "missing rhs of infix", message => rx/term/;

#?DOES 1
throws-like { Buf.new().Str }, X::Buf::AsStr, method => 'Str';;
throws-like 'use experimental :pack; pack("B",  1)',       X::Buf::Pack, directive => 'B';
throws-like 'use experimental :pack; Buf.new.unpack("B")', X::Buf::Pack, directive => 'B';
throws-like 'use experimental :pack; pack "A2", "mÄ"',     X::Buf::Pack::NonASCII, char => 'Ä';
throws-like 'my class Foo { method a() { $!bar } }', X::Attribute::Undeclared,
            symbol => '$!bar', package-name => 'Foo', package-kind => 'class',
            what => 'attribute';
throws-like 'sub f() { $^x }', X::Signature::Placeholder,
            line => 1,
            placeholder => '$^x',
            ;

throws-like 'qr/a/', X::Obsolete, old => rx/<<qr>>/, replacement => rx/<<rx>>/;
throws-like '"a" . "b"', X::Obsolete, replacement => '~';
throws-like 's/a/b/i', X::Obsolete;
# RT #112470
throws-like 'my $a; ${a} = 5', X::Obsolete;

throws-like 'do    { $^x }', X::Placeholder::Block, placeholder => '$^x';
throws-like 'do    { @_  }', X::Placeholder::Block, placeholder => '@_';
throws-like 'class { $^x }', X::Placeholder::Block, placeholder => '$^x';
# RT #76956
throws-like '$^x',           X::Placeholder::Mainline, placeholder => '$^x';
# RT #73502
throws-like '@_',            X::Placeholder::Mainline, placeholder => '@_';
# RT #85942
throws-like '"foo".{ say $^a }', X::Placeholder::Mainline;
# RT #78112
throws-like 'class RT78112 { has $.a = $^b + 1; }', X::Placeholder::Attribute, placeholder => '$^b';

throws-like 'sub f(*@ = 2) { }', X::Parameter::Default, how => 'slurpy', parameter => *.not;
throws-like 'sub f($x! = 3) { }', X::Parameter::Default, how => 'required', parameter => '$x';
throws-like 'sub f(:$x! = 3) { }', X::Parameter::Default, how => 'required';
throws-like 'sub f($:x) { }',  X::Parameter::Placeholder,
        parameter => '$:x',
        right     => ':$x';
throws-like 'sub f($?x) { }',  X::Parameter::Twigil,
        parameter => '$?x',
        twigil    => '?';
throws-like 'sub (Int Str $x) { }', X::Parameter::MultipleTypeConstraints;


# RT #123834
throws-like 'sub f($x = 60 is rw) { }', X::Parameter::AfterDefault, type => 'trait';
throws-like 'sub f($x = 60 where Int) { }', X::Parameter::AfterDefault, type => 'post constraint';



# some of these redeclaration errors take different code
# paths in rakudo, so we over-test a bit to catch them all,
# even if the tests look rather boring;
throws-like 'sub a { }; sub a { }',X::Redeclaration, symbol => 'a', what => 'routine';
# RT #78370
throws-like 'my &a; multi a { }', X::Redeclaration, symbol => 'a', what => 'routine';
throws-like 'sub a { }; multi sub a { }',X::Redeclaration, symbol => 'a', what => 'routine';
throws-like 'my class A { }; my class A { }',  X::Redeclaration, symbol => 'A';
throws-like 'my class B { }; my subset B of Any;', X::Redeclaration, symbol => 'B';
throws-like 'CATCH { }; CATCH { }', X::Phaser::Multiple, block => 'CATCH';
# multiple return types
throws-like 'sub f(--> List) returns Str { }', X::Redeclaration;
throws-like 'my Int sub f(--> Str) { }', X::Redeclaration;
# RT #115356
throws-like 'my class F { }; role F { }', X::Redeclaration, symbol => 'F';

throws-like 'my class A { my @a; @a!List::foo() }',
    X::Method::Private::Permission,
    method          => 'foo',
    calling-package => 'A',
    source-package  => 'List';

throws-like '1!foo()',
    X::Method::Private::Unqualified,
    method          => 'foo';

throws-like 'sub f() { }; f() := 2', X::Bind;
throws-like 'OUTER := 5', X::Bind, target => /OUTER/;
throws-like 'my int $x := 2', X::Bind::NativeType, name => '$x';
throws-like 'my @a; @a[] := <foo bar baz>', X::Bind::ZenSlice, type => Array;
throws-like 'my %a; %a{} := foo=>1, bar=>2, baz=>3', X::Bind::ZenSlice, type => Hash;
throws-like 'my @a; @a[0, 1] := (2, 3)', X::Bind::Slice, type => Array;
throws-like 'my %a; %a<a b> := (2, 3)', X::Bind::Slice, type => Hash;


throws-like 'for (1; 1; 1) { }', X::Obsolete,
    old         => rx/<<for>>/,
    replacement => rx/<<loop>>/;
throws-like 'foreach (1..10) { }', X::Obsolete,
    old         => "'foreach'",
    replacement => "'for'";
throws-like 'undef', X::Obsolete,
    old         => rx/<<undef>>/;
# RT #77118
{
    throws-like '<>', X::Obsolete, old => "<>";
}
# RT #92408
throws-like 'my ($a, $b); $a . $b', X::Obsolete;

throws-like 'my $a::::b', X::Syntax::Name::Null;
throws-like 'unless 1 { } else { }', X::Syntax::UnlessElse;
throws-like 'unless 1 { } elsif 42 { }', X::Syntax::UnlessElse;
throws-like 'for my $x (1, 2, 3) { }', X::Syntax::P5;
throws-like ':!foo(3)', X::Syntax::NegatedPair, key => 'foo';
throws-like 'my $0', X::Syntax::Variable::Numeric;
throws-like 'my sub f($0) { }', X::Syntax::Variable::Numeric, what => 'parameter';
throws-like 'my $<a>', X::Syntax::Variable::Match;
throws-like 'my class A { my $!foo }', X::Syntax::Variable::Twigil, twigil => '!', scope => 'my';
#RT #86880
throws-like 'role Breakable { my $!broken = Bool::False; }; class Frobnitz does Breakable {};',
    X::Syntax::Variable::Twigil, twigil => '!', scope => 'my';
throws-like 'my $?FILE', X::Syntax::Variable::Twigil, twigil => '?', scope => 'my';
# RT #125780
throws-like 'constant $?FILE = "foo"', X::Comp::NYI;
throws-like 'my $::("foo")', X::Syntax::Variable::IndirectDeclaration;
throws-like '@a', X::Undeclared, symbol => '@a';
# RT #115396
throws-like '"@a[]"', X::Undeclared, symbol => '@a';
throws-like 'augment class Any { }', X::Syntax::Augment::WithoutMonkeyTyping;
throws-like '{ use MONKEY-TYPING; }; augment class Any { }', X::Syntax::Augment::WithoutMonkeyTyping,
    'MONKEY-TYPING applies lexically';
throws-like 'use MONKEY-TYPING; augment role Positional { }', X::Syntax::Augment::Illegal;
throws-like 'sub postbla:sym<foo>() { }', X::Syntax::Extension::Category, category => 'postbla';
# RT #73938
throws-like 'sub twigil:<@>() { }', X::Syntax::Extension::Category, category => 'twigil';
throws-like 'sub infix:sym< >() { }', X::Syntax::Extension::Null;
# RT #83992
throws-like 'my @a = 1, => 2', X::Syntax::InfixInTermPosition, infix => '=>';
throws-like 'sub f(:in(:$in)) { }', X::Signature::NameClash, name => 'in';
throws-like '(my $foo) does Int', X::Does::TypeObject;
throws-like '(my $foo) does Int, Bool', X::Does::TypeObject;
# RT #76742
throws-like 'Bool does role { method Str() { $.perl } };', X::Does::TypeObject;
throws-like 'my role R { }; 99 but R("wrong");', X::Role::Initialization;
throws-like 'my role R { has $.x; has $.y }; 99 but R("wrong");', X::Role::Initialization;
throws-like 'my role R { }; 99 does R("wrong");', X::Role::Initialization;
throws-like 'my role R { has $.x; has $.y }; 99 does R("wrong");', X::Role::Initialization;
# RT #73806
throws-like q[if() {}], X::Comp::Group, sorrows => sub (@s) { @s[0] ~~ X::Syntax::KeywordAsFunction};
# RT #125812
throws-like q[with() {}], X::Comp::Group, sorrows => sub (@s) { @s[0] ~~ X::Syntax::KeywordAsFunction};
throws-like q[without() {}], X::Comp::Group, sorrows => sub (@s) { @s[0] ~~ X::Syntax::KeywordAsFunction};

# RT #78404
throws-like q[my grammar G { regex foo { } }], X::Syntax::Regex::NullRegex;
throws-like q[/ /], X::Syntax::Regex::NullRegex;
throws-like q[/ a | /], X::Syntax::Regex::NullRegex;
throws-like q[/ a || /], X::Syntax::Regex::NullRegex;
throws-like q[/ a & /], X::Syntax::Regex::NullRegex;
# RT #67554
throws-like q{/ [] /}, X::Syntax::Regex::NullRegex;
throws-like q{/ | /}, X::Syntax::Regex::NullRegex;
# RT #71800
throws-like q{/ () /}, X::Syntax::Regex::NullRegex;
# RT #82142
throws-like q{s//b/}, X::Syntax::Regex::NullRegex;


throws-like 'sub f($a?, $b) { }', X::Parameter::WrongOrder,
    misplaced   => 'required',
    after       => 'optional';
throws-like 'sub f(*@a, $b) { }', X::Parameter::WrongOrder,
    misplaced   => 'required',
    after       => 'variadic';
throws-like 'sub f(*@a, $b?) { }', X::Parameter::WrongOrder,
    misplaced   => 'optional positional',
    after       => 'variadic';

#?rakudo todo 'parsing regression RT #124679'
{
    throws-like '#`', X::Syntax::Comment::Embedded;
}

# RT #71814
throws-like "=begin\n", X::Syntax::Pod::BeginWithoutIdentifier, line => 1, filename => rx/EVAL/;

for <
  $^A $^B $^C $^D $^E $^F $^G $^H $^I $^J $^K $^L $^M
  $^N $^O $^P $^Q $^R $^S $^T $^U $^V $^W $^X $^Y $^Z
  $* $" $$ $; $& $` $' $, $. $\ $| $? $@ $]
  $: $= $% $^ $~ @- @+ %- %+ %!
> {
    throws-like "$_ = 1;", X::Syntax::Perl5Var, "Did $_ throw Perl5Var?";
}

#?rakudo todo 'awesome error message is not printed because these are parsed differently'
for qw{ $( $) $< $> $/ $[ $- $+ } {
    throws-like "$_ = 1;", X::Syntax::Perl5Var, "Did $_ throw Perl5Var?";
}

#?rakudo todo 'good error message, but not the one that we are expecting'
for '$#' {
    throws-like "$_ = 1;", X::Syntax::Perl5Var, "Did $_ throw Perl5Var?";
}

throws-like '$#foo', X::Obsolete;
# RT #122645
lives-ok { EVAL '$@' }, '$@ is no longer a problem';

# RT #123884
throws-like '$\\ = 1;', X::Syntax::Perl5Var, message => /'.nl-out'/, "Error message for \$\\ mentions .nl-out";

throws-like '$/ = "\n\n";', X::Syntax::Perl5Var, message => /'.nl-in'/, "Error message for \$/ mentions .nl-in";

throws-like { EVAL '"$"' }, X::Backslash::NonVariableDollar, 'non-variable $ in double quotes requires backslash';
lives-ok { EVAL 'class frob { has @!bar; method test { return $@!bar } }' },
  'uses of $@!bar not wrongfully accused of using old $@ variable';

throws-like '1∞', X::Syntax::Confused;
throws-like 'for 1, 2', X::Syntax::Missing, what => 'block';
throws-like 'my @a()', X::Syntax::Reserved, reserved => /shape/ & /array/;
throws-like 'my &a()', X::Syntax::Reserved, instead  => /':()'/;

# RT #115922
throws-like '"\u"', X::Backslash::UnrecognizedSequence, sequence => 'u';

throws-like 'm:i(@*ARGS[0])/foo/', X::Value::Dynamic;

throws-like 'self', X::Syntax::Self::WithoutObject;
throws-like 'class { has $.x = $.y }', X::Syntax::VirtualCall, call => '$.y';
throws-like '$.a', X::Syntax::NoSelf, variable => '$.a';
# RT #59118
throws-like 'my class B0Rk { $.a }',  X::Syntax::NoSelf, variable => '$.a';

throws-like 'has $.x', X::Attribute::NoPackage;
throws-like 'my module A { has $.x }', X::Attribute::Package, package-kind => 'module';

# RT #115362
throws-like 'package Y { has $.foo }', X::Attribute::Package, package-kind => 'package';

throws-like 'has sub a() { }', X::Declaration::Scope, scope => 'has', declaration => 'sub';
throws-like 'has package a { }', X::Declaration::Scope, scope => 'has', declaration => 'package';
throws-like 'our multi a() { }', X::Declaration::Scope::Multi, scope => 'our';
throws-like 'multi sub () { }', X::Anon::Multi, multiness => 'multi';
throws-like 'proto sub () { }', X::Anon::Multi, multiness => 'proto';
throws-like 'class { multi method () { }}', X::Anon::Multi, routine-type => 'method';
throws-like 'use MONKEY-TYPING; augment class { }', X::Anon::Augment, package-kind => 'class';
throws-like 'use MONKEY-TYPING; augment class NoSuchClass { }', X::Augment::NoSuchType,
    package-kind => 'class',
    package => 'NoSuchClass';
throws-like 'use MONKEY-TYPING; augment class No::Such::Class { }', X::Augment::NoSuchType,
    package => 'No::Such::Class';

throws-like ':45<abcd>', X::Syntax::Number::RadixOutOfRange, radix => 45;
throws-like ':0<0>', X::Syntax::Number::RadixOutOfRange, message => rx/0/;
throws-like 'rx:g/a/',   X::Syntax::Regex::Adverb, adverb => 'g', construct => 'rx';
throws-like 'my sub f($x, $y:) { }', X::Syntax::Signature::InvocantMarker;

throws-like 'Date.new("2012-02-30")', X::OutOfRange,
    range => Range, message => rx/<<1\.\.29>>/;
throws-like 'DateTime.new(year => 2012, month => 5, day => 22, hour => 18, minute => 3, second => 60)',
            X::OutOfRange, comment => /'leap second'/;
throws-like 'use fatal; "foo"[2]', X::OutOfRange, what => rx:i/index/, range => '0..0', got => 2;

throws-like 'sub f() { }; &f.unwrap("foo")', X::Routine::Unwrap;

# X::Constructor::Positional
{
    class Foo { };
    throws-like 'Mu.new(1)',         X::Constructor::Positional, type => Mu;
    throws-like 'Foo.new(1, 2, 3);', X::Constructor::Positional, type => Foo;
}

throws-like 'my %h = 1', X::Hash::Store::OddNumber;

# TOOD: might be X::Syntax::Malformed too...
throws-like 'sub foo;', X::UnitScope::Invalid, what => 'sub';
# RT #75776
throws-like 'my $d; my class A {method x { $d }}; for () { sub }', X::Syntax::Missing, what => 'block';
throws-like 'constant foo;', X::Syntax::Missing, what => /initializer/;
throws-like 'constant * = 3;', X::Syntax::Missing, what => /constant/;
throws-like '1 <=> 2 <=> 3', X::Syntax::NonAssociative, left => '<=>', right => '<=>';

throws-like 'my class A {...}; my grammar B { ... }', X::Package::Stubbed, packages => <A B>;

throws-like 'my sub a { PRE 0  }; a()', X::Phaser::PrePost, phaser => 'PRE', condition => /0/;
throws-like 'my sub a { POST 0 }; a()', X::Phaser::PrePost, phaser => 'POST', condition => /0/;

throws-like 'use fatal; my $x = "5 foo" + 8;', X::Str::Numeric, source => '5 foo', pos => 1,
            reason => /:i trailing/;
throws-like '"a".match(:x([1, 2, 3]), /a/).Str', X::Str::Match::x, got => Array;
throws-like '"a".trans([Any.new] => [Any.new])', X::Str::Trans::IllegalKey, key => Any;
throws-like '"a".trans(rx/a/)', X::Str::Trans::InvalidArg, got => Regex;

throws-like '1.foo',  X::Method::NotFound, method => 'foo', typename => 'Int';
throws-like '1.+foo', X::Method::NotFound, method => 'foo', typename => 'Int';
throws-like 'my class Priv { method x { self!foo } }; Priv.x',
                      X::Method::NotFound,
                      method    => 'foo',
                      typename  => 'Priv',
                      private   => { $_ === True };
# RT #77582
throws-like 'my %h; %h.nosuchmethods', X::Method::NotFound, typename => 'Hash';

throws-like '1.List::join', X::Method::InvalidQualifier,
            method         => 'join',
            invocant       => 1,
            qualifier-type => List;

# RT #58558
throws-like '!!! 42', X::StubCode, message => 42;
throws-like 'use fatal; ... 42', X::StubCode, message => 42;
{
    my $c = 0;
    try {
        ??? 42;
        CONTROL { default { $c++ } }
    }
    is $c, 1, '??? with argument warns';
}

throws-like 'die "foo"', Exception, backtrace => Backtrace;
throws-like 'use fatal; ~(1, 2, 6 ... 10)', X::Sequence::Deduction;

throws-like 'my class B does Int { }', X::Composition::NotComposable, target-name => 'B', composer => Int;
throws-like 'my Str $x := 3', X::TypeCheck::Binding, got => Int, expected => Str;
throws-like 'sub f() returns Str { 5 }; f', X::TypeCheck::Return, got => Int, expected => Str;
throws-like 'sub f(--> Nil) { return 5 }; f', X::Comp, payload => /Nil/;
throws-like 'sub f(--> 42) { return 43 }; f', X::Comp, payload => /42/;
throws-like 'sub f(--> 42) { return 42 }; f', X::Comp, payload => /42/, "we don't allow args even if the same";
throws-like 'sub f(--> "foo") { return () }; f', X::Comp, payload => /'"foo"'/;
throws-like 'sub f(--> Junction) { 5 }; f', X::TypeCheck::Return, got => Int, expected => Junction;
throws-like 'my Int $x = "foo"', X::TypeCheck::Assignment, got => 'foo',
            expected => Int, symbol => '$x';
throws-like 'subset Fu of Mu where * eq "foo"; my Fu $x = "bar";', X::TypeCheck::Assignment;

throws-like 'sub f() { 42 }; f() = 3', X::Assignment::RO;
throws-like '1.0 = 3', X::Assignment::RO;
# RT #113534
throws-like '120 = 3', X::Assignment::RO;
throws-like '1e0 = 3', X::Assignment::RO;
throws-like '"a" = 3', X::Assignment::RO;

throws-like '1.foo', X::Method::NotFound, method => 'foo', typename => 'Int';
throws-like 'my class NC { }; NC.new does NC', X::Mixin::NotComposable,
            :target(*.defined), :rolish(*.^name eq 'NC');
throws-like 'my class NC { }; NC.new but  NC', X::Mixin::NotComposable,
            :target(*.defined), :rolish(*.^name eq 'NC');

throws-like 'last', X::ControlFlow,
            illegal => 'last', enclosing => 'loop construct';
throws-like 'next', X::ControlFlow,
            illegal => 'next', enclosing => 'loop construct';
throws-like 'redo', X::ControlFlow,
            illegal => 'redo', enclosing => 'loop construct';

throws-like 'my package A { }; my class B is A { }', X::Inheritance::Unsupported;

throws-like 'my module Expo { sub f is export { }; { sub f is export { } } }',
                X::Export::NameClash, symbol => '&f';

# RT #113408
throws-like '<a b> »+« <c>', X::HyperOp::NonDWIM,
            left-elems => 2, right-elems => 1,
            operator => { .name eq 'infix:<+>' };

#?rakudo.jvm skip 'UnwindException'
throws-like 'my sub f() { gather { return } }; ~f()', X::ControlFlow::Return;

throws-like 'DateTime.new("2012/04")', X::Temporal::InvalidFormat,
            invalid-str => '2012/04',
            target      => 'DateTime';

throws-like 'Date.new("2012/04")', X::Temporal::InvalidFormat,
            invalid-str => '2012/04',
            target      => 'Date';

throws-like 'EVAL("foo", :lang<no-such-language>)',
           X::Eval::NoSuchLang,
           lang => 'no-such-language';

throws-like 'DateTime.new("1998-12-31T23:59:60+0200", :timezone<Z>)', X::DateTime::TimezoneClash;

throws-like 'use fatal; (1+2i).Num',  X::Numeric::Real, target => Num;
throws-like 'use fatal; (1+2i).Real', X::Numeric::Real, target => Real;

#RT #114134
{
throws-like 'my class A {}; (-> &c, $m { A.new()(); CATCH { default { $m } } } )(A, "")', X::TypeCheck::Binding;

dies-ok {EVAL(class A{}; (-> &c, $m { A.new()(); CATCH { default { $m } } } )(A, "")) }, "Should fail type check with unbound variable";
}

# RT #75640
# cannot use dies-ok, because it puts the call in the dynamic scope of a
# dispatcher
try {
    proto a() { nextsame };
    a();
}
ok $! ~~ X::NoDispatcher, 'nextsame in proto';

# probably not quite spec, but good enough for now
# RT #79162
throws-like '["a" "b"]', X::Syntax::Confused, reason => 'Two terms in a row';

# similarly RT #79002
throws-like 'my class A { has $.a syntax error; }', X::Syntax::Confused;

# another X::Syntax::Confused, RT #115964
throws-like 'my $bar = "test"; my $foo = { given $bar { when Real { 1 } when Str { 2 } } };' , X::Syntax::Confused;

# suggestions
my $emits_suggestions = False;
{
    try EVAL('my $foo = 10; say $Foo');
    $emits_suggestions = True if $!.^can("suggestions");
}

if $emits_suggestions {
    throws-like 'my $foo = 10; say $Foo;', X::Undeclared, suggestions => '$foo';
    throws-like 'my @barf = 1, 2, 3; say $barf[2]', X::Undeclared, suggestions => '@barf';

    throws-like 'my $intergalactic-planetary = "planetary intergalactic"; say $IntergalacticPlanetary', X::Undeclared, suggestions => '$intergalactic-planetary';

    throws-like 'my class Foo is Junktion {}', X::Inheritance::UnknownParent, suggestions => 'Junction';
    throws-like 'my class Bar is junction {}', X::Inheritance::UnknownParent, suggestions => 'Junction';
    throws-like 'my class Baz is Juntcion {}', X::Inheritance::UnknownParent, suggestions => 'Junction';

    {
        try EVAL('say &huc("foo")');
        ok $! ~~ X::Undeclared::Symbols, "&huc throws X::Undeclared::Symbols";
        is $!.routine_suggestion<huc>, ["uc"], '&uc is a suggestion';
    }

    {
        try EVAL('say huc("foo")');
        ok $! ~~ X::Undeclared::Symbols, "huc throws X::Undeclared::Symbols";
        is $!.routine_suggestion<huc>, ["uc"], 'uc is a suggestion';
    }

    try EVAL('toolongtomatchanything()');
    is +($!.routine_suggestion<toolongtomatchanything>), 0, "no suggestions for a strange name";
    ok $!.message !~~ /:s Did you mean/, "doesn't show suggestions if there are none.";

    try EVAL('my class TestClassFactoryInterfaceBridgeMock is TooLongOfANameToBeConsideredGoodPerl { }');
    is +($!.suggestions), 0, "no suggestions for a strange class";
    ok $!.message !~~ /:s Did you mean/, "doesn't show suggestions if there are none.";

    try EVAL('$i-just-made-this-up = "yup"');
    is +($!.suggestions), 0, "no suggestions for a strange variable";
    ok $!.message !~~ /:s Did you mean/, "doesn't suggest if there's no suggestions.";

    throws-like 'sub yoink(Junctoin $barf) { }', X::Parameter::InvalidType, suggestions => 'Junction';

    {
        try EVAL('my cool $a');
        ok $! ~~ X::Comp::Group, 'my cool $a throws an X::Comp::Group.';
        ok $!.sorrows[0] ~~ X::Undeclared, "the first sorrow is X::Undeclared.";
        is $!.sorrows[0].suggestions.sort, <Bool Cool>, "the suggestions are Cool and Bool";
    }

    {
        try EVAL('Ecxeption.new("wrong!")');
        ok $! ~~ X::Undeclared::Symbols, "Ecxeption.new throws X::Undeclared::Symbols";
        is $!.type_suggestion<Ecxeption>, ["Exception"], 'Exception is a suggestion';
    }

    throws-like 'sub greet($name) { say "hello, $nam" }', X::Undeclared, suggestions => '$name';

    throws-like 'class Greeter { has $.name; method greet { say "hi, $name" } }', X::Undeclared, suggestions => '$!name';
}

# RT #77270
throws-like 'sub foo(--> NoSuchType) { }; foo', X::Undeclared, what => { m/'Type'/ }, symbol => { m/'NoSuchType'/ };

throws-like 'my class Foobar is Foobar', X::Inheritance::SelfInherit, name => "Foobar";

{
    # RT #69760
    my $code = q{class GrammarUserClass { method bar { PostDeclaredGrammar.parse('OH HAI'); } }; grammar PostDeclaredGrammar { rule TOP { .* } }; GrammarUserClass.bar;};
    throws-like $code, X::Undeclared::Symbols, post_types => { .{"PostDeclaredGrammar"} :exists };
}

{
    throws-like q{if 10 > 5 { say "maths works!" } else if 10 == 5 { say "identity is weird" } else { say "math is weird" }}, X::Syntax::Malformed::Elsif;
}

{
    # RT #72958
    throws-like q{1/2.''()}, X::Method::NotFound, method => '', typename => 'Int';
}

{
    # RT #78314
    throws-like q{role Bottle[::T] { method Str { "a bottle of {T}" } }; class Wine { ... }; say Bottle[Wine].new;}, X::Package::Stubbed;
}

throws-like q[sub f() {CALLER::<$x>}; my $x; f], X::Caller::NotDynamic, symbol => '$x';

# RT #116547
{
    try EVAL('my ($abe, $ba, $abc); $abd');
    diag $!.message;
    ok $!.message ~~ /'Did you mean'/, "Doesn't explode";
}

# RT #76368
{
    throws-like q[ sub foo(Str) { }; foo 42; ], X::TypeCheck::Argument;

    throws-like q[ proto sub foo(Str) {*}; foo 42; ], X::TypeCheck::Argument, protoguilt => { $_ };

    {
        my $code = q[ sub foo($x) { }; foo; ];
        throws-like $code, X::TypeCheck::Argument,
            signature => rx/ '($x)' /, 
            objname   => { m/foo/ };
    }

    {
        my $code = q[ sub foo(Str) { }; foo 42; ];
        throws-like $code, X::TypeCheck::Argument, 
            signature => rx/ '(Str)' /, 
            arguments => { .[0] eq "Int" };
    }

    {
        my $code = q[ sub foo(Int $x, Str $y) { }; foo "not", 42; ];
        throws-like $code, X::TypeCheck::Argument, 
            arguments => { .[0] ~ .[1] eq "StrInt" },
            signature => rx/ '(Int $x, Str $y)' /;
    }
}

# RT #78012
throws-like 'my class A { method b { Q<b> } }; my $a = A.new; my $b = &A::b.assuming($a); $b();',
    X::Method::NotFound, method => { m/'assuming'/ }, private => { $_ === False };

# RT #66776
throws-like 'for 1,2,3, { say 3 }', X::Comp::Group, 
    sorrows => sub (@s) { @s[0] ~~ X::Syntax::BlockGobbled && @s[0].message ~~ /^Expression/ },
    panic => sub ($p) { $p ~~ X::Syntax::Missing && $p.what ~~ /^block/ }; 

# RT #66776
throws-like 'CATCH { when X::Y {} }', X::Comp::Group,
    sorrows => sub (@s) { @s[0] ~~ X::Syntax::BlockGobbled && @s[0].what ~~ /'X::Y'/ },
    panic => sub ($p) { $p ~~ X::Syntax::Missing && $p.what ~~ /^block/ };

# RT #75230
throws-like 'say 1 if 2 if 3 { say 3 }', X::Syntax::Confused, 
    reason => { m/'Missing semicolon'/ },
    pre => { m/'1 if 2 if'/ },
    post => { m/'3 { say 3 }'/ };

# RT #77522
throws-like '/\ X/', X::Syntax::Regex::Unspace,
    message => { m/'No unspace allowed in regex' .+ '(\' \')' .+ '\x20'/ }, char => { m/' '/ };

# RT #77380
throws-like '/m ** 1..-1/', X::Comp::Group, 
    panic => { .payload ~~ m!'Unable to parse regex; couldn\'t find final \'/\''! },
    sorrows => { .[0] => { $_ ~~ X::Syntax::Regex::MalformedRange } and .[1] => { $_ ~~ X::Syntax::Regex::UnrecognizedMetachar } };

# RT #122502
throws-like '/m ** 1 ..2/', X::Syntax::Regex::SpacesInBareRange,
    pre => { m!'/m ** 1 ..'! },
    post => { m!'2/'! };

# RT #115726
throws-like 'sub infix:<> (){}', X::Comp::Group,
    panic => { $_ ~~ X::Syntax::Extension::Null and .pre ~~ m/'sub infix:<>'/ and .post ~~ m/'()'/ },
    message => /'Null operator is not allowed'/,
    worries => { .[0].payload ~~ m/'Pair with <> really means an empty list, not null string'/ };

# RT #122646
throws-like '&[doesntexist]', X::Comp, # XXX probably needs exception type fix
  'unknown operator should complain better';

# RT #72816
throws-like { $*an_undeclared_dynvar = 42 }, X::Dynamic::NotFound;

{
    my $*foo = 0;
    throws-like { EVAL '$*foo = 1; say' }, X::Comp::Group;
    is $*foo, 0, 'should be a compile time error';
}

# RT #113680
{
    throws-like { EVAL("use ThisDoesNotExistAtAll ") }, Exception;
}

# RT #116607
{
    throws-like { EVAL q[my \foo], }, X::Syntax::Term::MissingInitializer,
       message => 'Term definition requires an initializer';
}

# RT #88748
{
    throws-like { EVAL q[given 42 { when SomeUndeclaredType { 1 }; default { 0 } }] },
        X::Comp::Group,
        'adequate error message when undeclared type is used in "when" clause',
        message => { m/SomeUndeclaredType/ };
}

# RT #118067
{
    my class A is Any { proto method new($) {*} };
    throws-like { A.new(now) }, X::Multi::NoMatch,
        'no NullPMC access error but exception X::Multi::NoMatch';
}

# RT #120831
{
    throws-like 'my Int a;', X::Syntax::Malformed,
        'adequate error message when declaring "my Int a;"',
        message => { m/"Malformed my (did you mean to declare a sigilless"/ };
    throws-like 'my Int a', X::Syntax::Malformed,
        'adequate error message when declaring "my Int a"',
        message => { m/"Malformed my (did you mean to declare a sigilless"/ };
}

# RT #114014
{
    throws-like { EVAL q[ ord.Cool ] }, Exception,
        'adequate error message when calling bare "ord"';
}

# RT #123584
{
    is_run q[$; my $b;], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use of unnamed \$ variable in sink context" / }, "unnamed var in sink context warns"
}

# RT #127062
{
    is_run 'my @a = -1, 2, -3; print [+] (.abs + .abs for @a)',
        {
            status => 0,
            out    => '12',
            err    => ''
        },
        'no warning about Useless use of "+" in sink context';
}

# RT #114430
{
    throws-like { ::('') }, X::NoSuchSymbol,
        'fail sensibly for empty lookup.';
}

# RT #117859
throws-like 'class RT117859 { trusts Bar }', X::Undeclared, symbol => 'Bar', what => 'Type';

# RT #93988
throws-like '5.', X::Comp::Group, sorrows => sub (@s) { @s[0] ~~ X::Syntax::Number::IllegalDecimal };

# RT #81502
throws-like 'BEGIN { ohnoes() }; sub ohnoes() { }', X::Undeclared::Symbols;
throws-like 'BEGIN { die "oh noes!" }', X::Comp::BeginTime, exception => sub ($e) { $e.message eq 'oh noes!' };

throws-like q:to/CODE/, X::Comp::BeginTime, exception => X::Multi::NoMatch;
    class Polar {
         proto method new(|) { * }
         multi method new(Real \mag, Real \theta) { }
    }
    constant j = Polar.new( 0e0 );
CODE

# RT #123397
throws-like 'my package A {}; my A $a;', X::Syntax::Variable::BadType;
throws-like 'my package A {}; sub foo(A $a) { }', X::Parameter::BadType;

# RT #123627
throws-like 'use DoesNotMatter Undeclared;', X::Undeclared::Symbols;
throws-like 'no DoesNotMatter Undeclared;', X::Undeclared::Symbols;

# RT #73102
throws-like 'my Int (Str $x);', X::Syntax::Variable::ConflictingTypes, outer => Int, inner => Str;

throws-like '$k', X::Undeclared, post => '$k', highexpect => &not,
    "X::Undeclared precedes the name and doesn't expect anything else";

# RT #125427
throws-like 'multi sub prefix:<|> (\a) { a.flat }', X::Syntax::Extension::SpecialForm,
    category => 'prefix', opname => '|';
throws-like 'multi sub infix:<=>(\a, \b) { }', X::Syntax::Extension::SpecialForm,
    category => 'infix', opname => '=';
throws-like 'multi sub infix:<:=>(\a, \b) { }', X::Syntax::Extension::SpecialForm,
    category => 'infix', opname => ':=';
throws-like 'multi sub infix:<::=>(\a, \b) { }', X::Syntax::Extension::SpecialForm,
    category => 'infix', opname => '::=';

# RT #125745
throws-like 'multi sub infix:<~~>(\a, \b) { }', X::Syntax::Extension::SpecialForm,
    category => 'infix', opname => '~~';

# RT #125441
throws-like 'enum Error ( Metadata => -20); class Metadata { }', X::Redeclaration;

# RT #125228
throws-like 'sub foo() is export(WTF) { }', X::Undeclared::Symbols;

# RT #125259
throws-like 'sub x(array[Int]) { }', X::Comp::BeginTime;

# RT #125120
throws-like 'enum X <A>; sub foo(A $a) { True', X::Syntax::Missing;

# RT #108462
throws-like '{ our sub foo { say "OMG" } }; { our sub foo { say "WTF" } };', X::Redeclaration;
throws-like 'my class C { my method foo { say "OMG" }; my method foo { say "WTF" } }', X::Redeclaration;
throws-like 'my class C { our method foo { say "OMG" }; our method foo { say "WTF" } }', X::Redeclaration;
throws-like 'my grammar G { my token foo { OMG }; my token foo { WTF } }', X::Redeclaration;
throws-like 'my grammar G { our token foo { OMG }; our token foo { WTF } }', X::Redeclaration;

# RT #125335
throws-like 'use fatal; +("\b" x 10)', X::Str::Numeric, source-indicator => /'\b'/;

# RT #125574
#?rakudo.jvm skip 'Error while compiling, type X::TooLateForREPR'
throws-like 'my class A { ... }; my class A is repr("Uninstantiable") { }', X::TooLateForREPR;

# RT #114274
throws-like 'gather { return  1}', X::ControlFlow::Return;

# RT #123732
throws-like 'for ^5 { .say; NEXT { return } }', X::ControlFlow::Return;
throws-like 'for ^5 { return; }', X::ControlFlow::Return;
throws-like 'return;', X::ControlFlow::Return;

# RT #125595
throws-like 'loop (my $i = 0; $i <= 5; $i++;) { say $i }', X::Syntax::Malformed, what => 'loop spec';

# RT #115398
throws-like 'my package P { }; P[Int]', X::NotParametric;
throws-like 'my module M { }; M[Int]', X::NotParametric;
throws-like 'my class C { }; C[Int]', X::NotParametric;

# RT #115400
throws-like 'my package P { }; sub foo(P of Int) { }', X::NotParametric;
throws-like 'my module M { }; sub foo(M of Int) { }', X::NotParametric;
throws-like 'my class C { }; sub foo(C of Int)', X::NotParametric;

# RT #125620
{
    my class CustomException is Exception {}
    try die CustomException.new;
    lives-ok { $!.gist }, 'Can gist an exception with no message method';
    ok $!.gist ~~ /CustomException/,
        'Gist of exception with no message method mentions the type';
    ok CustomException.new.gist ~~ /CustomException/,
        'Gist of unthrown exception with no message method mentions the type';
}

ok Exception.new.Str.chars, "Exception.new.Str produces some default text";
ok X::AdHoc.new.gist ~~ m:i/explain/,
    "X::AdHoc.new.gist mentions the word 'explain'";

for <fail die throw rethrow resumable resume> -> $meth {
    throws-like 'X::NYI.' ~ $meth, Exception,
        message => rx/equire.*instance.*type\sobject/;
}

# RT #125642
throws-like 'sub foo() returns Bar { }', X::InvalidType, typename => 'Bar';
throws-like 'my class C hides Baz { }', X::InvalidType, typename => 'Baz';
throws-like 'my class C does InNoWayExist { }', X::InvalidType, typename => 'InNoWayExist';
throws-like 'sub foo() returns !!!wtf??? { }', X::Syntax::Malformed, what => 'trait';

# RT #125675
throws-like '(1, 2, 3).map(True)', X::Multi::NoMatch;

# RT #125504
my $notahash = "a";
throws-like '$notahash<foo>', Exception, payload => rx:i/associative/, payload => rx/^^<-[\{\}]>+$$/;

# RT #119763
throws-like 'my $x :a', X::Syntax::Adverb;

# RT #117417
throws-like 'sub foo ($bar :D) { 1; }', X::Parameter::InvalidType;

# RT #126091
{
    throws-like 'my Nil $a = 3', X::TypeCheck::Assignment, expected => Nil;
    throws-like 'sub aa (Nil $a) { }; my $b = 3; aa($b)',
        X::TypeCheck::Binding, expected => Nil;
}

# RT #126105
throws-like 'my Int $a is default(Nil)',
    X::Parameter::Default::TypeCheck, got => Nil;

{
    is_run q[1;2], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* "Useless use"/ }, "sink distributes to statement list with 2 messages";
    is_run q[1,2], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* "Useless use"/ }, "sink distributes to comma list with 2 messages";
    is_run q[{ 1,2 },Nil], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* "Useless use"/ }, "sink distributes to comma list with 2 messages with bare block before Nil";
    is_run q[{ 1,2 }], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* "Useless use"/ }, "sink distributes to comma list with 2 messages with bare block alone";
    is_run q[my $x; $x = 1, 123], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 123/ }, "sink distributes to comma list when first is item assignment";
    is_run q[my $x = 1, 123], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 123/ }, "sink distributes to comma list when first is item initializer";
    is_run q["foo"], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 'foo' / }, "sink warns on string";
    is_run q[6.0221409e+23], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* '6.0221409' 'e'|'E' / }, "sink warns on num";
    is_run q[my $x; $x], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* '$x' / }, "sink warns on variable";
    is_run q[1+2], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* '1+2' / }, "sink warns on operator";
    is_run q[:foo(42)], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* ':foo(42)' / }, "sink warns on colonpair";
    is_run q[foo => 42], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 'foo => 42' / }, "sink warns on fatarrow";
    is_run q["foo" => 42], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* '=>' / }, "sink warns on pair composer";
    is_run q[<42i>], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* '42' / }, "sink warns on complex";
    is_run q[<1/3i>], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* '1/3' / }, "sink warns on fractional rat";
    is_run q[<123.456>], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* '123.456' / }, "sink warns on decimal rat";
    is_run q[<123i 456i>], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* '456' / }, "sink warns components of qw";
    is_run q[1 while 0], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 'Nil' / }, "sink warns on while mod and suggests Nil";
    is_run q[1 until 1], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 'Nil' / }, "sink warns on until mod and suggests Nil";
    is_run q["nada" for 1,2], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 'Nil' / }, "sink warns on for mod and suggests Nil";
    is_run q[1.0 given 1,2], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 'Nil' / }, "sink warns on given mod and suggests Nil";
    is_run q[6.02e23 for 1], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 'Nil' / }, "sink warns on floater and suggests Nil";
    is_run q[Mu for 1], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 'Nil' / }, "sink warns on type object outside Any and suggests Nil";
    is_run q[Any for 1], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 'Nil' / }, "sink warns on type object Any and suggests Nil";
    is_run q[Cool for 1], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 'Nil' / }, "sink warns on type object inside Any and suggests Nil";
    is_run q[my $sink; $sink for 1], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 'Nil' / }, "sink warns on variable and suggests Nil";
    is_run q[() while 0], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* 'Nil' / }, "sink warns on () and suggests Nil";
    is_run q[my @x = gather 43], { status => 0, err => / ^ "WARNINGS" \N* \n "Useless use" .* '43' / }, "sink warns inside of gather";
}

# RT #125769
{
    sub a {
	if 1 { my $f = Failure.new("foo"); }
	unless 0 { my $f = Failure.new("foo"); }
	return 1;
    }
    #?rakudo.jvm skip 'failure assignment still blows up on JVM, RT #125769'
    is a(), 1, "failure assignment at end of if block doesn't blow up";
    sub b {
	if 1 { my $f := Failure.new("bar"); }
	unless 0 { my $f := Failure.new("bar"); }
	return 2;
    }
    is b(), 2, "failure binding at end of if block doesn't blow up";
    sub c {
	{ my $f := Failure.new("bar"); }
	{ my $f := Failure.new("bar") if 1; }
	{ my $f := Failure.new("bar") unless 0; }
	return 3;
    }
    is c(), 3, "failure binding at end of block doesn't blow up with or without modifier if";
}

# RT #126987
throws-like 'enum Animal (Cat, Dog)', X::Undeclared::Symbols;
throws-like 'constant foo = bar', X::Undeclared::Symbols;

# RT #126888
throws-like '(1,2)[0] := 3', X::Bind;

# vim: ft=perl6
