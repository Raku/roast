use v6;

use Test;

plan 33;

# basic lvalue assignment
{
    my $hash;
    isa-ok $hash, Any;

    $hash{"1st"} = 5;
    isa-ok $hash, Hash;

    is $hash{"1st"}, 5, 'lvalue hash assignment works (w/ double quoted keys)';

    $hash{'1st'} = 4;
    is $hash{'1st'}, 4, 'lvalue hash re-assignment works (w/ single quoted keys)';

    $hash<3rd> = 3;
    is $hash<3rd>, 3, 'lvalue hash assignment works (w/ unquoted style <key>)';
}

# basic hash creation w/ comma separated key/values
{
    my $hash = hash("1st", 1);
    isa-ok $hash, Hash;
    is $hash{"1st"}, 1, 'comma separated key/value hash creation works';
    is $hash<1st>,   1, 'unquoted <key> fetching works';
}

{
    my $hash = hash("1st", 1, "2nd", 2);
    isa-ok $hash, Hash;
    is $hash{"1st"}, 1,
      'comma separated key/value hash creation works with more than 1st pair';
    is $hash{"2nd"}, 2,
      'comma separated key/value hash creation works with more than 1st pair';
}

# hash slicing
{
    my $hash = {'1st' => 1, '2nd' => 2, '3rd' => 3};
    isa-ok $hash, Hash;

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
    isa-ok $hash_a, "Hash";
    my $hash_b = { a => 1, "b", 2 };
    isa-ok $hash_b, "Hash";
    my $hash_c = hash('a', 1, "b", 2);
    isa-ok $hash_c, "Hash";
    my $hash_d = hash 'a', 1, "b", 2;
    isa-ok $hash_d, "Hash";
}

# infinity HoHoHoH...
{
    my %hash = (val => 42);
    %hash<ref> = %hash;
    isa-ok %hash,           Hash;
    isa-ok %hash<ref>,      Hash;
    isa-ok %hash<ref><ref>, Hash;
    is %hash<ref><val>,      42, "access to infinite HoHoHoH... (1)";
    is %hash<ref><ref><val>, 42, "access to infinite HoHoHoH... (2)";
}

# RT #132238
throws-like "\n\nsay \$<\n\n", X::Comp::AdHoc,
    'good error message for unclosed <> hash operator',
    message =>
        /:i[:s unable to parse<|w>] .* <|w>find\s+\'\>\' .* [:s at line 3] /;
#?rakudo todo 'RT #132238'
throws-like "say \$<", X::Comp::AdHoc,
    'better and shorter error message for unclosed <> hash operator',
    # somewhat tricky does not contain "expecting any of"
    gist => /^ [. <!before [:s expecting any of:]>]* $ /;

# vim: ft=perl6
