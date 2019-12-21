use v6;

use Test;

=begin kwid

Tests for Synopsis 3
=end kwid

plan 45;

{ # L<S03/Changes to Perl operators/ "?| is a logical OR">
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

  ok( ?(infix:<?|>(True) == True), '?| works with one argument');
  ok( ?(infix:<?|>() == False), '?| works with no arguments');

  isa-ok (42 ?| 41), Bool, '?| yields a Bool';
  isa-ok infix:<?|>(True), Bool, '?| with one argument yields a Bool';
  isa-ok infix:<?|>(), Bool, '?| with no arguments yields a Bool';

}

{ # L<S03/Changes to Perl operators/ "?& is a logical AND">
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

  ok( ?(infix:<?&>(False) == False), '?& works with one argument');
  ok( ?(infix:<?&>() == True), '?& works with no arguments');

  isa-ok (42 ?& 41), Bool, '?& yields a Bool';
  isa-ok infix:<?&>(True), Bool, '?& with one argument yields a Bool';
  isa-ok infix:<?&>(), Bool, '?& with no arguments yields a Bool';
}

{ ## L<S03/Changes to Perl operators/ "?^ is a logical XOR">
  # work with pure Bool's
  ok( ?(False?^False == False), '?^ works with Bools');
  ok( ?(False?^True  == True),  '?^ works with Bools');
  ok( ?(True ?^False == True),  '?^ works with Bools');
  ok( ?(True ?^True  == False), '?^ works with Bools');

  ok( ?(''   ?^''    == False), '?^ works');
  ok( ?(Any  ?^ 1    == True),  '?^ works');
  ok( ?(-1   ?^ Any  == True),  '?^ works');
  ok( ?(42   ?^ 42   == False), '?^ works');
  ok( ?(42   ?^ 41   == False),  '?^ works');

  ok( ?(infix:<?^>(True) == True), '?^ works with one argument');
  ok( ?(infix:<?^>() == False), '?^ works with no arguments');

  isa-ok (42 ?^ 41), Bool, '?^ yields a Bool';
  isa-ok infix:<?^>(True), Bool, '?^ with one argument yields a Bool';
  isa-ok infix:<?^>(), Bool, '?^ with no arguments yields a Bool';
}

ok (?^5) === False, 'prefix ?^ (+)';
ok (?^0) === True,  'prefix ?^ (-)';
