use Test;

plan 14;

=begin description

This test tests C<deepmap>.

=end description

{
    is-deeply deepmap({ $_ + 1}, (1, 2, 3)), (2, 3, 4), "deepmap works";
    is-deeply deepmap(* + 1, (1, 2, (3, (4)))), (2, 3, (4, (5))), "deepmap descends into sublists";
    is-deeply deepmap(* + 1, (1, 2, (), (3, ()))), (2, 3, (), (4, ())), "deepmap copes with empty lists";
    is-deeply deepmap(* ~ "_", {a => "a", b => "b"}), {a => "a_", b => "b_"}, "deepmap descends into hashes";

    my $list = ("a", ("bb", "ccc"), "dddd");
    is-deeply deepmap({.chars}, $list), (1, (2, 3), 4), "deepmap applies correctly";
    is-deeply $list.deepmap(*.chars), (1, (2, 3), 4), "deepmap is callable as method";

    {
        my $in = [1, (2, 3), {a => 4, b => 5, c => [5, 6]}, {d => {a => 7}}, [8, 9]];
        my $expected = [-1, (-2, -3), {a => -4, b => -5, c => [-5, -6]}, {d => {a => -7}}, [-8, -9]];
        is-deeply $in.deepmap(-*), $expected, "deepmap preserves structure";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6302
lives-ok { Array».gist; deepmap *.self, Array },
    'hypering or deepmapping an Iterable type object does not hang';

# regression spotted by gfldex++
is <a b c>.deepmap({ next if $_ eq "b"; $_ }), "a c", 'did next work';
is <a b c>.nodemap({ next if $_ eq "b"; $_ }), "a c", 'did next work';

# regression spotted by SqrtNegInf++
# Note that we cannot use is-deeply, as that ignores differences
# at the container level.
is ((0,1),(2,3)).deepmap(* + 1).raku, '($(1, 2), $(3, 4))',
  'did we get sublists in containers';

# https://github.com/rakudo/rakudo/issues/5778
{
    my Str @a = <a bb cccc>;
    is-deeply @a.deepmap("x" ~ *), (my Str @ = <xa xbb xcccc>),
      'do we get a Str @ if the constraint allows';
    is-deeply @a.deepmap(*.chars), (1,2,4),
      'do we get a List if the constraint disallows';
}

# https://github.com/rakudo/rakudo/issues/4435
{
    my @data =
      { val => 1, name => 'alpha', },
      { val => 2, name => 'beta',  },
      { val => 3, name => 'gamma', },
      { val => 4, name => 'delta', },
    ;
    is-deeply @data.deepmap({ $_ + 10 if $_ ~~ Numeric }),
      [{ :11val }, { :12val }, { :13val }, { :14val }],
      'did the keys and values match up?';
}

# vim: expandtab shiftwidth=4
