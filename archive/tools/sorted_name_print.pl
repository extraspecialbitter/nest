#!/usr/bin/perl

# Initializations

#$issue=$1
$issue="0803W1746";
$filedir="../haiku/$issue/";
$filename="$filedir/haiku.txt";
$name_number=4;
$poem_offset=6;
@names = "";

# Open the data file

open(INFILE,$filename);

# Get line count

$line_count = `wc -l < $filename`;
# print $line_count, "\n";

while (<INFILE>) {
     $line = $_;
     last if $. == $line_count;
      if ($. == $name_number) {
#         print;
          push (@names, $line);
          $name_number+=$poem_offset;
      }
}

# $, = "\n";
  print sort by_last_name @names;

  sub by_last_name {
        return (split ' ', $a )[-1]
               cmp
               (split ' ', $b )[-1];
  }

