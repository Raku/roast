use Test;

plan 132;

my sub is-true(\value, str $description)  is test-assertion {
    ok value =:= True, $description
}
my sub is-false(\value, str $description) is test-assertion {
    ok value =:= False, $description
}

#------------------------------------------------------------------------------
# compare signed ints

my int8  $i8  = -1;
my int16 $i16 = -1;
my int32 $i32 = -1;
my int64 $i64 = -1;
my int   $i   = -1;

is-true $i8  == $i8,  'equality on 8bit signed int';
is-true $i16 == $i16, 'equality on 16bit signed int';
is-true $i32 == $i32, 'equality on 32bit signed int';
is-true $i64 == $i64, 'equality on 64bit signed int';
is-true $i   == $i,   'equality on signed int';

is-false $i8  != $i8,  'unequality on 8bit signed int';
is-false $i16 != $i16, 'unequality on 16bit signed int';
is-false $i32 != $i32, 'unequality on 32bit signed int';
is-false $i64 != $i64, 'unequality on 64bit signed int';
is-false $i   != $i,   'unequality on signed int';

is-false $i8  < $i8,  'less than on 8bit signed int';
is-false $i16 < $i16, 'less than on 16bit signed int';
is-false $i32 < $i32, 'less than on 32bit signed int';
is-false $i64 < $i64, 'less than on 64bit signed int';
is-false $i   < $i,   'less than on signed int';

is-true $i8  <= $i8,  'less than or equal on 8bit signed int';
is-true $i16 <= $i16, 'less than or equal on 16bit signed int';
is-true $i32 <= $i32, 'less than or equal on 32bit signed int';
is-true $i64 <= $i64, 'less than or equal on 64bit signed int';
is-true $i   <= $i,   'less than or equal on signed int';

is-false $i8  > $i8,  'greater than on 8bit signed int';
is-false $i16 > $i16, 'greater than on 16bit signed int';
is-false $i32 > $i32, 'greater than on 32bit signed int';
is-false $i64 > $i64, 'greater than on 64bit signed int';
is-false $i   > $i,   'greater than on signed int';

is-true $i8  >= $i8,  'greater than or equal on 8bit signed int';
is-true $i16 >= $i16, 'greater than or equal on 16bit signed int';
is-true $i32 >= $i32, 'greater than or equal on 32bit signed int';
is-true $i64 >= $i64, 'greater than or equal on 64bit signed int';
is-true $i   >= $i,   'greater than or equal on signed int';

#------------------------------------------------------------------------------
# compare unsigned ints

my uint8  $u8  = -1;
my uint16 $u16 = -1;
my uint32 $u32 = -1;
my uint64 $u64 = -1;
my uint   $u   = -1;

is $u8,                   255, 'is unsigned 8 ok';
is $u16,                65535, 'is unsigned 16 ok';
is $u32,           4294967295, 'is unsigned 32 ok';
is $u64, 18446744073709551615, 'is unsigned 64 ok';
is $u,   18446744073709551615, 'is unsigned ok';

is-true $u8  == $u8,  'equality on 8bit unsigned int';
is-true $u16 == $u16, 'equality on 16bit unsigned int';
is-true $u32 == $u32, 'equality on 32bit unsigned int';
is-true $u64 == $u64, 'equality on 64bit unsigned int';
is-true $u   == $u,   'equality on unsigned int';

is-false $u8  != $u8,  'unequality on 8bit unsigned int';
is-false $u16 != $u16, 'unequality on 16bit unsigned int';
is-false $u32 != $u32, 'unequality on 32bit unsigned int';
is-false $u64 != $u64, 'unequality on 64bit unsigned int';
is-false $u   != $u,   'unequality on unsigned int';

is-false $u8  < $u8,  'less than on 8bit unsigned int';
is-false $u16 < $u16, 'less than on 16bit unsigned int';
is-false $u32 < $u32, 'less than on 32bit unsigned int';
is-false $u64 < $u64, 'less than on 64bit unsigned int';
is-false $u   < $u,   'less than on unsigned int';

is-true $u8  <= $u8,  'less than or equal on 8bit unsigned int';
is-true $u16 <= $u16, 'less than or equal on 16bit unsigned int';
is-true $u32 <= $u32, 'less than or equal on 32bit unsigned int';
is-true $u64 <= $u64, 'less than or equal on 64bit unsigned int';
is-true $u   <= $u,   'less than or equal on unsigned int';

is-false $u8  > $u8,  'greater than on 8bit unsigned int';
is-false $u16 > $u16, 'greater than on 16bit unsigned int';
is-false $u32 > $u32, 'greater than on 32bit unsigned int';
is-false $u64 > $u64, 'greater than on 64bit unsigned int';
is-false $u   > $u,   'greater than on unsigned int';

is-true $u8  >= $u8,  'greater than or equal on 8bit unsigned int';
is-true $u16 >= $u16, 'greater than or equal on 16bit unsigned int';
is-true $u32 >= $u32, 'greater than or equal on 32bit unsigned int';
is-true $u64 >= $u64, 'greater than or equal on 64bit unsigned int';
is-true $u   >= $u,   'greater than or equal on unsigned int';

#------------------------------------------------------------------------------
# mixed comparisons

is-false $u8  == $i8,  'equality on 8bit uint / int';
is-false $u16 == $i16, 'equality on 16bit uint / int';
is-false $u32 == $i32, 'equality on 32bit uint / int';
is-false $u64 == $i64, 'equality on 64bit uint / int';
is-false $u   == $i,   'equality on uint / int';

is-false $i8  == $u8,  'equality on 8bit int / uint';
is-false $i16 == $u16, 'equality on 16bit int / uint';
is-false $i32 == $u32, 'equality on 32bit int / uint';
is-false $i64 == $u64, 'equality on 64bit int / uint';
is-false $i   == $u,   'equality on int / uint';

is-false $u8  != $i8,  'unequality on 8bit uint / int';
is-false $u16 != $i16, 'unequality on 16bit uint / int';
is-false $u32 != $i32, 'unequality on 32bit uint / int';
is-false $u64 != $i64, 'unequality on 64bit uint / int';
is-false $u   != $i,   'unequality on uint / int';

is-false $i8  != $u8,  'unequality on 8bit int / uint';
is-false $i16 != $u16, 'unequality on 16bit int / uint';
is-false $i32 != $u32, 'unequality on 32bit int / uint';
is-false $i64 != $u64, 'unequality on 64bit int / uint';
is-false $i   != $u,   'unequality on int / uint';

is-false $u8  < $i8,  'less than on 8bit uint / int';
is-false $u16 < $i16, 'less than on 16bit uint / int';
is-false $u32 < $i32, 'less than on 32bit uint / int';
is-false $u64 < $i64, 'less than on 64bit uint / int';
is-false $u   < $i,   'less than on uint / int';

is-true $i8  < $u8,  'less than on 8bit int / uint';
is-true $i16 < $u16, 'less than on 16bit int / uint';
is-true $i32 < $u32, 'less than on 32bit int / uint';
is-true $i64 < $u64, 'less than on 64bit int / uint';
is-true $i   < $u,   'less than on int / uint';

is-false $u8  <= $i8,  'less than or equal on 8bit uint / int';
is-false $u16 <= $i16, 'less than or equal on 16bit uint / int';
is-false $u32 <= $i32, 'less than or equal on 32bit uint / int';
is-false $u64 <= $i64, 'less than or equal on 64bit uint / int';
is-false $u   <= $i,   'less than or equal on uint / int';

is-true $i8  <= $u8,  'less than or equal on 8bit int / uint';
is-true $i16 <= $u16, 'less than or equal on 16bit int / uint';
is-true $i32 <= $u32, 'less than or equal on 32bit int / uint';
is-true $i64 <= $u64, 'less than or equal on 64bit int / uint';
is-true $i   <= $u,   'less than or equal on int / uint';

is-true $u8  > $i8,  'greater than on 8bit uint / int';
is-true $u16 > $i16, 'greater than on 16bit uint / int';
is-true $u32 > $i32, 'greater than on 32bit uint / int';
is-true $u64 > $i64, 'greater than on 64bit uint / int';
is-true $u   > $i,   'greater than on uint / int';

is-false $i8  > $u8,  'greater than on 8bit int / uint';
is-false $i16 > $u16, 'greater than on 16bit int / uint';
is-false $i32 > $u32, 'greater than on 32bit int / uint';
is-false $i64 > $u64, 'greater than on 64bit int / uint';
is-false $i   > $u,   'greater than on int / uint';

is-true $u8  >= $i8,  'greater than or equal on 8bit uint / int';
is-true $u16 >= $i16, 'greater than or equal on 16bit uint / int';
is-true $u32 >= $i32, 'greater than or equal on 32bit uint / int';
is-true $u64 >= $i64, 'greater than or equal on 64bit uint / int';
is-true $u   >= $i,   'greater than or equal on uint / int';

is-false $i8  >= $u8,  'greater than or equal on 8bit int / uint';
is-false $i16 >= $u16, 'greater than or equal on 16bit int / uint';
is-false $i32 >= $u32, 'greater than or equal on 32bit int / uint';
is-false $i64 >= $u64, 'greater than or equal on 64bit int / uint';
is-false $i   >= $u,   'greater than or equal on int / uint';

# https://github.com/rakudo/rakudo/issues/3936
{
    is-deeply (my byte   $ = +^0),                  255, 'byte scaled ok';
    is-deeply (my uint8  $ = +^0),                  255, 'uint8 scaled ok';
    is-deeply (my uint16 $ = +^0),                65535, 'uint16 scaled ok';
    is-deeply (my uint32 $ = +^0),           4294967295, 'uint32 scaled ok';
    is-deeply (my uint64 $ = +^0), 18446744073709551615, 'uint64 scaled ok';
    is-deeply (my uint   $ = +^0), 18446744073709551615, 'uint scaled ok';
}

# https://github.com/rakudo/rakudo/issues/5954
{
    my class Data {
        has uint32 $.a;
        has uint32 $.b;
        has uint32 $.c;
        has uint32 $.hashlen;
        has Buf $.salt;
    }

    my int $fails;
    for 1 .. 20000 {
        my $meta = Data.new(:salt(Buf.new), :hashlen(32));
        ++$fails if $meta.hashlen != 32;
    }

    nok $fails, "Saw $fails failures in uint test";
}
