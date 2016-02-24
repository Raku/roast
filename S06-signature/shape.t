use v6.c;
use Test;

plan 34;

sub single-dim(@a[3]) { }
lives-ok { single-dim(Array.new(:shape(3))) }, '[3] shape constraint accepts matcing array';
dies-ok { single-dim(Array.new()) }, '[3] shape constraint denies unshaped array';
dies-ok { single-dim(Array.new(:shape(4))) }, '[3] shape constraint denies oversied array';
dies-ok { single-dim(Array.new(:shape(2))) }, '[3] shape constraint denies undersized array';
dies-ok { single-dim(Array.new(1, 2, 3)) }, 'Shape constraints are about declared shape';
dies-ok { single-dim(Array.new(:shape(2,2))) }, '[3] shape constraint denies over-dimensioned array...';
dies-ok { single-dim(Array.new(:shape(3,2))) }, '...even if first dimension matches';

sub multi-dim(@a[4,4]) { }
lives-ok { multi-dim(Array.new(:shape(4,4))) }, '[4,4] shape constraint accepts matcing array';
dies-ok { multi-dim(Array.new()) }, '[4,4] shape constraint denies unshaped array';
dies-ok { multi-dim(Array.new(:shape(4, 5))) }, '[4,4] shape constraint denies oversied array (1)';
dies-ok { multi-dim(Array.new(:shape(5, 4))) }, '[4,4] shape constraint denies oversied array (2)';
dies-ok { multi-dim(Array.new(:shape(3,4))) }, '[4,4] shape constraint denies undersized array (1)';
dies-ok { multi-dim(Array.new(:shape(4,3))) }, '[4,4] shape constraint denies undersized array (2)';
dies-ok { multi-dim(Array.new([1..4],[1..4])) }, 'Shape constraints are about declared shape';
dies-ok { multi-dim(Array.new(:shape(3,3,3))) }, '[4,4] shape constraint denies over-dimensioned array...';
dies-ok { multi-dim(Array.new(:shape(4,4,3))) }, '...even if first dimensions match';
dies-ok { multi-dim(Array.new(:shape(4))) }, '[4,4] shape constraint denies under-dimensioned array';

sub whatever-dim(@a[*]) { }
lives-ok { whatever-dim(Array.new()) }, '[*] shape constraint accepts undimensioned array';
lives-ok { whatever-dim(Array.new(:shape(3))) }, '[*] shape constraint accepts fixed single dimension array';
dies-ok { whatever-dim(Array.new(:shape(3,3))) }, '[*] shape constraint rejects 2-dimensioned array';

sub whatever-multidim(@a[*,*]) { }
lives-ok { whatever-multidim(Array.new(:shape(3,3))) }, '[*,*] shape constraint accepts 2-dim shaped array';
dies-ok { whatever-multidim(Array.new(:shape(3))) }, '[*,*] shape constraint rejects 1-dim array';
dies-ok { whatever-multidim(Array.new(:shape(3,3,3))) }, '[*,*] shape constraint rejects 3-dim array';
dies-ok { whatever-multidim(Array.new()) }, '[*,*] shape constraint rejects undimensioned array';

sub whatever-partialdim(@[4,*]) { }
lives-ok { whatever-partialdim(Array.new(:shape(4,3))) }, '[4,*] shape constraint accepts 2-dim shaped array with 4 first dims';
dies-ok { whatever-partialdim(Array.new(:shape(3,3))) }, '[4,*] shape constraint rejects 2-dim shaped array with 3 first dims';
dies-ok { whatever-partialdim(Array.new(:shape(4))) }, '[4,*] shape constraint rejects 1-dim array';
dies-ok { whatever-partialdim(Array.new(:shape(4,4,4))) }, '[4,*] shape constraint rejects 3-dim array';
dies-ok { whatever-partialdim(Array.new()) }, '[4,*] shape constraint rejects undimensioned array';

sub dependent($n, @a[$n]) { }
lives-ok { dependent(3, Array.new(:shape(3))) }, 'can use earlier parameters in shape specification (1)';
lives-ok { dependent(*, Array.new(:shape(3))) }, 'can use earlier parameters in shape specification (2)';
dies-ok { dependent(4, Array.new(:shape(3))) }, 'can use earlier parameters in shape specification (3)';
dies-ok { dependent(4, Array.new()) }, 'can use earlier parameters in shape specification (4)';
dies-ok { dependent(4, Array.new(:shape(4,3))) }, 'can use earlier parameters in shape specification (5)';

