## Input record separator

printf 'this,is\na,sample' | perl -nE 'BEGIN{$/ = ","} say "$.)$_"'

printf 'this,is\na,sample' | perl -lne 'BEGIN{$/ = ","} print "$.)$_"'

cat report.log

perl -lne 'BEGIN{$/ = "Error:"} print if /something/' report.log

## Single character separator with -0 option

s='this:is:a:sample:string'

echo "$s" | perl -0072 -lnE 'say "$.) $_"'

echo "$s" | perl -0072 -lnE 'say $_ if /a/'

s='this:is:a:sample:string'

echo "$s" | perl -l -0072 -ne 'print if /a/'

echo "$s" | perl -0072 -lne 'print if /a/'

s='   a\t\tb\n\t\n:1000\n\n\n\n123 7777:x  y \n \n z  '

printf '%b' "$s" | perl -0072 -lanE 'say join ",", @F'

## NUL separator and slurping

printf 'foo\0bar\0' | cat -v

printf 'foo\0bar\0' | perl -ln0e 'print'

cat paths.txt

perl -0777 -pe 's|(?<!\A)/.+/|/|s' paths.txt

seq 2 | perl -0777 -ne 'print $_ x 2'

## Paragraph mode

cat programming_quotes.txt

perl -00 -ne 'print if /you/' programming_quotes.txt

perl -F'\n' -00 -ane 'print if $#F == 1' programming_quotes.txt

s='a\n\n\n\n\n\n\n\n12\n34\n\nhi\nhello\n'

printf '%b' "$s" | perl -00 -ne 'print if $. <= 2'

s='\n\n\na\nb\n\n12\n34\n\nhi\nhello\n\n\n\n'

printf '%b' "$s" | perl -00 -lnE 'say "$_\n---" if $. == 1'

printf '%b' "$s" | perl -00 -lnE 'say "$_\n---" if eof'

printf '%b' "$s" | perl -00 -nE 'END{say $.}'

printf '%b' "$s" | perl -00 -nE 'BEGIN{$/="\n\n"}; END{say $.}'

perl -l -00 -ne 'if(/code/){print $s, $_; $s="\n"}' programming_quotes.txt

perl -l -00 -ne 'if(/you/){print $s, $_; $s="\n"}' programming_quotes.txt

## Output record separator

seq 8 | perl -l054 -ne 'print if /[24]/'

seq 8 | perl -l0 -ne 'print if /[24]/' | cat -v

seq 8 | perl -l054 -nE 'print if /[24]/; END{say}'

seq 2 | perl -ne 'print'

seq 2 | perl -ne 'BEGIN{$\ = "---\n"} print'

printf 'foo\0bar\0' | perl -0lpe 'BEGIN{$\ = ".\n"}'

seq 6 | perl -lpe '$\ = $. % 3 ? "-" : "\n"'

