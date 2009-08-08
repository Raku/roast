use v6;
use Test;

# L<S09/Autovivification/>

plan 7;

{
  my $foo = 0;
  $foo++;
  is $foo, 1, 'lvalue $var works';
}

{
  my $foo = [0];
  $foo[0]++;
  is $foo[0], 1, 'lvalue $var[] works';
}

{
  my $foo = [[0]];
  $foo[0][0]++;
  is $foo[0][0], 1, 'lvalue $var[][] works';
}

{
  my @foo = [0];
  @foo[0][0]++;
  is @foo[0][0], 1, 'lvalue @var[][] works';
}

{
  is ++[[0]][0][0], 1, 'lvalue [[]][][] works';
}

{
  my $foo = {a => [0]};
  $foo<a>[0]++;
  is $foo<a>[0], 1, 'lvalue $var<>[] works';
}

{
  my %foo = (a => [0]);
  %foo<a>[0]++;
  is %foo<a>[0], 1, 'lvalue %var<>[] works';
}

# vim: ft=perl6
