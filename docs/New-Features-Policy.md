
# Policy For Implementation of New Features

## STATUS: WORKING DRAFT

This policy is currently undergoing a trial of its suitability. Any problems identified
during the trial period [should be reported](https://github.com/perl6/roast/issues/new).

## PURPOSE

The main purpose of this policy is to maintain Raku 6 a language that is:

1. Consistent
2. Provides only widely-desired features in-core

It accomplishes this goal by reducing the frequency of or eliminating entirely detrimental
scenarios that have been observed in the past and are detailed in `APPENDIX A: THE WRONG WAY`.

At the same time, this policy must be kept in balance with the amount of new feature proposals
we receive. If too few users are willing to follow the policy with new feature proposals,
the language might be missing out on highly-sought-after features.

## FEATURE IMPACT SCORE

```
#
#
#
# Editor's comments: it should be fairly easy to make a small tool that calculates impact score
#                    so we can drop this whole section out of the document because it's overly
#                    complex and isn't strictly required
#
#                    Note: the actual score values will see a lot of tweaking as we start using this policy
#
```

A new value type accepted by a parameter of a routine has smaller impact than a new class with
a dozen methods added to the language. For that reason, different requirements exist for features,
depending on the impact score calculated as described below. The calculated score is just a rough
guideline and doesn't have to be exact. You may choose to follow more policy steps than those
required by the impact score.

**NOTE:** following all of the required policy steps does NOT guarantee your addition's inclusion.
Considering filing an Issue with the rough idea of your feature first, to get community feedback,
before committing considerable amounts of time to your addition.

* The feature conflicts with earlier language versions and must be added to the next language version: 100000pt
* The addition contains a new class (available to users WITHOUT having to load some module): 1000pt.
* The addition contains a new method (even if it's inside the new class being added): 100pt.
    * Add another 50pt if the class is `Cool` (THE `Cool`, not a subclass)
    * Add another 100pt if the class is `Any` (THE `Any`, not a subclass). This likely affects all `List` methods, due to
      everything-is-a-1-item-list semantics.
    * Add another 1000pt if the class is `Mu` (THE `Mu`, not a subclass)
* The addition contains a new argument (even if it's taken by the new method): 10pt.
* The addition involves a new candidate to handle a new type of values for the argument (even if it's a new method that handles a single value type in a single argument). Extra candidates added for performances reasons do not count: 5pt.
* The addition involves widening accepted range of arguments (e.g. a parameter that took only `Int`s is being changed to take all `Numeric`s): 1pt.
    * Add another 10pt if the change is to accept all `Any` types
    * add another 50pt if the change is to accept all `Mu` types

The reason methods/attributes/values get counted even for newly-minted classes/methods/attributes
is because they still add to the language learning curve/maintenance burden.

Add up all the points. If you got:

* 100000pt or more, you must go through all the steps of the policy
* 1000pt or more, you can omit XXXXXXXXXXXXXX steps
* 100pt or more, you can omit XXXXXXXXXXXXXX steps
* 10pt or more, you can omit XXXXXXXXXXXXXX steps
* Fewer than 10pt, you can omit XXXXXXXXXXXXXX steps

### Example 1:

I want to add `class Widgets` that implements 12 methods. 5 of the methods don't take any args,
5 take one arg with `Int` as the type, 1 takes three args each, all type-constrainted to `Int`,
and one takes three args each, with all-`Str` and all-`Int` candidates.

```perl6
  class Widgets { # 1000pt
      method one {…} # 100pt
      method two {…} # 100pt
      method three {…} # 100pt
      method four {…} # 100pt
      method five {…} # 100pt
      method six(Int) {…} # 100pt + 10pt + 5pt
      method seven(Int) {…} # 100pt + 10pt + 5pt
      method eight(Int) {…} # 100pt + 10pt + 5pt
      method nine(Int) {…} # 100pt + 10pt + 5pt
      method ten(Int) {…} # 100pt + 10pt + 5pt
      multi method eleven(Int, Int, Int) {…} # 100pt + 30pt + 5pt
      multi method eleven(int, int, int) {…} # performance-enhancing candidate doesn't count
      multi method twelve(Int, Int, Int) {…} # 100pt + 30pt + 5pt
      multi method twelve(Str, Str, Str) {…} #              + 5pt # extra candidate only
  }
```

The score would be:

* 1000pt for new class
* 12x 100pt for 12 new methods
* (5 + 2*3)x 10pt for 11 new arguments
* 5pt for extra candidate (for the `twelve` method)

That's 2315 points in total and I must complete XXXXXXXXX steps of the policy for this feature.

## POLICY STEPS

These are the steps that must be undertaken for a new feature to make it into the language.
Depending on the feature's impact score (see above), some of these may be omited.

### 1) USER DOCUMENTATION

The feature must have written down documentation. You can choose to prepare it as a PR in
[`perl6/doc` repo](https://github.com/perl6/doc/pulls), but be sure to start the title of the PR
with `*DO NOT MERGE*`, to prevent accidental merges of documentation before the feature is accepted.

* If the impact score of the addition is below 100pt, a [new Issue in `perl6/doc` repo](https://github.com/perl6/doc/issues) requesting documentation of the feature to be written
can be filed in lue of actual documentation written.

### 2) FEATURE TESTS

This step applies only if you're NOT submitting SPECIFICATION TESTS (see below). Feature tests
is a basic set of tests that essentially proves that your code does what it claims it's going to do.
It doesn't have to be extensive.

**IMPORTANT:** if you're submitting your feature tests as a PR in
[`perl6/roast` repo](https://github.com/perl6/roast/pulls), be sure they go into some file
(you can create a new one) inside `FEATURE-TESTS/` directory, to avoid mixing them with fuller spec
tests. This will allow other volunteers to see that more tests need to be written for a feature.

### 3) SPECIFICATION TESTS

A set of tests that specify the behaviour of the feature. They should cover all of the promised
behaviours of the feature, including all of the value types accepted by the parameters. Include
tests covering failure conditions and edge cases, if any exist.

You can choose to prepare the tests as a PR in
[`perl6/roast` repo](https://github.com/perl6/roast/pulls). The PR's title must start with `*DO NOT
MERGE*`, to prevent accidental merges of the tests before the feature is accepted.

* If the impact score of the addition is below 500pt, you can submit FEATURE TESTS only (a smaller,
basic set of tests) as well as [new Issue in `perl6/roast` repo](https://github.com/perl6/roast/issues) requesting specification tests to be written for
the feature, if it's accepted.

### 4) TRIAL IMPLEMENTATION IN THE ECOSYSTEM

A good way to convince the community your addition deserves a place in core is to have a well-used
implementation available in [the ecosystem](https://modules.perl6.org). Keep in mind a viable
solution doesn't have to involve adding your feature to core. You can also suggest the inclusion
of your module in compiler distributions, such as Rakudo Star.

This policy step requires an ecosystem module offering the feature to be available to the public
for at least 3 months. While there's yet no good way to gauge "public interest" in the module,
going through this step avoids Features on a Whim as well as shows the commitment by the feature's
author for the feature to be accepted. Other modules using your module as well as sizable list
of filed and resolved Issues are good indicators of a much-needed feature.

If you're struggling for a name for your module, **or if your module requires unsupported features
such as Slangs or NQP** consider using an arbitrary name in `CoreLab::` namespace.

* If the impact score of the addition is lower than 100pt, you may omit this step.
* If the impact score of the addition is between 100pt ..^ 120pt, this step is optional, unless at
least two core developers request this step to be performed.
* If the impact score of the addition is between 120pt ..^ 300pt, this step is optional, unless at
least one core developer request this step to be performed.

#### Notes on Feasibility

The requirement of unsupported features for the trial implementation, such as the use of NQP, is *not*
a reason why a the implementation should not be created. If such features are required, the module's
documentation should be clear that it's an experiment for core inclusion and the easiest way to
make that fact clear is to place the module into `CoreLab::` namespace.

However, there will be cases where a separate implementation is not feasible or even possible. In
such cases, the feature can be placed into core, but it must require the use of `experimental` pragma
to be enabled by the user. The experimental status must last for at least 3 months.

For a major version language release, features that have been experimental for 3 months must be
either: (a) accepted and their experimental status removed; (b) rejected and the feature removed
entirely; (c) sufficiently modified to warrant a new experimental period; (d) kept as is, but
a detailed explanation must be written explaining why the experiment must go on unchanged. The goal
here is to avoid having experimental features being too "stable" (e.g. a few users use it and then
leave their modules to rot, in several years a bunch of others rely on those modules, and now you
have a ton of software relying on an exprimental feature). Provision (d) allows for extended experiments
for cases where lack of volunteers' time prevents sufficient evaluation or modification of the feature.

### 5) REVIEW BY CORE DEVELOPERS

A "core developer" is a person who has a commit bit to a largely-compliant, "usable" implementation
of the Raku 6 language that's in active development. If impact score requires more than one
reviewer, the reviewers must be core developers from different implementations (where possible; the
goal here is to ensure all implementations are reasonably satisfied with the feature being available
in the language, and to avoid too many features becoming "implementation dependent).

The language pumpkin (currently `jnthn++`) and BDFL (Larry Wall) have veto rights over all
feature additions. If you are a core developer yourself, you cannot function as your own reviewer.
Due to veto powers, the pumpkin and BDFL are not subject to this rule.

* If the impact score of the addition is 100pt or lower, you may omit this step, providing you
notify other core devs of the addition in a reasonable manner, such as opening and immediately
closing (to generate a notification) a GitHub Issue stating you implemented a new feature.
* If the impact score of the addition is between 100pt ^..^ 130pt, at least one core developer
  must review the feature
* If the impact score of the addition is between 130pt ^..^ 500pt, at least two core developers
  must review the feature
* If the impact score of the addition is 500pt or above, at least three core developers
    must review the feature

## APPENDIX A: THE WRONG WAY

This appendix describes hypothetical and real-world scenarios that are detrimental for the language:

### Features on a Whim

*Dev1 is writing a program and thinks a routine they wrote is very useful and should be in core.
They make a PR for its inclusion. Dev2 sees the PR, thinks the feature is awesome and merges it.
They high-five each other and go about their business.*

#### Problems

1. **No docs were created:** most users aren't aware this feature exists. Some who spot it in
  compiler's source code or in code of Dev1/Dev2 start using it and even showcase it in
  presentations about the language.
2. **No tests:** the feature has many bugs, but without tests, they remain undetected
3. **No spec:** the feature is not part of the language, but those who use it don't realize that.

Fast-forward 10 months into the future. Dev3 notices the routine and realizes it's very similar to
an already-existing routine that does the same thing that Dev1 and Dev2 forgot about. Dev3 tries to
remove the feature, but several users pop up saying they've been using the feature and removal
breaks their code. Dev3 then tries to write the spec for the feature, but notices the interface
is inconsistent with the rest of the language and can't be fixed because of the way the routine
has been in use.

The language now has a il-designed, nearly-useless routine in it. The language has a wart in
consistency. Users have more to learn.

*More people should review a feature before it's added. The feature must come with docs and tests,
writing which often exposes many problems with design.*

### Featuritis

*Dev1 comes up with a useful routine to include in core. The routine can take `:$argument1` with
a Callable to affect its behaviour. Dev2 sees the PR and says they also want to affect another
aspect of the behaviour, so another argument is added to the routine. Dev1 then says it's probably
useful to combine those effects, and they introduce another argument to control that. Dev2 thinks
the options are awesome and merges the PR. Dev1 writes a mile of docs and spectests. They high-five
each other and go about their business.*

#### Problems

1. The feature does not rely on **actual user demand** and instead implements a multitude of
  options to control for all possible behaviours the devs could think of.

Fast-forward 10 months into the future. User1 tries to use `:$argument1` with another, related
routine and finds out it doesn't take it. Dev3 goes to add it for consistency and notices the
other two arguments taken by the first routine are missing as well, so they get added too.
Moreover, Dev3 notices 10 other related routines none of which takes these arguments and adds them
there too.

The language now has a proliferation of nearly-useless arguments on a dozen routines. Users
have to read a lot more documentation to learn the language. Maintainers waste their time
on maintaining these extra arguments. The compiler is slower due to extra conditionals required
to check those arguments.

*Features should be first trialed as ecosystem modules to gauge user interest and to painlessly
eliminate any potential design problems. The would-be-nice-to-have features should not be
implemented right away. Instead, the routine should be designed in such a way that if any of
those features become highly-desired in the future, it would be easy to add them.*

### Tradition as Excuse

*Dev1 wants to add a new syntax for an already-existing feature. Dev2 protests. Dev1
says TIMTOWTDI! Dev2 merges the PR. They high-five each other and go about their business.*

#### Problems

1. The addition was not based on any **concrete real demand**, but rather vague statements subject
  to varying interpretations.

Fast-forward 10 months into the future. User1 reports a problem with their code. Dev3 goes to
fix it but notices syntaxes for two different features are now ambiguous in certain places. Dev3
has no choice but to document it as a Trap. User1…User9999999 keep repeating the mistake and get
told to read the Traps document.

The language now has an inconsistency and surprising behaviour. Users have to learn more syntax
variations as well as learn about the problematic case.

*Vague acronyms and tradition should not be used as a primary drive for feature addition. A
proliferation of variations in one place is not a reason to offer the same variety elsewhere.
Reducing that variation in the first place might be a more desirable goal.*
