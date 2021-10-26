use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

=begin description

Tests the cases where multi-dispatch is resolved sequentially (e.g. ambiguous subsets/where clauses)

=end description

# L<S12/"Types and Subtypes">

plan 2;

# https://github.com/Raku/roast/issues/7651
group-of 2 => 'ambiguous subset matches resolved sequentially' => {
  # note: godzilla is both a monster and a hero
  subset Monster of Str where { $_ eq any( <godzilla gammera ghidra golem> ) };
  subset Hero    of Str where { $_ eq any( <godzilla beowulf ultraman inframan> ) };

  group-of 2 => 'two multis based on subsets' => {
    multi sub classify (Monster $name) {
        return "$name is a monster";
    }
    multi sub classify (Hero $name) {
        return "$name is a hero";
    }
    is( classify('ultraman'), "ultraman is a hero",
        "Testing that the multi with the only subset match runs.");
    is( classify('godzilla'), "godzilla is a monster",
        "Testing ambiguous case runs first multi that matches.");
   }
  group-of 2 => 'two multis reversed' => { 
    # here the same multis are defined in a different order
    multi sub classify (Hero $name) {
        return "$name is a hero";
    }
    multi sub classify (Monster $name) {
        return "$name is a monster";
    }
    is( classify('ultraman'), "ultraman is a hero",
        "Testing that the multi with the only subset match runs.");
    is( classify('godzilla'), "godzilla is a hero",
        "Testing ambiguous case runs first multi that matches.");
   }
}


group-of 1 => 'negative case' => {
    multi sub classify (Hero $name) {
        return "$name is a hero";
    }
    throws-like { classify('doris_day') }, Exception,
    "Testing that disallowed strings throw exceptions.";
}




