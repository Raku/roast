use v6.c;

use Test;

# L<S04/The C<for> statement>
# L<S32::Containers/List/=item map>
# L<S32::Containers/List/=item sort>

plan 4;

# works
{
  my @array = <1 2 3 4>;
  my $output='';

  for (map { 1 }, @array) -> $elem {
    $output ~= "$elem,";
  }

  is $output, "1,1,1,1,", "map works in for";
}

# works, too
{
  my @array = <1 2 3 4>;
  my $output='';

  for sort @array -> $elem {
    $output ~= "$elem,";
  }

  is $output, "1,2,3,4,", "sort works in for";
}

{
  my @array = <1 2 3 4>;
  my $output='';

  for (map { 1 }, sort @array) -> $elem {
    $output ~= "$elem,";
  }

  is $output, "1,1,1,1,", "map and sort work in for";
}

{
  my @array = <1 2 3 4>;
  my $output='';

  for (map { $_ * 2 }, sort @array) -> $elem {
    $output ~= "$elem,";
  }

  is $output, "2,4,6,8,", "map and sort work in for";
}

# vim: ft=perl6
