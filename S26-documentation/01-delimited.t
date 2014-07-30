use Test;
plan 40;
my $r;

=begin foo
=end foo

$r = $=pod[0];
isa_ok $r, Pod::Block, 'returns a Pod Block';
isa_ok $r, Pod::Block::Named, 'returns a named Block';
is $r.name, 'foo', 'name is ok';
is $r.contents, [], 'no contents, all right';

=begin foo
some text
=end foo

$r = $=pod[1];
isa_ok $r.contents[0], Pod::Block::Para;
is $r.contents[0].contents, "some text", 'the contents are all right';
is $r.name, 'foo', 'name is ok';

=begin foo
some
spaced   text
=end foo

$r = $=pod[2];
is $r.name, 'foo', 'name is ok';
is $r.contents[0].contents,
   "some spaced text", 'additional whitespace removed from the contents';

=begin foo
paragraph one

paragraph
two
=end foo
$r = $=pod[3];
is $r.name, 'foo', 'name is ok';
isa_ok $r.contents[0], Pod::Block::Para;
isa_ok $r.contents[1], Pod::Block::Para;
is $r.contents[0].contents, "paragraph one", 'paragraphs ok, 1/2';
is $r.contents[1].contents, "paragraph two", 'paragraphs ok, 2/2';

=begin something
    =begin somethingelse
    toot tooot!
    =end somethingelse
=end something

$r = $=pod[4];
is $r.name, 'something', 'parent name ok';
isa_ok $r.contents[0], Pod::Block, "nested blocks work";
isa_ok $r.contents[0].contents[0], Pod::Block::Para, "nested blocks work";
is $r.contents[0].contents[0].contents, "toot tooot!", "and their contents";
is $r.contents[0].name, 'somethingelse', 'child name ok';

# Albi
=begin foo
and so,  all  of  the  villages chased
Albi,   The   Racist  Dragon, into the
very   cold   and  very  scary    cave

and it was so cold and so scary in
there,  that  Albi  began  to  cry

    =begin bar
    Dragon Tears!
    =end bar

Which, as we all know...

    =begin bar
    Turn into Jelly Beans!
    =end bar
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

=begin pod

someone accidentally left a space
 
between these two paragraphs

=end pod

$r = $=pod[6];
isa_ok $r, Pod::Block;
is $r.contents[0].contents, 'someone accidentally left a space',
   'accidental space, 1/2';
is $r.contents[1].contents, 'between these two paragraphs',
   'accidental space, 2/2';

# various things which caused the spectest to fail at some point
=begin kwid

= DESCRIPTION
bla bla

foo
=end kwid

$r = $=pod[7];
is $r.contents[0].contents, '= DESCRIPTION bla bla';
isa_ok $r.contents[1], Pod::Block::Para;
is $r.contents[1].contents, 'foo';

=begin more-discussion-needed

XXX: chop(@array) should return an array of chopped strings?
XXX: chop(%has)   should return a  hash  of chopped strings?

=end more-discussion-needed

$r = $=pod[8];
isa_ok $r, Pod::Block;

=begin pod
    =head1 This is a heading block

    This is an ordinary paragraph.
    Its text  will   be     squeezed     and
    short lines filled. It is terminated by
    the first blank line.

    This is another ordinary paragraph.
    Its     text    will  also be squeezed and
    short lines filled. It is terminated by
    the trailing directive on the next line.
        =head2 This is another heading block

        This is yet another ordinary paragraph,
        at the first virtual column set by the
        previous directive
=end pod

$r = $=pod[9];
isa_ok $r.contents[0], Pod::Heading;
isa_ok $r.contents[1], Pod::Block::Para;
isa_ok $r.contents[2], Pod::Block::Para;
isa_ok $r.contents[3], Pod::Heading;
isa_ok $r.contents[4], Pod::Block::Para;
is $r.contents.elems, 5;

eval_lives_ok "=begin pod\nSome documentation\n=end pod", "Pod files don't have to end in a newline";
