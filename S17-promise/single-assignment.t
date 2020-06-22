use v6;
use Test;
plan 12;

my $exception = ::('X::Promise::Resolved');

{
    my $promise = Promise.new;
    my $vow = $promise.vow;

    $vow.keep(1);
    is $promise.status, Kept, 'Keeping a vow keeps the promise';
    is $promise.result, 1, 'Keeping a vow assigns a result to the promise';

    throws-like { $vow.keep(2) }, $exception, promise => $promise,
     message => 'Cannot keep/break a Promise more than once (status: Kept)',
     'Keeping a vow throws if the promise was Kept already';

    is $promise.result, 1,
     'Keeping a vow does not change the result of an already Kept promise';

    throws-like { $vow.break(3) }, $exception, promise => $promise,
     message => 'Cannot keep/break a Promise more than once (status: Kept)',
     'Breaking a vow throws if the promise was Kept already';

    is $promise.status, Kept,
     'Breaking a vow does not change the status of an already Kept promise';
}

{
    my $promise = Promise.new;
    my $vow = $promise.vow;

    $vow.break(1);
    is $promise.status, Broken, 'Breaking a vow breaks the promise';
    is $promise.cause, 1, 'Breaking a vow assigns a cause to the promise';

    throws-like { $vow.break(2) }, $exception, promise => $promise,
     message => 'Cannot keep/break a Promise more than once (status: Broken)',
     'Breaking a vow throws if the promise was Broken already';

    is $promise.cause, 1,
     'Breaking a vow does not change the cause of an already Broken promise';

    throws-like { $vow.keep(3) }, $exception, promise => $promise,
     message => 'Cannot keep/break a Promise more than once (status: Broken)',
     'Keeping a vow throws if the promise was Broken already';

    is $promise.status, Broken,
     'Keeping a vow does not change the status of an already Broken promise';
}

# vim: expandtab shiftwidth=4
