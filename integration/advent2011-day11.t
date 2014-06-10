# http://perl6advent.wordpress.com/2011/12/11/privacy-and-oop/
use v6;
use Test;
plan 5;

class Order {
    my class Item {
	has $.name;
	has $.price;
    }

    has Item @!items;

    method add_item($name, $price) {
	@!items.push(Item.new(:$name, :$price))
    }

    method discount() {
	self!compute_discount()
    }

    method total() {
	self!compute_subtotal() - self!compute_discount();
    }

    method !compute_subtotal() {
	[+] @!items>>.price
    }

    method !compute_discount() {
	my $sum = self!compute_subtotal();
	if $sum >= 1000 {
	    $sum * 0.15
	}
	elsif $sum >= 100 {
	    $sum * 0.1
	}
	else {
	    0
	}
    }

    method total-sanity {EVAL 'self!compute_subtotal() - self!compute_discount()'}
    method total-with-typo {EVAL 'self!compite_subtotal() - self!compute_discount()'}
}

my $order = Order.new;
$order.add_item('Widget', 10.99);
$order.add_item('Gadget', 25.50);
$order.add_item('Gizmo', 49.00);

lives_ok {$order.total-sanity},'order total sanity';
dies_ok {$order.total-with-typo},'order total with typo';
lives_ok {EVAL '$order.discount'}, 'public method sanity';
dies_ok {EVAL '$order!compute_discount'}, 'private method sanity';
dies_ok {EVAL '$o!Order::compute_discount'}, 'private method sanity';


