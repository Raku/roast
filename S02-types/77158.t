use v6;
use Test;
plan 2;

ok :(Int).perl eq ':(Int)', "RT #77158 Doing .perl on an :(Int)";
ok :(Array of Int).perl eq ':(Array[Int])', "Doing .perl on an :(Array of Int)";
