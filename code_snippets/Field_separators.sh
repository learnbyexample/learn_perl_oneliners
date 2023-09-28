## Default field separation

echo '   a   b   c   ' | perl -anE 'say $#F'

echo '   a   b   c   ' | perl -anE 'say "($F[0])"'

echo '   a   b   c   ' | perl -anE 'say "($F[-1])"'

printf '     one \t\f\v two\t\r\tthree \t\r ' | perl -anE 'say scalar @F'

printf '     one \t\f\v two\t\r\tthree \t\r ' | perl -anE 'say "$F[1]."'

## Input field separator

echo 'goal:amazing:whistle:kwality' | perl -F: -anE 'say "$F[0]\n$F[2]"'

echo 'one;two;three;four' | perl -F';' -anE 'say $F[2]'

echo 'load;err_msg--\ant,r2..not' | perl -F'\W+' -anE 'say $F[2]'

echo 'hi.bye.hello' | perl -F'\.' -anE 'say $F[1]'

printf 'COOL\nnice car\n' | perl -F'/[aeiou]/i' -anE 'say $#F'

echo 'goal:amazing:whistle:kwality' | perl -F'/:/,$_,2' -ane 'print $F[1]'

## Character-wise separation

echo 'apple' | perl -F -anE 'say $F[0]'

echo 'fox:αλεπού' | perl -CS -F -anE 'say @F[4..6]'

## Newline character in the last field

echo 'cat dog' | perl -anE 'say "[$F[-1]]"'

echo 'cat:dog' | perl -F: -anE 'say "[$F[-1]]"'

printf 'cat:dog' | perl -F: -anE 'say "[$F[-1]]"'

echo '  a b   c   ' | perl -anE 'say $#F'

echo ':a:b:c:' | perl -F: -anE 'say $#F; say "[$F[-1]]"'

## Using the -l option for field splitting

echo 'cat:dog' | perl -F: -lane 'print "[$F[-1]]"'

echo ':a:b:c:' | perl -F: -lane 'print scalar @F'

echo ':a:b:c:' | perl -lne 'print scalar split/:/,$_,-1'

## Whitespace and NUL characters in field separation

s='pick eat rest laugh'

echo "$s" | perl -F'/t /' -lane 'print $F[0]'

echo "$s" | perl -F't ' -lane 'print $F[1]'

echo "$s" | perl -F't\x20' -lane 'print $F[1]'

echo "$s" | perl -F't[ ]' -lane 'print $F[1]'

echo "$s" | perl -lne 'print((split /t[ ]/)[1])'

printf 'aa\0b\0c' | perl -F$'\0' -anE 'say join ",", @F' | cat -v

printf 'aa\0b\0c' | perl -F'\0' -anE 'say join ",", @F' | cat -v

## Output field separator

perl -lane 'BEGIN{$,=" "} print $F[0], $F[2]' table.txt

s='Sample123string42with777numbers'

echo "$s" | perl -F'\d+' -lane 'BEGIN{$,=","} print @F'

echo 'table' | perl -F -lane 'print @F[0..2]'

s='Sample123string42with777numbers'

echo "$s" | perl -F'\d+' -lane 'print join ",", @F'

s='goal:amazing:whistle:kwality'

echo "$s" | perl -F: -lane 'print join "-", @F[-1, 1, 0]'

echo "$s" | perl -F: -lane 'print join "::", @F, 42'

s='goal:amazing:whistle:kwality'

echo "$s" | perl -F: -lane 'print "$F[0] $F[2]"'

echo "$s" | perl -F: -lane 'print "@F[0, 2]"'

echo "$s" | perl -F: -lane 'BEGIN{$"="-"} print "msg: @F[-1, 1, 0]"'

## Manipulating $#F

s='goal:amazing:whistle:kwality'

echo "$s" | perl -F: -lane '$#F=1; print join ",", @F'

echo "$s" | perl -F: -lane '$F[$#F+1]="sea"; print join ":", @F'

echo "$s" | perl -F: -lane '$F[7]="go"; print join ":", @F'

echo "1:2:3" | perl -F: -lane '$#F=-1; print "[@F]"'

cat marks.txt

perl -anE 'BEGIN{$,="\t"; @g = qw(D C B A S)}
           say @F, $.==1 ? "Grade" : $g[$F[-1]/10 - 5]' marks.txt

## Defining field contents instead of splitting

s='Sample123string42with777numbers'

echo "$s" | perl -nE '@f=/\d+/g; say $f[1]'

s='coat Bin food tar12 best Apple fig_42'

echo "$s" | perl -nE 'say join ",", /\b[a-z0-9]+\b/g'

s='items: "apple" and "mango"'

echo "$s" | perl -nE '@f=/"[^"]+"/g; say $f[0]'

perl -nE 'say join "\n", //g if /\bm\w*\b/' table.txt

perl -nE 'say join "\n", //g if /\bh\w*\b/ || /\bb\w*\b/' table.txt

perl -nE 'say $& while /\bm\w*\b/g' table.txt

perl -nE 'say $& while /\b[bh]\w*\b/g' table.txt

s='eagle,"fox,42",bee,frog'

echo "$s" | perl -F, -lane 'print $F[1]'

echo "$s" | perl -lne 'print((/"[^"]+"|[^,]+/g)[1])'

## Fixed width processing

cat items.txt

perl -lne 'print join ",", unpack "a8a4a6"' items.txt

perl -lne 'print((unpack "a8a4a6")[1])' items.txt

perl -lne 'print join ",", unpack "a5x3a3xa6"' items.txt

printf 'banana\x0050\x00' | perl -nE 'say join ":", unpack "Z*Z*"'

perl -lne 'print join ",", unpack "a5x3a*"' items.txt

echo 'b 123 good' | perl -nE 'say substr $_,2,3'

echo 'b 123 good' | perl -ne 'print substr $_,6'

echo 'b 123 good' | perl -pe 'substr $_,2,3,"gleam"'

## Assorted field processing functions

s='goal:amazing:42:whistle:kwality:3.14'

echo "$s" | perl -F: -lane 'print join ":", grep {/i[nts]/} @F'

echo "$s" | perl -F: -lane 'print scalar grep {!/\d/} @F'

s='hour hand band mat heated apple hit'

echo "$s" | perl -lane 'print join "\n", grep {!/^h/ && length()<4} @F'

echo '20 711 -983 5 21' | perl -lane 'print join ":", grep {$_ > 20} @F'

perl -lane 'print if 1 >= grep {/r/} @F' table.txt

s='goal:amazing:42:whistle:kwality:3.14'

echo "$s" | perl -F: -lane 'print join ":", map {uc} @F'

echo "$s" | perl -F: -lane 'print join ":", map {/^[gw]/ ? uc : $_} @F'

echo '23 756 -983 5' | perl -lane 'print join ":", map {$_ ** 2} @F'

echo 'AaBbCc' | perl -F -lane 'print join " ", map {ord} @F'

echo 'AaBbCc' | perl -F -lane 'map {$_ = ord} @F; print "@F"'

echo 'a b c' | perl -lane 'print join ",", map {qq/"$_"/} @F'

s='hour hand band mat heated pineapple'

echo "$s" | perl -lane 'print join "\n", map {y/ae/X/r} grep {/^h/} @F'

echo "$s" | perl -lane 'print join "\n", grep {y/ae/X/; /^h/} @F'

echo '23 756 -983 5' | perl -lane 'print join " ", sort {$a <=> $b} @F'

s='floor bat to dubious four'

echo "$s" | perl -lane 'print join ":", sort @F'

echo "$s" | perl -lane 'print join ":", sort {length($a) <=> length($b)} @F'

echo "$s" | perl -lane 'print join ":", sort {length($b) <=> length($a)} @F'

echo 'dragon' | perl -F -lane 'print reverse sort @F'

s='try a bad to good i teal by nice how'

echo "$s" | perl -anE 'say join ":",
                  sort {length($b) <=> length($a) or $a cmp $b} @F'

echo "$s" | perl -anE 'say join ":", map {$_->[0]}
                       sort {$b->[1] <=> $a->[1] or $a->[0] cmp $b->[0]}
                       map {[$_, length($_)]} @F'

cat marks.txt

perl -lane '@i = sort {$F[$b] cmp $F[$a]} 0..$#F if $.==1;
            print join "\t", @F[@i]' marks.txt

