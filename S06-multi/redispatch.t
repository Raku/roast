use v6;
use Test;

plan 13;

# it doesn't seem to be explicit in S06, but {next,call}{same,with}
# work with multi subs too, not just with methods


{
    my $tracker = '';
    multi a($)     { $tracker ~= 'Any' };
    multi a(Int $) { $tracker ~= 'Int'; nextsame; $tracker ~= 'Int' };

    lives-ok { a(3) },      'can call nextsame inside a multi sub';
    is $tracker, 'IntAny', 'called in the right order';
}

{
    my $tracker = '';
    multi b($)     { $tracker ~= 'Any' };
    multi b(Int $) { $tracker ~= 'Int'; callsame; $tracker ~= 'Int' };

    lives-ok { b(3) },        'can call callsame inside a multi sub';
    is $tracker, 'IntAnyInt', 'called in the right order';
}

{
    my $tracker = '';
    multi c($x)     { $tracker ~= 'Any' ~ $x };
    multi c(Int $x) { $tracker ~= 'Int'; nextwith($x+1); $tracker ~= 'Int' };

    lives-ok { c(3) },      'can call nextwith inside a multi sub';
    is $tracker, 'IntAny4', 'called in the right order';
}

{
    my $tracker = '';
    multi d($x)     { $tracker ~= 'Any' ~ $x };
    multi d(Int $x) { $tracker ~= 'Int'; callwith($x+1); $tracker ~= 'Int' };

    lives-ok { d(3) },         'can call callwith inside a multi sub';
    is $tracker, 'IntAny4Int', 'called in the right order';
}

# RT #75008
{
    multi e() { nextsame };
    lives-ok &e, "It's ok to call nextsame in the last/only candidate";
}

# RT 76328
{
    try { nextsame };
    isa-ok $!, X::NoDispatcher, 'nextsame in main block dies due to lack of dispatcher';
}

# RT 125539
{
    multi a(Int $a) { samewith "$a" }
    multi a(Str $a) { is $a, "42", 'samewith $a stringified in sub' }

    class B {
        multi method b(Int $b) { samewith "$b" }
        multi method b(Str $b) {
            is $b, "42", 'samewith $b stringified for ' ~ self.perl;
        }
    }

    a 42;
    B.b(42);
    B.new.b(42);
}
