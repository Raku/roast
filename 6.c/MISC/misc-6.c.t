use v6.c;
use Test;
use lib $*PROGRAM.parent(3).add: 'packages/Test-Helpers';
use Test::Util;

plan 1;

group-of 2 => '$*ARGFILES is set to $*IN inside sub MAIN' => {
    my @args = <THE FILES CONTENT>.map: {make-temp-file :$^content}

    is_run ｢
        use v6.c;
        sub MAIN(*@args) {
            .say for lines;
        }
    ｣,
    "blah\nbleh\nbloh", :@args, {
        :err(''), :0status, :out("THE\nFILES\nCONTENT\n"),
    }, 'inside MAIN in 6.c language (with @*ARGS content)';

    is_run ｢
        use v6.c;
        sub MAIN(*@args) {
            .say for lines;
        }
    ｣,
    "blah\nbleh\nbloh", {
        :err(''), :0status, :out("blah\nbleh\nbloh\n"),
    }, 'inside MAIN in 6.c language (without @*ARGS content)';
}

# vim: expandtab shiftwidth=4
