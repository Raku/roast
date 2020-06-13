use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 9;

# https://github.com/Raku/old-issue-tracker/issues/3084
{
    my $c = [[1], [2], [3]].map( { $_ } ).Array;
    $c.unshift(7);
    is $c.elems, 4, ".unshift in sink context doesn't empty Array";
}

# https://github.com/Raku/old-issue-tracker/issues/3127
{
    eval-lives-ok "List.sink", "can sink a List";
}

# https://github.com/Raku/old-issue-tracker/issues/5123
{
    my $sunk = False;
    my ($a) = class { method sink { $sunk = True } }.new;
    is $sunk, False, 'my ($a) = ... does not trigger sinking';
}

# https://github.com/Raku/old-issue-tracker/issues/5233
{
    my @results = gather for 1..1 { ^10 .map: *.take }

    is @results, "0 1 2 3 4 5 6 7 8 9", "map inside sunk 'for' runs as sunk";
}

#?rakudo.jvm todo 'is True'
{
    my $sunk = False;
    my sub wrap_in_scalar() is rw {
        my $var = class { method sink { $sunk = True } }.new;
        $var;
    }

    wrap_in_scalar();

    is $sunk, False, "we don't sink things that are wrapped in a container";
}

{
    my $sunk = False;
    (class {
      method STORE(*@args) {
      }

      method foo() {
          self;
      }

      method sink() {
          $sunk = True;
      }
    # NOTE: whitespace between elements on next line is significant as some
    # implementations have different code path for `|.=foo` vs `| .=fo`
    }.new).=foo;

    is $sunk, False, "we don't sink the result of thing().=method-name";
}

{
    my $sunk = False;
    (class {
      method STORE(*@args) {
      }

      method foo() {
          self;
      }

      method sink() {
          $sunk = True;
      }
    # NOTE: whitespace between elements on next line is significant as some
    # implementations have different code path for `|.=foo` vs `| .=fo`
    }.new) .= foo;

    is $sunk, False, "we don't sink the result of thing() .= method-name";
}

# https://github.com/rakudo/rakudo/issues/1531
subtest 'sub calls in last statement of sunk `for` get sunk' => {
    plan 4;
    my $a; $a Z+= 2 for ^3;
    is-deeply $a, 6, 'postfix `for`, Z+= op';

    my $b; for ^3 { $b Z+= 2 }
    is-deeply $b, 6, 'block `for`, Z+= op';

    throws-like { sub foo {fail}; foo for ^1; Nil }, Exception,
        'postfix `for` with sub that returns Failure';

    throws-like { sub foo {fail}; for ^1 { foo }; Nil }, Exception,
        'block `for` with sub that returns Failure';
}

# https://github.com/rakudo/rakudo/issues/1693
is_run ｢unit package A; our sub need() {}; for <s> { A::need }; print 'pass'｣,
    { :out<pass>, :err(''), :0status}, 'no crash in for ... { Package::foo }';

# vim: expandtab shiftwidth=4
