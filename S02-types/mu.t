use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 8;

# Tests for Mu type

{ # coverage; 2016-10-14

    # Note: many test functions can't take a Mu type object, so we cheat

    subtest 'Mu:U.self is identity' => {
        plan 2;
        cmp-ok    Mu.self, '=:=',  Mu,          'got self';
        is-deeply Mu.self.defined, Bool::False, 'not .defined';
    }

    subtest 'Mu:D.self is identity' => {
        plan 2;
        my \v := Mu.new;
        cmp-ok    v.self, '=:=',       v,          'got self';
        is-deeply Mu.new.self.defined, Bool::True, 'is .defined';
    }

    subtest 'Mu.return-rw' => {
        plan 3;

        sub rrw { my Mu $x; $x.return-rw }();
        cmp-ok    rrw.WHAT, '=:=',  Mu,     'got Mu';
        is-deeply rrw.defined, Bool::False, 'not .defined';
        lives-ok { rrw() = 42; }, 'can assign to returned value';
    }

    is_run 'Mu.new.put', { :err(''), :out(/^ 'Mu' /), :0status, },
        'Mu.put outputs self';

    is-deeply infix:<=:=>(False), Bool::True, 'single-arg =:= returns True (1)';
    is-deeply infix:<=:=>(42),    Bool::True, 'single-arg =:= returns True (2)';
    is-deeply infix:<eqv>(False), Bool::True, 'single-arg eqv returns True (1)';
    is-deeply infix:<eqv>(42),    Bool::True, 'single-arg eqv returns True (2)';
}

# vim: expandtab shiftwidth=4
