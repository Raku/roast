use v6;

use Test;

plan 11;

is ~(6..3 :by(-1)), '6 5 4 3', ':by(-1)';
is ~(3..3 :by(-1)), '3',       ':by(-1) on one-elem range';
is ~(2..3 :by(-1)), '',        ':by(-1) on increasing range';

is ~('c'..'a' :by(-1)), 'c b a', ':by(-1) on char range';
is ~('a'..'a' :by(-1)), 'a',     ':by(-1) on one-elem char range';
is ~('a'..'b' :by(-1)), '',      ':by(-1) on increasing one-elem char range';

is ~(0..2 :by(.5)), '0 0.5 1 1.5 2', ':by(.5) on numeric range';
is ~('a'..'c' :by(.5)), 'a a b b c', ':by(.5) on char range';
is ~(2..0 :by(-.5)), '2 1.5 1 0.5 0', ':by(-.5) on numeric range';
is ~('c'..'a' :by(-.5)), 'c b b a a', ':by(-.5) on char range';

is ~('a'..'f' :by(1.6)), 'a b d e',  ':by(1.6) on char range';
