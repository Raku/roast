use v6;

use Test;

=begin pod

=head1 DESCRIPTION

This test tests various file stat methods.

=end pod

plan 13;

# time stat tests (modify/change/access)
{
    my $before_creation = time - 1;

    my $tmpfile1 = create_temporary_file(1);
    my $original1_modified = $tmpfile1.IO.modified;
    my $original1_changed = $tmpfile1.IO.changed;
    my $original1_accessed = $tmpfile1.IO.accessed;

    my $tmpfile2 = create_temporary_file(2);
    my $original2_modified = $tmpfile2.IO.modified;
    my $original2_changed = $tmpfile2.IO.changed;
    my $original2_accessed = $tmpfile2.IO.accessed;

    ok ($before_creation < $original1_modified), 'IO.modified should be greater than pre-creation timestamp';
    ok ($before_creation < $original1_changed),  'IO.changed should be greater than pre-creation timestamp';
    ok ($before_creation < $original1_accessed), 'IO.accessed should be greater than pre-creation timestamp';

    sleep 2; # tick for time comparisons


    # altering content
    my $fh1 = open $tmpfile1, :w orelse die "Could not open $tmpfile1 for writing";
    $fh1.print("example content");
    $fh1.close;

    ok ($original1_modified < $tmpfile1.IO.modified), 'IO.modified should be updated when file content changes';
    ok ($original1_changed  < $tmpfile1.IO.changed),  'IO.changed should be updated when file content changes';
    ok ($original1_accessed == $tmpfile1.IO.accessed), 'IO.accessed should NOT be updated when file is opened for writing';
   
    # opening for read
    $fh1 = open $tmpfile1, :r orelse die "Could not open $tmpfile1 for reading";
    $fh1.close;

    ok ($original1_accessed == $tmpfile1.IO.accessed), 'IO.accessed should NOT be updated when file is opened for reading';

    # reading contents of file 
    slurp $tmpfile1;
    ok ($original1_accessed < $tmpfile1.IO.accessed), 'IO.accessed should be updated when contents of file is read';


    # changing file permissions

    $tmpfile2.IO.chmod(0o000);
    my $post_chmod_modified = $tmpfile2.IO.modified;
    my $post_chmod_changed = $tmpfile2.IO.changed;

    ok ($original2_changed == $post_chmod_modified), 'IO.modified should NOT be updated when file mode is altered';
    ok ($original2_changed  < $post_chmod_changed),  'IO.changed should be updated when file mode is altered';
    ok ($post_chmod_modified != $post_chmod_changed),  'IO.changed and IO.modified should differ after file mode change';


    # accessing file

    remove_file $tmpfile1;
    remove_file $tmpfile2;
}


sub create_temporary_file($id) {
    my $time = time;
    my $file = "temp-16-filehandles-filestat-" ~ $*PID ~ "-" ~ $id ~ ".temp";
    my $fh = open $file, :w orelse die "Could not create $file";   #OK not used
    $fh.print($time);                            # store pre-creation timestamp
    diag "Using file $file";
    return $file;
}

sub remove_file ($file) {
    unlink $file;
    ok($file.IO ~~ :!e, "Test file $file was successfully removed");
}

# vim: ft=perl6
