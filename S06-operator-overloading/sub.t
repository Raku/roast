use v6;

use Test;

plan 30;

=begin pod

Testing operator overloading subroutines

=end pod

# L<S06/"Operator overloading">

# This set of tests is very basic for now.
# TODO: all variants of overloading syntax (see spec "So any of these")


{
    sub postfix:<W> ($wobble) { return "ANDANDAND$wobble"; };

    is("boop"W, "ANDANDANDboop",
       'postfix operator overloading for new operator');
}

{
    sub postfix:<&&&&&> ($wobble) { return "ANDANDANDANDAND$wobble"; };
    is("boop"&&&&&, "ANDANDANDANDANDboop",
       "postfix operator overloading for new operator (weird)");
}

# demonstrate sum prefix

{
    my sub prefix:<Σ> (@x) { [+] @x }
    is(Σ [1..10], 55, "sum prefix operator");
}

# check that the correct overloaded method is called
{
    multi postfix:<!> ($x) { [*] 1..$x }
    multi postfix:<!> (Str $x) { return($x.uc ~ "!!!") }

    is(10!, 3628800, "factorial postfix operator");
    is("bumbershoot"!, "BUMBERSHOOT!!!", "correct overloaded method called");
}

# [NOTE]
# pmichaud ruled that prefix:<;> and postfix:<;> shouldn't be defined by
# the synopses: https://irclog.perlgeek.de/perl6/2006-07-29#i_-200213
# so we won't test them here.

# Overriding prefix:<if>
# L<S04/"Statement parsing" /"since prefix:<if> would hide statement_modifier:<if>">
#?rakudo skip 'missing block, apparently "if" not an op RT #124982'
{
    my proto prefix:<if> ($a) { $a*2 }
    is (if+5), 10;
}

# [NOTE]
# pmichaud ruled that infix<if> is incorrect:
#   https://irclog.perlgeek.de/perl6/2006-07-29#i_-200221
# so we won't test it here either.

# great.  Now, what about those silent auto-conversion operators a la:
# multi sub prefix:<+> (Str $x) returns Num { ... }
# ?

# I mean, + is all well and good for number classes.  But what about
# defining other conversions that may happen?

# RT #86906
{
    throws-like { EVAL q[ multi sub circumfix:<⌊⌋>($a) { return $a.floor; } ] },
        X::Syntax::AddCategorical::TooFewParts,
        message => "Not enough symbols provided for categorical of type circumfix; needs 2",
        'circumfix definition without whitespace between starter and stopper fails with X::Syntax::AddCategorical::TooFewParts';

    throws-like { EVAL q[ multi sub circumfix:< ⌊ | ⌋ >($a) { return $a.floor; } ] },
        X::Syntax::AddCategorical::TooManyParts,
        message => "Too many symbols provided for categorical of type circumfix; needs only 2",
        'circumfix definition with three parts fails with X::Syntax::AddCategorical::TooManyParts';

    throws-like { EVAL q[ multi sub infix:< ⌊ ⌋ >($a) { return $a.floor; } ] },
        X::Syntax::AddCategorical::TooManyParts,
        message => "Too many symbols provided for categorical of type infix; needs only 1",
        'infix definition with two parts fails with X::Syntax::AddCategorical::TooManyParts';

    throws-like { EVAL q[ multi sub term:< foo bar >() { return pi; } ] },
        X::Syntax::AddCategorical::TooManyParts,
        message => "Too many symbols provided for categorical of type term; needs only 1",
        'term definition with two parts fails with X::Syntax::AddCategorical::TooManyParts';
}


# taken from S06-operator-overloading/method.t
{
    class Bar {
        has $.bar is rw;
        method Stringy() { ~self }; # the tests assume prefix:<~> gets called by qq[], but .Stringy gets actually called
    }

    multi sub prefix:<~> (Bar $self)      { return $self.bar }
    multi sub infix:<+>  (Bar $a, Bar $b) { return "$a $b" }

    {
        my $val;
        my $foo = Bar.new();
        $foo.bar = 'software';
        $val = "$foo";
        is($val, 'software', '... basic prefix operator overloading worked');

        lives-ok {
            my $foo = Bar.new();
            $foo.bar = 'software';
            $val = $foo + $foo;
        }, '... class methods work for class';
        is($val, 'software software', '... basic infix operator overloading worked');
    }

# Test that the object is correctly stringified when it is in an array.
# And test that »...« automagically work, too.
    {
        my $obj;
        $obj     = Bar.new;
        $obj.bar = "pugs";

        my @foo = ($obj, $obj, $obj);
        my $res;
        lives-ok { $res = ~<<@foo }, "stringification didn't die";
        is $res, "pugs pugs pugs", "stringification overloading worked in array stringification";
    }


}


# RT #116643
{
    lives-ok { sub prefix:<\o/>($) {} }, 'can declare operator with a backslash (1)';
    lives-ok { sub postfix:<\\>($) {} }, 'can declare operator with a backslash (2)';

    my $RT116643 = EVAL 'sub infix:<\\o/>($a, $b) { $a * $b }; 21 \\o/ 2';
    is $RT116643, 42, 'can declare and use operator with a backslash';
}

# RT #115724
{
    lives-ok { sub circumfix:<w "> ($a) { }; },
        'can define circumfix operator with a double quote (")';
    my $RT115724 = EVAL 'sub circumfix:<w "> ($a) { $a }; w 111 "';
    is $RT115724 , 111, 'can define and use circumfix operator with a double quote (")';
}

# RT #117737
{
    throws-like { EVAL q< sub infix:[/./] { 42 } > },
        X::Syntax::Extension::TooComplex,
        message => "Colon pair value '/./' too complex to use in name",
        'infix definition for /./ fails with X::Syntax::Extension::TooComplex';
}

# RT #119919
{
    lives-ok { sub infix:["@"] ($a, $b) { 42 } },
        'can define infix with brackets as delimiter';
    my $RT119919 = EVAL 'sub infix:["@"] ($a, $b) { 42 }; 5@5';
    is $RT119919, 42, 'can define and use infix with brackets as delimiter';

    lives-ok { sub circumfix:["@", "@"] ($a) { $a } },
        'can define circumfix with brackets as delimiter';
    #?rakudo.jvm emit # TTIAR
       $RT119919 = EVAL 'sub circumfix:["@", "@"] ($a) { $a }; @ 5 @';
    #?rakudo.jvm skip 'failing due to above failure'
    is $RT119919, 5, 'can define and use circumfix with brackets as delimiter';

    constant sym = "µ";
    sub infix:[sym] { "$^a$^b" };
    is 5 µ 5, "55", 'can define and use operator with a sigilless constant as symbol';
    constant $sym = "°";
    sub infix:[$sym] { "$^a$^b" };
    is 5 ° 5, "55", 'can define and use operator with a sigiled constant as symbol';
}

{
    throws-like ｢sub meow:<bar> {}｣, X::Syntax::Extension::Category,
        'defining custom op in non-exitent category throws';

    subtest ':sym<> colonpair on subroutine names is reserved' => {
        plan 6;
        #?rakudo 2 todo 'a 6.c-errata test demands these throw X::Syntax::Extension::Category'
        throws-like 'sub meow:sym<bar> {}', X::Syntax::Reserved, ':sym<...>';
        throws-like 'sub meow:sym«bar» {}', X::Syntax::Reserved, ':sym«...»';
        throws-like 'sub meow:foo<bar>:sym<bar> {}', X::Syntax::Reserved,
            ':foo<bar>:sym<...>';
        throws-like 'sub meow:foo<bar>:sym«bar» {}', X::Syntax::Reserved,
            ':foo<bar>:sym«...»';
        throws-like 'sub meow:sym<bar>:foo<bar> {}', X::Syntax::Reserved,
            ':sym<...>:foo<bar>';
        throws-like 'sub meow:sym«bar»:foo<bar> {}', X::Syntax::Reserved,
            ':sym«...»:foo<bar>';
    }

    eval-lives-ok ｢sub meow:foo<bar> {42}; meow:foo<bar>() == 42 or die｣,
        'can use colon-name extended sub name';
}

# vim: ft=perl6
