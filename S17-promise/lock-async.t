use Test;

plan 39;

throws-like { Lock::Async.new.unlock },
    X::Lock::Async::NotLocked,
    'Cannot unlock an async lock that was never locked';

{
    my $lock = Lock::Async.new;
    lives-ok { await $lock.lock() }, 'Can successfully acquire the lock';
    lives-ok { $lock.unlock() }, 'Can successfully release the lock';
    lives-ok { await $lock.lock() }, 'Can successfully acquire the lock again';
    lives-ok { $lock.unlock() }, 'Can successfully release the lock again';
    throws-like { Lock::Async.new.unlock },
        X::Lock::Async::NotLocked,
        'Trying an extra unlock dies';
}

{
    my $lock = Lock::Async.new;

    my $acquire1 = $lock.lock();
    isa-ok $acquire1, Promise, 'lock() method returns a Promise';
    is $acquire1.status, Kept, 'The Promise on first call to lock is Kept';

    my $acquire2 = $lock.lock();
    isa-ok $acquire2, Promise, 'Second call to lock() method returns a Promise';
    is $acquire2.status, Planned, 'The Promise on the second call to lock is Planned';

    lives-ok { $lock.unlock() }, 'Can unlock';
    await Promise.anyof($acquire2, Promise.in(5));
    is $acquire2.status, Kept, 'The Promise on the second lock() call was kept';
    lives-ok { $lock.unlock() }, 'Can unlock the second time';

    my $acquire3 = $lock.lock();
    is $acquire3.status, Kept, 'Locking the now-free lock again works';
    lives-ok { $lock.unlock() }, 'And can unlock it again';
}

{
    my $lock = Lock::Async.new;

    my @promises;
    lives-ok { @promises = $lock.lock() xx 5 }, '5 acquires in a row work';
    for ^5 -> $i {
        isa-ok @promises[$i], Promise, "Acquire {$i + 1} returns a Promise";
    }
    is @promises[0].status, Kept, 'First Promise is kept';
    for 1..4 -> $i {
        is @promises[$i].status, Planned, "Promise {$i + 1} is planned";
    }

    for 1..4 -> $i {
        lives-ok { $lock.unlock() }, "Unlock $i lived";
        await Promise.anyof(@promises[$i], Promise.in(5));
        is @promises[$i].status, Kept, "Promise {$i + 1} is now also kept";
    }
    lives-ok { $lock.unlock() }, 'Unlock 5 lived';

    my $acquire-after = $lock.lock();
    is $acquire-after.status, Kept, 'Locking the now-free lock again works';
    lives-ok { $lock.unlock() }, 'And can unlock it again';
}

{
    my $target = 0;;
    my $target-lock = Lock::Async.new;
    await start {
        for ^10000 -> $i {
            $target-lock.protect: {
                $target += $i;
            }
        }
    } xx 4;
    is $target, 4 * [+](^10000), 'Lock provides mutual exclusion (1)';
}

{
    my @target;
    my $target-lock = Lock::Async.new;
    await start {
        for ^10000 -> $i {
            $target-lock.protect: {
                push @target, $i;
            }
        }
    } xx 4;
    is [+](@target), 4 * [+](^10000), 'Lock provides mutual exclusion (2)';
}

done-testing;
