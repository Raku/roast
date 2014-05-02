use v6;

use Test;
# L<S04/"Loop statements"/redo>
plan 11;

{
    my $i = 0;
    while (defined($i)) { if (++$i < 3) { redo }; last }
    is($i, 3, "redo caused reapplication of block");
}

{
    my @log;    
    my $i;
    while ++$i < 5 {
        push @log, "before";
        if (++$i == 2) {
            redo;
        } else {
            push @log, "no_redo";
        }
        push @log, "after";
    }
    
    is(~@log, "before before no_redo after before no_redo after", "statements after redo are not executed");
}

{
    my $i = 0;
    my $j = 0;

    for (1, 0) -> $x {
        if ($x && (++$i % 2 == 0)) { redo };
        $j++;
    }

    is($j, 2, '$j++ encountered twice');
    is($i, 1, '$i++ encountered once');
}


{
    my $i = 0;
    my $j = 0;

    for (1, 0, 1, 0) -> $x {
        if ($x && (++$i % 2 == 0)) { redo };
        $j++;
    }

    is($j, 4, '$j++ encountered four times');
    is($i, 3, '$i++ encountered three times');
}


{
    my $i = 0;
    my $j;

    loop ($j = 0; $j < 4; $j++) {
        if ($j % 2 == 0 and $i++ % 2 == 0) { redo }
        $i-=2;
    }

    is($j, 4, '$j unaltered by the fiasco');
    is($i, -4, '$i incremented and decremented correct number of times');
}

{
    # rubicon TestLoopStuff.rb
    #  def testRedoWithFor
    #    sum = 0
    #    for i in 1..10
    #      sum += i
    #      i -= 1
    #      if i > 0
    #        redo
    #      end
    #    end
    #    assert_equal(220, sum)
    #  end
    my $stopping = 100;
    my $sum = 0;
    for 1..10 -> $i is copy {
        $sum += $i;
        $i -= 1;
        last if !$stopping--;
        if $i > 0 {
            redo
        }
    }
    # pugs, rakudo and perl5 independently agree that this should be
    # 201, not 220 as the ruby example says.
    # that's because the ruby example doesn't have the 'is copy' trait.
    is($sum, 201, "testRedoWithFor");

    $stopping = 100;
    $sum = 0;
    my $j = 1;
    my $i;
    while do {$i = $j; $j++ <= 10} {
    $sum += $i;
    $i -= 1;
    last if !$stopping--;
    if $i > 0 { redo }
    }
    is($sum, 220, "test redo with while");
}

{
    # RT #72442
    eval_dies_ok '{redo}', 'redo without loop construct dies';
}

# vim: ft=perl6
