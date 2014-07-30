use Test;
plan 27;
my $r;

=for foo

$r = $=pod[0];
isa_ok $r, Pod::Block, 'returns a Pod6 Block';
isa_ok $r, Pod::Block::Named, 'returns a named Block';
is $r.name, 'foo', 'name is ok';
is $r.contents, [], 'no contents, all right';

=for foo
some text

$r = $=pod[1];
isa_ok $r.contents[0], Pod::Block::Para;
is $r.contents[0].contents, "some text", 'the contents are all right';

=for foo
some
spaced   text

$r = $=pod[2];
is $r.contents[0].contents,
   "some spaced text", 'additional whitespace removed  from the contents';
=begin pod

=for got
Inside got

    =for bidden
    Inside bidden

Outside blocks
=end pod

$r = $=pod[3];
isa_ok $r.contents[0], Pod::Block;
is $r.contents[0].contents[0].contents, "Inside got",
   'paragraph block contents ok, 1/2';
isa_ok $r.contents[1], Pod::Block;
is $r.contents[1].contents[0].contents, "Inside bidden",
   'paragraph block contents ok, 1/2';
isa_ok $r.contents[2], Pod::Block::Para;
is $r.contents[2].contents, "Outside blocks",
   'contents outside blocks is all right';

# mixed blocks
=begin pod
=begin one
one, delimited block
=end one
=for two
two, paragraph block
=for three
three, still a parablock

=begin four
four, another delimited one
=end four
=end pod

$r = $=pod[4];
is $r.contents[0].contents[0].contents,
   "one, delimited block", "mixed blocks, 1";
is $r.contents[1].contents[0].contents,
   "two, paragraph block", "mixed blocks, 2";
is $r.contents[2].contents[0].contents,
   "three, still a parablock", "mixed blocks, 3";
is $r.contents[3].contents[0].contents,
   "four, another delimited one", "mixed blocks, 4";

# tests without Albi would still be tests, but definitely very, very sad
# also, Albi without paragraph blocks wouldn't be the happiest dragon
# either
=begin foo
and so,  all  of  the  villages chased
Albi,   The   Racist  Dragon, into the
very   cold   and  very  scary    cave

and it was so cold and so scary in
there,  that  Albi  began  to  cry

    =for bar
    Dragon Tears!

Which, as we all know...

    =for bar
    Turn into Jelly Beans!
=end foo

$r = $=pod[5];
isa_ok $r, Pod::Block;
is $r.contents.elems, 5, '5 sub-nodes in foo';
is $r.name, 'foo';
is $r.contents[0].contents,
   'and so, all of the villages chased Albi, The Racist Dragon, ' ~
   'into the very cold and very scary cave',
   '...in the marmelade forest';
is $r.contents[1].contents,
   'and it was so cold and so scary in there, that Albi began to cry',
   '...between the make-believe trees';
is $r.contents[2].name, 'bar';
is $r.contents[2].contents[0].contents, "Dragon Tears!",
   '...in a cottage cheese cottage';
is $r.contents[3].contents, "Which, as we all know...",
   '...lives Albi! Albi!';
is $r.contents[4].name, 'bar';
is $r.contents[4].contents[0].contents, "Turn into Jelly Beans!",
   '...Albi, the Racist Dragon';
