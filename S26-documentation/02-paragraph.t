use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;
plan 28;
my $r;

=for Foo

$r = $=pod[0];
isa-ok $r, Pod::Block, 'returns a Pod6 Block';
isa-ok $r, Pod::Block::Named, 'returns a named Block';
is $r.name, 'Foo', 'name is ok';
is $r.contents, [], 'no contents, all right';

=for Foo
some text

$r = $=pod[1];
isa-ok $r.contents[0], Pod::Block::Para;
is $r.contents[0].contents, "some text", 'the contents are all right';

=for Foo
some
spaced   text

$r = $=pod[2];
is $r.contents[0].contents,
   "some spaced text", 'additional whitespace removed  from the contents';
=begin pod

=for Got
Inside Got

    =for Bidden
    Inside Bidden

Outside blocks
=end pod

$r = $=pod[3];
isa-ok $r.contents[0], Pod::Block;
is $r.contents[0].contents[0].contents, "Inside Got",
   'paragraph block contents ok, 1/2';
isa-ok $r.contents[1], Pod::Block;
is $r.contents[1].contents[0].contents, "Inside Bidden",
   'paragraph block contents ok, 1/2';
isa-ok $r.contents[2], Pod::Block::Para;
is $r.contents[2].contents, "Outside blocks",
   'contents outside blocks is all right';

# mixed blocks
=begin pod
=begin One
One, delimited block
=end One
=for Two
Two, paragraph block
=for Three
Three, still a parablock

=begin Four
Four, another delimited one
=end Four
=end pod

$r = $=pod[4];
is $r.contents[0].contents[0].contents,
   "One, delimited block", "mixed blocks, 1";
is $r.contents[1].contents[0].contents,
   "Two, paragraph block", "mixed blocks, 2";
is $r.contents[2].contents[0].contents,
   "Three, still a parablock", "mixed blocks, 3";
is $r.contents[3].contents[0].contents,
   "Four, another delimited one", "mixed blocks, 4";

# tests without Albi would still be tests, but definitely very, very sad
# also, Albi without paragraph blocks wouldn't be the happiest dragon
# either
=begin Foo
and so,  all  of  the  villages chased
Albi,   The   Racist  Dragon, into the
very   cold   and  very  scary    cave

and it was so cold and so scary in
there,  that  Albi  began  to  cry

    =for Bar
    Dragon Tears!

Which, as we all know...

    =for Bar
    Turn into Jelly Beans!
=end Foo

$r = $=pod[5];
isa-ok $r, Pod::Block;
is $r.contents.elems, 5, '5 sub-nodes in foo';
is $r.name, 'Foo';
is $r.contents[0].contents,
   'and so, all of the villages chased Albi, The Racist Dragon, ' ~
   'into the very cold and very scary cave',
   '...in the marmelade forest';
is $r.contents[1].contents,
   'and it was so cold and so scary in there, that Albi began to cry',
   '...between the make-believe trees';
is $r.contents[2].name, 'Bar';
is $r.contents[2].contents[0].contents, "Dragon Tears!",
   '...in a cottage cheese cottage';
is $r.contents[3].contents, "Which, as we all know...",
   '...lives Albi! Albi!';
is $r.contents[4].name, 'Bar';
is $r.contents[4].contents[0].contents, "Turn into Jelly Beans!",
   '...Albi, the Racist Dragon';


# https://github.com/Raku/old-issue-tracker/issues/6293
#?rakudo.jvm skip 'GH Raku/nqp#727'
is_run Q:to/♥♥♥/, :compiler-args['--doc=Text'],
    =for pod
    =for nested
    =for para :nested(1)
    E<alpha;beta>E<alpha;beta;gamma>
    ♥♥♥
{:err(''), :out("αβαβγ\n"), :0status}, 'nested paras do not crash/warn';

# vim: expandtab shiftwidth=4
