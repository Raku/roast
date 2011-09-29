use v6;

use Test;

plan 31;

# basic lvalue assignment
#?rakudo skip 'hash autovivification'
{
    my $hash;
    isa_ok $hash, Any;

    $hash{"1st"} = 5;
    isa_ok $hash, Hash;

    is $hash{"1st"}, 5, 'lvalue hash assignment works (w/ double quoted keys)';

    $hash{'1st'} = 4;
    is $hash{'1st'}, 4, 'lvalue hash re-assignment works (w/ single quoted keys)';

    $hash<3rd> = 3;
    is $hash<3rd>, 3, 'lvalue hash assignment works (w/ unquoted style <key>)';
}

# basic hash creation w/ comma separated key/values
{
    my $hash = hash("1st", 1);
    isa_ok $hash, Hash;
    is $hash{"1st"}, 1, 'comma separated key/value hash creation works';
    is $hash<1st>,   1, 'unquoted <key> fetching works';
}

{
    my $hash = hash("1st", 1, "2nd", 2);
    isa_ok $hash, Hash;
    is $hash{"1st"}, 1,
      'comma separated key/value hash creation works with more than 1st pair';
    is $hash{"2nd"}, 2,
      'comma separated key/value hash creation works with more than 1st pair';
}

# hash slicing
{
    my $hash = {'1st' => 1, '2nd' => 2, '3rd' => 3};
    isa_ok $hash, Hash;

    my @slice1 = $hash{"1st", "3rd"};
    is +@slice1,   2, 'got the right amount of values from the %hash{} slice';
    is @slice1[0], 1, '%hash{} slice successful (1)';
    is @slice1[1], 3, '%hash{} slice successful (2)';

    my @slice2;
    @slice2 = $hash<3rd 1st>;
    is +@slice2,   2, 'got the right amount of values from the %hash<> slice';
    is @slice2[0], 3, '%hash<> slice was successful (1)';
    is @slice2[1], 1, '%hash<> slice was successful (2)';

    # slice assignment
    $hash{"1st", "3rd"} = (5, 10);
    is $hash<1st>,  5, 'value was changed successfully with slice assignment';
    is $hash<3rd>, 10, 'value was changed successfully with slice assignment';

    $hash<1st 3rd> = (3, 1);
    is $hash<1st>, 3, 'value was changed successfully with slice assignment';
    is $hash<3rd>, 1, 'value was changed successfully with slice assignment';
}

# hashref assignment using {}
# L<S06/Anonymous hashes vs blocks/So you may use sub or hash or pair to disambiguate:>
{
    my $hash_a = { a => 1, b => 2 };
    #?niecza todo
    isa_ok $hash_a, "Hash";
    my $hash_b = { a => 1, "b", 2 };
    #?niecza todo
    isa_ok $hash_b, "Hash";
    my $hash_c = hash('a', 1, "b", 2);
    #?niecza todo
    isa_ok $hash_c, "Hash";
    my $hash_d = hash 'a', 1, "b", 2;
    #?niecza todo
    isa_ok $hash_d, "Hash";
}

# infinity HoHoHoH...
#?rakudo skip 'isa Hash'
#?niecza skip 'Cannot use hash access on an object of type Capture'
{
    my %hash = (val => 42);
    %hash<ref> = \%hash;
    isa_ok %hash,           "Hash";
    isa_ok %hash<ref>,      "Hash";
    isa_ok %hash<ref><ref>, "Hash";
    is %hash<ref><val>,      42, "access to infinite HoHoHoH... (1)";
    is %hash<ref><ref><val>, 42, "access to infinite HoHoHoH... (2)";
}

# vim: ft=perl6
