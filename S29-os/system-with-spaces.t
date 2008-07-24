use v6;
use Test;
plan 1+322;

# L<S29/"OS"/"=item run">

skip_rest "This file was in t_disabled/.  Remove this SKIP if it now works.";
exit;

#?rakudo 323 skip 'test relevant only for pugs'

if $?OS ne 'MSWin32' {
   skip_rest "These are Win32-specific tests";
   exit;
}

=begin pod

Test the interaction of system(LIST) and whitespace characters. In
an ideal world, system() does Just Enough quoting of the parameters
that system(LIST) is sane. On *nix-like platforms, system(LIST)
is an actual system call, so there should be no additional logic needed.
On Win32, system(LIST) does not exist and is mostly implemented as
system("@LIST") , so additional quoting magic is needed.

This situation on Win32 is aggravated by the fact that there is no magic
routine to do parameter I<en>coding but a routine to do parameter I<de>coding,
which is not really documented and varies between the versions of MSVC.
So there is no fast and easy way to get automagic command line quoting for all
programs, especially if double-quotes as parameters are involved.

Haskell's automagic quoting seems to be amazingly good though.

=end pod

# Win32 specific tests for system() being sane enough

my $cwdb = $*CWD;
my $cwd = $cwdb;
$cwd  ~~ s:P5:g!\\!/!;
$cwdb ~~ s:P5:g,/,\\,;

my $testdir = "t/builtins/system/t e s t";
my $exename = "showav";
my $plxname = "showargv.pl";

my $exe = "$testdir/$exename";
my $exex = $exe ~ ".exe";
my $exeb = $exe;
$exeb ~~ s:P5:g,/,\\,;
my $exebx = $exeb ~ ".exe";

my $plx = "$testdir/$plxname";
my $plxb = $plx;
$plxb ~~ s:P5:g,/,\\,;

my $bat = "$testdir/$plxname";
my $batb = $bat;
$batb ~~ s:P5:g,/,\\,;

my $cmdx = $bat ~ ".cmd";
my $cmdb = $batb;
my $cmdbx = $cmdb ~ ".cmd";

my $pugs = 'pugs.exe';

my @command = (
  $exe,
  $exex,
  $exeb,
  $exebx,
  "./$exe",
  "./$exex",
  ".\\$exeb",
  ".\\$exebx",
  "$cwd/$exe",
  "$cwd/$exex",
  "$cwdb\\$exeb",
  "$cwdb\\$exebx",
  # "$bat",
  # "$batx",
  # "$batb",
  # "$batbx",
  # "./$bat",
  # "./$batx",
  # ".\\$batb",
  # ".\\$batbx",
  # "$cwd/$bat",
  # "$cwd/$batx",
  # "$cwdb\\$batb",
  # "$cwdb\\$batbx",
  # "$cmdx",
  # "$cmdbx",
  # "./$cmdx",
  # "\\$cmdbx",
  # "$cwd/$cmdx",
  # "$cwdb\\$cmdbx",
  # [$INTERPRETER, $batx],
  # [$INTERPRETER, $batbx],
  # [$INTERPRETER, "./$batx"],
  # [$INTERPRETER, ".\\$batbx"],
  # [$INTERPRETER, "$cwd/$batx"],
  # [$INTERPRETER, "$cwdb\\$batbx"],
  # [$INTERPRETER, "-w", "$cwdb\\$batbx"],
  # [$pugs,'-e',q!say('['~$*PROGRAM_NAME~']['~@*ARGS.join('][')~']')!],
  [$pugs,$plx],
  [$pugs,$plxb],
);

my @av = (
  undef,
  "",
  " ",
  "abc",
  "a b\tc",
  "\tabc",
  "abc\t",
  " abc\t",
  "\ta b c ",
  ["\ta b c ", ""],
  ["\ta b c ", " "],
  ["", "\ta b c ", "abc"],
  [" ", "\ta b c ", "abc"],
  ['" "', 'a" "b" "c', "abc"],

  # Added by Max Maischein
  'Hello "World"!',
  'c:\\',
  'c:\\test name',
  'c:\\test directory\\',
  '\\\\localhost\\',
  'Hello ^_^',
  'Hello ^^',
  '^^',
  '""',
);

diag "Creating test files";
my $counter;
my @cleanup;

for @command -> $cmd {
  my @cmd = $cmd;
  for @av -> $arg {
    my @args = $arg;

    my $prog = "perl6-temprun-test-" ~ ($counter++) ~ ".tmp";

    my $fh = open($prog, :w);
    $fh.say("system(");
    #say @cmd;
    #say @args;
    for @cmd, @args -> $l {
      my $line = $l.perl();
      #say $line;
      $line ~~ s:P5/^\\//;
      #say $line;
      $fh.say($line ~ ",")
    };
    $fh.say(")");
    $fh.close();
    undefine $fh;

    push @cleanup, $prog;
  };
};
ok(1,"Created test files");

my $counter = 0;
for @command -> $cmd {
  my @cmd = $cmd;
  for @av -> $arg {
    my @args = $arg;

    my $outfile = "perl6-tempout-" ~ ($counter) ~ ".tmp";
    push @cleanup, $outfile;

    my $prog = "perl6-temprun-test-" ~ ($counter++) ~ ".tmp";    

    my $cmd = @cmd[*-1];
    my $expected = "[" ~ $cmd ~ "][" ~ @args.join("][") ~ "]";
    my $name = "|" ~ @cmd.join("*") ~ "| with [" ~ @args.join("][") ~ "]";

    if (! system($pugs ~ " " ~ $prog ~ "> " ~ $outfile)) {
      fail($name);
      diag slurp $prog;
      next();
    };

    my $output = slurp $outfile;
    $output .= chomp;

    is($output,$expected,$name)
      or diag slurp $prog;
  };
};

diag "Cleaning up";
for @cleanup { unlink($_) };
