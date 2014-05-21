# http://perl6advent.wordpress.com/2010/12/21/day-21-transliteration-and-beyond/
use v6;
use Test;
plan 4;

is "GATTACA".trans( "TCAG" => "0123" ), "3200212", 'trans';
sub rot13($text) { $text.trans( "A..Za..z" => "N..ZA..Mn..za..m" ) }
is rot13('Why did the chicken cross the road?'), 'Jul qvq gur puvpxra pebff gur ebnq?', 'rot13';

my $kabbala = 'To get to the other side!';
$kabbala.=trans("A..Ia..i" => "1..91..9");
is $kabbala, 'To 75t to t85 ot85r s945!', 'kabbala';

my $html = q:to"END";
<!DOCTYPE html>
<html>
  <body>
    <h1>My&nbsp;Heading</h1>
    <p>A paragraph.</p>
  </body>
</html>
END

my $escaped = $html.trans(
    [ '&',     '<',    '>'    ] =>
    [ '&amp;', '&lt;', '&gt;' ]
);

is_deeply [$escaped.lines], [
    '&lt;!DOCTYPE html&gt;',
    '&lt;html&gt;',
    '  &lt;body&gt;',
    '    &lt;h1&gt;My&amp;nbsp;Heading&lt;/h1&gt;',
    '    &lt;p&gt;A paragraph.&lt;/p&gt;',
    '  &lt;/body&gt;',
    '&lt;/html&gt;'
], 'html escaping';

