use Test;
plan 39;
my $r;

=begin pod
The seven suspects are:

=item  Happy
=item  Dopey
=item  Sleepy
=item  Bashful
=item  Sneezy
=item  Grumpy
=item  Keyser Soze
=end pod

$r = $=pod[0];
is $r.contents.elems, 8;
for 1..7 {
    isa_ok $r.contents[$_], Pod::Item;
}

is $r.contents[1].contents[0].contents, 'Happy', 'contents is happy :)';
is $r.contents[2].contents[0].contents, 'Dopey';
is $r.contents[7].contents[0].contents, 'Keyser Soze';
nok $r.contents[4].level.defined, 'no level information';

=begin pod
=item1  Animal
=item2     Vertebrate
=item2     Invertebrate

=item1  Phase
=item2     Solid
=item2     Liquid
=item2     Gas
=item2     Chocolate
=end pod

$r = $=pod[1];
is $r.contents.elems, 8;
for 0..7 {
    isa_ok $r.contents[$_], Pod::Item;
}

is $r.contents[0].contents[0].contents, 'Animal';
is $r.contents[0].level,   1;
is $r.contents[2].contents[0].contents, 'Invertebrate';
is $r.contents[2].level,   2;
is $r.contents[3].contents[0].contents, 'Phase';
is $r.contents[3].level,   1;
is $r.contents[4].contents[0].contents, 'Solid';
is $r.contents[4].level,   2;

=begin pod
=comment CORRECT...
=begin item1
The choices are:
=end item1
=item2 Liberty
=item2 Death
=item2 Beer
=end pod

$r = $=pod[2];
is $r.contents.elems, 5;
for 1..4 {
    isa_ok $r.contents[$_], Pod::Item;
}

# XXX Those items are :numbered in S26, but we're waiting with block
# configuration until we're inside Rakudo, otherwise we'll have to
# pretty much implement Pair parsing in gsocmess only to get rid of
# it later.

=begin pod
Let's consider two common proverbs:

=begin item
I<The rain in Spain falls mainly on the plain.>

This is a common myth and an unconscionable slur on the Spanish
people, the majority of whom are extremely attractive.
=end item

=begin item
I<The early bird gets the worm.>

In deciding whether to become an early riser, it is worth
considering whether you would actually enjoy annelids
for breakfast.
=end item

As you can see, folk wisdom is often of dubious value.
=end pod

$r = $=pod[3];
is $r.contents.elems, 4;
is $r.contents[0].contents, "Let's consider two common proverbs:";
ok $r.contents[1].contents[1].contents
   ~~ /:s This is a common .+ are extremely attractive/;
ok $r.contents[2].contents[1].contents
   ~~ /:s In deciding .+ annelids for breakfast/;
is $r.contents[3].contents, "As you can see, folk wisdom is often of dubious value.";
