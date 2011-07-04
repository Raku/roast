use v6;
use Test;

plan 17;

# L<S06/Perl5ish subroutine declarations/You can declare a sub without
# parameter list>

sub simple { 'simple' }
#?rakudo skip 'siglist'
is &simple.signature, :(), 'signature is :() when none is specified';
is simple(), 'simple', 'can call sub with no signature specified';
dies_ok { simple( :golf<hotel> ) },
        'sub with no signature dies when given a named argument';
dies_ok { simple( 'india' ) },
        'sub with no signature dies when given positional argument';

sub positional { @_[0] }
#?rakudo skip 'siglist'
is &positional.signature, :(Mu *@_),
   'signature is :(Mu *@_) when none is specified and @_ is used';
is positional( 'alpha' ), 'alpha', 'can call sub with positional param used';
nok positional().defined, 'sub using positional param called with no params';
dies_ok { positional( :victor<whiskey> ) },
   'sub using positional param called with named param';

sub named { %_<bravo> }
#?rakudo skip 'siglist'
is &named.signature, :(Mu *%_),
   'signature is :(Mu *%_) when none is specified and %_ is used';
is named( :bravo<charlie> ), 'charlie', 'can call sub with named param used';
nok named().defined, 'named param sub is callable with no params';
dies_ok { named( 'zulu' ) }, 'named param sub dies with positional param';

sub both { @_[1] ~ %_<delta> }
#?rakudo skip 'siglist'
is &both.signature, :(Mu *@_, Mu *%_),
   'signature is :(Mu *@_, Mu *%_) when none is specified and @_ and %_ are used';
is both( 'x', :delta<echo>, 'foxtrot' ), 'foxtrotecho',
   'can call sub with both named and positional params used';
is both(), '',
   'sub using both named and position params works with no params';

# RT 71112
{
    sub rt71112 { @_[0] = 'bug' }
    my $tender = 'sanity';
    #?rakudo todo 'RT 71112: Cannot assign to readonly variable.'
    dies_ok { rt71112( $tender ) }, 'Sub that tries to modify @_ dies';
    is $tender, 'sanity', 'The variable passed is unchanged.';
}

done;

# vim: ft=perl6
