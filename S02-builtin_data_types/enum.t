use v6;

use Test;

plan 30;
# L<S12/Enums>
{
    my %hash; eval '%hash = enum «:Mon(1) Tue Wed Thu Fri Sat Sun»';

    #is((%hash<Mon Tue Wed Thu Fri Sat Sun>) »eq« (1 .. 7)), "enum generated correct sequence");
    is(%hash<Mon>, 1, "first value ok", :todo);
    is(%hash<Thu>, 4, "fourth value ok", :todo);
    is(%hash<Sun>, 7, "last value ok", :todo);
};

{
    my %hash; eval '%hash = enum «:Two(2) Three Four»';

    #is((%hash<Two Three Four>) »eq« (2 .. 4)), "enum generated correct sequence");
    is(%hash<Two>, 2, "first value ok", :todo);
    is(%hash<Three>, 3, "second value ok", :todo);
    is(%hash<Four>, 4, "last value ok", :todo);
};

my %hash;

#?rakudo skip 'Parse error: Statement not terminated properly'
lives_ok { %hash = enum <<:Sun(1) :Mon(2) :Tue(3) :Wed(4) :Thu(5) :Fri(6) :Sat(7)>>; }, 'specifying keys and values works...', :todo<feature>;

is %hash.keys, <Sun Mon Tue Wed Thu Fri Sat>, '...and the right keys are assigned', :todo<feature>;

is %hash.values, 1..7, '...and the right values are assigned', :todo<feature>;

%hash = ();

#?rakudo skip 'Parse error: Statement not terminated properly'
lives_ok { %hash = enum <<:Sun(1) Mon Tue Wed Thu Fri Sat>>; }, 'specifying a value for only the first key works...', :todo<feature>;

is %hash.keys, <Sun Mon Tue Wed Thu Fri Sat>, '...and the right keys are assigned', :todo<feature>;

is %hash.values, 1..7, '...and the right values are assigned', :todo<feature>;

%hash = ();

#?rakudo skip 'Parse error: Statement not terminated properly'
lives_ok { %hash = enum «:Sun(1) Mon Tue Wed Thu Fri Sat»; }, 'french quotes work...', :todo<feature>;

is %hash.keys, <Sun Mon Tue Wed Thu Fri Sat>, '...and the right keys are assigned', :todo<feature>;

is %hash.values, 1..7, '...and the right values are assigned', :todo<feature>;

%hash = ();

#?rakudo skip 'Parse error: Statement not terminated properly'
lives_ok { %hash = enum <<:Sun(1) Mon Tue :Wed(4) Thu Fri Sat>>; }, 'specifying continuous values in the middle works...', :todo<feature>;

is %hash.keys, <Sun Mon Tue Wed Thu Fri Sat>, '...and the right keys are assigned', :todo<feature>;

is %hash.values, 1..7, '...and the right values are assigned', :todo<feature>;

%hash = ();

#?rakudo skip 'Parse error: Statement not terminated properly'
lives_ok { %hash = enum <<:Sun(1) Mon Tue :Wed(5) Thu Fri Sat>>; }, 'specifying different values in the middle works...', :todo<feature>;

is %hash.keys, <Sun Mon Tue Wed Thu Fri Sat>, '...and the right keys are assigned', :todo<feature>;

is %hash.values, (1, 2, 3, 5, 6, 7, 8), '...and the right values are assigned', :todo<feature>;

%hash = ();

#?rakudo skip 'Parse error: Statement not terminated properly'
lives_ok { %hash = enum «:Alpha<A> Bravo Charlie Delta Echo»; }, 'specifying a string up front works', :todo<feature>;

is %hash.keys, <Alpha Bravo Charlie Delta Echo>, '...and the right keys are assigned', :todo<feature>;

is %hash.values, <A B C D E>, '...and the right values are assigned', :todo<feature>;

%hash = ();

eval q[
lives_ok { %hash = enum <<:Alpha<A> Bravo Charlie Delta Echo>>; }, 'specifying a string up front works (Texas quotes)', :todo<feature>;
];

is %hash.keys, <Alpha Bravo Charlie Delta Echo>, '...and the right keys are assigned', :todo<feature>;

is %hash.values, <A B C D E>, '...and the right values are assigned', :todo<feature>;

%hash = ();

#?rakudo skip 'Parse error: Statement not terminated properly'
lives_ok { %hash = enum «:zero(0) one two three four five six seven eight nine :ten<a> eleven twelve thirteen fourteen fifteen»; }, 'mixing strings and integers works', :todo<feature>;

is %hash.keys, <zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen>, '...and the right keys are assigned', :todo<feature>;

is %hash.values, (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F'), '...and the right values are assigned', :todo<feature>;

%hash = ();

