use v6.d;
use Test;

plan 2;

is uniname(0x110000), '<unassigned>',
  "uniname too high returns <unassigned> (1)";
is uniname(0x210000), '<unassigned>',
  "uniname too high returns <unassigned> (2)";

# vim: expandtab shiftwidth=4
