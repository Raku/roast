use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 181;

# https://github.com/Raku/old-issue-tracker/issues/2075
throws-like 'sub foo(--> NoSuchType) { }; foo', X::Undeclared, what => { m/'Type'/ }, symbol => { m/'NoSuchType'/ };

throws-like 'my class Foobar is Foobar', X::Inheritance::SelfInherit, name => "Foobar";

{
    # https://github.com/Raku/old-issue-tracker/issues/1362
    my $code = q{class GrammarUserClass { method bar { PostDeclaredGrammar.parse('OH HAI'); } }; grammar PostDeclaredGrammar { rule TOP { .* } }; GrammarUserClass.bar;};
    throws-like $code, X::Undeclared::Symbols, post_types => { .{"PostDeclaredGrammar"} :exists };
}

{
    throws-like q{if 10 > 5 { say "maths works!" } else if 10 == 5 { say "identity is weird" } else { say "math is weird" }}, X::Syntax::Malformed::Elsif;
}

{
    # https://github.com/Raku/old-issue-tracker/issues/1528
    throws-like q{1/2.''()}, X::Method::NotFound, method => '', typename => 'Int';
}

{
    # https://github.com/Raku/old-issue-tracker/issues/2219
    throws-like q{role Bottle[::T] { method Str { "a bottle of {T}" } }; class Wine { ... }; say Bottle[Wine].new;}, X::Package::Stubbed;
}

throws-like q[sub f() {CALLER::<$x>}; my $x; f], X::Caller::NotDynamic, symbol => '$x';

# https://github.com/Raku/old-issue-tracker/issues/3036
{
    try EVAL('my ($abe, $ba, $abc); $abd');
    diag $!.message;
    ok $!.message ~~ /'Did you mean'/, "Doesn't explode";
}

# https://github.com/Raku/old-issue-tracker/issues/1909
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

# https://github.com/Raku/old-issue-tracker/issues/2185
#?rakudo.jvm todo 'correct method, but result for .private is empty'
throws-like 'my class A { method b { Q<b> } }; my $a = A.new; my $b = &A::b.assuming($a); $b();',
    X::Method::NotFound, method => { m/'assuming'/ }, private => { $_ === False };

# https://github.com/Raku/old-issue-tracker/issues/1076
throws-like 'for 1,2,3, { say 3 }', X::Comp::Group,
    sorrows => sub (@s) { @s[0] ~~ X::Syntax::BlockGobbled && @s[0].message ~~ /^Expression/ },
    panic => sub ($p) { $p ~~ X::Syntax::Missing && $p.what ~~ /^block/ };

# https://github.com/Raku/old-issue-tracker/issues/1076
throws-like 'CATCH { when X::Y {} }', X::Comp::Group,
    sorrows => sub (@s) { @s[0] ~~ X::Syntax::BlockGobbled && @s[0].what ~~ /'X::Y'/ },
    panic => sub ($p) { $p ~~ X::Syntax::Missing && $p.what ~~ /^block/ };

# https://github.com/Raku/old-issue-tracker/issues/1770
throws-like 'say 1 if 2 if 3 { say 3 }', X::Syntax::Confused,
    reason => { m/'Missing semicolon'/ },
    pre => { m/'1 if 2'/ },
    post => { m/'3 { say 3 }'/ };

# https://github.com/Raku/old-issue-tracker/issues/4431
#?rakudo todo 'Wrong eject position'
throws-like 'if True if { };', X::Syntax::Missing,
    what => 'block',
    pre => 'if True ',
    post => 'if { };';

# https://github.com/Raku/old-issue-tracker/issues/2107
throws-like '/\ X/', X::Syntax::Regex::Unspace,
    message => { m/'No unspace allowed in regex' .+ '(\' \')' .+ '\x20'/ }, char => { m/' '/ };

# https://github.com/Raku/old-issue-tracker/issues/2087
throws-like '/m ** 1..-1/', X::Comp::Group,
    panic => { .payload ~~ m!'Unable to parse regex; couldn\'t find final \'/\''! },
    sorrows => { .[0] => { $_ ~~ X::Syntax::Regex::MalformedRange } and .[1] => { $_ ~~ X::Syntax::Regex::UnrecognizedMetachar } };

# https://github.com/Raku/old-issue-tracker/issues/2593
throws-like 'multi sub postcircumfix:«⟨  ⟩»($foo, $a) { $a.say }; my $a; $a⟨5;', X::Comp::FailGoal,
   dba => "postcircumfix:sym<⟨ ⟩>",
   goal => "'⟩'";
throws-like 'multi sub circumfix:«⟨  ⟩»($foo, $a) { $a.say }; ⟨5;', X::Comp::FailGoal,
   dba => "circumfix:sym<⟨ ⟩>",
   goal => "'⟩'";
throws-like '„foo', X::Comp::FailGoal,
   dba => "low curly double quotes",
   goal => "<[”“]>"; # While this may shackle us to an implementation detail,
                     # We need a test that ensures the '' normally comes from
                     # the rx code, except maybe in the above finagle cases.
throws-like '[1,2', X::Comp::FailGoal,
   dba => "array composer",
   goal => "']'";    # Normal literal-in-regex case.

# https://github.com/Raku/old-issue-tracker/issues/3479
throws-like '/m ** 1 ..2/', X::Syntax::Regex::SpacesInBareRange,
    pre => { m!'/m ** 1 ..'! },
    post => { m!'2/'! };

# https://github.com/Raku/old-issue-tracker/issues/2971
throws-like 'sub infix:<> (){}', X::Comp::Group,
    panic => { $_ ~~ X::Syntax::Extension::Null and .pre ~~ m/'sub infix:<>'/ and .post ~~ m/'()'/ },
    message => /'Null operator is not allowed'/,
    worries => { .[0].payload ~~ m/'Pair with <> really means an empty list, not null string'/ };

# https://github.com/Raku/old-issue-tracker/issues/3493
throws-like '&[doesntexist]', X::Comp, # XXX probably needs exception type fix
  'unknown operator should complain better';

# https://github.com/Raku/old-issue-tracker/issues/1497
throws-like { $*an_undeclared_dynvar = 42 }, X::Dynamic::NotFound;

{
    my $*foo = 0;
    throws-like { EVAL '$*foo = 1; say' }, X::Comp::Group;
    is $*foo, 0, 'should be a compile time error';
}

#?rakudo.js.browser skip "use at EVAL time not supported in the browser"
# https://github.com/Raku/old-issue-tracker/issues/2791
throws-like ｢use ThisDoesNotExistAtAll｣, X::CompUnit::UnsatisfiedDependency;

# https://github.com/Raku/old-issue-tracker/issues/3039
throws-like ｢my \foo｣, X::Syntax::Term::MissingInitializer,
   message => 'Term definition requires an initializer';

# https://github.com/Raku/old-issue-tracker/issues/2410
throws-like ｢given 42 { when SomeUndeclaredType { 1 }; default { 0 } }｣,
    X::Comp::Group, :message(/SomeUndeclaredType/),
'adequate error message when undeclared type is used in "when" clause';

# https://github.com/Raku/old-issue-tracker/issues/3142
{
    my class A is Any { proto method new($) {*} };
    throws-like { A.new(now) }, X::Multi::NoMatch,
        'no NullPMC access error but exception X::Multi::NoMatch';
}

# https://github.com/Raku/old-issue-tracker/issues/3293
{
    throws-like 'my Int a;', X::Syntax::Malformed,
        'adequate error message when declaring "my Int a;"',
        message => { m/"Malformed my (did you mean to declare a sigilless"/ };
    throws-like 'my Int a', X::Syntax::Malformed,
        'adequate error message when declaring "my Int a"',
        message => { m/"Malformed my (did you mean to declare a sigilless"/ };
}

# https://github.com/Raku/old-issue-tracker/issues/2820
throws-like ｢ord.Cool｣, X::Obsolete,
    'adequate error message when calling bare "ord"';

# https://github.com/Raku/old-issue-tracker/issues/3642
is_run q[$; my $b;], { :0status, :err(/
      ^ "WARNINGS" \N* \n "Useless use of unnamed \$ variable in sink context"
/)}, "unnamed var in sink context warns";

# https://github.com/Raku/old-issue-tracker/issues/4951
is_run 'my @a = -1, 2, -3; print [+] (.abs + .abs for @a)',
    { :0status, :out<12>, :err('')},
'no warning about Useless use of "+" in sink context';

# https://github.com/Raku/old-issue-tracker/issues/5476
is_run q|print ($_ with 'foo')|, { :0status, :out<foo>, :err('') },
    'no warning about "Useless use" with say ($_ with "foo")';

# https://github.com/Raku/old-issue-tracker/issues/5498
is_run q|sub infix:<↑>($a, $b) is assoc<right> {$a ** $b};
         sub infix:<↑↑>($a, $b) is assoc<right> { [↑] $a xx $b };
         print 3↑↑3|,
    { :0status, :out<7625597484987>, :err('') },
'no warning about "Useless use" with "onearg form of reduce"';

# https://github.com/Raku/old-issue-tracker/issues/2853
throws-like { ::('') }, X::NoSuchSymbol, 'fail sensibly for empty lookup';

# https://github.com/Raku/old-issue-tracker/issues/3122
throws-like 'class RT117859 { trusts Bar }', X::Undeclared,
    :symbol<Bar>, :what<Type>;

# https://github.com/Raku/old-issue-tracker/issues/2448
throws-like '5.', X::Comp::Group, sorrows => sub (@s) {
    @s[0] ~~ X::Syntax::Number::IllegalDecimal
}

# https://github.com/Raku/old-issue-tracker/issues/2312
throws-like 'BEGIN { ohnoes() }; sub ohnoes() { }', X::Undeclared::Symbols;
throws-like 'BEGIN { die "oh noes!" }', X::Comp::BeginTime,
    exception => sub ($e) { $e.message eq 'oh noes!' };

throws-like q:to/CODE/, X::Comp::BeginTime, exception => X::Multi::NoMatch;
    class Polar {
         proto method new(|) { * }
         multi method new(Real \mag, Real \theta) { }
    }
    constant j = Polar.new( 0e0 );
CODE

# https://github.com/Raku/old-issue-tracker/issues/3600
throws-like 'my package A {}; my A $a;', X::Syntax::Variable::BadType;
throws-like 'my package A {}; sub foo(A $a) { }', X::Parameter::BadType;

# https://github.com/Raku/old-issue-tracker/issues/3649
throws-like 'use DoesNotMatter Undeclared;', X::Undeclared::Symbols;
throws-like 'no DoesNotMatter Undeclared;', X::Undeclared::Symbols;

# https://github.com/Raku/old-issue-tracker/issues/1538
throws-like 'my Int (Str $x);', X::Syntax::Variable::ConflictingTypes, outer => Int, inner => Str;

throws-like '$k', X::Undeclared, post => '$k', highexpect => &not,
    "X::Undeclared precedes the name and doesn't expect anything else";

# https://github.com/Raku/old-issue-tracker/issues/4328
throws-like 'multi sub prefix:<|> (\a) { a.flat }', X::Syntax::Extension::SpecialForm,
    category => 'prefix', opname => '|';
throws-like 'multi sub infix:<=>(\a, \b) { }', X::Syntax::Extension::SpecialForm,
    category => 'infix', opname => '=';
throws-like 'multi sub infix:<:=>(\a, \b) { }', X::Syntax::Extension::SpecialForm,
    category => 'infix', opname => ':=';
throws-like 'multi sub infix:<::=>(\a, \b) { }', X::Syntax::Extension::SpecialForm,
    category => 'infix', opname => '::=';

# https://github.com/Raku/old-issue-tracker/issues/4453
throws-like 'multi sub infix:<~~>(\a, \b) { }', X::Syntax::Extension::SpecialForm,
    category => 'infix', opname => '~~';

# https://github.com/Raku/old-issue-tracker/issues/4334
throws-like 'enum Error ( Metadata => -20); class Metadata { }', X::Redeclaration;

# https://github.com/Raku/old-issue-tracker/issues/4257
throws-like 'sub foo() is export(WTF) { }', X::Undeclared::Symbols;

# https://github.com/Raku/old-issue-tracker/issues/4269
throws-like 'sub x(array[Int]) { }', X::Comp::BeginTime;

# https://github.com/Raku/old-issue-tracker/issues/4221
throws-like 'enum X <A>; sub foo(A $a) { True', X::Syntax::Missing;

# https://github.com/Raku/old-issue-tracker/issues/2613
throws-like '{ our sub foo { say "OMG" } }; { our sub foo { say "WTF" } };', X::Redeclaration;
throws-like 'my class C { my method foo { say "OMG" }; my method foo { say "WTF" } }', X::Redeclaration;
throws-like 'my class C { our method foo { say "OMG" }; our method foo { say "WTF" } }', X::Redeclaration;
throws-like 'my grammar G { my token foo { OMG }; my token foo { WTF } }', X::Redeclaration;
throws-like 'my grammar G { our token foo { OMG }; our token foo { WTF } }', X::Redeclaration;

# https://github.com/Raku/old-issue-tracker/issues/4296
throws-like 'use fatal; +("\b" x 10)', X::Str::Numeric, source-indicator => /'\b'/;

# https://github.com/Raku/old-issue-tracker/issues/4385
throws-like 'my class A { ... }; my class A is repr("Uninstantiable") { }', X::TooLateForREPR;

# https://github.com/Raku/old-issue-tracker/issues/2840
throws-like 'gather { return  1}', X::ControlFlow::Return;

# https://github.com/Raku/old-issue-tracker/issues/3668
throws-like 'for ^5 { NEXT { return } }', X::ControlFlow::Return;
throws-like 'for ^5 { return; }', X::ControlFlow::Return;
throws-like 'return;', X::ControlFlow::Return;

# https://github.com/Raku/old-issue-tracker/issues/4391
throws-like 'loop (my $i = 0; $i <= 5; $i++;) { say $i }', X::Syntax::Malformed, what => /^'loop spec'/;
# https://github.com/Raku/old-issue-tracker/issues/5220
throws-like 'loop () { say $i }', X::Syntax::Malformed, what => /^'loop spec' .* 'semicolon'/;
throws-like 'loop (my $i = 0, $i <= 5, $i++) { say $i }', X::Syntax::Malformed, what => /^'loop spec' .* 'got 1'/;
throws-like 'loop (my $i = 0; $i <= 5, $i++) { say $i }', X::Syntax::Malformed, what => /^'loop spec' .* 'got 2'/;
throws-like 'loop (my $i = 0; $i <= 5; $i++; $i++) { say $i }', X::Syntax::Malformed, what => /^'loop spec' .* 'got more'/;

# https://github.com/Raku/old-issue-tracker/issues/2945
throws-like 'my package P { }; P[Int]', X::NotParametric;
throws-like 'my module M { }; M[Int]', X::NotParametric;
throws-like 'my class C { }; C[Int]', X::NotParametric;

# https://github.com/Raku/old-issue-tracker/issues/2946
throws-like 'my package P { }; sub foo(P of Int) { }', X::NotParametric;
throws-like 'my module M { }; sub foo(M of Int) { }', X::NotParametric;
throws-like 'my class C { }; sub foo(C of Int)', X::NotParametric;

# https://github.com/Raku/old-issue-tracker/issues/4405
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

for <fail die throw rethrow resume> -> $meth {
    throws-like 'X::NYI.' ~ $meth, X::Parameter::InvalidConcreteness,
        should-be-concrete => 'True',
        param-is-invocant  => 'True',
        routine            => $meth;
}

# https://github.com/Raku/old-issue-tracker/issues/4414
throws-like 'sub foo() returns Bar { }', X::InvalidType, typename => 'Bar';
throws-like 'my class C hides Baz { }', X::InvalidType, typename => 'Baz';
throws-like 'my class C does InNoWayExist { }', X::InvalidType, typename => 'InNoWayExist';
throws-like 'sub foo() returns !!!wtf??? { }', X::Syntax::Malformed, what => 'trait';

# https://github.com/Raku/old-issue-tracker/issues/4432
# R#2729
throws-like '(1, 2, 3).map(True)',        X::Cannot::Map;
throws-like '(1, 2, 3).map: 1,2,3',       X::Cannot::Map;
throws-like '(1, 2, 3).map: (1,2,3)',     X::Cannot::Map;
throws-like '(1, 2, 3).map: * xx 2',      X::Cannot::Map;
throws-like '(1, 2, 3).map: { a => 42 }', X::Cannot::Map;

# https://github.com/Raku/old-issue-tracker/issues/4359
my $notahash = "a";
throws-like '$notahash<foo>', Exception, payload => rx:i/associative/, payload => rx/^^<-[\{\}]>+$$/;

# https://github.com/Raku/old-issue-tracker/issues/3233
throws-like 'my $x :a', X::Syntax::Adverb;

# https://github.com/rakudo/rakudo/issues/3949
throws-like { use MONKEY; EVAL 'infix:(&)' },
  X::Syntax::Adverb,
  what => ':(&)',
  'did the faulty adverb throw the correct error';

# https://github.com/Raku/old-issue-tracker/issues/3092
throws-like 'sub foo ($bar :D) { 1; }', X::Parameter::InvalidType;

# https://github.com/Raku/old-issue-tracker/issues/4542
{
    throws-like 'my Nil $a = 3', X::TypeCheck::Assignment, expected => Nil;
    throws-like 'sub aa (Nil $a) { }; my $b = 3; aa($b)',
        X::TypeCheck::Binding, expected => Nil;
}

# https://github.com/Raku/old-issue-tracker/issues/4554
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

    is_run q[∞; NaN; Inf; -Inf], { status => 0, :err{
        .contains: «WARNINGS  "Useless use"  ∞  NaN  Inf  -Inf».all
    }}, "sink warns about special Nums";

    is_run q[0xFF], { status => 0, :err{
        .contains: «WARNINGS  "Useless use"  integer  0xFF».all
    }}, "sink warning maintains used format of integers";
    is_run q[0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF], { status => 0, :err{
        .contains: «WARNINGS  "Useless use"  integer
          0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF».all
    }}, "sink warning maintains used format of big integers";
    is_run q[1.22222222222222222222222222222222222222e0], { status => 0, :err{
        .contains: «WARNINGS  "Useless use"  number
          1.22222222222222222222222222222222222222e0».all
    }}, "sink warning maintains used format of nums";
}

# https://github.com/Raku/old-issue-tracker/issues/4460
{
    sub a {
	if 1 { my $f = Failure.new("foo"); }
	unless 0 { my $f = Failure.new("foo"); }
	return 1;
    }
    # https://github.com/Raku/old-issue-tracker/issues/4460
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

# https://github.com/Raku/old-issue-tracker/issues/4902
throws-like 'enum Animal (Cat, Dog)', X::Undeclared::Symbols;
throws-like 'constant foo = bar', X::Undeclared::Symbols;

# https://github.com/Raku/old-issue-tracker/issues/2593
throws-like '(1,2)[0] := 3', X::Bind;
#?rakudo 2 todo 'wrong exception'
throws-like '(List)[0]  := 1', X::Bind, "can't bind into an undefined list";
throws-like '(Int)[0]   := 1', X::Bind, "can't bind into an undefined Int";
throws-like '10[0]      := 1', X::Bind, "can't bind into a defined Int";
throws-like '"Hi"[0]    := 1', X::Bind, "can't bind into a defined Str";

# https://github.com/Raku/old-issue-tracker/issues/5438
throws-like Q/my Array[Numerix] $x;/, X::Undeclared::Symbols, gist => /Numerix/;

# https://github.com/Raku/old-issue-tracker/issues/5677
throws-like 'for 1, 2 { my $p = {};', X::Syntax::Missing, what => 'block';

# https://github.com/Raku/old-issue-tracker/issues/5682
#?rakudo.jvm todo 'dies with X::AdHoc -- __P6opaque__77@3dc2adf9 in sub-signature of parameter @array'
throws-like 'sub foo(@array ($first, @rest)) { say @rest }; foo <1 2 3>;',
    X::TypeCheck::Binding, got => IntStr, expected => Positional;

# NOTE: the number of blocks (2) below is important; otherwise
# the $bt.list.elems will give the wrong number
{ # coverage; 2016-09-22
    {
        my sub foo { fail }();
        CATCH { default {
            my $bt = .backtrace;
            is-deeply $bt.flat, $bt.list, '.flat on Backtrace returns .list';
            #?rakudo.jvm todo 'got "6"'
            is $bt.list.elems, 4, 'we correctly have 2 elements in .list';
            #?rakudo.jvm todo 'got "new"'
            is $bt.list[0].code.name, 'foo', '.list contains correct items';
        }}
    }

    {
        my sub bar { die }();
        CATCH { default {
            my $bt = .backtrace;
            is $bt.concise, (
                $bt.grep({ !.is-hidden && .is-routine && !.is-setting })
                // "\n"
            ).join,
            '.concise output includes only non-hidden, non-setting routines';

            is $bt.summary, (
                $bt.grep({ !.is-hidden && (.is-routine || !.is-setting)})
                // "\n"
            ).join,
            '.summary output includes only non-hidden items that are either '
                ~ 'routines or non-setting items';
        }}
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5689
{ 
    my sub bar { X::AdHoc.new.throw }();
    CATCH { default {
        my $bt = .backtrace;
        is $bt.list.elems, 4, 'expecting 4 frames in the backtrace';
        is-deeply $bt.map({
            isa-ok $^b, Backtrace::Frame,
                 '.map arg (item #' ~ $++ ~ ') is a Backtrace::Frame';
            $^b;
        }), $bt.list, '.map operates correctly';
    }}
}

# https://github.com/Raku/old-issue-tracker/issues/5761
{
    my $warned;
    {
        EVAL 'my $!a';
        CONTROL { when CX::Warn { $warned = True; .resume } }
        CATCH { default { } }
    }
    nok $warned, 'No warning when producing error for "my $!a"';
}

# https://github.com/Raku/old-issue-tracker/issues/6310
{
    throws-like q| my \foo = Callable but role :: { } |,
        X::Method::NotFound, :message{.so},
	'X::Method::NotFound does not die with "X::Method::NotFound exception produced no message"';
}

# https://github.com/Raku/old-issue-tracker/issues/3701
{
    throws-like q|enum E <RT123926Foo Bar>; sub x(RT123926Floo) {}|,
        X::Parameter::InvalidType,
        typename    => 'RT123926Floo',
        suggestions => ['RT123926Foo'],
        'enum values are suggested for misspellings'
}

is_run ｢
    my $ = :WorryFoo<>; { no worries; my $ = :WorryBar<> }; my $ = :WorryBer<>;
    print "pass"
｣, %(:out<pass>, :err{
    .contains: 'use :WorryFoo' & 'use :WorryBer' & none 'use :WorryBar'
}), 'lexical worries pragma disables compiler warnings';


# https://github.com/Raku/old-issue-tracker/issues/4968
{
    sub test { throws-like $^code, X::Syntax::Malformed, :what(/return/) }
    test 'sub foo (--> Bool Int $x, Int $y) { True }';
    test 'sub foo (--> Bool Int $x; Int $y) { True }';
    test 'sub foo (--> Bool Int $x, Int $y)';
    test 'sub foo (--> Bool Int $x; Int $y)';
    test 'sub foo (--> Bool, Int $x, Int $y)';
    test 'sub foo (--> Bool; Int $x; Int $y)';
    test 'sub foo ($x, --> Bool, Int $y)';
    test 'sub foo ($x; --> Bool; Int $y)';
}

# https://github.com/Raku/old-issue-tracker/issues/4284
throws-like ｢my $x = "#={";
say 42;｣, X::Comp::FailGoal, line => 2, message => /«'line 1'»/;

# https://github.com/Raku/old-issue-tracker/issues/5858
throws-like ｢say ‘hello';
say 42;
say 50;｣, X::Comp::FailGoal, line => 3, message => /«'line 1'»/;

# https://github.com/rakudo/rakudo/issues/3751
{
    my $code = q:to/END/;
        say 'first both';\
        <<<<<<< HEAD
        say 'your';
        =======
        say 'their';
        >>>>>>> branch

        say 'middle both';

        <<<<<<< HEAD
        say 'your';
        =======
        say 'their';
        >>>>>>> branch

        q:to/QUOTED/;
        <<<<<<< HEAD
        this is not 
        =======
        a vcs conflict
        >>>>>>> branch
        QUOTED
        END
    throws-like $code, X::Comp::Group,
        sorrows => sub (@s) {
            +@s == 1 && @s[0] ~~ X::Comp::AdHoc && @s[0].line == 2
            && @s[0].payload eq 'Found a version control conflict marker'
        },
        panic => sub ($p) {
            $p ~~ X::Comp::AdHoc && $p.line == 10
            && $p.payload eq 'Found a version control conflict marker'
        };
}

# vim: expandtab shiftwidth=4
