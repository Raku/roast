use Test;
plan 10;

{
    my @fifties-novels;
    @fifties-novels[2 ; 2,3] = "Charlotte's Web", "The Voyage of the Dawn Treader";
    is_deeply @fifties-novels,
        Array.new(Any, Any, [Any, Any, "Charlotte's Web", "The Voyage of the Dawn Treader"]),
        "Autovivifying LoL assignment on Array with multiple final indices";
}

{
    my @fifties-novels;
    @fifties-novels[2, 4; 1] = "Charlotte's Web", "The Lord of the Rings";
    is_deeply @fifties-novels,
        Array.new(Any, Any, [Any, "Charlotte's Web"], Any, [Any, "The Lord of the Rings"]),
        "Autovivifying LoL assignment on Array with multiple starting indices";
}

{
    my @fifties-novels;
    @fifties-novels[2, 4; 2,3] =
        "Charlotte's Web", "The Voyage of the Dawn Treader",
        "The Lord of the Rings", "I Am Legend";
    is_deeply @fifties-novels,
        Array.new(Any, Any, [Any, Any, "Charlotte's Web", "The Voyage of the Dawn Treader"],
                  Any, [Any, Any, "The Lord of the Rings", "I Am Legend"]),
        "Autovivifying LoL assignment on Array with multiple starting indices and multiple final indices";
}

{
    my @lmao-matrix; # an LoL-accessed-Array (obviously)
    @lmao-matrix[*; 2] = "whatever";
    is_deeply @lmao-matrix, Array.new(),
        "Assignment on Array to * slices do nothing on empty, unshaped arrays";

    @lmao-matrix = [<lists don't>], [<end here>];
    @lmao-matrix[*-1, *-2; 1] = <of are>;
    is_deeply @lmao-matrix, Array.new([<lists are>], [<end of>]),
        "LoL assignment on Array with WhateverCode indices";

    @lmao-matrix[*; {$_}; 0, 1] = <appended to each list>;
    is_deeply @lmao-matrix, Array.new([<lists are>, [<appended to>]], [<end of>, [<each list>]]),
        "Autovivifying LoL assignment on Array with Whatever/Code indices";
}

{
    my %weather;
    %weather{<Philadelphia Paris>;<description>} = "Mostly cloudy", "Clear";
    is_deeply %weather, {
        "Philadelphia" => {"description" => "Mostly cloudy"},
        "Paris"        => {"description" => "Clear"}
    }, "Autovivifying LoL assignment on Hash with multiple starting indices";
}

{
    my %weather;
    %weather{<Philadelphia>;<tempurature humidity description>} =
        7, .54, "Mostly cloudy";
    is_deeply %weather, {
        "Philadelphia" => {"tempurature" => 7, "humidity" => 0.54, "description" => "Mostly cloudy"},
    }, "Autovivifying LoL assignment on Hash with multiple final indices";
}

{
    my %weather;
    %weather{<Philadelphia Paris>;<tempurature humidity description>} =
        7, .54, "Mostly cloudy",
        2, .67, "Clear";
    is_deeply %weather, {
        "Philadelphia" => {"tempurature" => 7, "humidity" => 0.54, "description" => "Mostly cloudy"},
        "Paris"        => {"tempurature" => 2, "humidity" => 0.67, "description" => "Clear"}
    }, "Autovivifying LoL assignment on Hash with multiple starting indices and multiple final indices";
}

{
    my %rofl-mapping; # an LoL-accessed-Hash (obviously)
    %rofl-mapping{*; <unreachable>} = "whatever";
    is_deeply %rofl-mapping, {},
        "Assignment on Hash to * slices do nothing on empty, unshaped arrays";
}

# vim: ft=perl6
