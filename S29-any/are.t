use v6.e.PREVIEW;
use Test;

plan 17;

is-deeply ().are,                         Nil,     '() ok?';
is-deeply Int.are,                        Int,     'Int ok?';
is-deeply <a b c>.are,                    Str,     'Str ok?';
is-deeply (1,1.2,pi).are,                 Real,    'Real ok?';
is-deeply (1,1.2,pi,i).are,               Numeric, 'Nummeric ok?';
is-deeply (1,"one").are,                  Cool,    'Cool ok?';
is-deeply (DateTime.now, Date.today).are, Dateish, 'Datish ok?';

is-deeply ().are(Int),                             True, '() ok?';
is-deeply Int.are(Int),                            True, 'Int ok?';
is-deeply <a b c>.are(Str),                        True, 'Str ok?';
is-deeply (1,1.2,pi).are(Real),                    True,    'Real ok?';
is-deeply (1,1.2,pi,i).are(Numeric),               True, 'Nummeric ok?';
is-deeply (1,"one").are(Cool),                     True,    'Cool ok?';
is-deeply (DateTime.now, Date.today).are(Dateish), True, 'Datish ok?';
is-deeply <40 41 42>.are(Int),                     True, 'Str not Int?';

fails-like { Int.are(Str)     }, X::AdHoc,  # XXX proper exception?
  message => "Expected 'Str' but got 'Int'",
  'Int not Str?';
fails-like { <a b c>.are(Int) }, X::AdHoc,  # XXX proper exception?
  message => "Expected 'Int' but got 'Str' in element 0",
  'Str not Int?';

# vim: expandtab shiftwidth=4
