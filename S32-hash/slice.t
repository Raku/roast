use v6;
use Test;

# L<S32::Containers/"Hash">

=begin pod

Testing hash slices.

=end pod

plan 29;

{   my %hash = (1=>2,3=>4,5=>6);
    my @s=(2,4,6);

    is(@s, %hash{1,3,5},               "basic slice");
    is(@s, %hash{(1,3,5)},             "basic slice, explicit list");
    is(@s, %hash<1 3 5>,               "basic slice, <> syntax");

    is(%hash{1,1,5,1,3}, "2 2 6 2 4",   "basic slice, duplicate keys");
    is(%hash<1 1 5 1 3>, "2 2 6 2 4",   "basic slice, duplicate keys, <> syntax");


    my @slice = (3,5);

    is(%hash{@slice}, "4 6",      "slice from array, part 1");
    is(%hash{@slice}, (4,6),      "slice from array, part 2");
    is(%hash{@slice[1]}, (6),     "slice from array slice, part 1");
    is(%hash{@slice[0,1]}, (4,6), "slice from array slice, part 2");
}

#?niecza skip 'Excess arguments to CORE List.new, used 1 of 3 positionals'
#?pugs skip 'Must only use named arguments to new() constructor'
{   my %hash;

    %hash{(1,2)} = "one", "two";
    is %hash, {"1" => "one", "2" => "two"},
        "assigning a slice using keys from Parcel";

    %hash{Array.new(1,2)} = "one", "two";
    is %hash, {"1" => "one", "2" => "two"},
        "assigning a slice using keys from Array";

    %hash{"12".comb(/(\d)/)} = "one", "two";
    is %hash, {"1" => "one", "2" => "two"},
        "assigning a slice using keys from GatherIterator";
}

#?pugs todo 'feature'
#?rakudo todo 'binding on hash elements unimplemented'
#?niecza todo 'Writing to readonly scalar'
#?pugs skip "Can't modify constant item: VNum Infinity"
{
    my %hash = :a(1), :b(2), :c(3), :d(4);
    my @slice := %hash<b c>;
    is ~((@slice,*) = <A B C D>), "A B",
	"assigning a slice too many items yields a correct return value";
}

# Slices on hash literals
{   is ~({:a(1), :b(2), :c(3), :d(4)}<b c>), "2 3", "slice on hashref literal";

=begin pod

# not-yet

    is ~((:a(1), :b(2), :c(3), :d(4))<b c>), "2 3", "slice on hash literal";
See thread "Accessing a list literal by key?" on p6l started by Ingo
Blechschmidt: L<"http://www.nntp.perl.org/group/perl.perl6.language/23076">
Quoting Larry:
  Well, conservatively, we don't have to make it work yet.

=end pod

}

# Binding on hash slices
#?rakudo todo 'binding on hash elements unimplemented'
{   my %hash = (:a<foo>, :b<bar>, :c<baz>);

    try { %hash<a b> := <FOO BAR> };
    #?pugs 2 todo 'bug'
    #?niecza 2 todo
    is %hash<a>, "FOO", "binding hash slices works (1-1)";
    is %hash<b>, "BAR", "binding hash slices works (1-2)";
}

#?rakudo todo 'binding on hash elements unimplemented'
{   my %hash = (:a<foo>, :b<bar>, :c<baz>);

    try { %hash<a b> := <FOO> };
    #?pugs 2 todo 'bug'
    #?niecza 2 todo
    is %hash<a>, "FOO",    "binding hash slices works (2-1)";
    ok !defined(%hash<b>), "binding hash slices works (2-2)";
}

{   my %hash = (:a<foo>, :b<bar>, :c<baz>);
    my $foo  = "FOO";
    my $bar  = "BAR";

    try { %hash<a b> := ($foo, $bar) };
    #?rakudo 2 todo 'binding on hash elements unimplemented'
    #?pugs 2 todo 'bug'
    #?niecza 2 todo
    is %hash<a>, "FOO", "binding hash slices works (3-1)";
    is %hash<b>, "BAR", "binding hash slices works (3-2)";

    $foo = "BB";
    $bar = "CC";
    #?rakudo 2 todo 'binding on hash elements unimplemented'
    #?niecza 2 todo
    #?pugs 2 todo 'bug'
    is %hash<a>, "BB", "binding hash slices works (3-3)";
    is %hash<b>, "CC", "binding hash slices works (3-4)";

    %hash<a> = "BBB";
    %hash<b> = "CCC";
    is %hash<a>, "BBB", "binding hash slices works (3-5)";
    is %hash<b>, "CCC", "binding hash slices works (3-6)";

    #?rakudo 2 todo 'binding on hash elements unimplemented'
    #?pugs 2 todo 'bug'
    #?niecza 2 todo
    is $foo,     "BBB", "binding hash slices works (3-7)";
    is $bar,     "CCC", "binding hash slices works (3-8)";
}

# Calculated slices
{   my %hash = (1=>2,3=>4,5=>6);
    my @s=(2,4,6);

    is(@s, [%hash{%hash.keys}.sort],     "values from hash keys, part 1");
    is(@s, [%hash{%hash.keys.sort}],     "values from hash keys, part 2");
    is(@s, [%hash{(1,2,3)>>+<<(0,1,2)}], "calculated slice: hyperop");
}
#vim: ft=perl6
