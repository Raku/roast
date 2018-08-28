use v6;
use Test;
plan 50;
my $r;

=begin pod
This ordinary paragraph introduces a code block:

    $this = 1 * code('block');
    $which.is_specified(:by<indenting>);

    $which.spans(:newlines);

=end pod

$r = $=pod[0];
is $r.contents[0].contents, 'This ordinary paragraph introduces a code block:';
isa-ok $r.contents[1], Pod::Block::Code;
is $r.contents[1].contents.Str.subst("\r\n", "\n", :g), q[$this = 1 * code('block');
$which.is_specified(:by<indenting>);

$which.spans(:newlines);].subst("\r\n", "\n", :g);

# more fancy code blocks
=begin pod
This is an ordinary paragraph

    While this is not
    This is a code block

    =head1 Mumble mumble

    Suprisingly, this is not a code block
        (with fancy indentation too)

But this is just a text. Again

=end pod

$r = $=pod[1];
is $r.contents.elems, 5;
is $r.contents[0].contents, 'This is an ordinary paragraph';
isa-ok $r.contents[1], Pod::Block::Code;
is $r.contents[1].contents, "While this is not\nThis is a code block";
isa-ok $r.contents[2], Pod::Block;
is $r.contents[2].contents[0].contents, 'Mumble mumble';
isa-ok $r.contents[3], Pod::Block::Para;
is $r.contents[3].contents, "Suprisingly, this is not a code block"
                        ~ " (with fancy indentation too)";
is $r.contents[4].contents, "But this is just a text. Again";

=begin pod

Tests for the feed operators

    ==> and <==
    
=end pod

$r = $=pod[2];
is $r.contents[0].contents, 'Tests for the feed operators';
isa-ok $r.contents[1], Pod::Block::Code;
is $r.contents[1].contents, "==> and <==";

=begin pod
Fun comes

    This is code
  Ha, what now?

 one more block of code
 just to make sure it works
  or better: maybe it'll break!
=end pod

$r = $=pod[3];
is $r.contents.elems, 4;
is $r.contents[0].contents, 'Fun comes';
isa-ok $r.contents[1], Pod::Block::Code;
is $r.contents[1].contents, 'This is code';
isa-ok $r.contents[2], Pod::Block::Code;
is $r.contents[2].contents, 'Ha, what now?';
isa-ok $r.contents[3], Pod::Block::Code;
is $r.contents[3].contents, "one more block of code\n"
                        ~ "just to make sure it works\n"
                        ~ " or better: maybe it'll break!";

=begin pod

=head1 A heading

This is Pod too. Specifically, this is a simple C<para> block

    $this = pod('also');  # Specifically, a code block

=end pod

$r = $=pod[4];
is $r.contents.elems, 3;
isa-ok $r.contents[0], Pod::Block;
is $r.contents[0].contents[0].contents, 'A heading';
is $r.contents[1].contents[0],
   'This is Pod too. Specifically, this is a simple ';
isa-ok $r.contents[1].contents[1], Pod::FormattingCode;
is $r.contents[1].contents[1].type, 'C';
is $r.contents[1].contents[1].contents, 'para';
is $r.contents[1].contents[2], ' block';
isa-ok $r.contents[2], Pod::Block::Code;
is $r.contents[2].contents,
   q[$this = pod('also');  # Specifically, a code block];

=begin pod
    this is code

    =for Podcast
        this is not

    this is not code either

    =begin Itemization
        this is not
    =end Itemization

    =begin Quitem
        and this is not
    =end Quitem

    =begin item
        and this is!
    =end item
=end pod

$r = $=pod[5];
is $r.contents.elems, 6;
isa-ok $r.contents[0], Pod::Block::Code;
is $r.contents[0].contents, 'this is code';

isa-ok $r.contents[1], Pod::Block::Named;
is $r.contents[1].name, 'Podcast';
is $r.contents[1].contents[0].contents, 'this is not';

isa-ok $r.contents[2], Pod::Block::Para;
is $r.contents[2].contents, 'this is not code either';

isa-ok $r.contents[3], Pod::Block::Named;
is $r.contents[3].name, 'Itemization';
is $r.contents[3].contents[0].contents, 'this is not';

isa-ok $r.contents[4], Pod::Block::Named;
is $r.contents[4].name, 'Quitem';
is $r.contents[4].contents[0].contents, 'and this is not';

isa-ok $r.contents[5].contents[0], Pod::Block::Code;
is $r.contents[5].contents[0].contents, 'and this is!';

=begin code
    foo foo
    =begin code
    =end code
=end code

$r = $=pod[6];
isa-ok $r, Pod::Block::Code;
