use v6;
use Test;
use lib $?FILE.IO.parent(3).add("packages/Test-Helpers");
use Test::Util;

plan 10;

sub is-eqv-fails ($code, $desc) is test-assertion {
    my $package-lib-prefix = $?FILE.IO.parent(3).add('packages/Test-Helpers').absolute;

    is_run ~ "use lib $package-lib-prefix.raku();\n" ~ ｢
        use Test;
        use Test::Util;
      ｣ ~ $code,
      {
        :out{so .contains: all 'not ok', 'meows'},
        :err{.contains: 'Failed test'}
      },
      $desc;
}

is-eqv Seq,           Seq,           'Seq:U, Seq:U';
is-eqv (1, 2, 3).Seq, (1, 2, 3).Seq, 'Seq:D, Seq:D';
is-eqv (1, 2, 3),     (1, 2, 3),     'List:D, List:D';
is-eqv-fails ｢is-eqv Seq, (1, 2, 3).Seq, 'meows'     ｣, 'Seq:U, Seq:D';
is-eqv-fails ｢is-eqv (1, 2, 3).Seq, Seq, 'meows'     ｣, 'Seq:D, Seq:U';
is-eqv-fails ｢is-eqv (1, 2, 3).Seq, (1,).Seq, 'meows'｣, 'Seq:D, different Seq:D';
is-eqv-fails ｢is-eqv (1, 2, 3).Seq, (1,), 'meows'    ｣, 'Seq:D, List:D';
is-eqv-fails ｢is-eqv (1,), (1, 2, 3).Seq, 'meows'    ｣, 'List:D, Seq:D';
is-eqv-fails ｢is-eqv (1,), (1, 2, 3), 'meows'        ｣, 'List:D, different List:D';
is-eqv-fails ｢is-eqv (1,), 1, 'meows'                ｣, 'List:D, Int:D';


# vim: expandtab shiftwidth=4
