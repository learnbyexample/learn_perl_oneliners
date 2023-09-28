# Exercise solutions

<br>

# One-liner introduction

**1)** For the input file `ip.txt`, display all lines containing `is`.

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

**2)** For the input file `ip.txt`, display the first field of lines *not* containing `y`. Consider space as the field separator for this file.

```bash
$ perl -anE 'say $F[0] if !/y/' ip.txt
Hello
This
12345
```

**3)** For the input file `ip.txt`, display all lines containing no more than 2 fields.

```bash
$ perl -ane 'print if $#F < 2' ip.txt
Hello World
12345
```

**4)** For the input file `ip.txt`, display all lines containing `is` in the second field.

```bash
$ perl -ane 'print if $F[1] =~ /is/' ip.txt
Today is sunny
```

**5)** For each line of the input file `ip.txt`, replace the first occurrence of `o` with `0`.

```bash
$ perl -pe 's/o/0/' ip.txt
Hell0 World
H0w are you
This game is g0od
T0day is sunny
12345
Y0u are funny
```

**6)** For the input file `table.txt`, calculate and display the product of numbers in the last field of each line. Consider space as the field separator for this file.

```bash
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14

$ perl -anE 'BEGIN{$p=1} $p *= $F[-1]; END{say $p}' table.txt
-923.16
```

**7)** Append `.` to all the input lines for the given stdin data.

```bash
# can also use: perl -lne 'print "$_."'
$ printf 'last\nappend\nstop\ntail\n' | perl -pe 's/$/./'
last.
append.
stop.
tail.
```

**8)** Use the contents of the `s` variable to display all matching lines from the input file `ip.txt`. Assume that `s` doesn't have any regexp metacharacters. Construct the solution such that there's at least one word character immediately preceding the contents of the `s` variable.

```bash
$ s='is'

$ r="$s" perl -ne 'print if /\B$ENV{r}/' ip.txt
This game is good
```

**9)** Use `system` to display the contents of the filename present in the second field of the given input line. Consider space as the field separator.

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

**1)** For the given input, display except the third line.

```bash
$ seq 34 37 | perl -ne 'print if $. != 3'
34
35
37
```

**2)** Display only the fourth, fifth, sixth and seventh lines for the given input.

```bash
$ seq 65 78 | perl -ne 'print if 4..7'
68
69
70
71
```

**3)** For the input file `ip.txt`, replace all occurrences of `are` with `are not` and `is` with `is not` only from line number **4** till the end of file. Also, only the lines that were changed should be displayed in the output.

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

**4)** For the given stdin, display only the first three lines. Avoid processing lines that are not relevant.

```bash
$ seq 14 25 | perl -pe 'exit if $. > 3'
14
15
16
```

**5)** For the input file `ip.txt`, display all lines from the start of the file till the first occurrence of `game`.

```bash
$ perl -ne 'print; exit if /game/' ip.txt
Hello World
How are you
This game is good
```

**6)** For the input file `ip.txt`, display all lines that contain `is` but not `good`.

```bash
$ perl -ne 'print if /is/ && !/good/' ip.txt
Today is sunny
```

**7)** For the input file `ip.txt`, extract the word before the whole word `is` as well as the word after it. If such a match is found, display the two words around `is` in reversed order. For example, `hi;1 is--234 bye` should be converted to `234:1`. Assume that the whole word `is` will not be present more than once in a single line.

```bash
# can also use: perl -ne 'print if s/.*?(\w+)\W+is\W+(\w+).*/$2:$1/' ip.txt
$ perl -nE 'say "$2:$1" if /(\w+)\W+is\W+(\w+)/' ip.txt
good:game
sunny:Today
```

**8)** For the input file `hex.txt`, replace all occurrences of `0xA0` with `0x50` and `0xFF` with `0x7F`.

```bash
$ cat hex.txt
start: 0xA0, func1: 0xA0
end: 0xFF, func2: 0xB0
restart: 0xA010, func3: 0x7F

$ perl -pe 's/0xA0/0x50/g; s/0xFF/0x7F/g' hex.txt
start: 0x50, func1: 0x50
end: 0x7F, func2: 0xB0
restart: 0x5010, func3: 0x7F
```

**9)** Find the starting index of the first occurrence of `is` or `the` or `was` or `to` for each input line of the file `idx.txt`. Assume that every input line will match at least one of these terms.

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

**10)** Display all lines containing `[4]*` for the given stdin data.

```bash
# can also use: perl -ne 'print if /\Q[4]*/'
$ printf '2.3/[4]*6\n2[4]5\n5.3-[4]*9\n' | perl -ne 'print if index($_, "[4]*") != -1'
2.3/[4]*6
5.3-[4]*9
```

**11)** For the given input string, replace all lowercase alphabets to `x` only for words starting with `m`.

```bash
$ s='ma2T3a a2p kite e2e3m meet'
$ echo "$s" | perl -pe 's/\bm\w+/$&=~tr|a-z|x|r/ge'
xx2T3x a2p kite e2e3m xxxx
```

**12)** For the input file `ip.txt`, delete all characters other than lowercase vowels and the newline character. Perform this transformation only between a line containing `you` up to line number `4` (inclusive).

```bash
# can also use: perl -pe 'tr/aeiou\n//cd if /you/ .. 4' ip.txt
$ perl -lpe 'tr/aeiou//cd if /you/ .. 4' ip.txt
Hello World
oaeou
iaeioo
oaiu
12345
You are funny
```

**13)** For the input file `sample.txt`, display from the start of the file till the first occurrence of `are`, excluding the matching line.

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

$ perl -pe 'exit if /are/' sample.txt
Hello World

Good day
```

**14)** For the input file `sample.txt`, display from the last occurrence of `do` till the end of the file.

```bash
$ tac sample.txt | perl -ne 'print; exit if /do/' | tac
Much ado about nothing
He he he
```

**15)** For the input file `sample.txt`, display from the 9th line till a line containing `you`.

```bash
$ perl -ne 'print if 9 .. /you/' sample.txt
Today is sunny
Not a bit funny
No doubt you like it too
```

**16)** Display only the odd numbered lines from `ip.txt`.

```bash
$ perl -ne 'print if $.%2' ip.txt
Hello World
This game is good
12345
```

**17)** For the `table.txt` file, print only the line number for lines containing `air` or `win`.

```bash
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14

$ perl -nE 'say $. if /air|win/' table.txt
1
3
```

**18)** For the input file `table.txt`, calculate the sum of numbers in the last column, excluding the second line.

```bash
$ perl -anE '$total += $F[-1] if $.!=2; END{say $total}' table.txt
45.14
```

**19)** Print the second and fourth line for every block of five lines.

```bash
# can also use: seq 15 | perl -ne 'BEGIN{$h{2}=$h{4}=1} print if $h{$.%5}'
$ seq 15 | perl -ne 'print if $.%5 == 2 || $.%5 == 4'
2
4
7
9
12
14
```

**20)** For the input file `ip.txt`, display all lines containing `e` or `u` but not both.

```bash
$ perl -ne 'print if /e/ xor /u/' ip.txt
Hello World
This game is good
Today is sunny
```

<br>

# In-place file editing

**1)** For the input file `text.txt`, replace all occurrences of `in` with `an` and write back the changes to `text.txt` itself. The original contents should get saved to `text.txt.orig`

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

**2)** For the input file `text.txt`, replace all occurrences of `an` with `in` and write back the changes to `text.txt` itself. Do not create backups for this exercise. Note that you should have solved the previous exercise before starting this one.

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

**3)** For the input file `copyright.txt`, replace `copyright: 2018` with `copyright: 2020` and write back the changes to `copyright.txt` itself. The original contents should get saved to `2018_copyright.txt.bkp`

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

**4)** In the code sample shown below, two files are created by redirecting the output of the `echo` command. Then a Perl command is used to edit `b1.txt` in-place as well as create a backup named `bkp.b1.txt`. Will the Perl command work as expected? If not, why?

```bash
$ echo '2 apples' > b1.txt
$ echo '5 bananas' > -ibkp.txt
$ perl -ibkp.* -pe 's/2/two/' b1.txt
```

Unquoted strings on the command line are subjected to shell interpretation. So, `-ibkp.*` will get expanded as `-ibkp.txt` (as there exists a file whose name starts with `-ibkp.`). This results in back up filename as `b1.txtbkp.txt` (because `bkp.txt` will be treated as the suffix to be added to `b1.txt`). The correct usage is `perl -i'bkp.*' -pe 's/2/two/' b1.txt` to get `bkp.b1.txt` as the back up filename.

**5)** For the input file `pets.txt`, remove the first occurrence of `I like ` from each line and write back the changes to `pets.txt` itself. The original contents should get saved with the same filename inside the `bkp` directory. Assume that you do not know whether `bkp` exists or not in the current working directory.

```bash
$ cat pets.txt
I like cats
I like parrots
I like dogs

$ mkdir -p bkp
$ perl -i'bkp/*' -pe 's/I like //' pets.txt

$ cat pets.txt
cats
parrots
dogs
$ cat bkp/pets.txt
I like cats
I like parrots
I like dogs
```

<br>

# Field separators

**1)** For the input file `brackets.txt`, extract only the contents between `()` or `)(` from each input line. Assume that `()` characters will be present only once every line.

```bash
$ cat brackets.txt
foo blah blah(ice) 123 xyz$ 
(almond-pista) choco
yo )yoyo( yo

# can also use: perl -nE 'say /[()]([^()]+)[()]/' brackets.txt
$ perl -F'[()]' -nE 'say $F[1]' brackets.txt
ice
almond-pista
yoyo
```

**2)** For the input file `scores.csv`, extract `Name` and `Physics` fields in the format shown below.

```bash
$ cat scores.csv
Name,Maths,Physics,Chemistry
Blue,67,46,99
Lin,78,83,80
Er,56,79,92
Cy,97,98,95
Ort,68,72,66
Ith,100,100,100

# can also use: perl -F, -lane 'print join ":", @F[0,2]' scores.csv
$ perl -F, -lane 'print "$F[0]:$F[2]"' scores.csv
Name:Physics
Blue:46
Lin:83
Er:79
Cy:98
Ort:72
Ith:100
```

**3)** For the input file `scores.csv`, display names of those who've scored above `80` in Maths.

```bash
$ perl -F, -lane 'print $F[0] if $F[1]>80' scores.csv
Cy
Ith
```

**4)** Display the number of word characters for the given inputs. Word definition here is same as used in regular expressions. Can you construct two different solutions as indicated below?

```bash
# solve using the 's' operator
$ echo 'hi there' | perl -nE 'say s/\w//g'
7

# solve without using the substitution or transliteration operators
$ echo 'u-no;co%."(do_12:as' | perl -F'\w' -anE 'say $#F'
12
```

**Note** that the first solution will print an empty string for lines not containing any word character, while the second one will print `0`. You can use `s/\w//g + 0` cover such corner cases.

**5)** For the input file `quoted.txt`, extract the sequence of characters surrounded by double quotes and display them in the format shown below.

```bash
$ cat quoted.txt
1 "grape" and "mango" and "guava"
("c 1""d""a-2""b")

$ perl -nE 'say join ",", sort /"[^"]+"/g' quoted.txt
"grape","guava","mango"
"a-2","b","c 1","d"
```

**6)** Display only the third and fifth characters from each input line as shown below.

```bash
$ printf 'restore\ncat one\ncricket' | perl -F -anE 'say @F[2,4]'
so
to
ik
```

**7)** Transform the given input file `fw.txt` to get the output as shown below. If a field is empty (i.e. contains only space characters), replace it with `NA`.

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

**8)** For the input file `scores.csv`, display the header as well as any row which contains `b` or `t` (irrespective of case) in the first field.

```bash
$ perl -F, -ane 'print if $F[0]=~/[bt]/i || $.==1' scores.csv
Name,Maths,Physics,Chemistry
Blue,67,46,99
Ort,68,72,66
Ith,100,100,100
```

**9)** Extract all whole words containing `42` but not at the edge of a word. Assume a word cannot contain `42` more than once.

```bash
$ s='hi42bye nice1423 bad42 cool_42a 42fake'
$ echo "$s" | perl -nE 'say join "\n", /\w+42\w+/g'
hi42bye
nice1423
cool_42a
```

**10)** For the input file `scores.csv`, add another column named **GP** which is calculated out of 100 by giving 50% weightage to Maths and 25% each for Physics and Chemistry.

```bash
$ perl -F, -lane 'print join ",", @F, $.==1 ? "GP" :
                        $F[1]/2 + ($F[2]+$F[3])/4' scores.csv
Name,Maths,Physics,Chemistry,GP
Blue,67,46,99,69.75
Lin,78,83,80,79.75
Er,56,79,92,70.75
Cy,97,98,95,96.75
Ort,68,72,66,68.5
Ith,100,100,100,100
```

**11)** For the input file `mixed_fs.txt`, retain only the first two fields from each input line. The input and output field separators should be space for first two lines and `,` for the rest of the lines.

```bash
$ cat mixed_fs.txt
rose lily jasmine tulip
pink blue white yellow
car,mat,ball,basket
light green,brown,black,purple
apple,banana,cherry

$ perl -lne '$s = $.<3 ? " " : ",";
             print join $s, (split $s)[0,1]' mixed_fs.txt
rose lily
pink blue
car,mat
light green,brown
apple,banana
```

**12)** For the given space separated numbers, filter only numbers in the range `20` to `1000` (inclusive).

```bash
$ s='20 -983 5 756 634223 1000'

$ echo "$s" | perl -lane 'print join " ", grep {$_>=20 && $_<=1000} @F'
20 756 1000
```

**13)** For the given input file `words.txt`, filter all lines containing characters in ascending and descending order.

```bash
$ cat words.txt
bot
art
are
boat
toe
flee
reed

# ascending order
$ perl -F -lane 'print if $_ eq join "", sort @F' words.txt
bot
art

# descending order
$ perl -F -lane 'print if $_ eq join "", reverse sort @F' words.txt
toe
reed
```

**14)** For the given space separated words, extract the three longest words.

```bash
$ s='I bought two bananas and three mangoes'

$ echo "$s" | perl -anE 'say join "\n", (sort {length($b) <=> length($a)} @F)[0..2]'
bananas
mangoes
bought
```

**15)** Convert the contents of `split.txt` as shown below.

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

**16)** Generate string combinations as shown below for the given input string passed as an environment variable.

```bash
$ s='{x,y,z}{1,2,3}' perl -E 'say join " ", glob $ENV{s}'
x1 x2 x3 y1 y2 y3 z1 z2 z3
```

**17)** For the input file `varying_fields.txt`, construct a solution to get the output shown below.

```bash
$ cat varying_fields.txt
hi,bye,there,was,here,to
1,2,3,4,5

$ perl -F, -lane 'print join ":", @F[0,1,-1]' varying_fields.txt
hi:bye:to
1:2:5
```

**18)** The `fields.txt` file has fields separated by the `:` character. Delete `:` and the last field if there is a digit character anywhere before the last field. Solution shouldn't use the `s` operator.

```bash
$ cat fields.txt
42:cat
twelve:a2b
we:be:he:0:a:b:bother
apple:banana-42:cherry:
dragon:unicorn:centaur

$ perl -F'/:/,$_,-1' -lane '$#F-- if /\d.*:/; print join ":", @F' fields.txt
42
twelve:a2b
we:be:he:0:a:b
apple:banana-42:cherry
dragon:unicorn:centaur
```

**19)** The sample string shown below uses `cat` as the field separator (irrespective of case). Use space as the output field separator and add `42` as the last field.

```bash
$ s='applecatfigCaT12345cAtbanana'
# can also use: perl -F'(?i)cat' -lane 'print join " ", @F, "42"'
$ echo "$s" | perl -F'(?i)cat' -lane 'print "@F 42"'
apple fig 12345 banana 42
```

**20)** For the input file `sample.txt`, filter lines containing 5 or more lowercase vowels.

```bash
# can also use: perl -ne 'print if /([aeiou][^aeiou]*+){5}/' sample.txt
$ perl -F'[aeiou]' -ane 'print if $#F>=5' sample.txt
How are you
Believe it
No doubt you like it too
Much ado about nothing
```

<br>

# Record separators

**1)** The input file `jumbled.txt` consists of words separated by various delimiters. Display all words that contain `an` or `at` or `in` or `it`, one per line.

```bash
$ cat jumbled.txt
overcoats;furrowing-typeface%pewter##hobby
wavering:concession/woof\retailer
joint[]seer{intuition}titanic

$ perl -0777 -nE 'say join "\n", /\w*[ai][nt]\w*/g' jumbled.txt
overcoats
furrowing
wavering
joint
intuition
titanic
```

**2)** Emulate `paste -sd,` with Perl.

```bash
# this command joins all input lines with the ',' character
$ paste -sd, ip.txt
Hello World,How are you,This game is good,Today is sunny,12345,You are funny
# make sure there's no ',' at the end of the line
# and that there's a newline character at the end of the line
$ perl -lpe '$\ = eof ? "\n" : ","' ip.txt
Hello World,How are you,This game is good,Today is sunny,12345,You are funny

# if there's only one line in input, again make sure there's no trailing ','
# and that there's a newline character at the end of the line
$ printf 'fig' | paste -sd,
fig
$ printf 'fig' | perl -lpe '$\ = eof ? "\n" : ","'
fig
```

**3)** For the input file `sample.txt`, extract all paragraphs having words starting with `do`.

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

# note that there's no extra empty line at the end of the output
$ perl -00 -lnE 'if(/\bdo/){say $s, $_; $s="\n"}' sample.txt
Just do-it
Believe it

Today is sunny
Not a bit funny
No doubt you like it too
```

**4)** For the input file `sample.txt`, change each paragraph to a single line by joining lines using `.` and a space character as the separator. Also, add a final `.` to each paragraph.

```bash
# note that there's no extra empty line at the end of the output
$ perl -F'\n' -00 -lane '$\ = eof ? ".\n" : ".\n\n"; print join ". ", @F' sample.txt
Hello World.

Good day. How are you.

Just do-it. Believe it.

Today is sunny. Not a bit funny. No doubt you like it too.

Much ado about nothing. He he he.
```

**5)** For the given input, use `;;` as the record separators and `:` as the field separators. Filter records whose second field is greater than `50`.

```bash
$ s='mango:100;;apple:25;;grapes:75'

# note that the output has ;; at the end, not a newline character
$ printf "$s" | perl -F: -lane 'BEGIN{$/=$\=";;"} print if $F[1]>50'
mango:100;;grapes:75;; 
```

**6)** The input file `f1.txt` has varying amount of empty lines between the records, change them to be always two empty lines. Also, remove the empty lines at the start and end of the file.

```bash
$ perl -l -00 -ne 'print $s, $_; $s="\n\n"' f1.txt
hello


world


apple
banana
cherry


tea coffee
chocolate
```

**7)** The sample string shown below uses `cat` as the record separator. Display only the even numbered records separated by a single empty line.

```bash
$ s='applecatfigcat12345catbananacatguava:cat:mangocat3'
$ echo "$s" | perl -lne 'BEGIN{$/ = "cat"} if($.%2==0){print $s, $_; $s="\n"}'
fig

banana

:mango
```

<br>

# Using modules

**1)** For the given space separated words, display the max word determined by alphabetic order.

```bash
$ s='let in bat xml me lion'

$ echo "$s" | perl -lane 'print ((sort @F)[-1])'
xml
```

**2)** For the given space separated words, randomize the order of characters for each word.

```bash
$ s='this is a sample sentence'

# sample randomized output shown here, could be different for you
$ echo "$s" | perl -MList::Util=shuffle -lane '
              print join " ", map {join "", shuffle split//} @F'
htis si a melasp ecnnsete
```

**3)** Use the [metacpan: XML::LibXML](https://metacpan.org/pod/XML::LibXML) module to get the content of all tags named `blue` for the input file `sample.xml`. See [grantm: Perl XML::LibXML by example](https://grantm.github.io/perl-libxml-by-example/) for a detailed book on the `XML::LibXML` module.

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

**4)** Display the current time in the format shown below.

```bash
# output will be different for you
# you can use %F to get YYYY-MM-DD format
$ perl -MTime::Piece -E 'say localtime->strftime("%e-%b-%Y %T")'
12-Sep-2023 11:01:14
```

>![info](../images/info.svg) See [metacpan: DateTime](https://metacpan.org/pod/DateTime) for more comprehensive functions.

<br>

# Multiple file input

**1)** Print the last field of first two lines for the input files `table.txt` and `ip.txt`. Assume space as the field separators for these two files. To make the output more informative, print filenames and a separator as shown in the output below. Assume that the input files will have at least two lines.

```bash
# assume table.txt ip.txt are passed as file inputs
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

**2)** For the input files `sample.txt`, `secrets.txt`, `ip.txt` and `table.txt`, display only the names of files that contain `at` or `fun` in the third field. Assume space as the field separator.

```bash
$ perl -anE 'if($F[2]=~/at|fun/){say $ARGV; close ARGV}
            ' sample.txt secrets.txt ip.txt table.txt
secrets.txt
ip.txt
table.txt
```

**3)** Print the first two lines for each of the input files `ip.txt`, `sample.txt` and `table.txt`. Also, add a separator between the results as shown below (note that the separator isn't present at the end of the output). Assume that the input files will have at least two lines.

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

**4)** Print only the second field of the third line, if any, from these input files: `ip.txt`, `sample.txt` and `copyright.txt`. Consider space as the field separator.

```bash
$ perl -lane 'print $F[1] if $.==3; close ARGV if eof' ip.txt sample.txt copyright.txt
game
day
bla
```

<br>

# Processing multiple records

**1)** For the input file `sample.txt`, print lines containing `do` only if the previous line is empty and the line before that contains `you`.

```bash
$ perl -ne 'print if /do/ && $p1 eq "\n" && $p2=~/you/; $p2=$p1; $p1=$_' sample.txt
Just do-it
Much ado about nothing
```

**2)** For the input file `sample.txt`, match lines containing `do` or `not` case insensitively. Each of these terms occur multiple times in the file. The goal is to print only the second occurrences of these terms (independent of each other).

```bash
# for reference, here are all the matches
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

**3)** For the input file `sample.txt`, print the matching line as well as `n` lines around the matching lines. The value for `n` is passed to the Perl command as an environment value.

```bash
# match a line containing 'are' or 'bit'
$ n=1 perl -e '@ip=<>; for(0..$#ip){$i=$_-$ENV{n}; $i=0 if $i<0;
               print @ip[$i..$_+$ENV{n}] if $ip[$_]=~/are|bit/}' sample.txt
Good day
How are you

Today is sunny
Not a bit funny
No doubt you like it too

# match a line containing 'World'
$ n=2 perl -e '@ip=<>; for (0..$#ip){$i=$_-$ENV{n}; $i=0 if $i<0;
                print @ip[$i..$_+$ENV{n}] if $ip[$_]=~/World/}' sample.txt
Hello World

Good day
```

**4)** For the input file `broken.txt`, print all lines between the markers `top` and `bottom`. The first Perl command shown below doesn't work because it is matching till the end of file as the second marker isn't found. Assume that the input file cannot have two `top` markers without a `bottom` marker appearing in between and vice-versa.

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

# wrong output
$ perl -ne '$f=0 if /bottom/; print if $f; $f=1 if /top/' broken.txt
3.14
1234567890
Hi there
Have a nice day
Good bye

# expected output
$ tac broken.txt | perl -ne '$f=0 if /top/; print if $f; $f=1 if /bottom/' | tac
3.14
1234567890
```

**5)** For the input file `concat.txt`, extract contents from a line starting with ``%%% `` until but not including the next such line. The block to be extracted is indicated by the variable `n` passed as an environment value.

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

**6)** For the input file `perl.md`, replace all occurrences of `perl` (irrespective of case) with `Perl`. But, do not replace any matches between ` ```perl ` and ` ``` ` lines (`perl` in these markers shouldn't be replaced either). Save the output in `out.md`.

```bash
$ perl -pe '$f=1 if /^```perl$/; s/perl/Perl/gi if !$f;
            $f=0 if /^```$/' perl.md > out.md

$ diff -sq out.md expected.md 
Files out.md and expected.md are identical
```

**7)** Print the last two lines for each of the input files `ip.txt`, `sample.txt` and `table.txt`. Also, add a separator between the results as shown below (note that the separator isn't present at the end of the output). Assume that the input files will have at least two lines.

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

**8)** For the input file `lines.txt`, delete the line that comes after a whole line containing `---`. Assume that such lines won't occur consecutively.

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

$ perl -ne 'print if $p ne "---\n"; $p=$_' lines.txt
Go There
come on
go there
---
come on!
---
COME ON
```

**9)** For the input file `result.csv`, use `---` to separate entries with the same name in the first column. Assume that the lines with the same first column value will always be next to each other.

```bash
$ cat result.csv
Amy,maths,89
Amy,physics,75
Joe,maths,79
John,chemistry,77
John,physics,91
Moe,maths,81
Ravi,physics,84
Ravi,chemistry,70
Yui,maths,92

$ perl -F, -lape 'print "---" if $.>1 && $p ne $F[0]; $p=$F[0]' result.csv
Amy,maths,89
Amy,physics,75
---
Joe,maths,79
---
John,chemistry,77
John,physics,91
---
Moe,maths,81
---
Ravi,physics,84
Ravi,chemistry,70
---
Yui,maths,92
```

<br>

# Two file processing

**1)** Use the contents of `match_words.txt` file to display matching lines from `jumbled.txt` and `sample.txt`. The matching criteria is that the second word of lines from these files should match the third word of lines from `match_words.txt`.

```bash
$ cat match_words.txt
%whole(Hello)--{doubt}==ado==
just,\joint*,concession<=nice

# 'concession' is one of the third words from 'match_words.txt'
# and second word from 'jumbled.txt'
$ perl -ne '@w=/\w++/g; $#ARGV==1 ? $h{$w[2]}=1 :
            exists $h{$w[1]} && print
           ' match_words.txt jumbled.txt sample.txt
wavering:concession/woof\retailer
No doubt you like it too
```

**2)** Interleave the contents of `secrets.txt` with the contents of a file passed as stdin in the format as shown below.

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

**3)** The file `search_terms.txt` contains one search string per line, and these terms have no regexp metacharacters. Construct a solution that reads this file and displays the search terms (matched case insensitively) that were found in every file passed as the arguments after `search_terms.txt`. Note that these terms should be matched anywhere in the line (so, don't use word boundaries).

```bash
$ cat search_terms.txt
hello
row
you
is
at

# ip: search_terms.txt jumbled.txt mixed_fs.txt secrets.txt table.txt oops.txt
$ perl -lne 'BEGIN{$c = $#ARGV-1} if($#ARGV == $c){ $s{$_}=1; next }
             for $k (keys %s) { $m{$k}=1 if /$k/i }
             if(eof){ !exists $m{$_} && delete $s{$_} for keys %s; %m=undef }
             END{ print for (keys %s) }
            ' search_terms.txt jumbled.txt mixed_fs.txt secrets.txt table.txt oops.txt
row
at

# ip: search_terms.txt ip.txt sample.txt oops.txt
$ perl -lne 'BEGIN{$c = $#ARGV-1} if($#ARGV == $c){ $s{$_}=1; next }
             for $k (keys %s) { $m{$k}=1 if /$k/i }
             if(eof){ !exists $m{$_} && delete $s{$_} for keys %s; %m=undef }
             END{ print for (keys %s) }
            ' search_terms.txt ip.txt sample.txt oops.txt
hello
you
is
```

**4)** Replace the third to fifth lines of the input file `ip.txt` with the second to fourth lines from the file `para.txt`.

```bash
$ perl -ne 'print if 2..4' para.txt | perl -pe '$_="" if 3..5; print <STDIN> if $.==3' ip.txt
Hello World
How are you
Start working on that
project you always wanted
to, do not let it end
You are funny
```

**5)** Insert one line from `jumbled.txt` before every two lines of `copyright.txt`.

```bash
$ perl -pe 'print scalar <STDIN> if $. % 2' <jumbled.txt copyright.txt
overcoats;furrowing-typeface%pewter##hobby
bla bla 2015 bla
blah 2018 blah
wavering:concession/woof\retailer
bla bla bla
copyright: 2020
```

**6)** Use the entire contents of `match.txt` to search `error.txt` and replace matching portions with the contents of `jumbled.txt`. Partial lines should NOT be matched.

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
joint[]seer{intuition}titanic
if print this
but not that
overcoats;furrowing-typeface%pewter##hobby
wavering:concession/woof\retailer
joint[]seer{intuition}titanic
```

**7)** Display lines from `scores.csv` by matching the first field based on a list of names from the `names.txt` file. Also, change the output field separator to a space character.

```bash
$ cat names.txt
Lin
Cy
Ith

$ perl -F, -lane 'if(!$#ARGV){ $h{$_}=1 }
                  else{ print "@F" if exists $h{$F[0]} }' names.txt scores.csv
Lin 78 83 80
Cy 97 98 95
Ith 100 100 100
```

**8)** The `result.csv` file has three columns — name, subject and mark. The `criteria.txt` file has two columns — name and subject. Match lines from `result.csv` based on the two columns from `criteria.txt` provided the mark column is greater than 80.

```bash
$ cat result.csv
Amy,maths,89
Amy,physics,75
Joe,maths,79
John,chemistry,77
John,physics,91
Moe,maths,81
Ravi,physics,84
Ravi,chemistry,70
Yui,maths,92

$ cat criteria.txt
Amy maths
John chemistry
John physics
Ravi chemistry
Yui maths

$ perl -F, -lane 'if(!$#ARGV){ @f=split; $h{$f[0],$f[1]}=1 }
                  else{ print if exists $h{$F[0],$F[1]} && $F[2]>80 }' criteria.txt result.csv
Amy,maths,89
John,physics,91
Yui,maths,92
```

**9)** Insert the contents of `hex.txt` before a line matching `cake` of the input file `table.txt`

```bash
$ perl -pe 'BEGIN{$r = join "", <STDIN>} print $r if /cake/' <hex.txt table.txt
brown bread mat hair 42
start: 0xA0, func1: 0xA0
end: 0xFF, func2: 0xB0
restart: 0xA010, func3: 0x7F
blue cake mug shirt -7
yellow banana window shoes 3.14
```

**10)** For the input file `ip.txt`, replace lines containing `are` with the contents of `hex.txt`.

```bash
$ perl -pe 'BEGIN{$r = join "", <STDIN>} $_=$r if /are/' <hex.txt ip.txt
Hello World
start: 0xA0, func1: 0xA0
end: 0xFF, func2: 0xB0
restart: 0xA010, func3: 0x7F
This game is good
Today is sunny
12345
start: 0xA0, func1: 0xA0
end: 0xFF, func2: 0xB0
restart: 0xA010, func3: 0x7F
```

<br>

# Dealing with duplicates

**1)** Retain only the first copy of a line for the input file `lines.txt`. Case should be ignored while comparing the lines. For example, `hi there` and `HI TheRE` should be considered as duplicates.

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

**2)** Retain only the first copy of a line for the input file `twos.txt`. Assume space as the field separator with exactly two fields per line. Compare the lines irrespective of the order of the fields. For example, `hehe haha` and `haha hehe` should be considered as duplicates.

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

# can also use: perl -ane 'print if !$h{join " ", sort @F}++' twos.txt
$ perl -lane 'print if !$h{$F[0] le $F[1] ? $_ : "$F[1] $F[0]"}++' twos.txt
hehe haha
door floor
6;8 3-4
true blue
hehe bebe
tru eblue
```

**3)** For the input file `twos.txt`, display only the unique lines. Assume space as the field separator with exactly two fields per line. Compare the lines irrespective of the order of the fields. For example, `hehe haha` and `haha hehe` should be considered as duplicates.

```bash
$ perl -ane '$k = join " ", sort @F;
             !$#ARGV ? !$h{$k}++ : $h{$k}==1 && print' twos.txt twos.txt
true blue
hehe bebe
tru eblue
```

<br>

# Perl rename command

**1)** Determine and implement the rename logic based on the filenames and expected output shown below.

```bash
$ touch ' (2020) Report part 1 . txt ' 'analysis Part 3 (2018) .log'

$ rename 's/^\h+|\h+$|[()]//g; s/\h*\.\h*/./g; s/\s+/_/g; s/.+/\L$&/' *

$ ls
2020_report_part_1.txt  analysis_part_3_2018.log
```

**2)** See [unix.stackexchange: rename Q&A sorted by votes](https://unix.stackexchange.com/questions/tagged/rename?tab=Votes) for further reading as well as a source for exercises.

