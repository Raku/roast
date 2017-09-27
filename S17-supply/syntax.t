use v6;
use Test;

plan 81;

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
    my $trigger = Supplier.new;
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
    my $trigger = Supplier.new;
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
    my $trigger1 = Supplier.new;
    my $trigger2 = Supplier.new;
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
    my $trigger1 = Supplier.new;
    my $closed2 = False;
    my $trigger2 = Supplier.new;
    my $s = supply {
        whenever $trigger1.Supply.on-close({ $closed1 = True; }) { }
        whenever $trigger2.Supply.on-close({ $closed2 = True; }) { }
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
    my $trigger1 = Supplier.new;
    my $closed2 = False;
    my $trigger2 = Supplier.new;
    my $s = supply {
        whenever $trigger1.Supply.on-close({ $closed1 = True; }) {
            emit $_;
        }
        whenever $trigger2.Supply.on-close({ $closed2 = True; }) {
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
    my $trigger1 = Supplier.new;
    my $trigger2 = Supplier.new;
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
    my $trigger = Supplier.new;
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

    my $trigger = Supplier.new;
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
    my $trigger = Supplier.new;
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

    my $trigger = Supplier.new;
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

# RT #128717
{
    my $i = 0;
    react whenever Supply.interval: 0.01 { done() if $_ == 3; $i++ }
    is $i, 3, 'blockless react/whenever works';
}

{
    my $trigger1 = Supplier.new;
    my $trigger2 = Supplier.new;

    my $p1 = Promise.new;
    my $p2 = Promise.new;
    my $p3 = Promise.new;

    my $s = supply {
        whenever $trigger1 -> $value {
            $p1.keep(True);
            await $p2;
            emit "a $value";
        }
        whenever $trigger2 -> $value {
            emit "the $value";
            $p3.keep(True);
        }
    }

    my @collected;
    $s.tap({ @collected.push($_) });

    start { $trigger1.emit('bear'); }
    await $p1;
    start { $trigger2.emit('wolf'); }
    $p2.keep(True);
    await $p3;

    is @collected, ['a bear', 'the wolf'], 'Can only be in one whatever block at a time';
}

# RT #126089
throws-like 'emit 42', X::ControlFlow, illegal => 'emit';
throws-like 'done', X::ControlFlow, illegal => 'done';

# whenever with channel
{
    my $c = Channel.new;
    start {
        $c.send($_) for 1..10;
        $c.close();
    }
    my $total = 0;
    react {
        whenever $c {
            $total += $_;
        }
    }
    is $total, 55, 'can use channels with whenever';
}

# multiple whenevers with channels
{
    my $c1 = Channel.new;
    my $c2 = Channel.new;
    my $p1 = Promise.new;
    my $p2 = Promise.new;
    start {
        $c1.send(1);
        await $p2;
        $c1.send(3);
        $c1.close();
    }
    start {
        await $p1;
        $c2.send(2);
        $c2.close();
    }
    my $order = '';
    react {
        whenever $c1 {
            $order ~= $_;
            $p1.keep(True) unless $p1;
        }
        whenever $c2 {
            $order ~= $_;
            $p2.keep(True);
        }
    }
    is $order, '123', 'multiple channels in whenever blocks work';
}

{
    my $closed = False;
    my $input = Supplier.new;
    my $s = supply {
        whenever $input {
            emit .uc;
        }
        CLOSE {
            $closed = True;
        }
    }

    my @got;
    my $t = $s.tap({ @got.push: $_ });
    $input.emit('dugong!');
    is @got, 'DUGONG!', 'supply block with CLOSE phaser works as normal';
    nok $closed, 'CLOSE phaser not run yet';
    $t.close;
    ok $closed, 'CLOSE phaser run on tap close';

    $closed = False;
    my $t2 = $s.tap();
    $input.done();
    ok $closed, 'CLOSE phaser runs also on normal termination';
    $closed = False;
    $t2.close;
    nok $closed, 'CLOSE phasers do not run twice (normal termination then .close)';
}

{
    sub foo($a) {
        supply {
            whenever Supply.from-list() {
                LAST emit $a;
            }
        }
    }
    is await(foo(42)), 42, 'LAST in whenever triggered without iterations sees correct outer (1)';
    #?rakudo.jvm todo "got: '42'"
    is await(foo(69)), 69, 'LAST in whenever triggered without iterations sees correct outer (2)';
}

lives-ok {
    react {
        whenever Supply.from-list(gather { die }) {
            QUIT { default { } }
        }
    }
}, 'QUIT properly handles exception even when dieing synchronously with the .tap';

{
    sub foo($a) {
        supply {
            whenever Supply.from-list(gather { die }) {
                QUIT {
                   default {
                       emit $a;
                   }
               }
            }
        }
    }
    is await(foo(42)), 42, 'QUIT in whenever triggered without iterations sees correct outer (1)';
    #?rakudo.jvm todo "got: '42'"
    is await(foo(69)), 69, 'QUIT in whenever triggered without iterations sees correct outer (2)';
}

# RT #128991
lives-ok {
    for ^5 {
        my $p = Promise.new;
        my $s = supply {
            whenever Supply.interval(.001) {
                done if $++ > 50;
            }
        }
        $s.tap(done => { $p.keep(True) }); # Will die if keeping twice
        await $p;
    }
}, 'Never get done message twice from a supply';
lives-ok {
    for ^5 {
        react {
            whenever Supply.interval(.001) {
                done if $++ > 50;
            }
        }
    }
}, 'No react guts crash in case that once spat out two done messages either'; 

lives-ok {
    my $s = supply { whenever Supply.interval(0.001) { done } }
    await do for ^4 {
        start {
            for ^500 {
                react { whenever $s { } }
            }
        }
    }
}, 'No races/crashes around interval that emits done (used to SEGV and various errors)';

lives-ok {
    my $times-triggered;
    react {
        whenever Supply.from-list(^10) {
            next if $_ %% 2;
            $times-triggered++;
        }
    }
    is $times-triggered, 5, "skipping every even number in ^10 with 'next' gives us 5";
}, 'calling "next" inside a whenever block will not die.';

subtest 'next in whenever' => {
    plan 4;

    my @res1;
    react { whenever supply { .emit for ^10 } { next if $_ > 3; @res1.push: $_ } }
    is-deeply @res1, [0, 1, 2, 3], 'skip elements at the end';

    my @res2;
    react { whenever supply { .emit for ^10 } { next if $_ < 6; @res2.push: $_ } }
    is-deeply @res2, [6, 7, 8, 9], 'skip elements at the start';

    my @res3;
    react { whenever supply { .emit for ^10 } {
        next unless 3 < $_ < 6; @res3.push: $_
    }}
    is-deeply @res3, [4, 5], 'skip elements in the middle';

    my @res4;
    react {
        whenever supply { .emit for ^10     } {
            next if $_ > 4;   @res4.push: $_;
        }
        whenever supply { .emit for ^100+5 } {
            next if $_ < 103; @res4.push: $_;
        }
    }
    is-deeply @res4.sort, (0, 1, 2, 3, 4,  103, 104).sort,
        'works when used in two whenevers';
}

# Golf of a react block with a TCP server, which failed to close taps of
# incoming data on the connection.
{
    my $closed = 0;
    my $sod = Supply.on-demand:
        -> $s { start { $s.emit(42); $s.done; } },
        closing => { $closed++ };
    react {
        whenever Supply.interval(0.01) {
            whenever $sod { }
        }
        whenever Promise.in(1) {
            done
        }
    }
    ok $closed, 'Supply is closed by Supply block after it sends done';
}

# RT #126842
lives-ok {
	for ^500 {
		my $channel = Channel.new;
		my $p1 = start {
			react {
				whenever $channel {
				}
			}
		}
		my $p2 = start {
			$channel.send($_) for (1..10);
			$channel.close;
		}
		await $p1,$p2;
	}
}, 'No hang or crash using react to consume channels';

# RT #128717
{
    my $i = 0;
    react whenever Supply.from-list(1..5) { $i += $_ }
    is $i, 15, 'react without block works';
}

# RT #130716
{
    my @pre-emit;
    my $ran-done = True;
    sub make-supply() {
        supply {
            until my $done {
                @pre-emit.push('x');
                emit(++$);
            }
            CLOSE { $ran-done = True; $done = True }
        }
    }

    my $s2 = make-supply;
    my @received;
    react {
        whenever $s2 -> $n {
            push @received, $n;
            done if $n >= 5;
        }
    }

    is @received, [1,2,3,4,5],
        'whenever tapping supply that syncrhonously emits sees values';
    ok $ran-done, 'done block in source supply was run';
    is @pre-emit, ['x','x','x','x','x'],
        'supply block loop did not run ahead of consumer';
}
{
    my $pre-emits = 0;
    my $post-emits = 0;
    sub make-supply() {
        supply {
            loop {
                $pre-emits++;
                emit(++$);
                $post-emits++;
            }
        }
    }

    my $s2 = make-supply;
    my @received;
    react {
        whenever $s2 -> $n {
            push @received, $n;
            done if $n >= 5;
        }
    }

    is @received, [1,2,3,4,5],
        'whenever tapping infinitely emitting synchronous supply terminates';
    is $pre-emits, 6,
        'supply block loop is terminated on emit to dead consumer (1)';
    is $post-emits, 5,
        'supply block loop is terminated on emit to dead consumer (2)';
}

# vim: ft=perl6 expandtab sw=4
