use v6.e.PREVIEW;
use Test;

plan 3;

subtest "BUILD" => {
    plan 2;
    my @order;
    my $once = 1;
    my role R0 {
        submethod BUILD(*%a) {
            is %a<arg>, 42, "argument passing works" if $once--;
            @order.push: $?ROLE.^name;
        }
    }
    my role R0a {
        # This won't appear on the list because only submethods are executed on roles.
        method BUILD {
            @order.push: $?ROLE.^name;
        }
    }
    my class C0 does R0 does R0a {
        submethod BUILD {
            @order.push: $?CLASS.^name;
        }
    }
    my role R1 does R0 {
        submethod BUILD {
            @order.push: $?ROLE.^name;
        }
    }
    my role R2 {
        submethod BUILD {
            @order.push: $?ROLE.^name;
        }
    }
    my class C1 does R1 does R2 is C0 {
        submethod BUILD {
            @order.push: $?CLASS.^name;
        }
    }
    C1.new(:42arg);
    is-deeply @order.List, <R0 C0 R0 R1 R2 C1>, "BUILDs are invoked in the right order";
}
subtest "TWEAK" => {
    plan 2;
    my @order;
    my $once = 1;
    my role R0 {
        submethod TWEAK(*%a) {
            is %a<arg>, 13, "argument passing works" if $once--;
            @order.push: $?ROLE.^name;
        }
    }
    my role R0a {
        # This won't appear on the list because only submethods are executed on roles.
        method TWEAK {
            @order.push: $?ROLE.^name;
        }
    }
    my class C0 does R0 does R0a {
        submethod TWEAK {
            @order.push: $?CLASS.^name;
        }
    }
    my role R1 does R0 {
        submethod TWEAK {
            @order.push: $?ROLE.^name;
        }
    }
    my role R2 {
        submethod TWEAK {
            @order.push: $?ROLE.^name;
        }
    }
    my class C1 does R1 does R2 is C0 {
        submethod TWEAK {
            @order.push: $?CLASS.^name;
        }
    }
    C1.new(:13arg);
    is-deeply @order.List, <R0 C0 R0 R1 R2 C1>, "TWEAKs are invoked in the right order";
}
subtest "DESTROY" => {
    plan 2;
    my @order;
    my $on_destroy = Promise.new;
    my $on_destroy_vow = $on_destroy.vow;
    my $build_ran = False;
    my $dlock = Lock.new;
    my role R0 {
        submethod DESTROY {
            @order.push: $?ROLE.^name if $on_destroy.status ~~ Planned;
        }
    }
    my role R0a {
        # This won't appear on the list because only submethods are executed on roles.
        method DESTROY {
            @order.push: $?ROLE.^name;
        }
        submethod BUILD {
            $build_ran = True;
        }
    }
    my class C0 does R0 does R0a {
        submethod DESTROY {
            @order.push: $?CLASS.^name if $on_destroy.status ~~ Planned;
        }
    }
    my role R1 does R0 {
        submethod DESTROY {
            @order.push: $?ROLE.^name if $on_destroy.status ~~ Planned;
        }
    }
    my role R2 {
        submethod DESTROY {
            @order.push: $?ROLE.^name if $on_destroy.status ~~ Planned;
        }
    }
    my class C1 does R1 does R2 is C0 {
        submethod DESTROY {
                if $on_destroy.status ~~ Planned {
                    $on_destroy_vow.keep(True);
                    @order.push: $?CLASS.^name;
                }
        }
    }
    start {
        while $on_destroy.status ~~ Planned {
            C1.new
        }
    }
    await $on_destroy;
    is-deeply @order.List, <R0 C0 R0 R1 R2 C1>, "DESTROYs are invoked in the right order";
    # Cross-check for all above cases where methods in roles aren't called.
    ok $build_ran, "submethod BUILD is still called where role is with method DESTROY";
}

done-testing;
