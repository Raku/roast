# http://perl6advent.wordpress.com/2009/12/18/day-18-roles/

use v6;
use Test;
plan 7;

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

#~ class Notebook does BatteryPower does SocketPower {}
throws_like { EVAL 'class Notebook does BatteryPower does SocketPower {}' },
  Exception, # doesn't have its own exception yet
  "Method 'find-power-accessories' collides and a resolution must be provided by the class";

class Laptop does BatteryPower does SocketPower {
    method find-power-accessories() {
        my $ss = $.adapter-type ~ ' OR ' ~ $.battery-type;
        return ProductSearch::find($ss);
    }
}

my Laptop $l ;
is $l.WHAT.gist , '(Laptop)' , 'If we resolve the conflict we can create laptops';

role Cup[::Contents] { }
role Glass[::Contents] { }
class EggNog { }
class MulledWine { }

my Cup of EggNog $mug ;
my Glass of MulledWine $glass ;

role Tray[::ItemType] { }
my Tray of Glass of MulledWine $valuable;

is $mug.WHAT.perl , 'Cup[EggNog]' , 'the $mug is a Cup of EggNog';
is $glass.WHAT.perl , 'Glass[MulledWine]' , 'the $glass is a Glass of MulledWine';
is $valuable.WHAT.perl , 'Tray[Glass[MulledWine]]' , 'the $valuable is a Tray of Glass of MulledWine';

role DeliveryCalculation[::Calculator] {
    has $.mass;
    has $.dimensions;
    method calculate($destination) {
        my $calc = Calculator.new(
            :$!mass,
            :$!dimensions
        );
        return $calc.delivery-to($destination);
    }
}

class ByDimension {
    has $.mass;
    has $.dimensions;
    method delivery-to($destination) {
        "ship $.dimensions to $destination";
    }
}

class ByMass {
    has $.mass;
    has $.dimensions;
    method delivery-to($destination) {
        "lug $.mass to $destination";
    }
}

class Furniture does DeliveryCalculation[ByDimension] {
}

class HeavyWater does DeliveryCalculation[ByMass] {
}

my $king-sized-bed = Furniture.new(:dimensions<1.8m X 2.0m X 0.5m>, :mass<30kg>);
my $reactor-top-up = HeavyWater.new(:dimensions<1m X 1m X 1m>, :mass<1107Kg>);

is $king-sized-bed.calculate('down-town'), 'ship 1.8m X 2.0m X 0.5m to down-town', 'parametic role;';
is $reactor-top-up.calculate('Springfield'), 'lug 1107Kg to Springfield', 'parametic role;';

done();
