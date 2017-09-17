use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/rulecode.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 10;

# L<S05/Extensible metasyntax (C<< <...> >>)/unambiguously calls a routine instead>

my regex abc { a b c }

my $var = "";
ok("aaabccc" ~~ m/aa <{ $var ?? $var !! rx{abc} }> cc/, 'Rule block second');

$var = rx/<&abc>/;
ok("aaabccc" ~~ m/aa <{ $var ?? $var !! rx{<.null>} }> cc/, 'Rule block first');

$var = rx/xyz/;
#?rakudo todo 'dunno RT #124527'
ok("aaabccc" !~~ m/aa <{ $var ?? $var !! rx{abc} }> cc/, 'Rule block fail');

$var = rx/<&abc>/;
ok("aaabccc" ~~ m/aa <{ $var ?? $var !! rx{abc} }> cc/, 'Rule block interp');

# RT #102860
ok 'abc' ~~ /<{ '.+' }>/, 'interpolating string with meta characters';
is $/.Str, 'abc', '... gives the right match';

# RT #125973
is 't' ~~ /<{'a'...'z'}>/, 't', 'sequence in a closure interpolates ok';

# RT #111474
is '123' ~~ / :my $a=2; <{ '$a' }> /, '2', 'scoping of variable in regex generated from <{}> metasyntax';
is '123' ~~ / :my $a=2; <{ '$' ~ 'a' }> /, '2', 'stage of variable in regex generated from <{}> metasyntax';
# Were $a to be interpolated before '', we'd get something like 'rx/2/' or 'rx[2]'
# which would either not parse as a regex or would include the 'rx' literally.
is '123' ~~ / :my $a=rx[2]; <{ '$a' }> /, '2', 'stage of variable in regex generated from <{}> metasyntax (2)';

# vim: ft=perl6
