use v6;

use Test;

=begin pod
=head1 DESCRIPTION

This test tests nothingmuch's C<lazy> proposal.

This proposal was accepted on 2005-08-23 in a p6l post by Larry
L<"http://www.nntp.perl.org/group/perl.perl6.language/22890">:

  > Which already seems to be there with
  > 
  >     lazy {...}
  > 
  > which is, I presume, mostly syntactic sugar for something like:
  > 
  >     sub is cached {...}

=end pod

plan 15;

{
  my $was_in_lazy;

  my $var = lazy { $was_in_lazy++; 42 };

  ok !$was_in_lazy,     'our lazy block wasn\'t yet executed (1)';

  is $var,          42, 'our lazy var has the correct value';
  ok $was_in_lazy,      'our lazy block was executed';

  is $var,          42, 'our lazy var still has the correct value';
  is $was_in_lazy,   1, 'our lazy block was not executed again';
}

# Same, but passing the lazy value around before accessing it:
{
  my $was_in_lazy;

  my $var = lazy { $was_in_lazy++; 42 };
  my $sub = -> Num $v, Bool $access { $access and +$v };

  ok !$was_in_lazy,         'our lazy block wasn\'t yet executed (2)';
  $sub($var, 0);  
  ok !$was_in_lazy,         'our lazy block has still not been executed';
  $sub($var, 1);
  ok $was_in_lazy,          'our lazy block has been executed now';
}

# dies_ok/lives_ok tests:
{
  my $was_in_lazy;
  my $lazy = lazy { $was_in_lazy++; 42 };
  lives_ok { $lazy = 23 }, "reassigning our var containing a lazy worked (1)";
  is $lazy, 23,            "reassigning our var containing a lazy worked (2)";
  ok !$was_in_lazy,        "reassigning our var containing a lazy worked (3)";
}

{
  my $was_in_lazy;
  my $lazy = lazy { $was_in_lazy++; 42 };
  lives_ok { $lazy := 23 }, "rebinding our var containing a lazy worked (1)";
  is $lazy, 23,             "rebinding our var containing a lazy worked (2)";
  ok !$was_in_lazy,         "rebinding our var containing a lazy worked (3)";
}

{
  dies_ok { (lazy { 42 }) = 23 },
    "directly assigning to a lazy var does not work";
}

# Arguably, we should remove the $was_in_lazy tests, as it doesn't really
# matter when the lazy {...} block is actually executed.
