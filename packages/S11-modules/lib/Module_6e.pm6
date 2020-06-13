use v6.e.PREVIEW;
unit module Module_6e;

sub core-revision is export { CORE-SETTING-REV }
sub perl-version is export { BEGIN $*PERL.version }

# vim: expandtab shiftwidth=4
