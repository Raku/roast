use v6;

use Test;

plan 26;

{
    my $union-type-checks = 0;
    my $union-find-method-calls = 0;

    class UnionTypeHOW {
        has @!types;

        submethod BUILD(:@!types) { }

        method new_type(*@types) {
            my $how = self.new(:@types);
            my $type = Metamodel::Primitives.create_type($how, 'Uninstantiable');
            $type
        }

        method name($) {
            @!types.map({ .^name }).join(' | ');
        }

        method compose($type) {
            # Set up type checking with cache.
            Metamodel::Primitives.configure_type_checking($type,
                [@!types, Any, Mu],
                :authoritative, :call_accepts);

            # Steal methods of Any/Mu for our method cache.
            my %cache;
            for flat Any.^method_table.pairs, Mu.^method_table.pairs {
                %cache{.key} //= .value;
            }
            Metamodel::Primitives.install_method_cache($type, %cache);

            $type
        }

        method type_check(Mu $, Mu \check) {
            $union-type-checks++;
            for flat @!types, Any, Mu {
                return True if Metamodel::Primitives.is_type(check, $_);
            }
            return False;
        }

        method accepts_type(Mu $, Mu \check) {
            for @!types {
                return True if Metamodel::Primitives.is_type(check, $_);
            }
            return False;
        }

        method find_method($, $name) {
            $union-find-method-calls++;
            Any.^find_method($name);
        }
    }

    my $int-or-rat = UnionTypeHOW.new_type(Int, Rat);
    ok !$int-or-rat.DEFINITE, 'Created a new type object';
    ok $int-or-rat.HOW ~~ UnionTypeHOW, 'Has correct HOW';
    is $int-or-rat.REPR, 'Uninstantiable', 'Has correct REPR';

    $union-type-checks = 0;
    $union-find-method-calls = 0;
    nok Int ~~ $int-or-rat, 'Union type broken before compose (1)';
    nok Rat ~~ $int-or-rat, 'Union type broken before compose (2)';
    nok 420 ~~ $int-or-rat, 'Union type broken before compose (3)';
    nok 4.2 ~~ $int-or-rat, 'Union type broken before compose (4)';

    ok $union-type-checks >= 4, 'Type checking called method before compose';
    ok $union-find-method-calls >= 4, 'ACCEPTS method lookup before compose';

    $int-or-rat.^compose;
    $union-type-checks = 0;
    $union-find-method-calls = 0;
    #?rakudo.jvm 4 todo 'RT #123426'
    ok Int ~~ $int-or-rat, 'Union type works with cache (1)';
    ok Rat ~~ $int-or-rat, 'Union type works with cache (2)';
    ok 420 ~~ $int-or-rat, 'Union type works with cache (3)';
    ok 4.2 ~~ $int-or-rat, 'Union type works with cache (4)';
    nok Str ~~ $int-or-rat, 'Union type works with cache (5)';
    nok 'w' ~~ $int-or-rat, 'Union type works with cache (6)';

    #?rakudo.jvm 2 todo 'RT #123426'
    is $union-type-checks, 0, 'Really did use type cache';
    is $union-find-method-calls, 0, 'Really did use method cache';
}

{
    my class SomeHOW {
        has $.name;
        method find_method(|) { Mu.^find_method('CREATE') }
    }
    my $t-from = Metamodel::Primitives.create_type(SomeHOW.new(name => 'from'));
    Metamodel::Primitives.compose_type($t-from, { attribute => [] });
    my $t-to = Metamodel::Primitives.create_type(SomeHOW.new(name => 'to'), :mixin);
    Metamodel::Primitives.compose_type($t-to, { attribute => [] });
    my $obj = $t-from.CREATE;
    is $obj.HOW.name, 'from', 'Sanity: object has expected type at creation';
    lives-ok { Metamodel::Primitives.rebless($obj, $t-to) },
        'Can rebless to a target mixin type';
    is $obj.HOW.name, 'to', 'Object has expected type after rebless';
}

{
    my class ParametricHOW does Metamodel::Naming {
        # The work required for creating types is handled outside of here.
    }

    my class ParameterizedHOW does Metamodel::Naming {
        has @!parameters is required;

        submethod BUILD(::?CLASS:D: :@parameters! --> Nil) {
            @!parameters := @parameters;
        }

        method new_type(::?CLASS:_: @parameters, Str:D :$name! --> Mu) {
            my ::?CLASS:D $meta := self.bless: :@parameters;
            my Mu         $obj  := Metamodel::Primitives.create_type: $meta, 'Uninstantiable';
            $meta.set_name: $obj, $name;
            $obj
        }

        method parameters(::?CLASS:D: Mu) { @!parameters }
    }

    my Mu $parametric := Metamodel::Primitives.create_type: ParametricHOW.new, 'Uninstantiable';
    $parametric.^set_name: 'Parametric'; # Eases debugging.
    lives-ok {
        Metamodel::Primitives.set_parameterizer: $parametric, -> Mu \obj, @parameters {
            my Str:D $name = 'Parameterized';
            ParameterizedHOW.new_type: @parameters, :$name
        }
    }, 'can set the parameterizer for a metaobject';

    my Mu $parameterized := Nil;
    my Mu $parameter     .= new; # Intentionally containerized with Scalar.
    lives-ok {
        $parameterized := Metamodel::Primitives.parameterize_type: $parametric, $parameter
    }, 'can parameterize metaobjects';
    cmp-ok $parameterized.^parameters.[0], &[=:=], $parameter,
      'type parameters passed to the parameterizer for a metaobject keep their original containers';
    cmp-ok Metamodel::Primitives.type_parameterized($parameterized), &[=:=], $parametric,
      'can get the parametric type of the result of a parameterization';
    cmp-ok Metamodel::Primitives.type_parameters($parameterized).[0], &[=:=], $parameter,
      'can get the type parameters of the result of a parameterization';
    cmp-ok Metamodel::Primitives.type_parameter_at($parameterized, 0), &[=:=], $parameter,
      'can get a specific type parameter of the result of a parameterization';
}
