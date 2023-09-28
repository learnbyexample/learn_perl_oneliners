## @ARGV, $ARGV and ARGV

perl -E 'say join "\n", @ARGV' f[1-3].txt greeting.txt

perl -nE 'say "$#ARGV: " . join ",", @ARGV' f[12].txt table.txt

perl -ne 'print "--- $ARGV ---\n" if $. == 1;
          print;
          close ARGV if eof' greeting.txt table.txt

perl -ne 'print if eof' greeting.txt table.txt

perl -ne 'print and close ARGV if $.==2' greeting.txt table.txt

perl -pe 'close ARGV if $.>=1' greeting.txt table.txt

perl -e 'print scalar readline' greeting.txt

perl -e '$line = <>; print "$line---\n"; print <>' greeting.txt

perl -E 'say getc' <greeting.txt

## STDIN

printf 'apple\nmango\n' | perl -e 'print <>'

printf 'apple\nmango\n' | perl -e 'print <>' greeting.txt

printf 'apple\nmango\n' | perl -e 'print <STDIN>' greeting.txt

## Skipping remaining contents per file

perl -ne '/\bba/ ? close ARGV : print' ip.txt table.txt

perl -nE 'if(/I/){say $ARGV; close ARGV}' f[1-3].txt greeting.txt

perl -nE '$m1=1 if /e\b/; $m2=1 if /[bm]at/i;
          if($m1 && $m2){say $ARGV; $m1=$m2=0; close ARGV; next};
          $m1=$m2=0 if eof' f[1-3].txt greeting.txt

