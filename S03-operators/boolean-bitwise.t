use v6;

use Test;

=begin kwid

Tests for Synopsis 3
=end kwid

plan 31;

{ # L<S03/Changes to Perl 5 operators/ "?| is a logical OR">
  # work with pure Bool's
  ok( ?(False?|False == False), '?| works with Bools');
  ok( ?(False?|True  == True),  '?| works with Bools');
  ok( ?(True ?|False == True),  '?| works with Bools');
  ok( ?(True ?|True  == True),  '?| works with Bools');

  ok( ?(''   ?| 0    == False), '?| works');
  ok( ?(1    ?| 0    == True),  '?| works');
  ok( ?(0    ?| 72   == True),  '?| works');
  ok( ?(42   ?| 42   == True),  '?| works');
  ok( ?(42   ?| 41   == True),  '?| works');
  
  isa_ok (42 ?| 41), Bool, '?| yields a Bool';
}

{ # L<S03/Changes to Perl 5 operators/ "?& is a logical AND">
  # work with pure Bool's
  ok( ?(False?&False == False), '?& works with Bools');
  ok( ?(False?&True  == False), '?& works with Bools');
  ok( ?(True ?&False == False), '?& works with Bools');
  ok( ?(True ?&True  == True),  '?& works with Bools');

  ok( ?('' ?& 'yes'  == False), '?& works');
  ok( ?(1  ?& False  == False), '?& works');
  ok( ?(42 ?& 42     == True),  '?& works');
  ok( ?(3  ?& 12     == True),  '?& works');
  ok( ?(3  ?& 13     == True),  '?& works');
  ok( ?(13 ?& 3      == True),  '?& works');
  
  isa_ok (42 ?& 41), Bool, '?& yields a Bool';
}

{ ## L<S03/Changes to Perl 5 operators/ "?^ is a logical XOR">
  # work with pure Bool's
  ok( ?(False?^False == False), '?^ works with Bools');
  ok( ?(False?^True  == True),  '?^ works with Bools');
  ok( ?(True ?^False == True),  '?^ works with Bools');
  ok( ?(True ?^True  == False), '?^ works with Bools');

  ok( ?(''   ?^''    == False), '?^ works');
  #?rakudo 2 skip 'Mu as argument to bitwise operators'
  ok( ?(Mu   ?^ 1    == True),  '?^ works');
  ok( ?(-1   ?^Mu    == True),  '?^ works');
  ok( ?(42   ?^ 42   == False), '?^ works');
  ok( ?(42   ?^ 41   == False),  '?^ works');
  
  isa_ok (42 ?^ 41), Bool, '?^ yields a Bool';
}
