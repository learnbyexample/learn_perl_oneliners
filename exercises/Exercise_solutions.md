# Exercise solutions

>![info](../images/info.svg) Exercise related files are available from [exercises folder of learn_perl_oneliners repo](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/exercises).

<br>

# One-liner introduction

**a)** For the input file `ip.txt`, display all lines containing `is`.

```bash
$ cat ip.txt
Hello World
How are you
This game is good
Today is sunny
12345
You are funny

$ perl -ne 'print if /is/' ip.txt
This game is good
Today is sunny
```

**b)** For the input file `ip.txt`, display first field of lines *not* containing `y`. Consider space as the field separator for this file.

```bash
$ perl -anE 'say $F[0] if !/y/' ip.txt
Hello
This
12345
```

**c)** For the input file `ip.txt`, display all lines containing no more than 2 fields.

```bash
$ perl -ane 'print if $#F < 2' ip.txt
Hello World
12345
```

**d)** For the input file `ip.txt`, display all lines containing `is` in the second field.

```bash
$ perl -ane 'print if $F[1] =~ /is/' ip.txt
Today is sunny
```

**e)** For each line of the input file `ip.txt`, replace first occurrence of `o` with `0`.

```bash
$ perl -pe 's/o/0/' ip.txt
Hell0 World
H0w are you
This game is g0od
T0day is sunny
12345
Y0u are funny
```

**f)** For the input file `table.txt`, calculate and display the product of numbers in the last field of each line. Consider space as the field separator for this file.

```bash
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14

$ perl -anE 'BEGIN{$p=1} $p *= $F[-1]; END{say $p}' table.txt
-923.16
```

**g)** Append `.` to all the input lines for the given `stdin` data.

```bash
$ printf 'last\nappend\nstop\n' | perl -pe 's/$/./'
last.
append.
stop.
```

**h)** Use contents of `s` variable to display all matching lines from the input file `ip.txt`. Assume that `s` doesn't have any regexp metacharacters. Construct the solution such that there's at least one word character immediately preceding the contents of `s` variable.

```bash
$ s='is'

$ r="$s" perl -ne 'print if /\B$ENV{r}/' ip.txt
This game is good
```

**i)** Use `system` to display contents of filename present in second field (space separated) of the given input line.

```bash
$ s='report.log ip.txt sorted.txt'
$ echo "$s" | perl -ane 'system("cat $F[1]")'
Hello World
How are you
This game is good
Today is sunny
12345
You are funny

$ s='power.txt table.txt'
$ echo "$s" | perl -ane 'system("cat $F[1]")'
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14
```

<br>

# Line processing

**a)** Remove only the third line of given input.

```bash
$ seq 34 37 | perl -ne 'print if $. != 3'
34
35
37
```

**b)** Display only fourth, fifth, sixth and seventh lines for the given input.

```bash
$ seq 65 78 | perl -ne 'print if 4..7'
68
69
70
71
```

**c)** For the input file `ip.txt`, replace all occurrences of `are` with `are not` and `is` with `is not` only from line number **4** till end of file. Also, only the lines that were changed should be displayed in the output.

```bash
$ cat ip.txt
Hello World
How are you
This game is good
Today is sunny
12345
You are funny

$ perl -ne 'print if $. > 3 && s/are|is/$& not/g' ip.txt
Today is not sunny
You are not funny
```

**d)** For the given `stdin`, display only the first three lines. Avoid processing lines that are not relevant.

```bash
$ seq 14 25 | perl -pe 'exit if $. > 3'
14
15
16
```

**e)** For the input file `ip.txt`, display all lines from start of the file till the first occurrence of `game`.

```bash
$ perl -ne 'print; exit if /game/' ip.txt
Hello World
How are you
This game is good
```

**f)** For the input file `ip.txt`, display all lines that contain `is` but not `good`.

```bash
$ perl -ne 'print if /is/ && !/good/' ip.txt
Today is sunny
```

**g)** For the input file `ip.txt`, extract the word before the whole word `is` as well as the word after it. If such a match is found, display the two words around `is` in reversed order. For example, `hi;1 is--234 bye` should be converted to `234:1`. Assume that whole word `is` will not be present more than once in a single line.

```bash
$ # can also use: perl -ne 'print if s/.*?(\w+)\W+is\W+(\w+).*/$2:$1/' ip.txt
$ perl -nE 'say "$2:$1" if /(\w+)\W+is\W+(\w+)/' ip.txt
good:game
sunny:Today
```

**h)** For the given input string, replace `0xA0` with `0x7F` and `0xC0` with `0x1F`.

```bash
$ s='start address: 0xA0, func1 address: 0xC0'

$ echo "$s" | perl -pe 's/0xA0/0x7F/; s/0xC0/0x1F/'
start address: 0x7F, func1 address: 0x1F
```

**i)** Find the starting index of first occurrence of `is` or `the` or `was` or `to` for each input line of the file `idx.txt`. Assume all input lines will match at least one of these terms.

```bash
$ cat idx.txt
match after the last newline character
and then you want to test
this is good bye then
you were there to see?

$ perl -nE '/is|the|was|to/; say $-[0]' idx.txt
12
4
2
9
```

**j)** Display all lines containing `[4]*` for the given `stdin` data.

```bash
$ # can also use: perl -ne 'print if /\Q[4]*/'
$ printf '2.3/[4]*6\n2[4]5\n5.3-[4]*9\n' | perl -ne 'print if index($_, "[4]*") != -1'
2.3/[4]*6
5.3-[4]*9
```

**k)** For the given input string, replace all lowercase alphabets to `x` only for words starting with `m`.

```bash
$ s='ma2T3a a2p kite e2e3m meet'
$ echo "$s" | perl -pe 's/\bm\w+/$&=~tr|a-z|x|r/ge'
xx2T3x a2p kite e2e3m xxxx
```

**l)** For the input file `ip.txt`, delete all characters other than lowercase vowels and newline character. Perform this transformation only between a line containing `you` up to line number `4` (inclusive).

```bash
$ # can also use: perl -pe 'tr/aeiou\n//cd if /you/ .. 4' ip.txt
$ perl -lpe 'tr/aeiou//cd if /you/ .. 4' ip.txt
Hello World
oaeou
iaeioo
oaiu
12345
You are funny
```

<br>

# In-place file editing

**a)** For the input file `text.txt`, replace all occurrences of `in` with `an` and write back the changes to `text.txt` itself. The original contents should get saved to `text.txt.orig`

```bash
$ cat text.txt
can ran want plant
tin fin fit mine line

$ perl -i.orig -pe 's/in/an/g' text.txt

$ cat text.txt
can ran want plant
tan fan fit mane lane
$ cat text.txt.orig
can ran want plant
tin fin fit mine line
```

**b)** For the input file `text.txt`, replace all occurrences of `an` with `in` and write back the changes to `text.txt` itself. Do not create backups for this exercise. Note that you should have solved the previous exercise before starting this one.

```bash
$ cat text.txt
can ran want plant
tan fan fit mane lane

$ perl -i -pe 's/an/in/g' text.txt

$ cat text.txt
cin rin wint plint
tin fin fit mine line
$ diff text.txt text.txt.orig
1c1
< cin rin wint plint
---
> can ran want plant
```

**c)** For the input file `copyright.txt`, replace `copyright: 2018` with `copyright: 2020` and write back the changes to `copyright.txt` itself. The original contents should get saved to `2018_copyright.txt.bkp`

```bash
$ cat copyright.txt
bla bla 2015 bla
blah 2018 blah
bla bla bla
copyright: 2018

$ perl -i'2018_*.bkp' -pe 's/copyright: \K2018/2020/g' copyright.txt

$ cat copyright.txt
bla bla 2015 bla
blah 2018 blah
bla bla bla
copyright: 2020
$ cat 2018_copyright.txt.bkp
bla bla 2015 bla
blah 2018 blah
bla bla bla
copyright: 2018
```

**d)** In the code sample shown below, two files are created by redirecting output of `echo` command. Then a `perl` command is used to edit `b1.txt` in-place as well as create a backup named `bkp.b1.txt`. Will the `perl` command work as expected? If not, why?

```bash
$ echo '2 apples' > b1.txt
$ echo '5 bananas' > -ibkp.txt
$ perl -ibkp.* -pe 's/2/two/' b1.txt
```

Unquoted strings on the command line are subjected to shell interpretation. So, `-ibkp.*` will get expanded as `-ibkp.txt` (as there exists a file whose name starts with `-ibkp.`). This results in back up filename as `b1.txtbkp.txt` (because `bkp.txt` will be treated as the suffix to be added to input file `b1.txt`). The correct usage is `perl -i'bkp.*' -pe 's/2/two/' b1.txt` to get `bkp.b1.txt` as the back up filename.

<br>

# Field separators

**a)** Extract only the contents between `()` or `)(` from each input line. Assume that `()` characters will be present only once every line.

```bash
$ cat brackets.txt
foo blah blah(ice) 123 xyz$ 
(almond-pista) choco
yo )yoyo( yo

$ perl -F'[()]' -nE 'say $F[1]' brackets.txt
ice
almond-pista
yoyo
```

**b)** For the input file `scores.csv`, extract `Name` and `Physics` fields in the format shown below.

```bash
$ cat scores.csv
Name,Maths,Physics,Chemistry
Blue,67,46,99
Lin,78,83,80
Er,56,79,92
Cy,97,98,95
Ort,68,72,66
Ith,100,100,100

$ perl -F, -lane 'print "$F[0]:$F[2]"' scores.csv
Name:Physics
Blue:46
Lin:83
Er:79
Cy:98
Ort:72
Ith:100
```

**c)** For the input file `scores.csv`, display names of those who've scored above `80` in Maths.

```bash
$ perl -F, -lane 'print $F[0] if $F[1]>80' scores.csv
Cy
Ith
```

**d)** Display the number of word characters for the given inputs. Word definition here is same as used in regular expressions. Can you construct two different solutions as indicated below?

```bash
$ # solve using 's' operator
$ echo 'hi there' | perl -nE 'say s/\w//g'
7

$ # solve without using substitution or transliteration operator
$ echo 'u-no;co%."(do_12:as' | perl -F'\w' -anE 'say $#F'
12
```

**e)** Construct a solution that works for both the given sample inputs and the corresponding output shown.

```bash
$ s1='1 "grape" and "mango" and "guava"'
$ s2='("a 1""d""c-2""b")'

$ echo "$s1" | perl -nE 'say join ",", sort /"[^"]+"/g'
"grape","guava","mango"
$ echo "$s2" | perl -nE 'say join ",", sort /"[^"]+"/g'
"a 1","b","c-2","d"
```

**f)** Display only the third and fifth characters from each input line.

```bash
$ printf 'restore\ncat one\ncricket' | perl -F -anE 'say @F[2,4]'
so
to
ik
```

**g)** Transform the given input file `fw.txt` to get the output as shown below. If second field is empty (i.e. contains only space characters), replace it with `NA`.

```bash
$ cat fw.txt
1.3  rs   90  0.134563
3.8           6
5.2  ye       8.2387
4.2  kt   32  45.1

$ perl -ne '@f = unpack "a3x2a2x7a*";
            $f[1] = "NA" if $f[1] eq "  ";
            print join ",", @f' fw.txt 
1.3,rs,0.134563
3.8,NA,6
5.2,ye,8.2387
4.2,kt,45.1
```

**h)** For the input file `scores.csv`, display the header as well as any row which contains `b` or `t` (irrespective of case) in the first field.

```bash
$ perl -F, -ane 'print if $F[0]=~/[bt]/i || $.==1' scores.csv
Name,Maths,Physics,Chemistry
Blue,67,46,99
Ort,68,72,66
Ith,100,100,100
```

**i)** Extract all whole words that contains `42` but not at the edge of a word. Assume a word cannot contain `42` more than once.

```bash
$ s='hi42bye nice1423 bad42 cool_42a 42fake'
$ echo "$s" | perl -nE 'say join "\n", /\w+42\w+/g'
hi42bye
nice1423
cool_42a
```

**j)** For the input file `scores.csv`, add another column named `GP` which is calculated out of `100` by giving `50%` weightage to `Maths` and `25%` each for `Physics` and `Chemistry`.

```bash
$ perl -F, -lane 'print join ",", @F, $.==1 ? "GP" :
                        $F[1]/2 + ($F[2]+$F[3])/4' scores.csv
Name,Maths,Physics,Chemistry,GP
Blue,67,46,99,69.75
Lin,78,83,80,79.75
Er,56,79,92,70.75
Cy,97,98,95,96.75
Ort,68,72,66,68.5
Ith,100,100,100,100.0
```

**k)** For the input file `mixed_fs.txt`, retain only first two fields from each input line. The input and output field separators should be space for first two lines and `,` for the rest of the lines.

```bash
$ cat mixed_fs.txt
rose lily jasmine tulip
pink blue white yellow
car,mat,ball,basket
light green,brown,black,purple

$ perl -lne '$s = $.<3 ? " " : ",";
             print join $s, (split $s)[0,1]' mixed_fs.txt
rose lily
pink blue
car,mat
light green,brown
```

**l)** For the given space separated numbers, filter only numbers in the range `20` to `1000` (inclusive).

```bash
$ s='20 -983 5 756 634223'

$ echo "$s" | perl -lane 'print join " ", grep {$_>=20 && $_<=1000} @F'
20 756
```

**m)** For the given input file `words.txt`, filter all lines containing characters in ascending and descending order.

```bash
$ cat words.txt
bot
art
are
boat
toe
flee
reed

$ # ascending order
$ perl -F -lane 'print if $_ eq join "", sort @F' words.txt
bot
art

$ # descending order
$ perl -F -lane 'print if $_ eq join "", reverse sort @F' words.txt
toe
reed
```

**n)** For the given space separated words, extract the three longest words.

```bash
$ s='I bought two bananas and three mangoes'

$ echo "$s" | perl -anE 'say join "\n", (sort {length($b) <=> length($a)} @F)[0..2]'
bananas
mangoes
bought
```

**o)** Convert the contents of `split.txt` as shown below.

```bash
$ cat split.txt
apple,1:2:5,mango
wry,4,look
pencil,3:8,paper

$ perl -F, -lane 'print join ",", $F[0],$_,$F[2] for split /:/,$F[1]' split.txt
apple,1,mango
apple,2,mango
apple,5,mango
wry,4,look
pencil,3,paper
pencil,8,paper
```

**p)** Generate string combinations as shown below for the given input string passed as an environment variable.

```bash
$ s='{x,y,z}{1,2,3}' perl -E 'say join " ", glob $ENV{s}'
x1 x2 x3 y1 y2 y3 z1 z2 z3
```

<br>

# Record separators

**a)** The input file `jumbled.txt` consists of words separated by various delimiters. Display all words that contain `an` or `at` or `in` or `it`, one per line.

```bash
$ cat jumbled.txt
overcoats;furrowing-typeface%pewter##hobby
wavering:concession/woof\retailer

$ perl -0777 -nE 'say join "\n", /\w*[ai][nt]\w*/g' jumbled.txt
overcoats
furrowing
wavering
```

**b)** Emulate `paste -sd,` with `perl`.

```bash
$ # this command joins all input lines with ',' character
$ paste -sd, ip.txt
Hello World,How are you,This game is good,Today is sunny,12345,You are funny
$ # make sure there's no ',' at end of the line
$ # and that there's a newline character at the end of the line
$ perl -lpe '$\ = eof ? "\n" : ","' ip.txt
Hello World,How are you,This game is good,Today is sunny,12345,You are funny

$ # if there's only one line in input, again make sure there's no trailing ','
$ # and that there's a newline character at the end of the line
$ printf 'foo' | paste -sd,
foo
$ printf 'foo' | perl -lpe '$\ = eof ? "\n" : ","'
foo
```

**c)** For the input file `sample.txt`, extract all paragraphs having words starting with `do`.

```bash
$ cat sample.txt
Hello World

Good day
How are you

Just do-it
Believe it

Today is sunny
Not a bit funny
No doubt you like it too

Much ado about nothing
He he he

$ # note that there's no extra empty line at the end of expected output
$ perl -00 -lnE 'if(/\bdo/){say $s, $_; $s="\n"}' sample.txt
Just do-it
Believe it

Today is sunny
Not a bit funny
No doubt you like it too
```

**d)** For the input file `sample.txt`, change all paragraphs into single line by joining lines using `.` and a space character as the separator. And add a final `.` to each paragraph.

```bash
$ # note that there's no extra empty line at the end of expected output
$ perl -F'\n' -00 -lane '$\ = eof ? ".\n" : ".\n\n"; print join ". ", @F' sample.txt
Hello World.

Good day. How are you.

Just do-it. Believe it.

Today is sunny. Not a bit funny. No doubt you like it too.

Much ado about nothing. He he he.
```

**e)** For the given input, use `;;` as record separators and `:` as field separators. Display all records with second field having an integer greater than `50`.

```bash
$ s='mango:100;;apple:25;;grapes:75'

$ # note that the output has ;; at the end but not newline character
$ printf "$s" | perl -F: -lane 'BEGIN{$/=$\=";;"} print if $F[1]>50'
mango:100;;grapes:75;; 
```

<br>

# Using modules

**a)** For the given space separated words, display the max word determined by alphabetic order.

```bash
$ s='let in bat xml me lion'

$ echo "$s" | perl -lane 'print ((sort @F)[-1])'
xml
```

**b)** For the given space separated words, randomize the order of characters for each word.

```bash
$ s='this is a sample sentence'

$ # sample randomized output shown here, could be different for you
$ echo "$s" | perl -MList::Util=shuffle -lane '
              print join " ", map {join "", shuffle split//} @F'
htis si a melasp ecnnsete
```

**c)** Use [metacpan: XML::LibXML](https://metacpan.org/pod/XML::LibXML) to get content of all tags named `blue` for the input file `sample.xml`. See [grantm: Perl XML::LibXML by example](https://grantm.github.io/perl-libxml-by-example/) for a detailed book on `XML::LibXML` module.

```bash
$ cat sample.xml
<doc>
    <greeting type="ask">Hi there. How are you?</greeting>
    <greeting type="reply">I am good.</greeting>
    <color>
        <blue>flower</blue>
        <blue>sand stone</blue>
        <light-blue>sky</light-blue>
        <light-blue>water</light-blue>
    </color>
</doc>

$ perl -MXML::LibXML -E '$ip = XML::LibXML->load_xml(location => $ARGV[0]);
     say $_->to_literal() for $ip->findnodes("//blue")' sample.xml
flower
sand stone
```

**d)** Display current time in the format shown below.

```bash
$ # output will be different for you
$ # you can use %F to get YYYY-MM-DD format
$ perl -MTime::Piece -E 'say localtime->strftime("%e-%b-%Y %T")'
29-Oct-2020 14:23:17
```

>![info](../images/info.svg) See [metacpan: DateTime](https://metacpan.org/pod/DateTime) for more comprehensive functions.

<br>

# Multiple file input

**a)** Print the last field of first two lines for the input files passed as arguments to the `perl` script. Assume space as the field separators for these two files. To make the output more informative, print filenames and a separator as shown in the output below. Assume input files will have at least two lines.

```bash
$ # assume table.txt ip.txt are passed as file inputs
$ perl -lane 'print ">$ARGV<" if $.==1; print "$F[-1]";
              if($.==2){print "----------"; close ARGV}
             ' table.txt ip.txt
>table.txt<
42
-7
----------
>ip.txt<
World
you
----------
```

**b)** For the given list of input files, display all filenames that contain `at` or `fun` in the third field in any of the input lines. Assume space as the field separator.

```bash
$ # assume sample.txt secrets.txt ip.txt table.txt are passed as file inputs
$ perl -anE 'if($F[2]=~/at|fun/){say $ARGV; close ARGV}
            ' sample.txt secrets.txt ip.txt table.txt
secrets.txt
ip.txt
table.txt
```

**c)** Print the first two lines for each of the input files `ip.txt`, `sample.txt` and `table.txt`. Also, add a separator between the results as shown below (note that the separator isn't present at the end of the output). Assume input files will have at least two lines.

```bash
$ perl -pe 'print $s if $.==1; if($.==2){close ARGV; $s="---\n"}
           ' ip.txt sample.txt table.txt
Hello World
How are you
---
Hello World

---
brown bread mat hair 42
blue cake mug shirt -7
```

<br>

# Processing multiple records

**a)** For the input file `sample.txt`, print a matching line containing `do` only if the previous line is empty and the line before that contains `you`.

```bash
$ perl -ne 'print if /do/ && $p1 eq "\n" && $p2=~/you/; $p2=$p1; $p1=$_' sample.txt
Just do-it
Much ado about nothing
```

**b)** Print only the second matching line respectively for the search terms `do` and `not` for the input file `sample.txt`. Match these terms case insensitively.

```bash
$ # for reference, here's all the matches
$ grep -i 'do' sample.txt
Just do-it
No doubt you like it too
Much ado about nothing
$ grep -i 'not' sample.txt
Not a bit funny
Much ado about nothing

$ perl -ne 'print if /do/i && ++$do==2;
            print if /not/i && ++$not==2;' sample.txt
No doubt you like it too
Much ado about nothing
```

**c)** For the input file `sample.txt`, print matching line as well as `n` lines around the matching lines. The value for `n` is passed to the `perl` command as an environment value.

```bash
$ # match a line containing 'are' or 'bit'
$ n=1 perl -e '@ip=<>; for(0..$#ip){$i=$_-$ENV{n}; $i=0 if $i<0;
               print @ip[$i..$_+$ENV{n}] if $ip[$_]=~/are|bit/}' sample.txt
Good day
How are you

Today is sunny
Not a bit funny
No doubt you like it too

$ # match a line containing 'World'
$ n=2 perl -e '@ip=<>; for (0..$#ip){$i=$_-$ENV{n}; $i=0 if $i<0;
                print @ip[$i..$_+$ENV{n}] if $ip[$_]=~/World/}' sample.txt
Hello World

Good day
```

**d)** For the input file `broken.txt`, print all lines between the markers `top` and `bottom`. The first `perl` command shown below doesn't work because it is matching till end of file if second marker isn't found. Assume that the input file cannot have two `top` markers without a `bottom` marker appearing in between and vice-versa.

```bash
$ cat broken.txt
top
3.14
bottom
---
top
1234567890
bottom
top
Hi there
Have a nice day
Good bye

$ # wrong output
$ perl -ne '$f=0 if /bottom/; print if $f; $f=1 if /top/' broken.txt
3.14
1234567890
Hi there
Have a nice day
Good bye

$ # expected output
$ tac broken.txt | perl -ne '$f=0 if /top/; print if $f; $f=1 if /bottom/' | tac
3.14
1234567890
```

**e)** For the input file `concat.txt`, extract contents from a line starting with ``%%% `` until but not including the next such line. The block to be extracted is indicated by variable `n` passed as an environment value.

```bash
$ cat concat.txt
%%% addr.txt
How are you
This game is good
Today %%% is sunny
%%% broken.txt
top %%%
1234567890
bottom
%%% sample.txt
Just %%% do-it
Believe it
%%% mixed_fs.txt
pink blue white yellow
car,mat,ball,basket

$ n=2 perl -ne '$c++ if /^%%% /; print if $c==$ENV{n}' concat.txt
%%% broken.txt
top %%%
1234567890
bottom

$ n=4 perl -ne '$c++ if /^%%% /; print if $c==$ENV{n}' concat.txt
%%% mixed_fs.txt
pink blue white yellow
car,mat,ball,basket
```

**f)** For the input file `perl.md`, replace all occurrences of `perl` (irrespective of case) with `Perl`. But, do not replace any matches between ` ```perl ` and ` ``` ` lines (`perl` in these markers shouldn't be replaced either).

```bash
$ perl -pe '$f=1 if /^```perl$/; s/perl/Perl/gi if !$f;
            $f=0 if /^```$/' perl.md > out.md

$ diff -sq out.md expected.md 
Files out.md and expected.md are identical
```

**g)** Print the last two lines for each of the input files `ip.txt`, `sample.txt` and `table.txt`. Also, add a separator between the results as shown below (note that the separator isn't present at the end of the output). Assume input files will have at least two lines.

```bash
$ perl -ne 'if(eof){print $s,$p,$_; $s="---\n"}; $p=$_' ip.txt sample.txt table.txt
12345
You are funny
---
Much ado about nothing
He he he
---
blue cake mug shirt -7
yellow banana window shoes 3.14
```

<br>

# Two file processing

**a)** Use contents of `match_words.txt` file to display matching lines from `jumbled.txt` and `sample.txt`. The matching criteria is that the second word of lines from these files should match the third word of lines from `match_words.txt`.

```bash
$ cat match_words.txt
%whole(Hello)--{doubt}==ado==
just,\joint*,concession<=nice

$ # 'concession' is one of the third words from 'match_words.txt'
$ # and second word from 'jumbled.txt'
$ perl -ne '@w=/\w++/g; $#ARGV==1 ? $h{$w[2]}=1 :
            exists $h{$w[1]} && print
           ' match_words.txt jumbled.txt sample.txt
wavering:concession/woof\retailer
No doubt you like it too
```

**b)** Interleave contents of `secrets.txt` with the contents of a file passed as `stdin` in the format as shown below.

```bash
$ perl -ne 'print $s, $_, scalar <STDIN>; $s="---\n"' secrets.txt <table.txt
stag area row tick
brown bread mat hair 42
---
deaf chi rate tall glad
blue cake mug shirt -7
---
Bi tac toe - 42
yellow banana window shoes 3.14
```

**c)** The file `search_terms.txt` contains one search string per line (these have no regexp metacharacters). Construct a solution that reads this file and displays search terms (matched case insensitively) that were found in all of the other input file arguments. Note that these terms should be matched with any part of the line, not just whole words.

```bash
$ cat search_terms.txt
hello
row
you
is
at

$ # ip: search_terms.txt jumbled.txt mixed_fs.txt secrets.txt table.txt oops.txt
$ perl -lne 'BEGIN{$c = $#ARGV-1} if($#ARGV == $c){ $s{$_}=1; next }
             for $k (keys %s) { $m{$k}=1 if /$k/i }
             if(eof){ !exists $m{$_} && delete $s{$_} for keys %s; %m=undef }
             END{ print for (keys %s) }
            ' search_terms.txt jumbled.txt mixed_fs.txt secrets.txt table.txt oops.txt
row
at

$ # ip: search_terms.txt ip.txt sample.txt oops.txt
$ perl -lne 'BEGIN{$c = $#ARGV-1} if($#ARGV == $c){ $s{$_}=1; next }
             for $k (keys %s) { $m{$k}=1 if /$k/i }
             if(eof){ !exists $m{$_} && delete $s{$_} for keys %s; %m=undef }
             END{ print for (keys %s) }
            ' search_terms.txt ip.txt sample.txt oops.txt
hello
you
is
```

**d)** Replace third to fifth lines of input file `ip.txt` with second to fourth lines from file `para.txt`

```bash
$ perl -ne 'print if 2..4' para.txt | perl -pe '$_="" if 3..5; print <STDIN> if $.==3' ip.txt
Hello World
How are you
Start working on that
project you always wanted
to, do not let it end
You are funny
```

**e)** Insert one line from `jumbled.txt` before every two lines of `copyright.txt`

```bash
$ perl -pe 'print scalar <STDIN> if $. % 2' <jumbled.txt copyright.txt
overcoats;furrowing-typeface%pewter##hobby
bla bla 2015 bla
blah 2018 blah
wavering:concession/woof\retailer
bla bla bla
copyright: 2020
```

**f)** Use entire contents of `match.txt` to search `error.txt` and replace with contents of `jumbled.txt`. Partial lines should NOT be matched.

```bash
$ cat match.txt
print this
but not that
$ cat error.txt
print this
but not that or this
print this
but not that
if print this
but not that
print this
but not that

$ perl -0777 -ne '$#ARGV==1 ? $s=$_ : $#ARGV==0 ? $r=$_ :
                  print s/^\Q$s/$r/gmr' match.txt jumbled.txt error.txt
print this
but not that or this
overcoats;furrowing-typeface%pewter##hobby
wavering:concession/woof\retailer
if print this
but not that
overcoats;furrowing-typeface%pewter##hobby
wavering:concession/woof\retailer
```

<br>

# Dealing with duplicates

**a)** Retain only first copy of a line for the input file `lines.txt`. Case should be ignored while comparing lines. For example `hi there` and `HI TheRE` will be considered as duplicates.

```bash
$ cat lines.txt
Go There
come on
go there
---
2 apples and 5 mangoes
come on!
---
2 Apples
COME ON

$ perl -ne 'print if !$h{lc $_}++' lines.txt
Go There
come on
---
2 apples and 5 mangoes
come on!
2 Apples
```

**b)** Retain only first copy of a line for the input file `twos.txt`. Assume space as field separator with two fields on each line. Compare the lines irrespective of order of the fields. For example, `hehe haha` and `haha hehe` will be considered as duplicates.

```bash
$ cat twos.txt
hehe haha
door floor
haha hehe
6;8 3-4
true blue
hehe bebe
floor door
3-4 6;8
tru eblue
haha hehe

$ # can also use: perl -ane 'print if !$h{join " ", sort @F}++' twos.txt
$ perl -lane 'print if !$h{$F[0] le $F[1] ? $_ : "$F[1] $F[0]"}++' twos.txt
hehe haha
door floor
6;8 3-4
true blue
hehe bebe
tru eblue
```

**c)** For the input file `twos.txt`, display only unique lines. Assume space as field separator with two fields on each line. Compare the lines irrespective of order of the fields. For example, `hehe haha` and `haha hehe` will be considered as duplicates.

```bash
$ perl -ane '$k = join " ", sort @F;
             !$#ARGV ? !$h{$k}++ : $h{$k}==1 && print' twos.txt twos.txt
true blue
hehe bebe
tru eblue
```

<br>

# Perl rename command

**a)** Determine and implement the rename logic based on the filenames and expected output shown below.

```bash
$ touch ' (2020) Report part 1 . txt ' 'analysis Part 3 (2018) .log'

$ rename 's/^\h+|\h+$|[()]//g; s/\h*\.\h*/./g; s/\s+/_/g; s/.+/\L$&/' *

$ ls
2020_report_part_1.txt  analysis_part_3_2018.log
```

**b)** See [unix.stackexchange: rename Q&A sorted by votes](https://unix.stackexchange.com/questions/tagged/rename?tab=Votes) for further reading as well as a source for exercises.

