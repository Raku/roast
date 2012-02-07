use v6;
use Test;

#?DOES 1
sub throws_like($code, $ex_type, *%matcher) {
    my $msg;
    if $code ~~ Callable {
        $msg = 'code dies';
        $code()
    } else {
        $msg = "'$code' died";
        eval $code;
    }
    ok 0, $msg;
    skip 'Code did not die, can not check exception', 1 + %matcher.elems;
    CATCH {
        default {
            ok 1, $msg;
            my $type_ok = $_.WHAT === $ex_type;
            ok $type_ok , "right exception type ({$ex_type.^name})";
            if $type_ok {
                for %matcher.kv -> $k, $v {
                    my $got = $_."$k"();
                    my $ok = $got ~~ $v,;
                    ok $ok, ".$k matches $v";
                    unless $ok {
                        diag "Got:      $got\n"
                            ~"Expected: $v";

                    }
                }
            } else {
                diag "Got:      {$_.WHAT.gist}\n"
                    ~"Expected: {$ex_type.gist}";
                skip 'wrong exception type', %matcher.elems;
            }
        }
    }
}

throws_like { Buf.new().Str }, X::Buf::AsStr, method => 'Str';
throws_like 'class Foo { $!bar }', X::Attribute::Undeclared,
            name => '$!bar', package-name => 'Foo';
throws_like 'sub f() { $^x }', X::Signature::Placeholder,
            line => 1;

#?rakudo skip 'parsing of $& and other p5 variables'
throws_like '$&', X::Obsolete, old => '$@ variable', new => '$/ or $()';

throws_like 'do    { $^x }', X::Placeholder::Block, placeholder => '$^x';
throws_like 'do    { @_  }', X::Placeholder::Block, placeholder => '@_';
throws_like 'class { $^x }', X::Placeholder::Block, placeholder => '$^x';
throws_like '$^x',           X::Placeholder::Mainline, placeholder => '$^x';
# RT #73502
throws_like '@_',            X::Placeholder::Mainline, placeholder => '@_';
throws_like 'sub f(*@a = 2) { }', X::Parameter::Default, how => 'slurpy';
throws_like 'sub f($x! = 3) { }', X::Parameter::Default, how => 'required';
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
throws_like 'my @a; my @a',  X::Redeclaration,      symbol => '@a';
throws_like 'sub a { }; sub a { }',X::Redeclaration, symbol => 'a', what => 'routine';
throws_like 'my class A { }; my class A { }',  X::Redeclaration, symbol => 'A';
throws_like 'my class B { }; my subset B { }', X::Redeclaration, symbol => 'B';
throws_like 'CATCH { }; CATCH { }', X::Phaser::Multiple, block => 'CATCH';

throws_like 'class A { my @a; @a!List::foo() }',
    X::Method::Private::Permission,
    method          => 'foo',
    calling-package => 'A',
    source-package  => 'List';

throws_like '1!foo()',
    X::Method::Private::Unqualified,
    method          => 'foo';

throws_like 'sub f() { }; f() := 2', X::Bind::WrongLHS;
throws_like 'my int $x := 2', X::Bind::NativeType;

throws_like 'for (1; 1; 1) { }', X::Obsolete,
    old         => rx/<<for>>/,
    replacement => rx/<<loop>>/;
throws_like 'foreach (1..10) { }', X::Obsolete,
    old         => "'foreach'",
    replacement => "'for'";
throws_like 'undef', X::Obsolete,
    old         => rx/<<undef>>/;

throws_like 'my $a::::b', X::Syntax::Name::Null;
throws_like 'unless 1 { } else { }', X::Syntax::UnlessElse;
throws_like 'for my $x (1, 2, 3) { }', X::Syntax::P5;
throws_like ':!foo(3)', X::Syntax::NegatedPair;
throws_like 'my $0', X::Syntax::Variable::Numeric;
throws_like 'my $<a>', X::Syntax::Variable::Match;
throws_like 'my class A { my $!foo }', X::Syntax::Variable::Twigil, twigil => '!', scope => 'my';
throws_like 'my $::("foo")', X::Syntax::Variable::IndirectDeclaration;
throws_like '@a', X::Undeclared, symbol => '@a';
throws_like 'augment class Any { }', X::Syntax::Augment::WithoutMonkeyTyping;
throws_like 'use MONKEY_TYPING; augment role Positional { }', X::Syntax::Augment::Role;

throws_like 'sub f($a?, $b) { }', X::Parameter::WrongOrder,
    misplaced   => 'required',
    after       => 'optional';
throws_like 'sub f(*@a, $b) { }', X::Parameter::WrongOrder,
    misplaced   => 'required',
    after       => 'variadic';
throws_like 'sub f(*@a, $b?) { }', X::Parameter::WrongOrder,
    misplaced   => 'optional positional',
    after       => 'variadic';

#?rakudo skip 'parsing regression'
throws_like '#`', X::Syntax::Comment::Embedded;
#?rakudo skip 'parsing regression'
throws_like '=begin', X::Syntax::Pod::BeginWithoutIdentifier;

throws_like '@', X::Syntax::SigilWithoutName;
throws_like '1∞', X::Syntax::Confused;

done;
