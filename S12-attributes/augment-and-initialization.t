use v6;



use Test;


# These tests are not specified by p6l, But these should be right...
# L<S12/"Attributes">

plan 8;

diag('Test for class attribute initialization');


{
	class T1 { }
	class T2 { }
	eval_lives_ok 'use MONKEY_TYPING; augment class T1 { has $.t = 1 }; 1',
		"Try to initialize public attribute";

    eval_lives_ok q'
		use MONKEY_TYPING;
		augment class T2 {
		    has $!t = 2;
		    method get { $!t };
		}; 1 }',
		"Try to initialize private attribute";


	my T1 $o1;
	my T2 $o2;

	$o1 = T1.new();
	$o2 = T2.new();
	is $o1.t, 1,
		"Testing value for initialized public attribute.";
	dies_ok { $o2.t },
		"Try to access the initialized private attribute.";
	is try { $o2.get }, 2,
		"Testing value for initialized private attribue.";

	$o1 = T1.new( t => 3 );
	$o2 = T2.new( t => 4 );
	is $o1.t, 3,
		"Testing value for attributes which is initialized by constructor.";
	dies_ok { $o2.t },
		"Try to access the private attribute which is initialized by constructor.";
	is try { $o2.get }, 4,
		"Testing value for private attribue which is initialized by constructor.";
}

# vim: ft=perl6
