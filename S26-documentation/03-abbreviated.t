use Test;
plan 30;
my $r;

=foo

$r = $=pod[0];
isa_ok $r, Pod::Block, 'returns a Pod6 Block';
isa_ok $r, Pod::Block::Named, 'returns a named Block';
is $r.contents, [], 'no contents, all right';

=foo some text

$r = $=pod[1];
is $r.contents[0].contents, "some text", 'the contents are all right';

=foo some text
and some more

$r = $=pod[2];
is $r.contents[0].contents, "some text and some more", 'the contents are all right';

=begin pod

=got Inside
got

=bidden Inside
bidden

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
    =two two,
    paragraph block
    =for three
    three, still a parablock

    =begin four
    four, another delimited one
    =end four
    =head1 And just for the sake of having a working =head1 :)
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
is $r.contents[4].contents[0].contents,
   "And just for the sake of having a working =head1 :)", 'mixed blocks, 5';

=begin foo
and so,  all  of  the  villages chased
Albi,   The   Racist  Dragon, into the
very   cold   and  very  scary    cave

and it was so cold and so scary in
there,  that  Albi  began  to  cry

    =bold Dragon Tears!

Which, as we all know...

    =bold Turn
          into
          Jelly
          Beans!
=end foo

$r = $=pod[5];
isa_ok $r, Pod::Block;
is $r.contents.elems, 5, '5 sub-nodes in foo';
is $r.contents[0].contents,
   'and so, all of the villages chased Albi, The Racist Dragon, ' ~
   'into the very cold and very scary cave',
   '...in the marmelade forest';
is $r.contents[1].contents,
   'and it was so cold and so scary in there, that Albi began to cry',
   '...between the make-believe trees';
is $r.contents[2].contents[0].contents, "Dragon Tears!",
   '...in a cottage cheese cottage';
is $r.contents[3].contents, "Which, as we all know...",
   '...lives Albi! Albi!';
is $r.contents[4].contents[0].contents, "Turn into Jelly Beans!",
   '...Albi, the Racist Dragon';

# from S26
=table_not
    Constants 1
    Variables 10
    Subroutines 33
    Everything else 57

$r = $=pod[6];
isa_ok $r, Pod::Block;
is $r.contents.elems, 1;
is $r.contents[0].contents,
   'Constants 1 Variables 10 Subroutines 33 Everything else 57';

=head3
Heading level 3

$r = $=pod[7];
isa_ok $r, Pod::Block;
isa_ok $r, Pod::Heading;
is $r.level, '3';
is $r.contents[0].contents, 'Heading level 3';
