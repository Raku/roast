use v6;

use Test;

plan 17;

#?rakudo.parrot skip 'Metamodel::Primitives NYI'
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
            for Any.^method_table.pairs, Mu.^method_table.pairs {
                %cache{.key} //= .value;
            }
            Metamodel::Primitives.install_method_cache($type, %cache);

            $type
        }

        method type_check(Mu $, Mu \check) {
            $union-type-checks++;
            for @!types, Any, Mu {
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
