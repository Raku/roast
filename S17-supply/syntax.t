use v6;
use Test;

{
    my $s = supply {
        emit 42;
        emit 'answer';
    }

    my @collected;
    $s.tap({ @collected.push($_) });
    is @collected.elems, 2, 'Got two values emitted by supply';
    is @collected[0], 42, 'First value correct';
    is @collected[1], 'answer', 'Second value correct';

    my @collected-again;
    $s.tap({ @collected-again.push($_) });
    is @collected-again.elems, 2, 'Tapping the supply another time works';
}

{
    my $oops = False;
    my $s = supply {
        emit 101;
        done;
        $oops = True;
        emit 'oh noes';
    }

    my @collected;
    $s.tap({ @collected.push($_) });
    is @collected.elems, 1, 'Only the one emit ran, due to done';
    is @collected[0], 101, 'Got correct value emitted';
    nok $oops, 'Did not continue running code after done';
}

{
    my $s = supply {
        emit 'beans';
        done;
    }

    my $emits-run = 0;
    my $dones-run = 0;
    my $quits-run = 0;
    $s.tap({ $emits-run++ }, done => { $dones-run++ }, quit => { $quits-run++ });
    is $emits-run, 1, 'Block with emit then done runs emit subscription once';
    is $dones-run, 1, 'Block with emit then done runs done subscription once';
    is $quits-run, 0, 'Block with emit then done never runs quit subscription';
}

{
    my $s = supply {
        emit 'peas';
    }

    my $emits-run = 0;
    my $dones-run = 0;
    my $quits-run = 0;
    $s.tap({ $emits-run++ }, done => { $dones-run++ }, quit => { $quits-run++ });
    is $emits-run, 1, 'Block with emit runs emit subscription once';
    is $dones-run, 1, 'Block with emit runs done subscription once (automatically)';
    is $quits-run, 0, 'Block with emit never runs quit subscription';
}

{
    my $s = supply {
        emit 'onions';
        die 'poop';
    }

    my $emits-run = 0;
    my $dones-run = 0;
    my $quits-run = 0;
    $s.tap({ $emits-run++ }, done => { $dones-run++ }, quit => { $quits-run++ });
    is $emits-run, 1, 'Block with emit then die runs emit subscription once';
    is $dones-run, 0, 'Block with emit then die never runs done subscription once';
    is $quits-run, 1, 'Block with emit then die runs quit subscription once';
}

{
    my $trigger = Supply.new;
    my $s = supply {
        whenever $trigger -> $value {
            emit $value * 2;
        }
    }

    my @collected;
    my $done = False;
    my $quit = False;
    $s.tap({ @collected.push($_) }, done => { $done = True }, quit => { $quit = True });

    $trigger.emit(21);
    is @collected.elems, 1, 'whenever loop ran and emitted first event into supply...';
    is @collected[0], 42, '...and emitted correct first value';

    $trigger.emit(50);
    is @collected.elems, 2, 'whenever loop ran and emitted second event into supply...';
    is @collected[1], 100, '...and emitted correct second value';

    nok $done, 'done not run automatically when there is a whenever';
    nok $quit, 'no unexpected quit when there is a whenever';

    $trigger.done();
    ok $done, 'done is run if the whenever gets done';
    nok $quit, 'still no unexpected quit';
}

{
    my $trigger = Supply.new;
    my $s = supply {
        whenever $trigger -> $value {
            emit $value.subst('fruit', 'bacon');
            LAST {
                emit "The end.";
            }
        }
    }

    my @collected;
    $s.tap({ @collected.push($_) });
    $trigger.emit('I ate fruit');
    $trigger.emit('The fruit was so tasty');
    $trigger.done();
    
    is @collected.elems, 3, 'whenever loop produced three values';
    is @collected[0], 'I ate bacon', 'First value from loop iteration correct';
    is @collected[1], 'The bacon was so tasty', 'Second value from loop iteration correct';
    is @collected[2], 'The end.', 'Value from LAST block correct';
}

{
    my $trigger1 = Supply.new;
    my $trigger2 = Supply.new;
    my $s = supply {
        whenever $trigger1 -> $value {
            emit "a $value";
        }
        whenever $trigger2 -> $value {
            emit "the $value";
        }
    }

    my @collected;
    $s.tap({ @collected.push($_) });
    $trigger1.emit('bike');
    $trigger1.emit('train');
    $trigger2.emit('plane');
    $trigger1.emit('car');
    $trigger2.emit('tram');
    $trigger1.emit('trebuchet');
    is @collected, ['a bike', 'a train', 'the plane', 'a car', 'the tram', 'a trebuchet'],
        'Multiple whenevers run concurrently';
}

{
    my $closed1 = False;
    my $trigger1 = Supply.new does role { method close(|) { $closed1 = True; nextsame; } };
    my $closed2 = False;
    my $trigger2 = Supply.new does role { method close(|) { $closed2 = True; nextsame; } };
    my $s = supply {
        whenever $trigger1 { }
        whenever $trigger2 { }
        done;
    }

    my $done = False;
    $s.tap(done => { $done = True });

    ok $done, 'supply block with two whenevers then done runs its done';
    ok $closed1, 'first whenever closes its supply due to the done';
    ok $closed2, 'second whenever closes its supply due to the done';
}

{
    my $closed1 = False;
    my $trigger1 = Supply.new does role { method close(|) { $closed1 = True; nextsame; } };
    my $closed2 = False;
    my $trigger2 = Supply.new does role { method close(|) { $closed2 = True; nextsame; } };
    my $s = supply {
        whenever $trigger1 {
            emit $_;
        }
        whenever $trigger2 {
            done;
        }
    }

    my @collected;
    my $done = False;
    $s.tap({ @collected.push($_) }, done => { $done = True });

    $trigger1.emit('tea');
    $trigger1.emit('coffee');
    $trigger2.emit('beer');
    $trigger1.emit('cocoa');

    is @collected, ['tea', 'coffee'], 'take-until style supply emitted correct values';
    ok $done, 'take-until style supply is done after second supply emits';
    ok $closed1, 'first supply tapped was closed';
    ok $closed2, 'second supply tapped was closed';
}

{
    my $trigger1 = Supply.new;
    my $trigger2 = Supply.new;
    my $s = supply {
        whenever $trigger1 { }
        whenever $trigger2 { }
    }

    my $done = False;
    $s.tap(done => { $done = True });

    nok $done, 'supply block with two whenevers starts out not done';

    $trigger2.done;
    nok $done, 'still not done after one whenever gets done';

    $trigger1.done;
    ok $done, 'but done after all whenevers get done';
}

{
    my $trigger = Supply.new;
    my $s = supply {
        whenever $trigger {
        }
    }

    my $emits-run = 0;
    my $dones-run = 0;
    my $quits-run = 0;
    $s.tap({ $emits-run++ }, done => { $dones-run++ }, quit => { $quits-run++ });

    $trigger.quit('OMG FIRE!');

    is $emits-run, 0, 'supply block with whenever that gets a quit emits no values';
    is $dones-run, 0, 'supply block with whenever that gets a quit is not done';
    is $quits-run, 1, 'supply block with whenever that gets a quit does quit';
}

{
    my class OMGBears is Exception { }

    my $trigger = Supply.new;
    my $s = supply {
        whenever $trigger {
            emit $_;
            QUIT {
                when OMGBears {
                    emit 'Run you fools!';
                    done;
                }
            }
        }
    }

    my @collected;
    my $dones-run = 0;
    my $quits-run = 0;
    $s.tap({ @collected.push($_); }, done => { $dones-run++ }, quit => { $quits-run++ });

    $trigger.emit('Something is coming');
    $trigger.emit('Something big');
    $trigger.quit(OMGBears.new);

    is @collected, ['Something is coming', 'Something big', 'Run you fools!'],
        'emits up to, and emit in a QUIT block, all came out OK';
    is $dones-run, 1, 'done inside of matched QUIT block worked';
    is $quits-run, 0, 'did not produce a quit, since exception handled';
}

{
    my $trigger = Supply.new;
    my $s = supply {
        whenever $trigger {
            QUIT {
                default {
                    # Handle anything
                }
            }
        }
    }

    my $dones-run = 0;
    my $quits-run = 0;
    $s.tap(done => { $dones-run++ }, quit => { $quits-run++ });

    $trigger.quit(Exception.new);
    is $dones-run, 1, 'supply with one whenever that quits but handles it will be done';
    is $quits-run, 0, '...and the handled exception will not cause a quit';
}

{
    my class UselessException is Exception { }

    my $trigger = Supply.new;
    my $s = supply {
        whenever $trigger {
            QUIT {
                 when UselessException {
                    # we never reach here
                }
            }
        }
    }

    my $dones-run = 0;
    my $quits-run = 0;
    $s.tap(done => { $dones-run++ }, quit => { $quits-run++ });

    $trigger.quit(Exception.new);
    is $quits-run, 1, 'supply with one whenever that quits, and QUIT does not match, will still quit';
    is $dones-run, 0, '...and done will not be run';
}

# RT #125987
{
    my $i = 0;
    react {
        whenever supply { emit 'x'; emit 'y'; } {
            $i++
        }
    }
    is $i, 2, 'react/whenever with supply that immediately emits values works';
}

{
    my $trigger1 = Supply.new;
    my $trigger2 = Supply.new;

    my $lock = Lock.new;
    my $cv1 = $lock.condition;
    my $cv2 = $lock.condition;

    my $s = supply {
        whenever $trigger1 -> $value {
            $lock.protect({ $cv1.signal; $cv2.wait });
            emit "a $value";
        }
        whenever $trigger2 -> $value {
            emit "the $value";
        }
    }

    my @collected;
    $s.tap({ @collected.push($_) });

    start { $trigger1.emit('bear'); }
    $lock.protect({ $cv1.wait });
    start { $trigger2.emit('wolf'); }
    sleep 0.5;
    $lock.protect({ $cv2.signal });
    sleep 0.5;

    is @collected, ['a bear', 'the wolf'], 'Can only be in one whatever block at a time';
}

done-testing;
