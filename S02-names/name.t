use v6;
use Test;

plan 15;

#?niecza skip "$a.VAR.name NYI"
# not specifically typed
{
    my $a;
    is $a.VAR.name, '$a', "uninitialized untyped variable should have name";
    $a++;
    is $a.VAR.name, '$a', "initialized untyped variable should have name";
} #2

#?niecza skip "Int $a.VAR.name NYI"
# typed
{
    my Int $a;
    is $a.VAR.name, '$a', "uninitialized typed variable should have name";
    $a++;
    is $a.VAR.name, '$a', "initialized typed variable should have name";
} #2

#?niecza skip "@a.VAR.name NYI"
# not specifically typed
{
    my @a;
    is @a.VAR.name, '@a', "uninitialized untyped array should have name";
    @a.push(1);
    is @a.VAR.name, '@a', "initialized untyped array should have name";
} #2

#?niecza skip "Int @a.VAR.name NYI"
# typed
{
    my Int @a;
    is @a.VAR.name, '@a', "uninitialized typed array should have name";
    @a.push(1);
    is @a.VAR.name, '@a', "initialized typed array should have name";
} #2

#?niecza skip "%a.VAR.name NYI"
# not specifically typed
{
    my %a;
    is %a.VAR.name, '%a', "uninitialized untyped hash should have name";
    %a<o>++;
    is %a.VAR.name, '%a', "initialized untyped hash should have name";
} #2

#?niecza skip "Int %a.VAR.name NYI"
# typed
{
    my Int %a;
    is %a.VAR.name, '%a', "uninitialized typed hash should have name";
    %a<o>++;
    is %a.VAR.name, '%a', "initialized typed hash should have name";
} #2

#?niecza skip "&a.VAR.name NYI"
# not specifically typed
{
    my &a;
    is &a.VAR.name, '&a', "uninitialized untyped sub should have name";
    &a = -> { ... };
    is &a.VAR.name, '&a', "initialized untyped sub should have name";
} #2

#?niecza skip "Int &a.VAR.name NYI"
# typed
{
    my Int &a;
    is &a.VAR.name, '&a', "uninitialized typed sub should have name";
#    &a = -> { ... };
#    is &a.VAR.name, '&a', "initialized typed sub should have name";
} #2

# vim: ft=perl6
