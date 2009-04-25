use v6;

use Test;
plan 1;

class Mock::PGE::Match {
   method isa($x) {
      return $x === PGE::Match || self.HOW.isa(self, $x);
   }
   # ...
}

sub get_pir_isa_pge_match {
   Q:PIR {
      get_hll_global $P0, ["Mock";"PGE"], "Match"
      $P1 = $P0."new"()
      $I0 = isa $P1, ["PGE";"Match"] # add "Mock" to fudge success ...
      .return ($I0)
   }
}

my $m = Mock::PGE::Match.new;
is get_pir_isa_pge_match(), $m.isa(PGE::Match), 'RT 60946 pir isa override' ;
