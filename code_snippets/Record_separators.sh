## Input record separator

printf 'this,is\na,sample,text' | perl -nE 'BEGIN{$/ = ","} say "$.)$_"'

printf 'this,is\na,sample,text' | perl -lne 'BEGIN{$/ = ","} print "$.)$_"'

cat report.log

perl -lne 'BEGIN{$/ = "Error:"} print if /something/' report.log

## Single character separator with the -0 option

s='this:is:a:sample:string'

echo "$s" | perl -0072 -lnE 'say "$.) $_"'

echo "$s" | perl -0072 -lnE 'say $_ if /a/'

s='this:is:a:sample:string'

echo "$s" | perl -l -0072 -ne 'print if /a/'

echo "$s" | perl -0072 -lne 'print if /a/'

s='   a\t\tb:1000\n\n\t \n\n123 7777:x  y \n \n z  :apple banana cherry'

printf '%b' "$s" | perl -0072 -lanE 'say join ",", @F'

## NUL separator

printf 'apple\0banana\0' | cat -v

printf 'apple\0banana\0' | perl -ln0e 'print'

## Slurping entire input

cat paths.txt

perl -0777 -pe 's|(?<!\A)/.+/|/|s' paths.txt

seq 2 | perl -0777 -ne 'print $_ x 2'

seq 2 | perl -gne 'print $_ x 2'

## Paragraph mode

cat para.txt

perl -00 -ne 'print if /do/' para.txt

perl -F'\n' -00 -ane 'print if $#F == 1' para.txt

s='a\n\n\n\n\n\n\n\n12\n34\n\nhi\nhello\n'

printf '%b' "$s" | perl -00 -ne 'print if $. <= 2'

s='\n\n\na\nb\n\n12\n34\n\nhi\nhello\n\n\n\n'

printf '%b' "$s" | perl -00 -lnE 'say "$_\n---" if $. == 1'

printf '%b' "$s" | perl -00 -lnE 'say "$_\n---" if eof'

printf '%b' "$s" | perl -00 -nE 'END{say $.}'

printf '%b' "$s" | perl -00 -nE 'BEGIN{$/="\n\n"}; END{say $.}'

perl -l -00 -ne 'if(/are/){print $s, $_; $s="\n"}' para.txt

perl -l -00 -ne 'if(/are|an/){print $s, $_; $s="\n"}' para.txt

## Output record separator

seq 8 | perl -l054 -ne 'print if /[24]/'

seq 8 | perl -l0 -ne 'print if /[24]/' | cat -v

seq 8 | perl -l054 -nE 'print if /[24]/; END{say}'

seq 2 | perl -ne 'print'

seq 2 | perl -ne 'BEGIN{$\ = "---\n"} print'

printf 'apple\0banana\0' | perl -0lpe 'BEGIN{$\ = ".\n"}'

seq 6 | perl -lpe '$\ = $. % 3 ? "-" : "\n"'

