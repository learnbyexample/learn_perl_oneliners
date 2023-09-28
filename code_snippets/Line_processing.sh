## Regexp based filtering

cat table.txt

perl -ne 'print if /ow\b/' table.txt

perl -ne 'print if !/[ksy]/' table.txt

cat paths.txt

perl -ne 'print if /\/home\/ram\//' paths.txt

perl -ne 'print if m{/home/ram/}' paths.txt

perl -ne 'print if !m#/home/ram/#' paths.txt

## Extracting matched portions

cat ip.txt

perl -nE 'say $& if /\b[a-z]\w*[ty]\b/' ip.txt

perl -nE 'say join "::", @{^CAPTURE} if /(\b[bdp]\w+).*((?1))/i' ip.txt

perl -nE 'say /^(\w+ ).*?(\d+)$/' table.txt

perl -nE 'say join ":", /^(\w+).*?(\d+)$/' table.txt

## Transliteration

echo 'Uryyb Jbeyq' | perl -pe 'tr/a-zA-Z/n-za-mN-ZA-M/'

echo 'apple:123:banana' | perl -pe 'tr/0-9\n/-/c'

echo 'apple:123:banana' | perl -pe 'tr/0-9\n//cd'

echo 'APPLE gobbledygook' | perl -pe 'tr|A-Za-z||s'

echo 'APPLE gobbledygook' | perl -pe 'tr|A-Z|a-z|s'

perl -ne 'print if tr/b// == 2' table.txt

s='orange apple appleseed'

echo "$s" | perl -pe 's#\bapple\b(*SKIP)(*F)|\w+#$&=~tr/a-z/A-Z/r#ge'

## Conditional substitution

printf '1,2,3,4\na,b,c,d\n' | perl -pe 's/,/-/g if !/2/'

perl -ne 'print s/ark/[$&]/rg if /the/' ip.txt

perl -ne 'print if s/\bw\w*t\b/{$&}/g' ip.txt

## Multiple conditions

perl -ne 'print if /ark/ && !/sky/' ip.txt

perl -ane 'print if /\bthe\b/ || $#F == 5' ip.txt

perl -ne 'print if /s/ xor /m/' table.txt

## next

perl -nE 'if(/\bpar/){print "%% $_"; next} say /s/ ? "X" : "Y"' anchors.txt

## exit

perl -ne 'print; exit if /say/' ip.txt

perl -pe 'exit if /say/' ip.txt

tac ip.txt | perl -ne 'print; exit if /an/' | tac

printf 'sea\neat\ndrop\n' | perl -ne 'print; exit(2) if /at/'

echo $?

perl -pE 'exit if /cake/' table.txt

perl -pE 'exit if /cake/; END{say "bye"}' table.txt

perl -pE 'BEGIN{say "hi"; exit; say "hello"} END{say "bye"}' table.txt

## Line number based processing

perl -ne 'print if $. == 3' ip.txt

perl -ne 'print if $. == 2 || $. == 6' ip.txt

printf 'gates\nnot\nused\n' | perl -pe 'tr/a-z/*/ if $. == 2'

seq 14 25 | perl -ne 'print if $. >= 10'

perl -ne 'print if eof' ip.txt

perl -ne 'print "$.:$_" if eof' ip.txt

perl -ne 'print if eof' ip.txt table.txt

seq 3542 4623452 | perl -ne 'if($. == 2452){print; exit}'

seq 3542 4623452 | perl -ne 'print if $. == 250; if($. == 2452){print; exit}'

time seq 3542 4623452 | perl -ne 'if($. == 2452){print; exit}' > f1

time seq 3542 4623452 | perl -ne 'print if $. == 2452' > f2

rm f1 f2

## Range operator

seq 14 25 | perl -ne 'print if 3..5'

perl -ne 'print if /to/ .. /pl/' ip.txt

perl -ne 'print if 6 .. /utter/' ip.txt

perl -ne 'print if !(/\bba/ .. eof)' ip.txt table.txt

perl -ne 'print if 7 .. /and/' ip.txt

perl -ne 'print if 7 ... /and/' ip.txt

perl -ne 'print if /Banana/ .. /XYZ/' ip.txt

## Working with fixed strings

printf 'int a[5]\nfig\n1+4=5\n' | perl -ne 'print if /a[5]/'

perl -E 'say "\Qa[5]"'

printf 'int a[5]\nfig\n1+4=5\n' | perl -ne 'print if /\Qa[5]/'

printf 'int a[5]\nfig\n1+4=5\n' | perl -pe 's/\Qa[5]/b[12]/'

echo '$x = $y + $z' | perl -pe 's/\Q$y + $z/100/'

echo '$x = $y + $z' | fs='$y + $z' perl -pe 's/\Q$ENV{fs}/100/'

perl -E '$x = q(x\y\\0z); say $x'

x='x\y\\0z' perl -E 'say $ENV{x}'

printf 'int a[5]\nfig\n1+4=5\n' | perl -ne 'print if index($_, "a[5]") != -1'

perl -E '$x=5; say "value of x:\t$x"'

s='$a = 2 * ($b + $c)'

echo "$s" | perl -ne 'print if index($_, q/($b + $c)/) != -1'

echo "$s" | fs='($b + $c)' perl -ne 'print if index($_, $ENV{fs}) != -1'

cat eqns.txt

s='a+b' perl -ne 'print if index($_, $ENV{s})==0' eqns.txt

s='a+b' perl -lne '$pos = length() - length($ENV{s});
                   print if index($_, $ENV{s}) == $pos' eqns.txt

perl -ne '$i = index($_, "="); print if 0 <= $i <= 5' eqns.txt

s='a+b' perl -ne 'print if index($_, $ENV{s})>=1' eqns.txt

printf 'a.b\na+b\n' | perl -lne 'print if /^a.b$/'

printf 'a.b\na+b\n' | perl -lne 'print if $_ eq q/a.b/'

printf '1 a.b\n2 a+b\n' | perl -lane 'print if $F[1] ne q/a.b/'

echo 'x+y' | perl -pe 's/\Qx+y/$x+@y/'

echo 'x+y' | r='$x+@y' perl -pe 's/\Qx+y/$ENV{r}/'

echo 'x+y' | perl -pe 's/\Qx+y/q($x+@y)/e'

echo 'x+y' | perl -pe 's/\Qx+y/q($x\/@y)/e'

echo 'x+y' | perl -pe 's|\Qx+y|q($x/@y)|e'

echo 'x+y' | perl -pe 's|\Qx+y|q($x/@y\\\z)|e'

