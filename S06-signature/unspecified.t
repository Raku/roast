use v6;
use Test;

plan 15;

sub simple { 'simple' }
#?rakudo skip 'siglist'
is &simple.signature, :(), 'signature is :() when none is specified';
is simple(), 'simple', 'can call sub with no signature specified';
is simple( :golf<hotel> ), 'simple',
   'can give named argument to sub with no signature';
is simple( 'india' ), 'simple',
   'can give positional argument to sub with no signature';

sub positional { @_[0] }
#?rakudo skip 'siglist'
is &positional.signature, :(Any *@_),
   'signature is :(Any *@_) when none is specified and @_ is used';
is positional( 'alpha' ), 'alpha', 'can call sub with positional param used';
is positional(), undef, 'sub using positional param called with no params';
is positional( :victor<whiskey> ), undef,
   'sub using positional param called with named param';

sub named { %_<bravo> }
#?rakudo skip 'siglist'
is &named.signature, :(Any *%_),
   'signature is :(Any *%_) when none is specified and %_ is used';
is named( :bravo<charlie> ), 'charlie', 'can call sub with named param used';
is named(), undef, 'named param sub is callable with no params';
dies_ok { named( 'zulu' ) }, 'named param sub dies with positional param';

sub both { @_[1] ~ %_<delta> }
#?rakudo skip 'siglist'
is &both.signature, :(Any *@_, Any *%_),
   'signature is :(Any *@_, Any *%_) when none is specified and @_ and %_ are used';
is both( 'x', :delta<echo>, 'foxtrot' ), 'foxtrotecho',
   'can call sub with both named and positional params used';
is both(), undef ~ undef,
   'sub using both named and position params works with no params';
