use v6;
use Test;

plan 125;

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
    for <append push> -> $what {
        my $a = Buf.new(1, 2, 3);
        ok $a === $a."$what"(4), "$what returns self";
        is $a.elems, 4, "Buf .elems correct after $what";
        is $a[3], 4, "Buf last element correct after $what";

        my @items = 5, 6;
        ok $a === $what eq "push" ?? $a.push(|@items) !! $a.append(@items),
        "$what returns self";

        is $a.elems, 6, "Buf .elems correct after {$what}ing a list";
        is $a[4], 5, "Buf penultimate element correct after {$what}ing a list";
        is $a[5], 6, "Buf last element correct after {$what}ing a list";

        ok $a === $a."$what"(7, 8), "$what returns self";

        is $a.elems, 8, "Buf .elems correct after {$what}ing varargs";
        is $a[6], 7, "Buf penultimate element correct {$what}ing appending varargs";
        is $a[7], 8, "Buf last element correct after {$what}ing varargs";

        ok $a === $what eq 'push' ?? $a.push(|9 xx 1) !! $a.append(9 xx 1),
          "$what returns self";

        is $a.elems, 9, "Buf .elems correct after {$what}ing xx list";
        is $a[8], 9, "Buf last element correct after {$what}ing xx list";
    }
}

{
    for <prepend unshift> -> $what {
        my $a = Buf.new(1, 2, 3);
        ok $a === $a."$what"(4), "$what returns self";
        is $a.elems, 4, "Buf .elems correct after $what";
        is $a[0], 4, "Buf first element correct after $what";

        my @items = 5, 6;
        ok $a === $what eq 'unshift'
          ?? $a.unshift(|@items) !! $a.prepend(@items),
          "$what returns self";

        is $a.elems, 6, "Buf .elems correct after {$what}ing a list";
        is $a[0], 5, "Buf first element correct after {$what}ing a list";
        is $a[1], 6, "Buf second element correct after {$what}ing a list";

        ok $a === $a."$what"(7, 8), "$what returns self";

        is $a.elems, 8, "Buf .elems correct after {$what}ing varargs";
        is $a[0], 7, "Buf first element correct {$what}ing appending varargs";
        is $a[1], 8, "Buf second element correct after {$what}ing varargs";

        ok $a === $what eq 'unshift'
          ?? $a.unshift(|9 xx 1) !! $a.prepend(9 xx 1), "$what returns self";

        is $a.elems, 9, "Buf .elems correct after {$what}ing xx list";
        is $a[0], 9, "Buf first element correct after {$what}ing xx list";
    }
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

{
    my @a;
    my $b = Blob.new(@a);
    is $b.elems, 0, "did Blob.new on empty array work";
    my $c = Buf.new(@a);
    is $c.elems, 0, "did Buf.new on empty array work";
}

# RT #127642
ok Blob eqv Blob, 'Blob eqv Blob lives, works';
nok Buf eqv Blob, 'Buf eqv Blob lives, works';

{
    for Blob, Buf -> $T {
        my $t = $T.^name;

        my $a = $T.allocate(10);
        is $a.elems, 10, "did we allocate a $t of 10 elements";
        is $a.join, "0000000000", "was the $t initialized correctly";

        if $T === Blob {
            throws-like { $a.reallocate(12) }, Exception,
              "we cannot reallocate a Blob";
        }
        else {
            $a.reallocate(12);
            is $a.elems, 12, "did we reallocate the $t to 12 elements";
            is $a.join, "000000000000", "was the $t changed correctly";
        }

        my $b = $T.allocate(10, 42);
        is $b.elems, 10, "did we allocate a $t to 10 elements";
        is $b.join, "42424242424242424242", "was the $t initialized correctly";

        if $T === Buf {
            $b.reallocate(13);
            is $b.elems, 13, "did we reallocate the $t to 13 elements";
            is $b.join, "42424242424242424242000", "was the $t changed correctly";
        }

        my $c = $T.allocate(10, (1,2,3));
        is $c.elems, 10, "did we allocate a $t to 10 elements";
        is $c.join, "1231231231", "was te $t initialized correctly";

        if $T === Buf {
            $c.reallocate(4);
            is $c.elems, 4, "did we reallocate the $t to 4 elements";
            is $c.join, "1231", "was the $t changed correctly";
        }
    }
}

# RT #126529
{
    my Blob $a = "a".encode;
    my Blob $b = "b".encode;
    $a ~= $b;
    is $a, utf8.new(97,98), 'infix:<~> with Blob does not die';
}
