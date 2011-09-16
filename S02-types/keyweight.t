use v6;
use Test;
plan 8;

#?rakudo emit class FatRat { method new($x, $y) { Rat.new($x, $y) } }; # FatRat NYI, so we fake it with Rat

# the below smartlink is broken; KeyWeight apparently is no longer specced
# L<S02/Mutable types/KeyWeight>

{
    my %h is KeyWeight = a => FatRat.new(1,2), b => FatRat.new(3,4);
    is +%h.keys, 2, 'Inititalization worked';

    is +%h, (FatRat.new(1,2) + FatRat.new(3,4)), '+%h works';

    %h<a> = FatRat.new(0, 1);
    is +%h.keys, 1, 'After setting an item to FatRat.new(0, 1), an item is gone';
    is ~%h.keys, 'b', '... and the right one is gone';
    is +%h, FatRat.new(3,4), '... and +%h has changed appropriately';
}

# L<S32::Containers/KeyWeight>

{
    my %h is KeyWeight = a => FatRat.new(1,2), b => FatRat.new(3,4);
    %h<a> = FatRat.new(-1,1); # negative key
    is +%h.keys, 2, 'No deletion of negative keys'; # may warn

    %h = x => FatRat.new(2,3), y => FatRat.new(1,3);
    my @a = %h.roll: 25;
    ok 2 < @a.grep(* eq 'y') < 25, 'KeyWeight.roll(25) (1)';
    ok @a.grep(* eq 'y') < @a.grep({* eq 'x'}), 'KeyWeight.roll(25) (2)';
}

# vim: ft=perl6
