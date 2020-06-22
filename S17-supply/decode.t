use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @utf8 =
  utf8.new(100,111,103),          # dog
  utf8.new(106,117,109,112,115),  # jumps
  utf8.new(111,118,101,114,13),   # over\r
  utf8.new(10,116,104,101),       # \nthe
  utf8.new(108,97,122,121),       # lazy
  utf8.new(102,111,120)           # fox
;
my @utf16 =
  utf16.new(100,111,103),          # dog
  utf16.new(106,117,109,112,115),  # jumps
  utf16.new(111,118,101,114,13),   # over\r
  utf16.new(10,116,104,101),       # \nthe
  utf16.new(108,97,122,121),       # lazy
  utf16.new(102,111,120)           # fox
;
my @str = <<do gjump sover "\r\nth" elaz yfo x>>;
my @schedulers = ThreadPoolScheduler.new, CurrentThreadScheduler;

plan @schedulers * 4;

for @schedulers -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    for \(), \("utf8") -> \c {
        tap-ok Supply.from-list(@utf8).decode(|c), @str,
          "decode a simple list of words with {c.raku.substr(1)}";
    }

    for \("utf16") -> \c {
        tap-ok Supply.from-list(@utf16).decode(|c), @str,
          "decode a simple list of words with {c.raku.substr(1)}";
    }

    is Supply.from-list(utf8.new(13),utf8.new(10)).decode.Seq[0].chars, 1,
      'did the separate \\r \\n join into a single char';
}

# vim: expandtab shiftwidth=4
