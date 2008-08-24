use v6;
use Test;

plan 12;

=begin description

Rakudo had a bug which caused failures when a regex match happend inside the
body of a C<while> loop.
See L<See http://rt.perl.org/rt3/Ticket/Display.html?id=58306>.

So now we test that you can use both a regex and its result object in any kind of block.

=end description

if 1 {
    ok 'a' ~~ /./, 'Can match in an if block';
    is ~$/, 'a', '... and can use the match var';
}

#?rakudo todo 'Proper contextual scoping for $/'
is ~$/, 'a', '... even outside the block';

my $loop = 1;

while $loop {
    ok 'b' ~~ /./, 'Can match in a while block';
    is ~$/, 'b', '... and can use the match var';
    $loop = 0;
}
#?rakudo todo 'Proper contextual scoping for $/'
is ~$/, 'b', '... even outside the block';

{
    ok 'c' ~~ /./, 'Can match in a bare block';
    is ~$/, 'c', '... and can use the match var';
}
#?rakudo todo 'Proper contextual scoping for $/'
is ~$/, 'c', '... even outside the block';

my $discarded = do {
    ok 'd' ~~ /./, 'Can match in a do block';
    is ~$/, 'd', '... and can use the match var';

}
#?rakudo todo 'Proper contextual scoping for $/'
is ~$/, 'd', '... even outside the block';

# TODO: repeat ... until, gather/take, lambdas

# vim: ft=perl6
