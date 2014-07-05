use v6;

use Test;

# Basic &leave tests
# L<S06/"The C<leave> function">

plan 23;

{
  my $bare = { leave 42; 23 };

  is $bare(), 42, 'basic leave() works';
}

{
  my $bare = { &?BLOCK.leave(42); 23 };

  is $bare(), 42, 'basic leave() is equivalent to &?BLOCK.leave()';
}

{
  my $bare = { &?BLOCK.leave: 42; 23 };

  is $bare(), 42, 'basic method leave works as colon listop';
}

{
  my $bare = { leave &?BLOCK: 42; 23 };

  is $bare(), 42, 'basic method leave works with indirect object';
}

{
  my @bare = [41, do { leave; 23 }, 43 ];

  is @bare, [41,43], 'basic leave returns null list in list context';
}

{
  my @bare = [41, do { 21 + leave() + 23 }, 43 ];

  is @bare, [41,43], 'basic leave() returns null list in list context';
}

{
  my @bare = [41, do { &?BLOCK.leave; 23 }, 43 ];

  is @bare, [41,43], 'basic &?BLOCK.leave returns null list in list context';
}

{
  my @bare = [41, do { 21 + &?BLOCK.leave() + 23 }, 43 ];

  is @bare, [41,43], 'basic &?BLOCK.leave() returns null list in list context';
}

{
  my @bare = [41, do { leave &?BLOCK: ; 23 }, 43 ];

  is @bare, [41,43], 'basic leave &?BLOCK: returns null list in list context';
}

{
  my @bare = [41, do { 21 + (leave &?BLOCK:) + 23 }, 43 ];

  is @bare, [41,43], 'basic leave &?BLOCK: returns null list in list context';
}

{
  my @bare = [41, do { leave 42, 43; 23 }, 44 ];

  is @bare, [41,42,43,44], 'basic leave returns valid list in list context';
}

{
  my @bare = [41, do { 21 + leave(42, 43) + 23 }, 44 ];

  is @bare, [41,42,43,44], 'basic leave() returns valid list in list context';
}

{
  my @bare = [41, do { 21 + &?BLOCK.leave(42,43) + 23 }, 44 ];

  is @bare, [41,42,43,44], 'basic &?BLOCK.leave() returns valid list in list context';
}

{
  my @bare = [41, do { leave &?BLOCK: 42, 43; 23 }, 44 ];

  is @bare, [41,42,43,44], 'basic leave &?BLOCK: returns valid list in list context';
}

{
  my @bare = [41, do { 21 + (leave &?BLOCK: 42, 43) + 23 }, 44 ];

  is @bare, [41,42,43,44], 'basic leave &?BLOCK: returns valid list in list context';
}

{
  my $sub = sub () {
    my $bare = { leave 42; 23 };

    my $ret = $bare();
    return 1000 + $ret;
  };

  is $sub(), 1042, 'leave() works and leaves only the innermost block';
}

{
  my $sub = sub () {
    &?ROUTINE.leave(42);
    return 23;
  };

  is $sub(), 42, 'leave() works with &?ROUTINE as invocant';
}

{
  my $outer = sub () {
    my $inner = sub () {
      my $most_inner = sub () {
        leave $outer: 42;
        return 23;
      };

      $most_inner();
      return 22;
    };

    $inner();
    return 21;
  }

  is $outer(), 42, 'nested leave() works with a subref as invocant';
}

{
  my $sub = sub () {
    my $bare = sub () {
      Block.leave: 42;
      return 23;
    };

    my $ret = $bare();
    return 1000 + $ret;
  };

  is $sub(), 1042, 'leave() works with a Class (Block) as invocant';
}

{
  my $sub = sub () {
    my $bare = sub () {
      leave Sub: 42;
      return 23;
    };

    my $ret = $bare();
    return 1000 + $ret;
  };

  is $sub(), 42, 'leave() works with a Class (Sub) as invocant';
}

{
  my $sub = sub () {
    LABEL: for 1..10 -> $n {
	for 'a' .. 'b' -> $a {
	    LABEL.leave(42);
	    "$a,$n";
	}
    }
  }

  is $sub(), 42, 'leave() works with a loop label';
}

EVAL q[[
  my $sub = sub () {
    eager do			# XXX without eager would require time travel
    LABEL: for 1..10 -> $n {
	for 'a' .. 'b' -> $a {
	    LABEL.leave(42,43);	# note, must cancel ordinary list comprehension!
	    "$a,$n";
	}
    }
  }

  is [$sub()], [42,43], 'leave() works with a loop label in list context';
]];

EVAL q[[
  my $sub = sub () {
    do LABEL: {
	LABEL.leave(42);
    } + 1000;
  }

  is $sub(), 1042, 'leave() works with an internal do label';
]];

# vim: ft=perl6
