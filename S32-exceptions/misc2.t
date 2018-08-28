use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;

plan 267;

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

throws-like '${۳}', X::Obsolete;

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
# RT #129968
throws-like 'class AAAA { class B {} }; use MONKEY; augment class AAAA { class B { } }',
    X::Redeclaration, symbol => 'B';
throws-like 'class AAAAA { class B::C {} }; use MONKEY; augment class AAAAA { class B::C { } }',
    X::Redeclaration, symbol => 'B::C';

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
  $" $$ $; $& $` $' $, $. $\ $| $? $@ $]
  @- @+ %- %+ %!
> {
    throws-like "$_ = 1;", X::Syntax::Perl5Var, "Did $_ throw Perl5Var?";
}

throws-like '$#foo', X::Syntax::Perl5Var;
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
    range => "1..29", message => rx/<<1\.\.29>>/;
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
# RT #129772
throws-like 'sub (int $i) { $i() }(42)', X::Method::NotFound;

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
        is $!.type_suggestion<Ecxeption>.grep("Exception"), ["Exception"], 'Exception is a suggestion';
    }

    throws-like 'sub greet($name) { say "hello, $nam" }', X::Undeclared, suggestions => '$name';

    throws-like 'class Greeter { has $.name; method greet { say "hi, $name" } }', X::Undeclared, suggestions => '$!name';
}

# R#2111
{
    lives-ok { EVAL(
      'package Zoo { use experimental :pack; sub go() is export { "".encode.unpack("*") }; }; import Zoo; go()'
    ) }, 'is "use experimental :pack" visible?';
}

# vim: ft=perl6
