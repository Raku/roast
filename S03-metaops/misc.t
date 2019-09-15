use v6;
use lib <t/packages>;
use Test;
use Test::Helpers;

plan 1;

=begin pod

=head1 DESCRIPTION

Miscellaneous metaop tests that don't fit into other files in this directory.

=end pod

# Covers opts in https://github.com/rakudo/rakudo/commit/b9b0838dd8
subtest 'cover metaop call simplification optimization' => {
    plan 8;
    subtest '(//=) +=' => {
        plan 2;
        my $a;
        ($a //= 42) += 10;
        is-deeply $a, 52, '(1)';
        ($a //= 42) += 10;
        is-deeply $a, 62, '(2)';
    }
    subtest 'R+= (||=)' => {
        plan 2;
        my $a;
        10 R+= ($a ||= 42);
        is-deeply $a, 52, '(1)';
        10 R+= ($a ||= 42);
        is-deeply $a, 62, '(2)';
    }
    subtest '(((R+= ([R-]=)) //=) +=)' => {
        plan 1;
        my $a = 12;
        ((10 R+= ($a [R-]= 42)) //= 100) += 1000;
        is-deeply $a, 1040, '(1)';
    }
    subtest '(((R+= ([R-]=)) //=) +=)' => {
        plan 1;
        my $a = 12;
        ((10 R+= ($a [R-]= 42)) //= 100) += 1000;
        is-deeply $a, 1040, '(1)';
    }
    subtest 'array var with ((||=) += )' => {
        plan 1;
        my @a = 20; (@a ||= 42) += 10;
        is-deeply @a, [11], '(1)';
    }

    # https://github.com/rakudo/rakudo/issues/1989
    subtest 'metassign to array/hash returned from a method' => {
        plan 2;
        my class Foo { has @.a is rw; has %.h is rw };
        my $o := Foo.new: :h{:42foo};
        is-deeply ($o.a += <a b c>), [3], '+= to array';
        is-deeply ($o.h ,= :100bar), {:42foo, :100bar}, ',= to hash';
    }
    subtest 'failure modes' => {
        plan 5;
        throws-like ｢my $a := 42; ($a //= 42)  += 10｣, X::Assignment::RO, '(1)';
        throws-like ｢my $a := 42; ($a ||= 42) R+= 10｣, X::Assignment::RO, '(2)';
        throws-like ｢my $a  = 42; ($a ||= 42) R+= 10｣, X::Assignment::RO, '(3)';
        throws-like ｢my $a  = 42; 1000 += ((10 R+= ($a [R-]= 42)) //= 100)｣, X::Assignment::RO,
            '(4)';
        # https://github.com/rakudo/rakudo/issues/1987
        throws-like '42.abs += 42', X::Assignment::RO, '(5)';
    }
    # GH rakudo/rakudo#1205
    # $_ = 1; $_ &= 2; must result in all(1,2)
    subtest 'assignment to a scalar' => {
        plan 3;
        my %junction_ops = :all<&>, :any<|>, :one<^>;
        for %junction_ops.pairs -> (:key($type), :value($op)) {
            doesn't-hang 'my $j = 1; $j ' ~ $op ~ '= 2; print $j.gist',
                         "junction '$type' doesn't freeze after assign metaop",
                         :out("{$type}(1, 2)"),
                         :err("");
        }
    }
}
