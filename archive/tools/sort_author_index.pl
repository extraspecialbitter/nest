#!/usr/bin/perl

# Initializations

#$issue=$1
$issue="0804q2250";
$filedir="../haiku/$issue";
$filename="$filedir/author_index.out";
@names = "";

# Open the data file

open(INFILE,$filename);

# Get line count

$line_count = `wc -l < $filename`;
# print $line_count, "\n";

while (<INFILE>) {
     $line = $_;
     last if $. > $line_count;
#    print;
     push (@names, $line);
}

# $, = "\n";
  print sort by_last_name @names;

  sub by_last_name {
        return (split ' ', $a )[1]
               cmp
               (split ' ', $b )[1];
  }

