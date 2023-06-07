use Test;

plan 30;

my $o;
my $o1;
my $p = -1;

#=== valid ways to write a =defn block:

# delimited, uses %config
=begin defn :numbered
B<term 1>
B<def 1>
=end defn

$o  = $=pod[++$p];
isa-ok $o, 'Pod::Defn';
ok $o.config<numbered>:exists;
is $o.term, 'B<term 1>';
isa-ok $o.contents[0], 'Pod::Block::Para';
is $o.contents[0].contents[0], 'B<def 1>';

# abbreviated, no %config, uses data on first line for term
=defn term 2
def 2 line1
def 2 line2

$o  = $=pod[++$p];
isa-ok $o, 'Pod::Defn';
is $o.term, 'term 2';
isa-ok $o.contents[0], 'Pod::Block::Para';
is $o.contents[0].contents[0], 'def 2 line1 def 2 line2';

# abbreviated, no %config, uses data on first line for term
# hash on first line is alias for %config ':numbered'
=defn # term 3
def 3 line1
def 3 line2

$o  = $=pod[++$p];
isa-ok $o, 'Pod::Defn';
ok $o.config<numbered>:exists;
is $o.term, 'term 3';
isa-ok $o.contents[0], 'Pod::Block::Para';
is $o.contents[0].contents[0], 'def 3 line1 def 3 line2';


# paragraph, uses %config
=for defn
term 4
def 4 line1
def 4 line2

$o  = $=pod[++$p];
isa-ok $o, 'Pod::Defn';
is $o.term, 'term 4';
isa-ok $o.contents[0], 'Pod::Block::Para';
is $o.contents[0].contents[0], 'def 4 line1 def 4 line2';

# paragraph, uses %config
=for defn :numbered(0)
term 5
def 5 line1
def 5 line2

$o  = $=pod[++$p];
isa-ok $o, 'Pod::Defn';
is $o.config<numbered>, 0;
is $o.term, 'term 5';
isa-ok $o.contents[0], 'Pod::Block::Para';
is $o.contents[0].contents[0], 'def 5 line1 def 5 line2';

# delimited, uses %config, multiple paragraphs
=begin defn :numbered
term 6
def 6 line 1

def 6 line 2 after blank line
=end defn

$o  = $=pod[++$p];
isa-ok $o, 'Pod::Defn';
is $o.config<numbered>, True;
is $o.term, 'term 6';
isa-ok $o.contents[0], 'Pod::Block::Para';
is $o.contents[0].contents[0], 'def 6 line 1';
isa-ok $o.contents[1], 'Pod::Block::Para';
is $o.contents[1].contents[0], 'def 6 line 2 after blank line';

# vim: expandtab shiftwidth=4
