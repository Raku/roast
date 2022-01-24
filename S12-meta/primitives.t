use v6.c;

use Test;

plan 18;

{
    my $union-type-checks = 0;
    my $union-find-method-calls = 0;

    class UnionTypeHOW {
        has @!types;
        has $.name;

        submethod BUILD(:@!types) { }

        method new_type(*@types) {
            my $how = self.new(:@types);
            my $type = Metamodel::Primitives.create_type($how, 'Uninstantiable');
            $type.^set_name: @types.map({ .^name }).join(' | ');
            $type
        }

        method set_name(Mu $, $!name) {}

        method name(Mu $) {
            $!name
        }

        method compose(Mu $type) {
            # Set up type checking with cache.
            Metamodel::Primitives.configure_type_checking($type,
                [|@!types, Any, Mu],
                :authoritative, :call_accepts);

            $type
        }

        method type_check(Mu $, Mu \check) {
            ++$union-type-checks;
            for |@!types, Any, Mu {
                return True if check<> =:= $_<>
            }
            return False;
        }

        method accepts_type(Mu $, Mu \check) {
            for @!types {
                return True if Metamodel::Primitives.is_type(check, $_);
            }
            return False;
        }

        method find_method(Mu $, $name) {
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

    ok $int-or-rat ~~ Int, "Union type ok before comopes if on LHS";
    ok $union-type-checks > 0, 'Type checking called method before compose';
    ok $union-find-method-calls >= 1, 'ACCEPTS method lookup before compose';

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

    ok $int-or-rat ~~ Int, "Union type ok after comopes if on LHS";

    # https://github.com/Raku/old-issue-tracker/issues/3606
    #?rakudo.jvm 1 todo 'RT #123426'
    is $union-type-checks, 0, 'Really did use type cache';
}
