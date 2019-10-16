# WORKING DRAFT: Language Release Guide

Many of the tasks in this document are concurrent. Please read through the entire document.

## Known Implementations of the Language

As release involves communications with authors of various implementations of the language,
please list the main repository for those in this section:

* Rakudo https://github.com/rakudo/rakudo

## Terminology

The following terms are used in this document and in other related papers:

- _language revision_ or _revision_

  A set of specifications defining a Raku language variant. Revisions are represented by symbolic names consisting of
  a single letter of Latin alphabet.

  _Note_ in this document we use `<rev>` to represent a generic revision letter.

- _language version_ or _version_

  Version is a string which represents full revision identification at implementation level. It consist of `6.` prefix
  followed by revision letter. For example, `6.e`. In the language code and sometimes at other locations the version
  string might be prefixed with `v` to be unambiguously identified: `v6.e`

- _review_

   The process of preparing a new language release.

- `PREVIEW`

   A modifier to mark language revision which is currently is in _review_ status: `e.PREVIEW`, `6.e.PREVIEW`,
   `v6.e.PREVIEW`.

## Release Status

_This section contains excerpts from [this discussion](https://github.com/perl6/problem-solving/issues/31)._

Language release process is based on the fact that changes are only allowed to a revision in _review_ status. Once a
revision is released it becomes _immutable_. From this moment on the only changes allowed are fixes. From the point of
view of a versioning system like git would look like the following diagram:

```
             6.<rev> tag
              V
---[master]---O-----------------> master now defines 6.<next-rev>.PREVIEW
               \
                +---[6.<rev>-errata]
```

## Preparation

Release preparation should commence well in advance of planned release date, as there's often a large amount of work to
perform.

### Communication Channels

All communications about language development and release process must be done via
[the problem solving repo](https://github.com/perl6/problem-solving). Prior to release, ensure
all the planned TODO items and Issues in that repository have been addressed.

_Note:_ 6.d release was using [Prep Repo](https://github.com/perl6/6.d-prep) to manage related
information. It may still have useful bits worth considering.

### Spec Review

All new commits in the spec repo since last release of the spec need to be reviewed to ensure
they spec desired behaviour for the language. The [`tools/spec-review.p6'](tools/spec-review.p6)
can be useful during this process, to open up batches of commits in your browser:

    tools/spec-review.p6 --start=6.c --n=50 --skip-batches=0 --browser=google-chrome

The commits that aren't part of any release version of the spec can be removed or modified, but
please coordinate with implementation authors, to avoid surprise breakage of code that uses these
experimental behaviours.

During review, if you file any Issues regarding something that needs to be discussed/decided on before release, be sure
to tag it with `6.<rev> review` tag (`6.e review`, for example), so that we know what still needs to be done before the
release.

### TODO Issues

Ensure all open `6.<rev> review`-tagged Issues in the roast repo have been taken care of before release.
Check with implementations authors for `6.<rev> review`-tagged issues in their repositories as well.
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

### VERSION File

Be sure to update the spec version in the [`VERSION` file](https://github.com/perl6/roast/blob/master/VERSION).

### Fudges

Fudges that fudge only particular implementations/VMs are OK to go into the release, however
fudges for features that no implementation has implemented successfully must be removed.

### Promotion

It's not a bad idea to whet users' appetite and get word of mouth going about upcoming release.
File an Issue in [our Marketing repo](https://github.com/perl6/marketing) to get some teaser
materials made for new features in upcoming language release.

### Information

Ensure all documentation that goes out to users is checked for "TODO" notes
that may be included on it.

Users need to be given a useful upgrade guide: what to do to their code to
ensure it works on new language version. Often, only a small part of the
new language version is placed behind a version pragma, with the rest of the
changes being simply clarifications to the past spec. The upgrade guide should
focus on the version-pragma-protected changes.

## Release Steps

Those steps are to be done when a new language revision is stabilized and time comes for a release:

1. Edit `VERSION` file and remove `.PREVIEW` modifier: `6.<rev>.PREVIEW` -> `6.<rev>`
1. Finalize revision announce in `docs/announce/6.<rev>.md`
1. Make sure no `use v6.<rev>.PREVIEW;` pragma has been left behind in a test file.

   Most of the time all is needed is removal of `.PREVIEW` modifier from the version string. Be careful as to make sure
   the pragma is not an essential part of the test.

1. Place version tag on the tip of `master` branch.

   ```
   $ git tag 6.<rev>
   ```
1. Create revision `-errata` branch.

   ```
   $ git branch 6.<rev>-errata
   ```

1. Commit changes

### Starting A New Release.

1. Edit `VERSION` file and change the version to `6.<rev>.PREVIEW`
1. Create revision announce in `docs/announce/6.<rev>.md`
1. Commit changes
