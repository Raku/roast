use v6;
unit class MultiVer;
use Test::Util;

class Foo:ver<0.0.2> { }

has $.prefix;
has @.distributions;
has $.standalone;
has $.standalone-script;
has $.inst-dir;
has $.inst-repo;
has $.use-lib;

submethod TWEAK {
    $!prefix //= make-temp-dir;
}

method mksubdir(IO:D() $path) {
    my $fullpath = $path.is-relative ?? $!prefix.add($path) !! $path;
    return $fullpath if $fullpath.e;
    my @path = $*SPEC.splitdir: $fullpath.resolve.relative($!prefix).IO;
    my $subdir = $!prefix;
    for @path -> $dir {
        die "Can only create dirs under \$.prefix, but '" ~ $path ~ "' is outside of it" if $dir eq '..';
        $subdir .= add($dir);
        next if $subdir.e;
        $subdir.mkdir;
    }
    $subdir
}

method rmsubdir(IO:D() $entry) {
    return unless $entry.e;
    if $entry.d {
        for $entry.dir -> $subentry {
            next if $subentry.basename eq '..' | '.';
            if $subentry.d {
                self.rmsubdir($subentry);
            }
            else {
                $subentry.unlink;
            }
        }
        $entry.rmdir;
    }
    else {
        $entry.unink;
    }
}

method make-dist(Str:D :$dist = 'MVDist', :%fields, Bool :$standalone, Bool :$include = True) {
    my %dist-fields =
        api => "0.0.1",
        ver => "0.0.1",
        auth => 'test:raku',
        description => 'Test distribution',
        |%fields;

    my $dest-dir = $.prefix.add($dist ~ "-" ~ %dist-fields<ver>).IO;

    # Remove the previous installation to guarantee no garbage is left behind.
    self.rmsubdir($dest-dir);

    for $?DISTRIBUTION.meta<resources>.grep({ .starts-with($dist ~ '/') && .ends-with('.in') }) -> IO() $tmpl {
        my $dest-path = $dest-dir.add($*SPEC.catdir($*SPEC.splitdir($tmpl.dirname)[1..*]));
        my $dest-file = self.mksubdir($dest-path).add($tmpl.basename.IO.extension(""));
        my $content = %?RESOURCES{$tmpl}.slurp;
        # Expand template's '#field#'
        $content ~~ s:g/ '#' $<field>=[\w+?] '#' /{ %dist-fields{~$<field>} // '' }/;
        $dest-file.spurt: $content;
    }
    my $distribution = CompUnit::Repository::Distribution.new(Distribution::Path.new($dest-dir));
    if $standalone {
        $!standalone = $distribution;
        $!standalone-script = $dest-dir.add("bin/test-code.raku");
    }
    else {
        if $include {
            @!distributions.push: $distribution;
            $!use-lib = Nil;
        }
    }
    $distribution
}

method install-dist(Str:D :$dist = 'MVDist', :%fields) {
    unless $!inst-dir {
        $!inst-dir = self.mksubdir("install");
        $!inst-repo = CompUnit::Repository::Installation.new(prefix => $!inst-dir);
        $!use-lib = Nil;
    }

    my $distribution = self.make-dist(:$dist, :%fields, :!include);

    $!inst-repo.install($distribution, :force);
    $distribution
}

method use-libs {
    return $_ with $!use-lib;
    my @incs = @!distributions.map({ "use lib q<{.prefix}>;" });
    @incs.push: "use lib q<inst#$_>;" with $!inst-dir;
    $!use-lib = @incs.pick(*).join("\n")
}

method preserve-repo(&code) {
    my $repo := $*REPO;
    LEAVE PROCESS::<$REPO> := $repo;
    &code();
}

method run(Str:D() $script, :@compiler-args) {
    run $*EXECUTABLE.absolute, |@compiler-args, $script, :in, :out, :err
}

method run-standalone(Str:D $code is copy, :@compiler-args, Bool :$use-lib) {
    fail "Standalone dist is not installed yet" unless $!standalone;
    if $use-lib {
        $code = self.use-libs ~ "\n#line 1 test-code.raku\n" ~ $code;
    }
    $!standalone-script.spurt: $code;
    my $p = self.run: $!standalone-script, :compiler-args[
        |@compiler-args,
        '-I' ~ $!standalone.prefix
    ];
}

method run-installed(Str:D $script-name, :@compiler-args) {
    fail "No distribution installed yet" unless $!inst-dir;
    my $raku-lib := %*ENV<RAKULIB> // Nil;
    LEAVE if $raku-lib === Nil {
            %*ENV<RAKULIB>:delete;
        }
        else {
            %*ENV<RAKULIB> := $raku-lib;
        };
    %*ENV<RAKULIB> = 'inst#' ~ $!inst-dir;
    self.run: $!inst-dir.add('bin/' ~ $script-name), :@compiler-args;
}

method distribution { $?DISTRIBUTION }