use Test;

plan 14;

ok Encoding::Registry.find('utf8') ~~ Encoding, 'Can find built-in utf8 encoding';
ok Encoding::Registry.find('utf-8') ~~ Encoding, 'Can find built-in utf-8 encoding';
ok Encoding::Registry.find('UTF-8') ~~ Encoding, 'Can find built-in UTF-8 encoding';
ok Encoding::Registry.find('ascii') ~~ Encoding, 'Can find built-in ascii encoding';
ok Encoding::Registry.find('iso-8859-1') ~~ Encoding, 'Can find built-in iso-8859-1 encoding';
ok Encoding::Registry.find('latin-1') ~~ Encoding, 'Can find built-in latin-1 encoding';

throws-like { Encoding::Registry.find('utf-29') },
    X::Encoding::Unknown, name => 'utf-29',
    'Unknown encoding throws correct type of exception';

{
    my class TestEncoding does Encoding {
        method name() { 'utf-29' }
        method alternative-names() { ('utf29', 'prime-enc') }
        method encoder() { die "NYI" }
        method decoder() { die "NYI" }
    }

    lives-ok { Encoding::Registry.register(TestEncoding) },
        'Can register an encoding';

    isa-ok Encoding::Registry.find('utf-29'), TestEncoding,
        'Can find an encoding by its name';
    isa-ok Encoding::Registry.find('UtF-29'), TestEncoding,
        'Encoding finding by name is case-insensitive';
    isa-ok Encoding::Registry.find('utf29'), TestEncoding,
        'Can find an encoding by its alternative names';
    isa-ok Encoding::Registry.find('Prime-Enc'), TestEncoding,
        'Encoding finding by alternative names is case-insensitive';

    my class TestEncoding2 does Encoding {
        method name() { 'utf-29' }
        method alternative-names() { () }
        method encoder() { die "NYI" }
        method decoder() { die "NYI" }
    }
    throws-like { Encoding::Registry.register(TestEncoding2) },
        X::Encoding::AlreadyRegistered, name => 'utf-29',
        'Cannot register an encoding with an overlapping name';

    my class TestEncoding3 does Encoding {
        method name() { 'utf-17' }
        method alternative-names() { ('prime-enc',) }
        method encoder() { die "NYI" }
        method decoder() { die "NYI" }
    }
    throws-like { Encoding::Registry.register(TestEncoding3) },
        X::Encoding::AlreadyRegistered, name => 'prime-enc',
        'Cannot register an encoding with an overlapping alternative name';
}
