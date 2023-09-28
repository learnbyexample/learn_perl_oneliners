## Executing Perl code

echo 'print "Hello Perl\n"' > hello.pl

perl hello.pl

perl -e 'print "Hello Perl\n"'

perl -le '$x=25; $y=12; print $x**$y'

perl -E '$x=25; $y=12; say $x**$y'

## Filtering

printf 'gate\napple\nwhat\nkite\n'

printf 'gate\napple\nwhat\nkite\n' | perl -ne 'print if /at/'

printf 'gate\napple\nwhat\nkite\n' | perl -ne 'print if !/e/'

cat table.txt

perl -nE 'say $& if /(?<!-)\d+$/' table.txt

perl -nE 'say /(\d+)$/' table.txt

## Substitution

printf '1:2:3:4\na:b:c:d\n' | perl -pe 's/:/-/'

printf '1:2:3:4\na:b:c:d\n' | perl -pe 's/:/-/g'

## Field processing

cat table.txt

perl -lane 'print $F[1]' table.txt

perl -lane 'print if $F[-1] < 0' table.txt

perl -lane '$F[0] =~ s/b/B/g; print "@F"' table.txt

## BEGIN and END

seq 4 | perl -pE 'BEGIN{say "---"} END{say "%%%"}'

## ENV hash

perl -E 'say $ENV{HOME}'

perl -E 'say $ENV{SHELL}'

word='hello' perl -E 'say $ENV{word}'

ip='hi\nbye' perl -E 'say $ENV{ip}'

cat anchors.txt

r='\Bpar\B'

rgx="$r" perl -ne 'print if /$ENV{rgx}/' anchors.txt

r='\Bpar\B'

perl -sne 'print if /$rgx/' -- -rgx="$r" anchors.txt

## Executing external commands

perl -e 'system("echo Hello World")'

perl -e 'system("wc -w <anchors.txt")'

perl -e 'system("seq -s, 10 > out.txt")'

cat out.txt

perl -E '$es=system("ls anchors.txt"); say $es'

perl -E 'system("ls anchors.txt"); say $?'

perl -E 'system("ls xyz.txt"); say $?'

perl -e '$words = `wc -w <anchors.txt`; print $words'

perl -e '$nums = qx/seq 3/; print $nums'

