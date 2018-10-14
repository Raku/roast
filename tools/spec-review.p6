#!/usr/bin/env perl6

unit sub MAIN (
    Bool :$no-repo-check,
    Str  :$start        = '6.c-errata',
    Str  :$end          = 'HEAD',
    UInt :$n            = 10,
    UInt :$skip         = 0,
    UInt :$skip-batches = 0, # skip this number multiplied by $n
    Str  :$browser      = 'google-chrome',
);

note ｢`git remote` suggests we are NOT inside roast repo. Aborting.｣ and exit 1
  unless $no-repo-check
    or qx/git remote -v/ ~~ m｢'https://github.com/'<-[^/]>+'/roast'｣;

my @lines = qqx｢
  git log --pretty=format:'\%h | \%s' --reverse $start...$end
｣.lines.grep(*.chars).grep({
    not /'6.' <[d..z]> ' REVIEW' | ^\S+ ' | Remove trailing whitespace' $/
}).skip($skip || $n*$skip-batches).map({
    'https://github.com/perl6/roast/commit/' ~ .words.head
}).head: $n;

.say for @lines;
run $browser, @lines;

=begin pod

This program opens up a sequence of roast commits in your favourite
browser, while skipping spec review commits and commits that claim
to remove trailing whitespace only.

=end pod
