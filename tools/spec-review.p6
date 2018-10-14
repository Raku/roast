#!/usr/bin/env perl6

unit sub MAIN (
    Bool :$no-repo-check,
    Str  :$start   = '6.c-errata',
    UInt :$n       = 10,
    UInt :$skip    = 0,
    Str  :$browser = 'google-chrome',
);

note ｢`git remote` suggests we are NOT inside roast repo. Aborting.｣ and exit 1
  unless $no-repo-check
    or qx/git remote -v/ ~~ m｢'https://github.com/'<-[^/]>+'/roast'｣;

run $browser, qx｢
  git log --pretty=format:'%h | %s' --reverse
｣.lines.skip($skip).grep({
    not /'6.' <[d..z]> ' REVIEW' | ^\S+ ' | Remove trailing whitespace' $/
}).map({
    'https://github.com/perl6/roast/commit/' ~ .words.head
}).head: $n;

=begin pod

This program opens up a sequence of roast commits in your favourite
browser, while skipping spec review commits and commits that claim
to remove trailing whitespace only.

=end pod
