use v6;
use Test;
plan 6;

{
    my $x = 0;
    42 notandthen $x++;
    is-deeply $x, 0, 'notandthen properly thunks RHS';
}
{
    my $x = 0;
    Int notandthen $x++ notandthen $x++;
    is-deeply $x, 1,
        'chaned notandthen executes RHS thunks only when appropriate';
}

subtest 'Empty in args to notandthen does not disappear' => {
    plan 4;
    my $r := do 42 without Empty;
    is-deeply $r,                              42, 'postfix `without`';
    is-deeply infix:<notandthen>(Empty, 42),   42, 'sub call';
    is-deeply (Empty notandthen 42),           42, 'op';
    is-deeply ((Int andthen 1) notandthen 42), 42, 'taking return of andthen';
}

is-deeply infix:<notandthen>([Int, 42]), (Int notandthen 42),
    '1-arg Iterable gets flattened (like +@foo slurpy)';

{
    my $calls = 0;
    my class Foo { method defined { $calls++; False } };
    sub meow { $^a };
    Foo andthen meow $_;
    is-deeply $calls, 1, 'notandthen does not call .defined on last arg (1)';

    $calls = 0;
    Foo andthen .&meow;
    is-deeply $calls, 1, 'notandthen does not call .defined on last arg (2)';
}
