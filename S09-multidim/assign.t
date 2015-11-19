use v6;
use Test;

plan 26;

lives-ok { my @a[3] = 1, 2, 3 },
    'Can assign exact number of elements to fixed size array';
lives-ok { my @a[3] = 1, 2 },
    'Can assign smaller number of elements than size to fixed size array';
dies-ok { my @a[3] = 1, 2, 3, 4 },
    'Cannot assign greater number of elements than size to fixed size array';
{
    my @a[3] = <a b c>;
    is @a[0], 'a', 'Assignment to fixed size array works (1)';
    is @a[1], 'b', 'Assignment to fixed size array works (2)';
    is @a[2], 'c', 'Assignment to fixed size array works (3)';
}

lives-ok { my @a[2;2] = <a b>, <c d> },
    'Can assign list of lists that matches shape of 2-dim array';
lives-ok { my @a[2;2] = (<a b>,) },
    'Shortfall of lists for first dimension is OK';
lives-ok { my @a[2;2] = (<a>,), <c d> },
    'Shortfall of elements in second dimension is OK';
dies-ok { my @a[2;2] = <a b>, <c d>, <e f> },
    'Cannot assign to many lists at first dimension';
dies-ok { my @a[2;2] = <a b>, <c d e> },
    'Cannot assign to many items at first dimension';
throws-like { my @a[2;2] = <a b c d> }, X::Assignment::ToShaped,
    'Cannot assign flat list of items';
{
    my @a[2;2] = <a b>, <c d>;
    is @a[0;0], 'a', 'Assignment to 2-dim array works (1)';
    is @a[0;1], 'b', 'Assignment to 2-dim array works (2)';
    is @a[1;0], 'c', 'Assignment to 2-dim array works (3)';
    is @a[1;1], 'd', 'Assignment to 2-dim array works (4)';
}

my @a[2;3] = <a b c>, <d e f>;
lives-ok { my @b[2;3] = @a },
    'Can assign shaped to shaped if shapes match exactly';
{
    my @b[2;3] = @a;
    is @b[0;0], 'a', 'Assignment to 2-dim array works (1)';
    is @b[0;1], 'b', 'Assignment to 2-dim array works (2)';
    is @b[0;2], 'c', 'Assignment to 2-dim array works (3)';
    is @b[1;0], 'd', 'Assignment to 2-dim array works (4)';
    is @b[1;1], 'e', 'Assignment to 2-dim array works (5)';
    is @b[1;2], 'f', 'Assignment to 2-dim array works (6)';
}
throws-like { my @b[2;2] = @a }, X::Assignment::ArrayShapeMismatch,
    'Cannot assign shaped to shaped if shapes mis-match (1)';
throws-like { my @b[2;4] = @a }, X::Assignment::ArrayShapeMismatch,
    'Cannot assign shaped to shaped if shapes mis-match (2)';
throws-like { my @b[3;3] = @a }, X::Assignment::ArrayShapeMismatch,
    'Cannot assign shaped to shaped if shapes mis-match (3)';
