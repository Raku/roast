use Test;
plan 45;

my $r;

=pod
B<I am a formatting code>

$r = $=pod[0].contents[0].contents[1];
isa_ok $r, Pod::FormattingCode;
is $r.type, 'B';
is $r.contents[0], 'I am a formatting code';

=pod
The basic C<ln> command is: C<ln> B<R<source_file> R<target_file>>

$r = $=pod[1].contents[0].contents;
is $r[0], 'The basic ';
isa_ok $r[1], Pod::FormattingCode;
is $r[1].type, 'C';
is $r[1].contents, 'ln';
is $r[2], ' command is: ';
isa_ok $r[3], Pod::FormattingCode;
is $r[3].type, 'C';
is $r[3].contents, 'ln';
isa_ok $r[5], Pod::FormattingCode;
is $r[4], " ";
is $r[5].type, 'B';
$r = $r[5].contents;
is $r[0], "";
isa_ok $r[1], Pod::FormattingCode;
is $r[1].type, 'R';
is $r[1].contents, 'source_file';
is $r[2], ' ';
isa_ok $r[3], Pod::FormattingCode;
is $r[3].type, 'R';
is $r[3].contents, 'target_file';

=pod
L<C<b>|a>
L<C<b>|a>

$r = $=pod[2].contents[0].contents;
for $r[1], $r[3] -> $link {
    is $link.type, 'L';
    is $link.contents[0], '';
    isa_ok $link.contents[1], Pod::FormattingCode;
    is $link.contents[1].contents, 'b';
    is $link.meta, 'a';
}

=begin pod

=head1 A heading

This is Pod too. Specifically, this is a simple C<para> block

    $this = pod('also');  # Specifically, a code block

=end pod

$r = $=pod[3];
is $r.contents.elems, 3;
isa_ok $r.contents[0], Pod::Block;
is $r.contents[0].contents[0].contents, 'A heading';
is $r.contents[1].contents[0],
   'This is Pod too. Specifically, this is a simple ';
isa_ok $r.contents[1].contents[1], Pod::FormattingCode;
is $r.contents[1].contents[1].type, 'C';
is $r.contents[1].contents[1].contents, 'para';
is $r.contents[1].contents[2], ' block';
isa_ok $r.contents[2], Pod::Block::Code;
is $r.contents[2].contents,
   q[$this = pod('also');  # Specifically, a code block];

=pod V<C<boo> B<bar> asd>

$r = $=pod[4];
is $r.contents[0].contents, 'C<boo> B<bar> asd';

# RT #114510
=pod C< infix:<+> >
=pod C<< infix:<+> >>

for @$=pod[5, 6] {
    is .contents[0].contents[1].contents[0], "infix:<+> ", "Can parse nested angles in formatting codes"
}

# vim: ft=perl6
