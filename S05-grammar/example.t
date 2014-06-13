use v6;
use Test;

plan 4;

=pod calling a rule a grammar with arguments

grammar G { rule rule($arg) {  {? $arg == 42 } } }
ok( G.parse('', :rule<rule>, :args(42,) ), 'call rule with argument' );


my rule schedule { <title> [ <talk> ]+ }

my token title { '<title>' <speaker> '</title>' }

my regex ws { .*? };

my token talk { '<small>' <speaker> '</small>' };

my token speaker { \w+ };


=begin pod

Use rules from a grammar.

=end pod

my $content = '
    <tr>
    <td align="center" width="8%">8:30</td>
	<td align="center" width="23%"><a href="http://www.yapcchicago.org/the-schedule/monday/m-abstracts#am830">Conferences for Beginners</a><br><small>Jim Brandt, brian d foy</small></td>
	<td colspan="3" align="center" bgcolor="#3f3f3f" width="69%">—</td>
    </tr>
	<tr>
    <td align="center" width="8%">9:00</td>
	<td align="center" width="23%"><a href="http://www.yapcchicago.org/the-schedule/monday/m-abstracts#am900">Opening Ceremonies</a><br><small>Josh McAdams</small></td>
	<td colspan="3" align="center" bgcolor="#3f3f3f" width="69%">—</td>
    </tr>
';

is(~($content ~~ m/<speaker>/), 'tr', 'read token from grammar namespace');

$content = '<title>Exactly</title> aosihdas
<small>A</small> aosidh
<small>B</small> aosidh
<small>C</small> aosidh
<small>D</small>';

is($content ~~ m/<title>/, '<title>Exactly</title>', 'match token');

# XXX this can't work this way
# 'schedule' is a rule (non-backtracking) so the implicit <.ws> will always
# match zero characters. 
#?rakudo todo 'test error
is($content ~~ m/<schedule>/, $content, 'match rule');

# vim: ft=perl6
