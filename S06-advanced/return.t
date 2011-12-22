use v6;
use Test;

=begin desc

This tests proper return of values from subroutines.

# L<S06/"The C<return> function">

See also t/blocks/return.t, which overlaps in scope.

=end desc

# NOTE: the smart link above actually doesn't go to a good
# reference for the spec for 'return', but I couldn't find
# one either. 

plan 79;

# These test the returning of values from a subroutine.
# We test each data-type with 4 different styles of return.
#
# The datatypes are:
#     Scalar
#     Array
#     Array-ref (aka List)
#     Hash
#     Hash-ref
#
# The 4 return styles are:
#     create a variable, and return it with the return statement
#     create a variable, and make it the last value in the sub (implied return)
#     create the value inline and return it with the return statement
#     create the value inline and make it the last value in the sub (implied return)
#
# NOTE:
# we do not really check return context here. That should be
# in it's own test file

# TODO-NOTE:
# Currently the Hash and Hash-ref tests are not complete, becuase hashes seem to be
# broken in a number of ways. I will get back to those later.

## void
# ok(eval('sub ret { return }; 1'), "return without value parses ok");

sub bare_return { return };

ok(! bare_return(), "A bare return is a false value");

my @l = <some values>;
@l = bare_return();
is( @l, [], "A bare return is an empty list in array/list context");

my $s = "hello";
$s = bare_return();

nok($s.defined, "A bare return is undefined in scalar context");

## scalars

sub foo_scalar {
    my $foo = 'foo';
    return $foo;
}
is(foo_scalar(), 'foo', 'got the right return value');

# ... w/out return statement

sub foo_scalar2 {
    my $foo = 'foo';
    $foo;
}
is(foo_scalar2(), 'foo', 'got the right return value');

# ... returning constant

sub foo_scalar3 {
    return 'foo';
}
is(foo_scalar3(), 'foo', 'got the right return value');

# ... returning constant w/out return statement

sub foo_scalar4 {
    'foo';
}
is(foo_scalar4(), 'foo', 'got the right return value');

## arrays

sub foo_array {
    my @foo = ('foo', 'bar', 'baz');
    return @foo;
}
my @foo_array_return = foo_array();
isa_ok(@foo_array_return, Array);
is(+@foo_array_return, 3, 'got the right number of return value');
is(@foo_array_return[0], 'foo', 'got the right return value');
is(@foo_array_return[1], 'bar', 'got the right return value');
is(@foo_array_return[2], 'baz', 'got the right return value');

# ... without the last return statement

sub foo_array2 {
    my @foo = ('foo', 'bar', 'baz');
    @foo;
}
my @foo_array_return2 = foo_array2();
isa_ok(@foo_array_return2, Array);
is(+@foo_array_return2, 3, 'got the right number of return value');
is(@foo_array_return2[0], 'foo', 'got the right return value');
is(@foo_array_return2[1], 'bar', 'got the right return value');
is(@foo_array_return2[2], 'baz', 'got the right return value');

# ... returning an Array constructed "on the fly"

sub foo_array3 {
    return ('foo', 'bar', 'baz');
}
my @foo_array_return3 = foo_array3();
isa_ok(@foo_array_return3, Array);
is(+@foo_array_return3, 3, 'got the right number of return value');
is(@foo_array_return3[0], 'foo', 'got the right return value');
is(@foo_array_return3[1], 'bar', 'got the right return value');
is(@foo_array_return3[2], 'baz', 'got the right return value');

# ... returning an Array constructed "on the fly" w/out return statement

sub foo_array4 {
    ('foo', 'bar', 'baz');
}
my @foo_array_return4 = foo_array4();
isa_ok(@foo_array_return4, Array);
is(+@foo_array_return4, 3, 'got the right number of return value');
is(@foo_array_return4[0], 'foo', 'got the right return value');
is(@foo_array_return4[1], 'bar', 'got the right return value');
is(@foo_array_return4[2], 'baz', 'got the right return value');

## Array Refs aka - Lists

sub foo_array_ref {
   my $foo = ['foo', 'bar', 'baz'];
   return $foo;
}
my $foo_array_ref_return = foo_array_ref();
isa_ok($foo_array_ref_return, Array);
is(+$foo_array_ref_return, 3, 'got the right number of return value');
is($foo_array_ref_return[0], 'foo', 'got the right return value');
is($foo_array_ref_return[1], 'bar', 'got the right return value');
is($foo_array_ref_return[2], 'baz', 'got the right return value');

# ... w/out the return statement

sub foo_array_ref2 {
   my $foo = ['foo', 'bar', 'baz'];
   $foo;
}
my $foo_array_ref_return2 = foo_array_ref2();
isa_ok($foo_array_ref_return2, Array);
is(+$foo_array_ref_return2, 3, 'got the right number of return value');
is($foo_array_ref_return2[0], 'foo', 'got the right return value');
is($foo_array_ref_return2[1], 'bar', 'got the right return value');
is($foo_array_ref_return2[2], 'baz', 'got the right return value');

# ... returning list constructed "on the fly"

sub foo_array_ref3 {
   return ['foo', 'bar', 'baz'];
}
my $foo_array_ref_return3 = foo_array_ref3();
isa_ok($foo_array_ref_return3, Array);
is(+$foo_array_ref_return3, 3, 'got the right number of return value');
is($foo_array_ref_return3[0], 'foo', 'got the right return value');
is($foo_array_ref_return3[1], 'bar', 'got the right return value');
is($foo_array_ref_return3[2], 'baz', 'got the right return value');

# ... returning list constructed "on the fly" w/out return statement

sub foo_array_ref4 {
   ['foo', 'bar', 'baz'];
}
my $foo_array_ref_return4 = foo_array_ref4();
isa_ok($foo_array_ref_return4, Array);
is(+$foo_array_ref_return4, 3, 'got the right number of return value');
is($foo_array_ref_return4[0], 'foo', 'got the right return value');
is($foo_array_ref_return4[1], 'bar', 'got the right return value');
is($foo_array_ref_return4[2], 'baz', 'got the right return value');

## hashes

sub foo_hash {
    my %foo = ('foo', 1, 'bar', 2, 'baz', 3);
    return %foo;
}

my %foo_hash_return = foo_hash();
ok(%foo_hash_return ~~ Hash);
is(+%foo_hash_return.keys, 3, 'got the right number of return value');
is(%foo_hash_return<foo>, 1, 'got the right return value');
is(%foo_hash_return<bar>, 2, 'got the right return value');
is(%foo_hash_return<baz>, 3, 'got the right return value');

my $keys;
lives_ok({ $keys = +(foo_hash().keys) },
    "can call method on return value (hashref)");
is($keys, 3, "got right result");
lives_ok({ foo_hash()<foo> },
    "can hash de-ref return value (hashref)");

# now hash refs

sub foo_hash_ref {
    my $foo = { 'foo' => 1, 'bar' => 2, 'baz' => 3 };
    return $foo;
}

my $foo_hash_ref_return = foo_hash_ref();
ok($foo_hash_ref_return ~~ Hash);
is(+$foo_hash_ref_return.keys, 3, 'got the right number of return value');
is($foo_hash_ref_return<foo>, 1, 'got the right return value');
is($foo_hash_ref_return<bar>, 2, 'got the right return value');
is($foo_hash_ref_return<baz>, 3, 'got the right return value');

lives_ok({ $keys = +(foo_hash_ref().keys) },
    "can call method on return value (hashref)");
is($keys, 3, "got right result");
lives_ok({ foo_hash_ref()<foo> },
    "can hash de-ref return value (hashref)");

# from return2.t
{
  sub userdefinedcontrol_a (&block) { block(); return 24 }
  sub official_a {
    userdefinedcontrol_a { return 42 };
  }
  is official_a(), 42, "bare blocks are invisible to return";
}

{
  sub userdefinedcontrol_b (&block) { block(); return 24 }
  sub official_b {
    {
        {
            userdefinedcontrol_b { return 42 };
        }
    }
  }
  is official_b(), 42, "nested bare blocks are invisible to return";
}

{
  sub userdefinedcontrol_c ($value, &block) { block($value); return 24 }
  sub official_c($value) {
    {
        userdefinedcontrol_c $value, -> $x { return $x };
    }
  }
  is official_c(42), 42, "pointy blocks are invisible to return";
}

# return should desugar to &?ROUTINE.leave, where &?ROUTINE is lexically scoped
#    to mean the current "official" subroutine or method.

#?niecza todo
{
  sub userdefinedcontrol3 (&block) { block(); return 36 }
  sub userdefinedcontrol2 (&block) { userdefinedcontrol3(&block); return 24 }
  sub userdefinedcontrol1 (&block) { userdefinedcontrol2(&block); return 12 }
  sub official_d {
    userdefinedcontrol1 { return 42 };
  }
  #?pugs todo 'bug'
  is official_d(), 42,
    "subcalls in user-defined control flow are invisible to return";
}

class Foo {
  method userdefinedcontrol3 (&block) { block(); 36 }
  submethod userdefinedcontrol2 (&block) { self.userdefinedcontrol3(&block); 24 }
  method userdefinedcontrol1 (&block) { self.userdefinedcontrol2(&block); 12 }
  method officialmeth {
    self.userdefinedcontrol1({ return 42 });
  }
  submethod officialsubmeth {
    self.userdefinedcontrol1({ return 43 });
  }
  our sub official {
    Foo.new.userdefinedcontrol1({ return 44 });
  }
}

#?pugs 3 todo 'return(), blocks and methods'
#?niecza 3 todo
is Foo.new.officialmeth(), 42,
    "return correctly from official method only";
is Foo.new.officialsubmeth(), 43,
    "return correctly from official submethod only";
is Foo::official(), 44,
    "return correctly from official sub only";

# RT #75118
#?rakudo skip 'RT 75118'
#?niecza skip "Excess arguments to return, unused named c"
{
    sub named() {
        return 1, 2, :c(3);
    }
    is named().elems, 3,       'return with named arguments';
    is named().[2].key, 'c',   ' ... correct key';
    #?rakudo todo 'named argument to return()'
    is named().[2].value, '3', ' ... correct value';
}

# RT #61732
#?niecza todo
{
    sub rt61732_c { 1; CATCH {} }
    #?rakudo todo 'RT 61732'
    is rt61732_c(), 1, 'sub with empty catch block returns value before block';
}

#?niecza todo
{
    sub rt61732_d { 1;; }
    is rt61732_d(), 1, 'get right value from sub with double ;';
}

# RT #63912
{
    sub rt63912 { return 1, 2; }
    lives_ok { rt63912() }, 'can call sub that returns two things (no parens)';
}

# RT #72836
{
    class RT72836 {
        method new() { }
    }
    lives_ok {my $c = RT72836.new},
        'can use value returned from empty routine';
}

# RT #61126
#?niecza skip "eager NYI"
{
    sub bar61126($code) { $code() }; sub foo61126 { bar61126 { return 1 }; return 2; };
    is foo61126, 1;

    sub baz61126 { eager map { return 1 }, 1; return 2 };
    is baz61126, 1;

}

# vim: ft=perl6
