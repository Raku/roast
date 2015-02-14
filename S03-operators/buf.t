use v6;
use Test;

plan 42;

ok (~^"foo".encode eqv utf8.new(0x99, 0x90, 0x90)), 'prefix:<~^>';

ok ("foo".encode ~& "bar".encode eqv "bab".encode), 'infix:<~&>';
ok ("ber".encode ~| "baz".encode eqv "bez".encode), 'infix:<~|>';
ok ("foo".encode ~^ "bar".encode eqv utf8.new(4, 14, 29)), 'infix:<~^>';

ok ("aaaaa".encode ~& "aa".encode eqv "aa\0\0\0".encode),
    '~& extends rightwards';
ok ("aaaaa".encode ~| "aa".encode eqv "aaaaa".encode),
    '~| extends rightwards';
ok ("aaaaa".encode ~^ "aa".encode eqv "\0\0aaa".encode),
    '~^ extends rightwards';

my $a = Buf.new(1, 2, 3);
my $b = Buf.new(1, 2, 3, 4);

 ok $a eq $a,    'eq +';
nok $a eq $b,    'eq -';
 ok $a ne $b,    'ne +';
nok $a ne $a,    'ne -';
 ok $a lt $b,    'lt +';
nok $a lt $a,    'lt -';
nok $b lt $a,    'lt -';
 ok $b gt $a,    'gt +';
nok $b gt $b,    'gt -';
nok $a gt $b,    'gt -';
is  $a cmp $a, Order::Same, 'cmp (same)';
is  $a cmp $b, Order::Less, 'cmp (smaller)';
is  $b cmp $a, Order::More, 'cmp (larger)';

ok $a ~ $b eq Buf.new(1, 2, 3, 1, 2, 3, 4), '~ and eq work on bufs';

is_deeply Buf.new(1, 2, 3) ~ Buf.new(4, 5), Buf.new(1, 2, 3, 4, 5), '~ concatenates';
nok Buf.new(), 'empty Buf is false';
ok  Buf.new(1), 'non-empty Buf is true';

ok Buf.new(1, 2, 3, 4).subbuf(2) eqv Buf.new(3, 4), '.subbuf(start)';
ok Buf.new(1, 2, 3, 4).subbuf(1, 2) eqv Buf.new(2, 3), '.subbuf(start, len)';

# Length out of bounds. Behave like substr, return elements available.
ok Buf.new(1, 2).subbuf(0, 3) eqv Buf.new(1,2), '.subbuf length out of bounds';
ok Buf.new.subbuf(0, 1) eqv Buf.new(), "subbuf on an empty buffer";

{ # Throw on negative range
    Buf.new(1).subbuf(-1, 1);
    ok 0, "throw on negative range";
    CATCH { when X::OutOfRange { ok 1, "throw on negative range" } }
}

{ # Throw on out of bounds
    Buf.new(0xFF).subbuf(2, 1);
    ok 0, "throw on out of range (positive)";
    CATCH { when X::OutOfRange { ok 1, "throw on out of range (positive)" } }
}

{ # Counted from the end
    ok Buf.new(^10).subbuf(*-5, 5) eqv Buf.new(5..9), "counted from the end";
    ok Buf.new(1, 2).subbuf(*-1, 10) eqv Buf.new(2), "counted from the end, length out of bounds";
}

{ # Throw on out of bounds, from the end.
    Buf.new(0xFF).subbuf(*-2, 1);
    ok 0, "throw on out of bounds, counted from the end";
    CATCH { when X::OutOfRange { ok 1, "throw on out of bounds, counted from the end"; } }
}

{ 
    Buf.new().subbuf(0, -1);
    ok 0, "throw on negative len";
    CATCH { when X::OutOfRange { ok 1, "throw on negative len" } }
}

# RT #122827
{
    my Blob $x;
    throws_like { $x ~= pack "V",1 }, X::Buf::AsStr, :method<Stringy>;
}

# RT #122600
{
    my $a = buf8.new([]);
    throws_like { "Foo: $a" }, X::Buf::AsStr, :method<Stringy>;
}

# Tests that used to gobble all memory in rakudo:
{
    is utf8.new(0x66, 0x6f, 0x6f) ~ 'bar', 'foobar', 'can concat a utf8 buffer to a string';
    is Any ~ 'bar'.encode, 'bar', 'can concat a buffer to something undefined'; #OK
}

# .bytes tests
{
    my $a = buf8.new(1, 2, 3, 4, 5);
    is $a.bytes, 5, "buf8 .bytes correct";
    
    my $b = buf16.new(1, 2, 3, 4, 5);
    is $b.bytes, 10, "buf16 .bytes correct";
    
    my $c = buf32.new(1, 2, 3, 4, 5);
    is $c.bytes, 20, "buf32 .bytes correct";
    
    my $d = buf64.new(1, 2, 3, 4, 5);
    is $d.bytes, 40, "buf64 .bytes correct";
}
