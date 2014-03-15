use v6;
use Test;
plan 21;

{
    my $employee = {
	name => 'Fred',
	age => 51,
	skills => <sweeping accounting barking>,
    };
    is($employee<name>, 'Fred', 'emp name');
    is($employee<skills>[1], 'accounting', 'emp skill');
};

{
    my %employee =
	name => 'Fred',
	age => 51,
	skills => <sweeping accounting barking>,
    ;
    is(%employee<name>, 'Fred', 'emp name');
    is(%employee<skills>[1], 'accounting', 'emp skill');
};

my %options =
    rpm => 440,
    duration => 60,
    ;

class HashArgsExample {
    method start(%options) {
	is %options<rpm>, 440, 'rpm hash option';
	is %options<duration>, 60, 'duration hash option';
    }
}

HashArgsExample.start(%options);

class NamedArgsExample {
    method start(:$rpm!, :$duration) {
	is $rpm, 440, 'rpm named arg';
	is $duration, 60, 'duration named';
    }
}

NamedArgsExample.start( |%options);

class NamedArgsExample2 {
    method start(:$rpm!, :$duration = 120) {
	is $rpm, 440, 'rpm named arg';
	is $duration, 120, 'duration named';
    }
}

NamedArgsExample2.start(:rpm<440>);
dies_ok {NamedArgsExample2.start()};


my @args = "Would you like fries with that?", 15, 5;
is substr(|@args), 'fries';

my %details = :year(1969), :month(7), :day(16),
    :hour(20), :minute(17);

class DateTime {
    has $.year;
    has $.month;
    has $.day;
    has $.hour;
    has $.minute;
}

my $moonlanding = DateTime.new( |%details );

is $moonlanding.year, 1969, 'moonlanding year';
is $moonlanding.month, 7, 'moonlanding month';
is $moonlanding.day, 16, 'moonlanding day';
is $moonlanding.hour, 20, 'moonlanding hour';
is $moonlanding.minute, 17, 'moonlanding minute';

{
    my %opts = blackberries => 42;
    is %opts<blackberries>, 42, 'blackberries';
}
{
    my %opts = :blackberries(42);
    is %opts<blackberries>, 42, 'blackberries';
}
{
    my $blackberries = 42;
    my %opts = :$blackberries;   # means the same as :blackberries($blackberries)
    is %opts<blackberries>, 42, 'blackberries';
}

my $lisp-list = 1 => 2 => 3 => Nil;  # it's nice that infix:<< => >> is right-associative

Pair.^add_fallback(
    -> $, $name { $name ~~ /^c<[ad]>+r$/ },  # should we handle this? yes, if /^c<[ad]>+r$/
    -> $, $name {                            # if it turned out to be our job, this is what we do
        -> $p {
            $name ~~ /^c(<[ad]>*)(<[ad]>)r$/;        # split out last 'a' or 'd'
            my $r = $1 eq 'a' ?? $p.key !! $p.value; # choose key or value
            $0 ?? $r."c{$0}r"() !! $r;               # maybe recurse
        } 
    }
    );

#?rakudo.jvm skip 'caddr example'
#?rakudo.parrot skip 'caddr example'
#?rakudo.moar skip 'caddr example'
is $lisp-list.caddr, 3, 'Pair.^add_fallback';
