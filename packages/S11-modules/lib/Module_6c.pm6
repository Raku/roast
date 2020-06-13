use v6.c;
unit module Module_6c;

sub core-revision is export { CORE-SETTING-REV }
sub perl-version is export { BEGIN $*PERL.version }

# vim: expandtab shiftwidth=4
