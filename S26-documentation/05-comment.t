use Test;
plan 9;
my $r;

sub norm_crlf($str) {
    $str.subst("\r\n", "\n", :g)
}

=begin pod
=for comment
foo foo
bla bla    bla

This isn't a comment
=end pod

$r = $=pod[0];
isa-ok $r.contents[0], Pod::Block::Comment;
is $r.contents[0].contents.elems, 1;
is norm_crlf($r.contents[0].contents), "foo foo\nbla bla    bla\n";

# from S26
=comment
This file is deliberately specified in Raku Pod format

$r = $=pod[1];
isa-ok $r, Pod::Block::Comment;
is $r.contents.elems, 1, 'one-line comment: number of elements';;
is norm_crlf($r.contents[0]),
   "This file is deliberately specified in Raku Pod format\n",
   'one-line comment: contents';

# this happens to break hilighting in some editors,
# so I put it at the end
=begin comment
foo foo
=begin invalid pod
=as many invalid pod as we want
===yay!
=end comment

$r = $=pod[2];
isa-ok $r, Pod::Block;
is $r.contents.elems, 1;
is norm_crlf($r.contents[0]), "foo foo\n=begin invalid pod\n"
                ~ "=as many invalid pod as we want\n===yay!\n";

# vim: expandtab shiftwidth=4
