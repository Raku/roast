use v6.c;
use Test;

plan 18;

# L<S06/Perl5ish subroutine declarations/You can declare a sub without
# parameter list>
#
# TODO: if there is a better way to compare signatures: don't rely on .perl

sub simple { 'simple' }
is &simple.signature.perl, ':()', 'signature is :() when none is specified';
is simple(), 'simple', 'can call sub with no signature specified';
dies-ok { EVAL('simple( :golf<hotel> )') },
        'sub with no signature dies when given a named argument';
dies-ok { EVAL("simple( 'india' )") },
        'sub with no signature dies when given positional argument';

sub positional { @_[0] }
is &positional.signature.perl, ':(*@_)',
   'signature is :(Mu *@_) when none is specified and @_ is used, RT #125486';
is positional( 'alpha' ), 'alpha', 'can call sub with positional param used';
nok positional().defined, 'sub using positional param called with no params';
dies-ok { positional( :victor<whiskey> ) },
   'sub using positional param called with named param';

sub named { %_<bravo> }
is &named.signature.perl, ':(*%_)',
   'signature is :(Mu *%_) when none is specified and %_ is used, RT #125486';
is named( :bravo<charlie> ), 'charlie', 'can call sub with named param used';
nok named().defined, 'named param sub is callable with no params';
dies-ok { named( 'zulu' ) }, 'named param sub dies with positional param';

sub both { @_[1] ~ %_<delta> }
is &both.signature.perl, ':(*@_, *%_)',
   'signature is :(Mu *@_, Mu *%_) when none is specified and @_ and %_ are used, RT #125486';
is both( 'x', :delta<echo>, 'foxtrot' ), 'foxtrotecho',
   'can call sub with both named and positional params used';
is both(), '',
   'sub using both named and position params works with no params';

# RT #71112
{
    sub rt71112 { @_[0] = 'changed'; @_[0]  }
    my $tender = 'sanity';
    lives-ok { rt71112( $tender ) }, 'Sub can modify its @_ as it has is copy semantics';
    is rt71112( $tender ), 'changed', 'And its modifications stick in its copy';
    is $tender, 'sanity', 'The variable passed is unchanged';
}

# vim: ft=perl6
