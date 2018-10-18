# WORKING DRAFT: Language Release Guide

This document contains the process for releasing the major version of the language. It uses
`6.d` version as example. Adjust that reference for the version you're actually releasing.

Many of the tasks in this document are concurrent. Please read through the entire document.

## Known Implementations of the Language

As release involves communications with authors of various implementations of the language,
please list the main repository for those in this section:

* Rakudo https://github.com/rakudo/rakudo

## Preparation

Release preparation should commence well in advance of planned release date, as there's often
a large amount of work to perform.

### Prep Repo

To keep various communications for the particular release in one place, and separate from general
spec communications, a [separate repository](https://github.com/perl6/6.d-prep) is created:

    https://github.com/perl6/6.d-prep

Prior to release, ensure all the planned TODO items and Issues in that repository have
been addressed.

### Spec Review

All new commits in the spec repo since last release of the spec need to be reviewed to ensure
they spec desired behaviour for the language. The [`tools/spec-review.p6'](tools/spec-review.p6)
can be useful during this process, to open up batches of commits in your browser:

    tools/spec-review.p6 --start=6.c --n=50 --skip-batches=0 --browser=google-chrome

The commits that aren't part of any release version of the spec can be removed or modified, but
please coordinate with implementation authors, to avoid surprise breakage of code that uses these
experimental behaviours.

During review, if you file any Issues regarding something that needs to be discussed/decided on
before release, be sure to tag it with `6.d-review` tag, so that we know what still needs to be
done before the release.

### TODO Issues

Ensure all open `6.d-review`-tagged Issues in the roast repo have been taken care of before release.
Check with implementations authors for `6.d-review`-tagged issues in their repositories as well.
It's not required that all implementations implement all of the new functionality before the
language release, but it can be very useful to be aware of the content of those Issues.

All specification changes need at least one functioning implementation of the language to
implement them. This is a PoV (Proof of Viability) that the features are implementable and don't
severely conflict with other features of the language.

### ChangeLog

The changelog is compiled by going through new commits in the repo since last spec release.
The same tool used for spec review can be used to assist when creating the changelog and the two
tasks can be completed concurrently.

The changelog's target audience are **the users of the language.** As such, it shouldn't contain
every minute detail of low relevance. The goal should be that users can read this document and
have a fairly good idea of what changes to their code they would have to make were they to upgrade
their compiler from one that supports previous language version to the one that supports the
one we're releasing.

### Fudges

Fudges that fudge only particular implementations/VMs are OK to go into the release, however
fudges for features that no implementation has implemented successfully must be removed.

### Promotion

It's not a bad idea to whet users' appetite and get word of mouth going about upcoming release.
File an Issue in [our Marketing repo](https://github.com/perl6/marketing) to get some teaser
materials made for new features in upcoming language release.
