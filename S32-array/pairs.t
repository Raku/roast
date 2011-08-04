use v6;

use Test;

plan 14;

=begin description

Basic C<pairs> tests, see S32.

=end description

# L<S32::Containers/"Array"/=item pairs>

{
  my @array = <a>;
  my @pairs;
  ok((@pairs = pairs(@array)), "basic pairs on arrays with a function");
  is +@pairs, 1,            "pairs on arrays returned the correct number of elems";
  if +@pairs != 1 {
    skip "skipped tests which depend on a test which failed", 2;
  } else {
    is @pairs[0].key,     0,  "key of pair returned by array.pairs was correct (1)";
    is @pairs[0].value, "a",  "value of pair returned by array.pairs was correct (1)";
  }
}

{
  my @array = <a b c>;
  my @pairs;
  ok((@pairs = @array.pairs), "basic pairs on arrays with oo invocation");
  is +@pairs, 3,            "pairs on arrays returned the correct number of elems";
  if +@pairs != 3 {
    skip "skipped tests which depend on a test which failed", 6;
  } else {
    is @pairs[0].key,     0,  "key of pair returned by array.pairs was correct (1)";
    is @pairs[1].key,     1,  "key of pair returned by array.pairs was correct (2)";
    is @pairs[2].key,     2,  "key of pair returned by array.pairs was correct (3)";
    is @pairs[0].value, "a",  "value of pair returned by array.pairs was correct (1)";
    is @pairs[1].value, "b",  "value of pair returned by array.pairs was correct (2)";
    is @pairs[2].value, "c",  "value of pair returned by array.pairs was correct (3)";
  }
}

#?pugs todo 'bug'
{
    my @array = (17, 23, 42);

    lives_ok { for @array.pairs -> $pair {
        $pair.value += 100;
    } }, 'aliases returned by @array.pairs should be rw (1)';

    #?rakudo todo 'Apparently not rw yet?'
    is @array[1], 123, 'aliases returned by @array.pairs should be rw (2)';
}

# vim: filetype=perl6
