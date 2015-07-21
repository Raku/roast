use Test;
plan 17;
my $r;

=begin pod
    =begin code :allow<B>
    =end code
=end pod

$r = $=pod[0].contents[0];
isa-ok $r, Pod::Block::Code;
is $r.config<allow>, 'B';

=begin pod
    =config head2  :like<head1> :formatted<I>
=end pod

$r = $=pod[1].contents[0];
isa-ok $r, Pod::Config;
is $r.type, 'head2';
is $r.config<like>, 'head1';
is $r.config<formatted>, 'I';

=begin pod
    =for pod :number(42) :zebras :!sheep :feist<1 2 3 4>
=end pod

$r = $=pod[2].contents[0];
is $r.config<number>, 42;
#?rakudo todo 'non-string colonpair pod options RT #124281'
{
  is $r.config<zebras>, True;
  is $r.config<sheep>, False;
  isa-ok $r.config<sheep>, Bool;
  isa-ok $r.config<feist>, List;
}

=begin pod
=for DESCRIPTION :title<presentation template>
=                :author<John Brown> :pubdate(2011)
=end pod

$r = $=pod[3].contents[0];
is $r.config<title>, 'presentation template';
is $r.config<author>, 'John Brown';
is $r.config<pubdate>, 2011;

=begin pod
=for table :caption<Table of contents>
    foo bar
=end pod

$r = $=pod[4].contents[0];
isa-ok $r, Pod::Block::Table;
is $r.config<caption>, 'Table of contents';

=begin pod
    =begin code :allow<B>
    These words have some B<importance>.
    =end code
=end pod

$r = $=pod[5].contents[0].contents[1];
isa-ok $r, Pod::FormattingCode;
