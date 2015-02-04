use Test;
plan 15;

{
    my @fifties-novels;
    @fifties-novels[2 ; 2,3] = "Charlotte's Web", "The Voyage of the Dawn Treader";
    is_deeply @fifties-novels,
        Array.new(Any, Any, [Any, Any, "Charlotte's Web", "The Voyage of the Dawn Treader"]),
        "Autovivifying LoL assignment with multiple final indices";
}

{
    my @fifties-novels;
    @fifties-novels[2, 4; 1] = "Charlotte's Web", "The Lord of the Rings";
    is_deeply @fifties-novels,
        Array.new(Any, Any, [Any, "Charlotte's Web"], Any, [Any, "The Lord of the Rings"]),
        "Autovivifying LoL assignment with multiple starting indices";
}

{
    my @fifties-novels;
    @fifties-novels[2, 4; 2,3] =
        "Charlotte's Web", "The Voyage of the Dawn Treader",
        "The Lord of the Rings", "I Am Legend";
    is_deeply @fifties-novels,
        Array.new(Any, Any, [Any, Any, "Charlotte's Web", "The Voyage of the Dawn Treader"],
                  Any, [Any, Any, "The Lord of the Rings", "I Am Legend"]),
        "Autovivifying LoL assignment with multiple starting indices and multiple final indices";
}

{
    my @lmao-matrix; # an LoL-accessed-Array (obviously)
    @lmao-matrix[*; 2] = "";
    is_deeply @lmao-matrix, Array.new(),
        "Assignment to * slices do nothing on empty, unshaped arrays";

    @lmao-matrix = [<lists don't>], [<end here>];
    @lmao-matrix[*-1, *-2; 1] = <of are>;
    is_deeply @lmao-matrix, Array.new([<lists are>], [<end of>]),
        "LoL assignment with WhateverCode indices";

    @lmao-matrix[*; {$_}; 0, 1] = <appended to each list>;
    is_deeply @lmao-matrix, Array.new([<lists are>, [<appended to>]], [<end of>, [<each list>]]),
        "Autovivifying LoL assignment with Whatever/Code indices";
}

# vim: ft=perl6
