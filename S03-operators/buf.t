use v6.c;
use Test;

plan 55;

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

#?rakudo.jvm skip 'RT #126530'
ok $a ~ $b eq Buf.new(1, 2, 3, 1, 2, 3, 4), '~ and eq work on bufs';

#?rakudo.jvm skip 'RT #126530'
is-deeply Buf.new(1, 2, 3) ~ Buf.new(4, 5), Buf.new(1, 2, 3, 4, 5), '~ concatenates';
nok Buf.new(), 'empty Buf is false';
ok  Buf.new(1), 'non-empty Buf is true';

ok Buf.new(1, 2, 3, 4).subbuf(2) eqv Buf.new(3, 4), '.subbuf(start)';
ok Buf.new(1, 2, 3, 4).subbuf(1, 2) eqv Buf.new(2, 3), '.subbuf(start, len)';

# Length out of bounds. Behave like substr, return elements available.
ok Buf.new(1, 2).subbuf(0, 3) eqv Buf.new(1,2), '.subbuf length out of bounds';
ok Buf.new.subbuf(0, 1) eqv Buf.new(), "subbuf on an empty buffer";

# Throw on negative range
throws-like { Buf.new(1).subbuf(-1, 1) }, X::OutOfRange,
  got   => -1,
  range => "0..1",
  "throw on negative range";

# Throw on out of bounds
throws-like { Buf.new(0xFF).subbuf(2, 1) }, X::OutOfRange,
  got   => 2,
  range => "0..1",
  "throw on out of range (positive)";

{ # Counted from the end
    ok Buf.new(^10).subbuf(*-5, 5) eqv Buf.new(5..9), "counted from the end";
    ok Buf.new(1, 2).subbuf(*-1, 10) eqv Buf.new(2), "counted from the end, length out of bounds";
}

# Throw on out of bounds, from the end.
throws-like { Buf.new(0xFF).subbuf(*-2, 1) }, X::OutOfRange,
  got   => *,
  range => "0..1",
  "throw on out of bounds, counted from the end";

throws-like { Buf.new().subbuf(0, -1) }, X::OutOfRange,
  got   => -1,
  range => "0..0",
  "throw on negative len";

# RT #122827
{
    use experimental :pack;
    my Blob $x;
    throws-like { $x ~= pack "V",1 }, X::Buf::AsStr, :method<Stringy>;
}

# RT #122600
{
    my $a = buf8.new([]);
    throws-like { "Foo: $a" }, X::Buf::AsStr, :method<Stringy>;
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

# .append tests (RT #125182)
{
    my $a = Buf.new(1, 2, 3);
    $a.append(4);
    is $a.elems, 4, "Buf .elems correct after push";
    is $a[3], 4, "Buf last element correct after push";

    my @items = 5, 6;
    $a.append(@items);

    is $a.elems, 6, "Buf .elems correct after pushing a list";
    is $a[4], 5, "Buf penultimate element correct after pushing a list";
    is $a[5], 6, "Buf last element correct after pushing a list";

    $a.append(7, 8);

    is $a.elems, 8, "Buf .elems correct after pushing varargs";
    is $a[6], 7, "Buf penultimate element correct after pushing varargs";
    is $a[7], 8, "Buf last element correct after pushing varargs";

    $a.append(9 xx 1);

    is $a.elems, 9, "Buf .elems correct after pushing xx list";
    is $a[8], 9, "Buf last element correct after pushing xx list";
}

# RT #123928
{
    my Buf $raw-bin .= new(0x55 xx 3);
    is $raw-bin.elems, 3, 'Can create Buf with .= new';
}

{
    my $b = Buf.new(^100);
    is-deeply $b.subbuf(^10), Buf.new(^10),
      'can we use ^10 as specifier';
    is-deeply $b.subbuf(10..20), Buf.new(10..20),
      'can we use 10..20 as specifier';
} 
