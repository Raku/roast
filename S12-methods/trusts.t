use v6;

use Test;

# Referencing various parts of Synopsis 12.
# L<S12/Trusts/"if that other class has indicated that it trusts the
# class">

plan 15;

class A {
    trusts B;

    has $!foo;
    has @!bar;
    has %!baz;
}

class B {
    has A $!my_A;

    submethod BUILD () {
        my $an_A = A.new();

        try {
            $an_A!A::foo = 'hello';
        };
        is( $!.defined ?? 1 !! 0, 0, 'A trusts B, B can set an A scalar attr; '~($!//'') );

        try {
            $an_A!A::bar = [1,2,3];
        };
        is( $!.defined ?? 1 !! 0, 0, 'A trusts B, B can set an A array attr; '~($!//'') );

        try {
            $an_A!baz = {'m'=>'v'};
        };
        is( $!.defined ?? 1 !! 0, 0, 'A trusts B, B can set an A hash attr; '~($!//'') );

        $!my_A = $an_A;
    }

    method read_from_A() {
        my ($foo, @bar, %baz);
	my $an_A = $!my_A;   #OK not used

        try {
            $foo = $!an_A!A::foo;
        };
        #?pugs 2 todo 'feature'
        is( $!.defined ?? 1 !! 0, 0, 'A trusts B, B can get an A scalar attr; '~($!//''));
        is( $foo, 'hello', 'value read by B from an A scalar var is correct');

        try {
            @bar = $!an_A!A::bar;
        };
        #?pugs 2 todo 'feature'
        is( $!.defined ?? 1 !! 0, 0, 'A trusts B, B can get an A array attr; '~($!//''));
        is_deeply( @bar, [1,2,3], 'value read by B from an A scalar var is correct');

        try {
            %baz = $!an_A!A::baz;
        };
        #?pugs 2 todo 'feature'
        is( $!.defined ?? 1 !! 0, 0, 'A trusts B, B can get an A hash attr; '~($!//'') );
        is_deeply( %baz, {'m'=>'v'}, 'value read by B from an A scalar var is correct' );
    }
}

class C {
    has A $!my_A;

    submethod BUILD () {
        my $an_A = A.new();

        try {
            $an_A!A::foo = 'hello';
        };
        #?pugs todo 'feature'
        is( $!.defined ?? 1 !! 0, 1, 'A does not trust C, C can not set an A scalar attr; '~($!//'') );

        try {
            $an_A!A::bar = [1,2,3];
        };
        #?pugs todo 'feature'
        is( $!.defined ?? 1 !! 0, 1, 'A does not trust C, C can not set an A array attr; '~($!//'') );

        try {
            $an_A!A::baz = {'m'=>'v'};
        };
        #?pugs todo 'feature'
        is( $!.defined ?? 1 !! 0, 1, 'A does not trust C, C can not set an A hash attr; '~($!//'') );

        $!my_A = $an_A;
    }

    method read_from_A() {
        my ($foo, @bar, %baz);
	my $an_A = $!my_A;

        try {
            $foo = $an_A!A::foo;
        };
        is( $!.defined ?? 1 !! 0, 1, 'A does not trust C, C can not get an A scalar attr; '~($!//'') );

        try {
            @bar = $an_A!A::bar;
        };
        is( $!.defined ?? 1 !! 0, 1, 'A does not trust C, C can not get an A array attr; '~($!//'') );

        try {
            %baz = $an_A!A::baz;
        };
        is( $!.defined ?? 1 !! 0, 1, 'A does not trust C, C can not get an A hash attr; '~($!//'') );
    }
}

my $my_B = B.new();
$my_B.read_from_A();

my $my_C = C.new();
$my_C.read_from_A();

# vim: ft=perl6
