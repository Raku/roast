use v6;
use Test;

plan 12;

# RT #64656
{
    # This confirms that '-' in a sub name is legal.
    my $subname = 'foo-bar';
    my $calls = 0;
    eval "sub $subname \{ \$calls++ \}";
    ok $! !~~ Exception, "can define $subname";
    eval_lives_ok "$subname()", "can call $subname";
    is $calls, 1, "$subname was called";
}

{
    my $subname = 'do-check';
    my $calls = 0;
    eval "sub $subname \{ \$calls++ \}";
    ok $! !~~ Exception, "can define $subname";
    #?rakudo 2 todo 'RT #64656'
    eval_lives_ok "$subname()", "can call $subname";
    is $calls, 1, "$subname was called";
}

{
    my $subname = 'sub-check';
    my $calls = 0;
    eval "sub $subname \{ \$calls++ \}";
    ok $! !~~ Exception, "can define $subname";
    #?rakudo 2 todo 'RT #64656'
    eval_lives_ok "$subname()", "can call $subname";
    is $calls, 1, "$subname was called";
}

{
    my $subname = 'method-check';
    my $calls = 0;
    eval "sub $subname \{ \$calls++ \}";
    ok $! !~~ Exception, "can define $subname";
    #?rakudo 2 todo 'RT #64656'
    eval_lives_ok "$subname()", "can call $subname";
    is $calls, 1, "$subname was called";
}
