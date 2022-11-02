use Test;

plan 7;

is-deeply ().are,                         Nil,     'Nil ok?';
is-deeply Int.are,                        Int,     'Int ok?';
is-deeply <a b c>.are,                    Str,     'Str ok?';
is-deeply (1,1.2,pi).are,                 Real,    'Real ok?';
is-deeply (1,1.2,pi,i).are,               Numeric, 'Nummeric ok?';
is-deeply (1,"one").are,                  Cool,    'Cool ok?';
is-deeply (DateTime.now, Date.today).are, Dateish, 'Datish ok?';

# vim: expandtab shiftwidth=4
