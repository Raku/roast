use v6;

# [TODO] add tests for ENTER/LEAVE/KEEP/UNDO/PRE/POST/etc

# Test multiple phasers.

use Test;

plan 2;

# L<S04/Phasers/"occur multiple times">
# IRC log:
# [05:41] <agentzh> TimToady: S04 doesn't discuss the running order 
#                   of multiple phasers (say, two END {} in 
#                   the same scope), so should we assume it's the
#                   same as in Perl 5?
# [05:41] <TimToady> yes

my $hist;

END { is $hist, 'B b c C I i end End ', 'running order of multiple phasers' }

END { $hist ~= 'End ' }
END { $hist ~= 'end ' }

INIT { $hist ~= 'I ' }
INIT { $hist ~= 'i ' }

CHECK { $hist ~= 'C ' }
CHECK { $hist ~= 'c ' }

BEGIN { $hist ~= 'B ' }
BEGIN { $hist ~= 'b ' }

is $hist, 'B b c C I i ', 'running order of multiple phasers';

# vim: ft=perl6
