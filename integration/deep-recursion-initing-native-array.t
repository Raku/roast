use Test;

plan 1;

# RT #130294
# This test is in a file of its own, because the bug it covered was quite
# sensitive to small changes.

my $size = 10001;
my int @mat[$size; $size];
init-array(0, $size - 1, $size * $size);
pass 'No SEGV or other crash in recursive init routine on a native array';

sub init-array($r, $c, $val) {
  @mat[$r; $c] = $val;
  if $c - 1 >= 0
  { # left
    init-array($r, $c - 1, $val - 1);
  }
  elsif $r + 1 < $size
  { # down
    init-array($r + 1, $c, $val - 1);
  }
}
