use v6;
use MONKEY-SEE-NO-EVAL;
use Test;

plan 86;

for <$scalar @positional %associative &callable> -> Str:D $name {
    subtest $name, {
        plan 3;

        my Parameter:D $lhs .= new: :$name;
        my Parameter:D $rhs  = ":($name)".&EVAL.params[0];
        is $lhs.sigil, $rhs.sigil, 'parameter has the correct sigil';
        is $lhs.name, $rhs.name, 'parameter has the correct name';
        cmp-ok $lhs.type, &[=:=], $rhs.type, 'parameter has the correct type';
    };
}

given <\sigilless> -> Str:D $name {
    subtest $name, {
        plan 3;

        my Parameter:D $lhs .= new: :$name;
        my Parameter:D $rhs  = ":($name)".&EVAL.params[0];
        is $lhs.sigil, $rhs.sigil, 'parameter has the correct sigil';
        is $lhs.name, $rhs.name, 'parameter has the correct name';
        is $lhs.raw, $rhs.raw, 'parameter is raw';
    };
}

given <$*dynamic> -> Str:D $name {
    subtest $name, {
        plan 3;

        my Parameter:D $lhs .= new: :$name;
        my Parameter:D $rhs  = ":($name)".&EVAL.params[0];
        is $lhs.sigil, $rhs.sigil, 'parameter has the correct sigil';
        is $lhs.twigil, $rhs.twigil, 'parameter has the correct twigil';
        is $lhs.name, $rhs.name, 'parameter has the correct name';
    };
}

for <$!private-attribute $.public-attribute> -> Str:D $name {
    subtest $name, {
        plan 3;

        my Parameter:D $lhs .= new: :$name;
        my Parameter:D $rhs  = Qs:to/CONTAINER/.&EVAL.^lookup('container').signature.params[1];
        class { has $name; method container($name) { } }
        CONTAINER
        is $lhs.sigil, $rhs.sigil, 'parameter has the correct sigil';
        is $lhs.twigil, $rhs.twigil, 'parameter has the correct twigil';
        is $lhs.name, $rhs.name, 'parameter has the correct name';
    };
}

for <:$named :nested($named) :nested(:$named)> -> Str:D $name {
    subtest $name, {
        plan 3;

        my Parameter:D $lhs .= new: :$name;
        my Parameter:D $rhs  = ":($name)".&EVAL.params[0];
        is $lhs.sigil, $rhs.sigil, 'parameter has the correct sigil';
        cmp-ok $lhs.named_names, &[eqv], $rhs.named_names, 'parameter has the correct named names';
        is $lhs.name, $rhs.name, 'parameter has the correct name';
    };
}

given <:$*dynamic> -> Str:D $name {
    subtest $name, {
        plan 4;

        my Parameter:D $lhs .= new: :$name;
        my Parameter:D $rhs  = ":($name)".&EVAL.params[0];
        is $lhs.sigil, $rhs.sigil, 'parameter has the correct sigil';
        is $lhs.twigil, $rhs.twigil, 'parameter has the correct twigil';
        cmp-ok $lhs.named_names, &[eqv], $rhs.named_names, 'parameter has the correct named names';
        is $lhs.name, $rhs.name, 'parameter has the correct name';
    };
}

for <:$!private-attribute :$.public-attribute> -> Str:D $name {
    subtest $name, {
        plan 4;

        my Parameter:D $lhs .= new: :$name;
        my Parameter:D $rhs  = Qs:to/CONTAINER/.&EVAL.^lookup('container').signature.params[1];
        class { has $name.substr(1); method container($name) { } }
        CONTAINER
        is $lhs.sigil, $rhs.sigil, 'parameter has the correct sigil';
        is $lhs.twigil, $rhs.twigil, 'parameter has the correct twigil';
        cmp-ok $lhs.named_names, &[eqv], $rhs.named_names, 'parameter has the correct named names';
        is $lhs.name, $rhs.name, 'parameter has the correct name';
    };
}

for <$optional? $mandatory! :$optional? :$mandatory!> -> Str:D $name {
    subtest $name, {
        plan 3;

        my Parameter:D $lhs .= new: :$name;
        my Parameter:D $rhs  = ":($name)".&EVAL.params[0];
        is $lhs.suffix, $rhs.suffix, 'parameter has the correct suffix';
        is $lhs.name, $rhs.name, 'parameter has the correct name';
        is $lhs.optional, $rhs.optional, 'parameter has the correct optionality';
    };
}

given <*%slurpy> -> Str:D $name {
    subtest $name, {
        plan 5;

        my Parameter:D $lhs .= new: :$name;
        my Parameter:D $rhs  = ":($name)".&EVAL.params[0];
        is $lhs.prefix, $rhs.prefix, 'parameter has the correct prefix';
        is $lhs.sigil, $rhs.sigil, 'parameter has the correct sigil';
        is $lhs.name, $rhs.name, 'parameter has the correct name';
        is $lhs.named, $rhs.named, 'parameter is named';
        is $lhs.slurpy, $rhs.slurpy, 'parameter is slurpy';
    };
}

for <*@slurpy **@slurpy +@slurpy> -> Str:D $name {
    subtest $name, {
        plan 5;

        my Parameter:D $lhs .= new: :$name;
        my Parameter:D $rhs  = ":($name)".&EVAL.params[0];
        is $lhs.prefix, $rhs.prefix, 'parameter has the correct prefix';
        is $lhs.sigil, $rhs.sigil, 'parameter has the correct sigil';
        is $lhs.name, $rhs.name, 'parameter has the correct name';
        is $lhs.positional, $rhs.positional, 'parameter is positional';
        is $lhs.slurpy, $rhs.slurpy, 'parameter is slurpy';
    };
}

given <+slurpy> -> Str:D $name {
    subtest $name, {
        plan 6;

        my Parameter:D $lhs .= new: :$name;
        my Parameter:D $rhs  = ":($name)".&EVAL.params[0];
        is $lhs.prefix, $rhs.prefix, 'parameter has the correct prefix';
        is $lhs.sigil, $rhs.sigil, 'parameter has the correct sigil';
        is $lhs.name, $rhs.name, 'parameter has the correct name';
        is $lhs.positional, $rhs.positional, 'parameter is positional';
        is $lhs.slurpy, $rhs.slurpy, 'parameter is slurpy';
        is $lhs.raw, $rhs.raw, 'parameter is raw';
    };
}

given <|capture> -> Str:D $name {
    subtest $name, {
        plan 5;

        my Parameter:D $lhs .= new: :$name;
        my Parameter:D $rhs  = ":($name)".&EVAL.params[0];
        is $lhs.prefix, $rhs.prefix, 'parameter has the correct prefix';
        is $lhs.sigil, $rhs.sigil, 'parameter has the correct sigil';
        is $lhs.name, $rhs.name, 'parameter has the correct name';
        is $lhs.capture, $rhs.capture, 'parameter is a capture';
        is $lhs.raw, $rhs.raw, 'parameter is raw';
    };
}

for <*%slurpy *@slurpy **@slurpy +@slurpy +slurpy |capture> X~ <! ?> -> Str:D $name {
    # XXX: These need to be bound due to a bug in &[eqv]'s Parameter
    # candidate.
    my Parameter:D $lhs := Parameter.new: :$name;
    my Parameter:D $rhs := Parameter.new: :name($name.chop);
    cmp-ok $lhs, &[eqv], $rhs, "'$name' is equivalent to '$name.chop()'";
}

given <$scalar> -> Str:D $name {
    ok  Parameter.new(:$name, :named).named,
        'can mark parameters as being named';
    ok  Parameter.new(:$name, :optional).optional,
        'can mark parameters as being optional';
    nok Parameter.new(:$name, :named, :mandatory).optional,
        'can mark parameters as being mandatory';
    ok  Parameter.new(:name("$name?"), :mandatory).optional,
        'optional positional parameters ignore any mandatory marker';
    nok Parameter.new(:name("$name!"), :optional).optional,
        'mandatory positional parameters ignore any optional marker';
    ok  Parameter.new(:name("$name?"), :named, :mandatory).optional,
        'optional named parameters ignore any mandatory marker';
    nok Parameter.new(:name("$name!"), :named, :optional).optional,
        'mandatory named parameters ignore any optional marker';
    ok  Parameter.new(:$name, :is-copy).copy,
        'can mark parameters as being copies';
    ok  Parameter.new(:$name, :is-raw).raw,
        'can mark parameters as being raw';
    nok Parameter.new(:$name, :is-rw).readonly,
        'can mark mandatory scalar parameters as being rw';
    ok  Parameter.new(:$name, :named, :is-rw).readonly,
        'cannot mark optional scalar parameters as being rw';
}

for <@positional %associative &callable> -> Str:D $name {
    my Str:D $kind = $name.substr: 1;
    ok Parameter.new(:$name, :is-rw).readonly, "cannot mark mandatory $kind parameters as being rw";
    ok Parameter.new(:$name, :named, :is-rw).readonly, "cannot mark optional $kind parameters as being rw";
}

given <\sigilless> -> Str:D $name {
    my Str:D $kind = $name.substr: 1;
    nok Parameter.new(:$name, :is-rw).readonly, "cannot mark $kind parameters as being rw";
}

given 1 -> Int:D $default {
    for <$scalar :$scalar> -> Str:D $name {
        my Parameter:D $parameter .= new: :$name, :$default;
        ok $parameter.default, "'$name' can have a default value";
    }
    for <*@slurpy **@slurpy +@slurpy +slurpy |capture> -> Str:D $name {
        my Parameter:D $parameter .= new: :$name, :$default;
        nok $parameter.default, "'$name' cannot have a default value";
    }
}

given Any -> Mu $type is raw {
    cmp-ok Parameter.new(:$type).type, &[=:=], $type, 'can pass type objects as types to Parameter.new';
    cmp-ok Parameter.new(:type($type.new)).type, &[=:=], $type, 'can pass instances as types to Parameter.new';
}

given <Int> -> Str:D $type {
    for <$typed @typed %typed &typed> -> Str:D $name {
        my Parameter:D $lhs .= new: :$name, :$type;
        my Parameter:D $rhs  = ":($type $name)".&EVAL.params[0];
        cmp-ok $lhs.type, &[=:=], $rhs.type, "'$type $name' has the correct type";
    }
}

given <Int:D> -> Str:D $type {
    for <$typed @typed %typed &typed> -> Str:D $name {
        subtest "$type $name", {
            plan 2;

            my Parameter:D $lhs .= new: :$name, :$type;
            my Parameter:D $rhs  = ":($type $name)".&EVAL.params[0];
            cmp-ok $lhs.type, &[=:=], $rhs.type, "parameter has the correct type";
            is $lhs.modifier, $rhs.modifier, "parameter has the correct modifier";
        }
    }
}

given <Int(Num(Str))> -> Str:D $type {
    for <$typed @typed %typed &typed> -> Str:D $name {
        subtest "$type $name", {
            plan 2;

            my Parameter:D $lhs .= new: :$name, :$type;
            my Parameter:D $rhs  = ":($type $name)".&EVAL.params[0];
            is $lhs.type.^name, $rhs.type.^name, 'parameter has the correct type';
            is $lhs.coerce_type.^name, $rhs.coerce_type.^name, 'parameter has the correct coercion type';
        };
    }
}

given <Int:D(Num:U(Str:_))> -> Str:D $type {
    for <$typed @typed %typed &typed> -> Str:D $name {
        subtest "$type $name", {
            plan 3;

            my Parameter:D $lhs .= new: :$name, :$type;
            my Parameter:D $rhs  = ":($type $name)".&EVAL.params[0];
            is $lhs.type.^name, $rhs.type.^name, 'parameter has the correct type';
            is $lhs.coerce_type.^name, $rhs.coerce_type.^name, 'parameter has the correct coercion type';
            is $lhs.modifier, $rhs.modifier, 'parameter has the correct modifier';
        };
    }
}

given Int:D -> Mu $type is raw {
    for <*@slurpy **@slurpy +@slurpy +slurpy |capture> -> Str:D $name {
        my Parameter:D $param .= new: :$name, :$type;
        cmp-ok $param.type, &[!=:=], $type, "'$type.^name() $name' does not get typed";
    }
}

given <$constrained>, ({ 1 },) -> [Str:D $name, @where] {
    my Parameter:D $param = Parameter.new: :$name, :@where;
    cmp-ok @where.all, &[~~], $param.constraints, "'$name where 1' has the correct constraints";
}

given <@sub-signatured>, :(Int:D) -> [Str:D $name, Signature:D $sub-signature] {
    my Parameter:D $param = Parameter.new: :$name, :$sub-signature;
    cmp-ok (1,), &[~~], $param.sub_signature, "'$name $sub-signature.gist()' has the correct sub-signature";
}

# vim: expandtab shiftwidth=4
