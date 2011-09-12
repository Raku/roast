# http://perl6advent.wordpress.com/2009/12/18/day-18-roles/

use v6;
use Test;
plan 6;

role BatteryPower {
    has $.battery-type;
    has $.batteries-included;
    method find-power-accessories() {
        return ProductSearch::find($.battery-type);
    }
}

class ElectricCar does BatteryPower {
    has $.manufacturer;
    has $.model;
}

role SocketPower {
    has $.adapter-type;
    has $.min-voltage;
    has $.max-voltage;
    method find-power-accessories() {
        return ProductSearch::find($.adapter-type);
    }
}

#~ class Laptop does BatteryPower does SocketPower {}
eval_dies_ok 'class Laptop does BatteryPower does SocketPower {}' , "Method 'find-power-accessories' collides and a resolution must be provided by the class";

class Laptop does BatteryPower does SocketPower {
    method find-power-accessories() {
        my $ss = $.adapter-type ~ ' OR ' ~ $.battery-type;
        return ProductSearch::find($ss);
    }
}

my Laptop $l ;
is $l.WHAT.gist , 'Laptop()' , 'If we resolve the conflict we can create laptops';

role Cup[::Contents] { }
role Glass[::Contents] { }
class EggNog { }
class MulledWine { }

my Cup of EggNog $mug ;
my Glass of MulledWine $glass ;

role Tray[::ItemType] { }
my Tray of Glass of MulledWine $valuable;

#?rakudo todo 'nom regression'
is $mug.WHAT.perl , 'Cup[EggNog]' , 'the $mug is a Cup of EggNog';
#?rakudo todo 'nom regression'
is $glass.WHAT.perl , 'Glass[MulledWine]' , 'the $glass is a Glass of MulledWine';
#?rakudo todo 'nom regression'
is $valuable.WHAT.perl , 'Tray[Glass[MulledWine]]' , 'the $valuable is a Tray of Glass of MulledWine';

#?rakudo skip 'parse error'
lives_ok 'role DeliveryCalculation[::Calculator] {has $.mass;method calculate($destination) {my $calc = Calculator.new(:$!mass);}}' , "Refering to $.mass and $!mass";

#TODO: When rakudo can pass the previous test we can add full tests for the role.
#~ role DeliveryCalculation[::Calculator] {
    #~ has $.mass;
    #~ has $.dimensions;
    #~ method calculate($destination) {
        #~ my $calc = Calculator.new(
            #~ :$!mass,
            #~ :$!dimensions
        #~ );
        #~ return $calc.delivery-to($destination);
    #~ }
#~ }

#~ class Furniture does DeliveryCalculation[ByDimension] {
#~ }
#~ class HeavyWater does DeliveryCalculation[ByMass] {
#~ }

done();
