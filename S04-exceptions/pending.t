use v6;
use Test;
plan 21;

# XXX I'm not very confident in my reading of S04, so give a suspicious eye
#     to these tests before using them.

# L<S04/Exceptions/"internal list of unhandled exceptions">

{
    try { die 'OMG' }
    ok $! ~~ Exception, '$! has an exception';
    #?rakudo 2 skip '$!.pending'
    ok $!.pending ~~ List, '$!.pending returns a List';
    is $!.pending, (), '$! there are no exceptions pending';

    undefine $!;
    ok ! $!, '$! has been cleared';
}

sub fail_it { fail $^a }

# L<S04/Exceptions/"test a Failure for .defined or .Bool">

{
    my @fails = ( fail_it(1), fail_it(2), fail_it(3), fail_it(4) );

    #?rakudo todo 'not full of fail?'
    ok all(@fails) ~~ Failure, '@fails is full of fail';
    ok $! !~~ Exception, 'fails do not enter $!';
    #?rakudo 11 skip '$!.pending'
    is +($!.pending.grep( ! *.handled )), 4,
       '$!.pending has three unhandled exceptions';

    ok ! @fails[0].handled, 'fail 0 is not handled';
    ok   @fails[0].not,     'fail 0 is not true';
    ok   @fails[0].handled, 'fail 0 is now handled';

    ok ! @fails[1].handled, 'fail 1 is not handled';
    ok ! @fails[1].defined, 'fail 1 is not defined';
    ok   @fails[1].handled, 'fail 1 is now handled';

# L<S04/Exceptions/"The .handled method is rw">

    ok ! @fails[2].handled, 'fail 2 is not handled';
    lives_ok { @fails[2].handled = 1 }, 'assign to .handled';
    ok   @fails[2].handled, 'fail 2 is now handled';

    is +($!.pending.grep( ! *.handled )), 1,
       '$!.pending has one unhandled exception';

    undefine $!;
    ok ! $!, '$! has been cleared';
}

# L<S04/Exceptions/"At scope exit,">

#?rakudo skip '$object.handled'
{
    my $fails_thrown = 0;
    {
        my @throwable = ( fail_it(1), fail_it(2), fail_it(3) );
        @throwable[1].handled = 1;
        CATCH {
            default {
                $fails_thrown += +($!.pending);
            }
        }
    }
    is $fails_thrown, 2, 'unhandled Failures in $! at block exit are thrown';

    undefine $!;
    ok ! $!, '$! has been cleared';
}

# L<S04/Exceptions/"a Mu method, not a Failure method">

{
    my $win = Mu.new;
    #?rakudo skip '$object.handled'
    ok $win.handled, '.handled method is true for all Mus';
}

# vim: ft=perl6
