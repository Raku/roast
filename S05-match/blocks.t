use v6;
use Test;

plan 17;

=begin description

Rakudo had a bug which caused failures when a regex match happend inside the
body of a C<while> loop.
See L<See http://rt.perl.org/rt3/Ticket/Display.html?id=58306>.

So now we test that you can use both a regex and its result object in any
kind of block, and in the condition, if any. 

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

#?rakudo skip 'Using match object in a while loop, RT #58352'
{
    my $str = 'abc';
    my $count = 0;
    my $match = '';;
    while $str ~~ /b/ {
        $count++;
        $str = '';
        $match = "$/";
    }
    ok $count, 'Can match in the condition of a while loop';
    is $match, 'b', '... and can use $/ in the block';
    is "$/",   'b', '... and can use $/ outside the block';
}

#?rakudo skip 'Using match object in an if statement, RT #58352'
{
    my $match = '';
    if 'xyc' ~~ /x/ {
        $match = "$/";
    }
    is $match, 'x', 'Can match in the condition of an if statement';
    is "$/", '  x', '... and can use $/ outside the block';
}

# TODO: repeat ... until, gather/take, lambdas, if/unless statement modifiers

# vim: ft=perl6
