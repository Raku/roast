use v6;
use Test;

plan 11;

# Coercions via type-named methods like Any.Int() are tested in coercion-types.t

my class Bar {
    has $.value;
}

my class C1 {
    has $.value;
    has Mu $.coercion-type;
    multi method new(::?CLASS:U: Bar:D $bar) {
        self.new: :value($bar.value), :coercion-type($*COERCION-TYPE)
    }

    proto method COERCE(Any $) {*}
    multi method COERCE(Numeric:D $n) {
        self.new: :value($n * 2)
    }
    # This method demoes how NOT to write a COERCE. It will work for C1 but will cause problems on descending classes.
    multi method COERCE(Bool:D $b) {
        C1.new: :value(!$b)
    }
    multi method COERCE(Array \v) {
        self.new: :value(~v)
    }
}

my class C2 is C1 {
    submethod COERCE(Numeric:D $v) {
        self.new: :value("'" ~ $v ~ "'")
    }
}

my class C3 is C2 {
    multi method COERCE(Pair:D $p) {
        self.new: :value($p.kv)
    }
}

sub is-coerced(Any $v, Mu \target, Any $value, Str:D $desc) {
    subtest $desc, {
        isa-ok $v, target, "target type is ";
        is $v.value, $value, "value";
    }
}

my C1(Any) $v1;

$v1 = pi;
is-coerced $v1, C1, pi * 2, "coercion of a Numeric";

$v1 = True;
is-coerced $v1, C1, False, "coercion of Bool";

$v1 = [1,2];
is-coerced $v1, C1, "1 2", "coercion via stringification";

$v1 = Bar.new(:value("ok!"));
is-coerced $v1, C1, "ok!", "coercion via fallback to method new";
isa-ok $v1.coercion-type, C1(Any), "method new has its context set";

throws-like { $v1 = a => 2 }, X::Coerce::Impossible,
            "coercion throws when no matching method found";

my C2(Any) $v2;

$v2 = pi * 2;
is-coerced $v2, C2, "'" ~ pi * 2 ~ "'", "submethod COERCE works";

throws-like { $v2 = ['a', 'b'] }, X::Coerce::Impossible,
            "a submethod blocks use of parent COERCE methods";

# With C3 we also test for submethod on parent class not blocking fallback to the grandpa class methods
my C3(Any) $v3;
$v3 = ['a', 'b'];
is-coerced $v3, C3, 'a b', "coercion via MRO works";

$v3 = :a<pair>;
is-coerced $v3, C3, 'a pair', "a descendant class can extend ancestor's coercions";

throws-like { $v3 = False }, X::Coerce::Impossible,
            "badly engineered COERCE method results in error on a descendant class";

done-testing;
