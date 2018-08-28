use v6;
use Test;
plan 20;

sub eval_elsewhere($code){ EVAL($code) }

#L<S03/Smart matching/Hash Hash Match if $_ eqv X>
my %hash1 = ( "foo"  => "Bar",  "blah" => "ding");
my %hash2 = ( "blah" => "ding", "foo"  => "Bar");   # order reversed
my %hash3 = ( "foo"  => "zzz",  "blah" => "frbz");  # same keys different values
my %hash4 = ( "oink" => "da",   "zork" => "zork");  # different keys and values
my %hash5 = ( "oink" => "da",   "zork" => Mu);      # Mu values cannot be equivalent (eqv): Must not die and must returns False (#1772)

{
    ok  (%hash1 ~~ %hash1),  'Hash ~~ Hash ($_ eqv X) 1';
    ok  (%hash1 ~~ %hash2),  'Hash ~~ Hash ($_ eqv X) 2';
    nok (%hash1 ~~ %hash3),  'Hash ~~ Hash ($_ eqv X) 3';
    nok (%hash1 ~~ %hash4),  'Hash ~~ Hash ($_ eqv X) 4';
    nok (%hash1 ~~ %hash5),  'Hash ~~ Hash ($_ eqv X) 5';
    nok (%hash1 !~~ %hash1), 'Hash !~~ Hash ($_ eqv X) 1';
    nok (%hash1 !~~ %hash2), 'Hash !~~ Hash ($_ eqv X) 2';
    ok  (%hash1 !~~ %hash3), 'Hash !~~ Hash ($_ eqv X) 3';
    ok  (%hash1 !~~ %hash4), 'Hash !~~ Hash ($_ eqv X) 4';
    ok  (%hash1 !~~ %hash5), 'Hash !~~ Hash ($_ eqv X) 4';

    ok  eval_elsewhere('(%hash1 ~~ %hash1)'),  'Hash ~~ Hash, eval_elsewhere 1';
    ok  eval_elsewhere('(%hash1 ~~ %hash2)'),  'Hash ~~ Hash, eval_elsewhere 2';
    nok eval_elsewhere('(%hash1 ~~ %hash3)'),  'Hash ~~ Hash, eval_elsewhere 3';
    nok eval_elsewhere('(%hash1 ~~ %hash4)'),  'Hash ~~ Hash, eval_elsewhere 4';
    nok eval_elsewhere('(%hash1 ~~ %hash5)'),  'Hash ~~ Hash, eval_elsewhere 5';
    nok eval_elsewhere('(%hash1 !~~ %hash1)'), 'Hash !~~ Hash, eval_elsewhere 1';
    nok eval_elsewhere('(%hash1 !~~ %hash2)'), 'Hash !~~ Hash, eval_elsewhere 2';
    ok  eval_elsewhere('(%hash1 !~~ %hash3)'), 'Hash !~~ Hash, eval_elsewhere 3';
    ok  eval_elsewhere('(%hash1 !~~ %hash4)'), 'Hash !~~ Hash, eval_elsewhere 4';
    ok  eval_elsewhere('(%hash1 !~~ %hash5)'), 'Hash !~~ Hash, eval_elsewhere 5';
}

# vim: ft=perl6
