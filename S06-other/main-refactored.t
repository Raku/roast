use v6.c;

use Test;

# These MAIN tests use the new interface that became available for the 2018.10
# release, specifically whether MAIN / ARGS-TO-CAPTURE / GENERATE-USAGE and
# old MAIN_HELPER and USAGE are being called at the right time.

my @basic-ok =
# @*ARGS --------------- @_ -------------------- %_ ----------------------------
  (),                    [],                     { },
  <foo>,                 [<foo>],                { },
  <foo bar>,             [<foo bar>],            { },
  <--bar foo>,           [<foo>],                { bar => True },
  <--bar=42 foo>,        [<foo>],                { bar => <42> },
  <--b=42 -b=666 foo>,   [<foo>],                { b => [<42 666>] },
  <bar foo>,             [<bar foo>],            { },
  <--help bar foo>,      [<bar foo>],            { help => True },
;

my @named-anywhere-ok = |@basic-ok,
# @*ARGS --------------- @_ -------------------- %_ ----------------------------
  <foo --bar>,           [<foo>],                { bar => True },
  <foo --bar=42>,        [<foo>],                { bar => <42> },
  <foo --b=42 -b=666>,   [<foo>],                { b => [<42 666>] },
  <bar foo --help>,      [<bar foo>],            { help => True },
;

plan 1
  + ((2 + 5 + 6 + 6 + 2 + 2 + 2) * @basic-ok / 3)
  + ((2 + 5 + 6 + 6 + 2 + 2 + 2) * @named-anywhere-ok / 3 )
;

# Need to run these tests outside of the main line, because otherwise normal
# MAIN processing would do other things that we don't want.

# --- Checking correct parsing and dispatch ------------------------------------
for @basic-ok -> \args, @expected, %expected {

    sub MAIN(*@_, *%_) {   # called by RUN-MAIN
        is-deeply @_, @expected, "right positionals for basic '@*ARGS[]'";
        is-deeply %_, %expected, "right named for basic '@*ARGS[]'";
    }

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script
}

for @named-anywhere-ok -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    sub MAIN(*@_, *%_) {   # called by RUN-MAIN
        is-deeply @_, @expected, "right positionals for anywhere '@*ARGS[]'";
        is-deeply %_, %expected, "right named for anywhere '@*ARGS[]'";
    }

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script
}

# --- Checking custom parsing and dispatch -------------------------------------
for @basic-ok -> \args, @expected, %expected {

    sub MAIN(*@_, *%_) {   # called by RUN-MAIN
        is-deeply @_, @expected, "right positionals for basic '@*ARGS[]'";
        is-deeply %_, %expected, "right named for basic '@*ARGS[]'";
    }
    sub ARGS-TO-CAPTURE(&main, @args) {   # called by RUN-MAIN
        ok &main =:= &MAIN, "right main for '@*ARGS[]'";
        is-deeply @args, args.Array, "right args for basic '@*ARGS[]'";
        ok &*ARGS-TO-CAPTURE ~~ Sub, 'is &*ARGS-TO-CAPTURE a Sub';
        Capture.new( list => @expected, hash => %expected )
    }

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script
}

for @named-anywhere-ok -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    sub MAIN(*@_, *%_) {   # called by RUN-MAIN
        is-deeply @_, @expected, "right positionals for anywhere '@*ARGS[]'";
        is-deeply %_, %expected, "right named for anywhere '@*ARGS[]'";
    }
    sub ARGS-TO-CAPTURE(&main, @args) {   # called by RUN-MAIN
        ok &main =:= &MAIN, "right main for '@*ARGS[]'";
        is-deeply @args, args.Array, "right args for anywhere '@*ARGS[]'";
        ok &*ARGS-TO-CAPTURE ~~ Sub, 'is &*ARGS-TO-CAPTURE a Sub';
        Capture.new( list => @expected, hash => %expected )
    }

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script
}

# --- Checking custom parsing, dispatch with MAIN_HELPER still there -----------
for @basic-ok -> \args, @expected, %expected {

    sub MAIN(*@_, *%_) {   # called by RUN-MAIN
        is-deeply @_, @expected, "right positionals for basic '@*ARGS[]'";
        is-deeply %_, %expected, "right named for basic '@*ARGS[]'";
    }
    sub ARGS-TO-CAPTURE(&main, @args) {   # called by RUN-MAIN
        ok &main =:= &MAIN, "right main for '@*ARGS[]'";
        is-deeply @args, args.Array, "right args for basic '@*ARGS[]'";
        ok &*ARGS-TO-CAPTURE ~~ Sub, 'is &*ARGS-TO-CAPTURE a Sub';
        Capture.new( list => @expected, hash => %expected )
    }
    my $main-helper-called;
    sub MAIN_HELPER() { $main-helper-called = True } # NOT called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script
    nok $main-helper-called, "MAIN_HELPER NOT called for '@*ARGS[]'";
}

for @named-anywhere-ok -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    sub MAIN(*@_, *%_) {   # called by RUN-MAIN
        is-deeply @_, @expected, "right positionals for anywhere '@*ARGS[]'";
        is-deeply %_, %expected, "right named for anywhere '@*ARGS[]'";
    }
    sub ARGS-TO-CAPTURE(&main, @args) {   # called by RUN-MAIN
        ok &main =:= &MAIN, "right main for '@*ARGS[]'";
        is-deeply @args, args.Array, "right args for anywhere '@*ARGS[]'";
        ok &*ARGS-TO-CAPTURE ~~ Sub, 'is &*ARGS-TO-CAPTURE a Sub';
        Capture.new( list => @expected, hash => %expected )
    }
    my $main-helper-called;
    sub MAIN_HELPER() { $main-helper-called = True } # NOT called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script
    nok $main-helper-called, "MAIN_HELPER NOT called for '@*ARGS[]'";
}

# --- Checking correct parsing, failed dispatch and GENERATE-USAGE -------------
for @basic-ok -> \args, @expected, %expected {

    # Catch any exits
    my $exit = "not called";
    my &*EXIT = { $exit = $_ };

    my $called;
    sub MAIN("NEVER MATCHES") { $called = True } # NOT called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script

    nok $called, "NOT called for '@*ARGS[]'";
    sub GENERATE-USAGE(&main, *@_, *%_) {   # called by RUN-MAIN
        ok &main =:= &MAIN, "right main for '@*ARGS[]'";
        is-deeply @_, @expected, "right positionals for basic '@*ARGS[]'";
        is-deeply %_, %expected, "right named for basic '@*ARGS[]'";
        ok &*GENERATE-USAGE ~~ Sub, 'is &*GENERATE-USAGE a Sub';
        "# generated usage for '@*ARGS[]'"
    }
    my $expected-exit = %expected<help> ?? 0 !! 2;
    is $exit, $expected-exit, "did we exit with $expected-exit";
}

for @named-anywhere-ok -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    # Catch any exits
    my $exit = "not called";
    my &*EXIT = { $exit = $_ };

    my $called;
    sub MAIN("NEVER MATCHES") { $called = True } # NOT called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script

    nok $called, "NOT called for '@*ARGS[]'";
    sub GENERATE-USAGE(&main, *@_, *%_) {   # called by RUN-MAIN
        ok &main =:= &MAIN, "right main for '@*ARGS[]'";
        is-deeply @_, @expected, "right positionals for anywhere '@*ARGS[]'";
        is-deeply %_, %expected, "right named for anywhere '@*ARGS[]'";
        ok &*GENERATE-USAGE ~~ Sub, 'is &*GENERATE-USAGE a Sub';
        "# generated usage for '@*ARGS[]'"
    }
    my $expected-exit = %expected<help> ?? 0 !! 2;
    is $exit, $expected-exit, "did we exit with $expected-exit";
}

# --- Checking correct parsing, failed dispatch and old USAGE ------------------
for @basic-ok -> \args, @expected, %expected {

    my $main-called;
    sub MAIN("NEVER MATCHES") { $main-called = True } # NOT called by RUN-MAIN
    my $usage-called;
    sub USAGE() { $usage-called = True }   # called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script

    nok $main-called, "MAIN NOT called for '@*ARGS[]'";
    ok $usage-called, "USAGE called for '@*ARGS[]'";
}

for @named-anywhere-ok -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    my $main-called;
    sub MAIN("NEVER MATCHES") { $main-called = True } # NOT called by RUN-MAIN
    my $usage-called;
    sub USAGE() { $usage-called = True }   # called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script

    nok $main-called, "MAIN NOT called for '@*ARGS[]'";
    ok $usage-called, "USAGE called for '@*ARGS[]'";
}

# --- Checking OLD MAIN_HELPER pre-2018.06 -------------------------------------
for @basic-ok -> \args, @expected, %expected {

    my $main-called;
    sub MAIN() { $main-called = True } # NOT called by RUN-MAIN
    my $helper-called;
    sub MAIN_HELPER($a = 0) { $helper-called = True } # called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script

    nok $main-called, "MAIN NOT called for '@*ARGS[]'";
    ok $helper-called, "MAIN_HELPER called for '@*ARGS[]'";
}

for @named-anywhere-ok -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    my $main-called;
    sub MAIN() { $main-called = True } # NOT called by RUN-MAIN
    my $helper-called;
    sub MAIN_HELPER($a = 0) { $helper-called = True } # called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script

    nok $main-called, "MAIN NOT called for '@*ARGS[]'";
    ok $helper-called, "MAIN_HELPER called for '@*ARGS[]'";
}

# --- Checking OLD MAIN_HELPER post-2018.06 ------------------------------------
for @basic-ok -> \args, @expected, %expected {

    my $main-called;
    sub MAIN() { $main-called = True } # NOT called by RUN-MAIN
    my $helper-called;
    sub MAIN_HELPER($, $a = 0) { $helper-called = True } # called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script

    nok $main-called, "MAIN NOT called for '@*ARGS[]'";
    ok $helper-called, "MAIN_HELPER called for '@*ARGS[]'";
}

for @named-anywhere-ok -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    my $main-called;
    sub MAIN() { $main-called = True } # NOT called by RUN-MAIN
    my $helper-called;
    sub MAIN_HELPER($, $a = 0) { $helper-called = True } # called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&MAIN,Nil);  # run the MAIN unit as if it is a script

    nok $main-called, "MAIN NOT called for '@*ARGS[]'";
    ok $helper-called, "MAIN_HELPER called for '@*ARGS[]'";
}

# --- Other tests---------------------------------------------------------------
{
    multi MAIN("NEVER MATCHES") { }
    multi MAIN("THE-HIDDEN-MULTI") is hidden-from-USAGE { }
    @*ARGS = ();
    RUN-MAIN(&MAIN,Nil);

    sub USAGE() {
        unlike $*USAGE, /'THE-HIDDEN-MULTI'/,
            'was the second MAIN skipped in USAGE';
    }
}

# vim: expandtab shiftwidth=4
