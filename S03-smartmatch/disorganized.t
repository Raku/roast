use v6;
use Test;
plan 41;

=begin pod

This tests the smartmatch operator, defined in L<S03/"Smart matching">

=end pod

sub eval_elsewhere($code){ eval($code) }

#L<S03/Smart matching/Any undef undefined not .defined>
{ 
    ok("foo" ~~ .defined, "foo is ~~ .defined");
    nok "foo" !~~ .defined,   'not foo !~~ .defined';
    nok((Mu ~~ .defined), "Mu is not .defined");
}

# TODO: 
# Set   Set
# Hash  Set
# Any   Set
# Set   Array
# Set   Hash
# Any   Hash

# Regex tests are in spec/S05-*

#L<S03/"Smart matching"/in range>
{ 
    # more range tests in t/spec/S03-operators/range.t
    #?pugs todo
    ok((5 ~~ 1 .. 10), "5 is in 1 .. 10");
    ok(!(10 ~~ 1 .. 5), "10 is not in 1 .. 5");
    ok(!(1 ~~ 5 .. 10), "1 is not i n 5 .. 10");
    ok(!(5 ~~ 5 ^..^ 10), "5 is not in 5 .. 10, exclusive");
};

# TODO:
# Signature Signature
# Callable  Signature
# Capture   Signature
# Any       Signature

# Signature Capture  

# reviewed by moritz on 2009-07-07 up to here.

=begin Explanation

You may be wondering what the heck is with all these try blocks.
Prior to r12503, this test caused a horrible death of Pugs which
magically went away when used inside an eval.  So the try blocks
caught that case.

=end Explanation

{
    my $result = 0;
    my $parsed = 0;
    my @x = 1..20;
    try {
        $result = all(@x) ~~ { $_ < 21 };
        $parsed = 1;
    };
    ok $parsed, 'C<all(@x) ~~ { ... }> parses';
    ok ?$result, 'C<all(@x) ~~ { ... } when true for all';

    $result = 0;
    try {
        $result = !(all(@x) ~~ { $_ < 20 });
    };
    ok $result,
        'C<all(@x) ~~ {...} when true for one';

    $result = 0;
    try {
        $result = !(all(@x) ~~ { $_ < 12 });
    };
    ok $result, 'C<all(@x) ~~ {...} when true for most';

    $result = 0;
    try {
        $result = !(all(@x) ~~ { $_ < 1  });
    };
    ok $result, 'C<all(@x) ~~ {...} when true for one';
};

# need to test in eval() since class definitions happen at compile time,
# ie before the plan is set up.
eval_lives_ok 'class A { method foo { return "" ~~ * } }; A.new.foo',
              'smartmatch in a class lives (RT 62196)';

# RT #69762
{
    ok sub {} ~~ Callable, '~~ Callable (true)';
    nok 68762 ~~ Callable, '~~ Callable (false)';
    ok 69762 !~~ Callable, '!~~ Callable (true)';
    nok sub {} !~~ Callable, '!~~ Callable (false)';

    ok sub {} ~~ Routine, '~~ Routine (true)';
    nok 68762 ~~ Routine, '~~ Routine (false)';
    ok 69762 !~~ Routine, '!~~ Routine (true)';
    nok sub {} !~~ Routine, '!~~ Routine (false)';

    ok sub {} ~~ Sub, '~~ Sub (true)';
    nok 68762 ~~ Sub, '~~ Sub (false)';
    ok 69762 !~~ Sub, '!~~ Sub (true)';
    nok sub {} !~~ Sub, '!~~ Sub (false)';

    ok sub {} ~~ Block, '~~ Block (true)';
    nok 68762 ~~ Block, '~~ Block (false)';
    ok 69762 !~~ Block, '!~~ Block (true)';
    nok sub {} !~~ Block, '!~~ Block (false)';

    ok sub {} ~~ Code, '~~ Code (true)';
    nok 68762 ~~ Code, '~~ Code (false)';
    ok 69762 !~~ Code, '!~~ Code (true)';
    nok sub {} !~~ Code, '!~~ Code (false)';
}
{

    class RT68762 { our method rt68762 {} };

    ok &RT68762::rt68762 ~~ Method, '~~ Method (true)';
    nok 68762            ~~ Method, '~~ Method (false)';
    ok 69762              !~~ Method, '!~~ Method (true)';
    nok &RT68762::rt68762 !~~ Method, '!~~ Method (false)';

}

# RT 72048
{
    role RT72048_role {}
    class RT72048_class does RT72048_role {}

    ok RT72048_class.new ~~ RT72048_role, 'class instance matches role';
    nok RT72048_class.new !~~ RT72048_role, 'class instance !!matches role';
}

ok "foo" ~~ *, 'thing ~~ * is true';
ok ("foo" ~~ *) ~~ Bool, 'thing ~~ * is a boolean';

done();

# vim: ft=perl6
