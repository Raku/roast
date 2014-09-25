use v6;

# L<S11/Runtime Importation>

use Test;

plan 18;

use lib '.';

my @tests = (
  "t::spec::packages::RequireAndUse1", { $^a == 42 },
  "t::spec::packages::RequireAndUse2", { $^a != 23 },
  "t::spec::packages::RequireAndUse3", { $^a != 23 },
);

for @tests -> $mod, $expected_ret {

  my @strings = (
    "use $mod",
    "require '{ $mod.split("::").join("/") ~ ".pm" }'",
  );

  for @strings -> $str {
    diag $str;
    my $retval = try { EVAL $str };

    ok defined($retval) && $retval != -1 && $expected_ret($retval),
      "require or use's return value was correct ({$str})";
    # XXX: Keys of %*INC not yet fully decided (module name? module object?),
    # IIRC.
    ok defined(%*INC{$mod}) && %*INC{$mod} != -1 && $expected_ret(%*INC{$mod}),
      "\%*INC was updated correctly ({$str})";
  }
}

our $loaded   = 0;
our $imported = 0;

EVAL q{use t::spec::packages::LoadCounter; 1} orelse die "error loading package: $!";
is($loaded,   1, "use loads a module");
is($imported, 1, "use calls &import");

EVAL q{use t::spec::packages::LoadCounter; 1} orelse die "error loading package: $!";
is($loaded,   1, "a second use doesn't load the module again");
is($imported, 2, "a second use does call &import again");

EVAL q{no t::spec::packages::LoadCounter; 1} orelse die "error no'ing package: $!";
is($loaded,   1, "&no doesn't load the module again");
is($imported, 1, "&no calls &unimport");


# vim: ft=perl6
