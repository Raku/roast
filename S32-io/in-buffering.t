use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 3;

sub fh-with (
    $data where Str:D|Blob:D, &test,
    :$buffer, Capture :$open-args = \()
) {
    state $path = make-temp-file;
    $path.spurt: $data;
    my $fh := $path.open: :in-buffer($buffer), |$open-args;
    test $fh;
}

for \(), \(:r), \(:rw) -> $open-args is raw {
    subtest ".open with $open-args.perl()" => {
        plan 10;

        fh-with "\0" x 100, :1buffer, {
            my $data = .getc;
            .path.spurt: "\x[1]" x 100;
            is-deeply ($data ~= .getc), "\0\x[1]", '.getc with 1-buffer';
        }

        fh-with "\0" x 100, :1000buffer, {
            my $data = .getc;
            .path.spurt: "\x[1]" x 100; # we already have next char in buffer
            is-deeply ($data ~= .getc), "\0\0", '.getc with 1000-buffer';
        }

        fh-with ("abcdefghi\n" x 100).encode, :10buffer, {
            my $data = .get;
            .path.spurt: ("123456789\n" x 100).encode;
            is-deeply ($data ~= .get), 'abcdefghi123456789', '.gets with 10-buffer';
        }

        fh-with ("abcdefghi\n" x 100).encode, :100buffer, {
            my $data = .get;
            # we already have next line in buffer
            .path.spurt: ("123456789\n" x 100).encode;
            is-deeply ($data ~= .get), 'abcdefghiabcdefghi', '.gets with 100-buffer';
        }

        fh-with ("abcdefghi\n" x 100).encode, :10buffer, {
            (my $lines := .lines)[0];
            .path.spurt: ("123456789\n" x 100).encode;
            is-deeply ([~] $lines[0,1]), 'abcdefghi123456789', '.lines with 10-buffer';
        }

        fh-with ("abcdefghi\n" x 100).encode, :100buffer, {
            (my $lines := .lines)[0];
            # we already have next line in buffer
            .path.spurt: ("123456789\n" x 100).encode;
            is-deeply ([~] $lines[0,1]), 'abcdefghiabcdefghi', '.lines with 100-buffer';
        }

        fh-with "abcdefghi\0" x 100, :10buffer, {
            my $data = .readchars: 10;
            .path.spurt: "123456789\0" x 100;
            is-deeply ($data ~= .readchars: 10),
                "abcdefghi\0123456789\0", '.readchars with 10-buffer';
        }

        fh-with "abcdefghi\0" x 100, :100buffer, {
            my $data = .readchars: 10;
            # we already have next line in buffer
            .path.spurt: "123456789\0" x 100;
            is-deeply ($data ~= .readchars: 10),
                "abcdefghi\0abcdefghi\0", '.readchars with 100-buffer';
        }

        fh-with "abcdefghi\0" x 100, :10buffer, {
            is-deeply .slurp, "abcdefghi\0" x 100, '.slurp with small buffer';
        }

        fh-with "abcdefghi\0" x 100, :10000buffer, {
            is-deeply .slurp, "abcdefghi\0" x 100, '.slurp with large buffer';
        }
    }
}
