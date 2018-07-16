# Perl 6 Specification Appendices

The `APPENDICES` directory of the Perl 6 specification contains *advisory*
specifications. These tests describe behaviour some implementations chose
to follow and other implementations may follow the same behaviour, to offer
similar execution results from the same Perl 6 programs.

However, it's possible some implementations or some environments may not
be able to adhere to these specifications. For example, an implementation
that can compute `2**-10000000000` sufficiently fast may choose to use
higher limits for powers before throwing overflow exceptions.

In summation, the APPENDICES contain tests that fall somewhere between
implementation-specific tests residing in test suites of particular
implementations and regular specification tests that all implementations
must adhere to.

An implementation may fail all of the tests in APPENDICES, yet still claim
the status of being a fully-compliant Perl 6 implementation.

## Available Appendices

### [`A01-limits`](A01-limits)

Contains tests of potentially-desirable behaviour that's dependent on the
limitations of typical environments. For example, raising a number to a
huge power effectively "hangs" the program, so the tests check such cases
throw an overflow error instead.

### [`A02-some-day-maybe`](A02-some-day-maybe)

This appendix contains things that may one day provide useful behaviours, but
at the moment they don't, yet they have to exist in implementations for one
reason or another (throwing an `X::NYI` exception). For example, one day
we might come up with a very useful usecase for write methods of an
`IO::CatHandle`, but until that day, these methods must throw an `X::NYI`,
because otherwise the versions of the parent's (`IO::Handle`) would be used
instead, providing confusing behaviour.
