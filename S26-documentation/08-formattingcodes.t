use Test;
plan 49;

my $r;

=pod
B<I am a formatting code>

$r = $=pod[0].contents[0].contents[0];
isa-ok $r, Pod::FormattingCode;
is $r.type, 'B';
is $r.contents[0], 'I am a formatting code', 'a single FC becomes a single FC';

=pod
The basic C<ln> command is: C<ln> B<R<source_file> R<target_file>>

$r = $=pod[1].contents[0].contents;
is $r[0], 'The basic ';
isa-ok $r[1], Pod::FormattingCode;
is $r[1].type, 'C';
is $r[1].contents, 'ln';
is $r[2], ' command is: ';
isa-ok $r[3], Pod::FormattingCode;
is $r[3].type, 'C';
is $r[3].contents, 'ln';
isa-ok $r[5], Pod::FormattingCode;
is $r[4], " ";
is $r[5].type, 'B';
$r = $r[5].contents;
isa-ok $r[0], Pod::FormattingCode;
is $r[0].type, 'R';
is $r[0].contents, 'source_file';
is $r[1], ' ';
isa-ok $r[2], Pod::FormattingCode;
is $r[2].type, 'R';
is $r[2].contents, 'target_file';

=pod
L<C<b>|a>
L<C<b>|a>

$r = $=pod[2].contents[0].contents;
for $r[0], $r[2] -> $link {
    is $link.type, 'L';
    isa-ok $link.contents[0], Pod::FormattingCode;
    is $link.contents[0].contents, 'b';
    is $link.meta, 'a';
}

=begin pod

=head1 A heading

This is Pod too. Specifically, this is a simple C<para> block

    $this = pod('also');  # Specifically, a code block

=end pod

$r = $=pod[3];
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

=pod V<C<boo> B<bar> asd>

$r = $=pod[4];
is $r.contents[0].contents, 'C<boo> B<bar> asd';

# https://github.com/Raku/old-issue-tracker/issues/2867
=pod C< infix:<+> >
=pod C<< infix:<+> >>

#?rakudo 2 todo 'C<> is supposed to be verbatim including leading space'
is $=pod[5].contents[0].contents[0].contents[0], " infix:<+> ",
  "Can parse nested angles in formatting codes with < >";
is $=pod[6].contents[0].contents[0].contents[0], " infix:<+> ",
  "Can parse nested angles in formatting codes with << >>";

=pod B< < B<foo> > >

$r = $=pod[7];
is $r.contents[0].contents[0].contents[1].contents[0], 'foo','FC inside balanced <>';

=pod E<65>

$r = $=pod[8];
is $r.contents[0].contents[0].contents[0], 'A', 'Plain decimal Int literal codepoint escape';

=pod E<0x41>

$r = $=pod[9];
is $r.contents[0].contents[0].contents[0], 'A', 'Hex literal codepoint escape';

=pod E<LATIN CAPITAL LETTER A>

$r = $=pod[10];
is $r.contents[0].contents[0].contents[0], 'A', 'Unicode character name escape';

=pod E<amp>

$r = $=pod[11];
#?rakudo.jvm skip 'HTML5 entities NYI under JVM due to GH Raku/nqp#727'
is $r.contents[0].contents[0].contents[0], '&', 'Lowercase HTML5 entity escape';

=pod E<Assign>

$r = $=pod[12];
#?rakudo.jvm skip 'HTML5 entities NYI under JVM due to GH Raku/nqp#727'
is $r.contents[0].contents[0].contents[0], '≔', 'Mixed-case HTML5 entity escape';

=pod E<sup2>

$r = $=pod[13];
#?rakudo.jvm skip 'HTML5 entities NYI under JVM due to GH Raku/nqp#727'
is $r.contents[0].contents[0].contents[0], '²', 'HTML5 entity escape containing a digit';

# vim: expandtab shiftwidth=4
