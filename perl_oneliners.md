# Preface

This book focuses on Perl usage from the command line, similar to `grep`, `sed` and `awk` usage. Syntax and features of these tools (along with languages like `C` and `bash`) were inspirations for Perl, so prior experience with them would make it easier to learn Perl.

You'll learn about various command line options and Perl features that make it possible to write compact cli scripts. Learning to use Perl from the command line will also allow you to construct solutions where Perl is just another tool in the shell ecosystem.

## Prerequisites

You should be comfortable with programming basics and have prior experience working with Perl. You should know concepts like scalar, array, hash and special variables, be familiar with control structures, regular expressions etc. If you need resources to get started with Perl and regular expressions, you can start with these links:

* [perldoc: perlintro](https://perldoc.perl.org/perlintro)
* [learnxinyminutes: perl](https://learnxinyminutes.com/docs/perl/)
* [perldoc: perlretut](https://perldoc.perl.org/perlretut)

You should also have prior experience working with command line, `bash` shell and be familiar with concepts like file redirection, command pipeline and so on.

## Conventions

* The examples presented here have been tested with **Perl version 5.32.0** and includes features not available in earlier versions.
* Code snippets shown are copy pasted from **bash** shell and modified for presentation purposes. Some commands are preceded by comments to provide context and explanations. Blank lines have been added to improve readability, only `real` time is shown for speed comparisons and so on.
* Unless otherwise noted, all examples and explanations are meant for **ASCII** characters
    * See also [stackoverflow: why does modern perl avoid utf-8 by default](https://stackoverflow.com/q/6162484/4082052)
* External links are provided for further reading throughout the book. Not necessary to immediately visit them. They have been chosen with care and would help, especially during re-reads.
* The [learn_perl_oneliners repo](https://github.com/learnbyexample/learn_perl_oneliners) has all the code snippets and files used in examples and exercises and other details related to the book. If you are not familiar with `git` command, click the **Code** button on the webpage to get the files.

## Acknowledgements

* [perl documentation](https://perldoc.perl.org/) — manuals, tutorials and examples
* [/r/perl/](https://www.reddit.com/r/perl/) — helpful forum for beginners and experienced programmers alike
* [stackoverflow](https://stackoverflow.com/) — for getting answers to pertinent questions on Perl, one-liners, etc
* [tex.stackexchange](https://tex.stackexchange.com/) — for help on `pandoc` and `tex` related questions
* [LibreOffice Draw](https://www.libreoffice.org/discover/draw/) — cover image
* [pngquant](https://pngquant.org/) and [svgcleaner](https://github.com/RazrFalcon/svgcleaner) for optimizing images
* [Warning](https://commons.wikimedia.org/wiki/File:Warning_icon.svg) and [Info](https://commons.wikimedia.org/wiki/File:Info_icon_002.svg) icons by [Amada44](https://commons.wikimedia.org/wiki/User:Amada44) under public domain
* [softwareengineering.stackexchange](https://softwareengineering.stackexchange.com/questions/39/whats-your-favourite-quote-about-programming) and [skolakoda](https://skolakoda.org/programming-quotes) for programming quotes

A heartfelt thanks to all my readers. Your valuable support has significantly eased my financial concerns and allows me to continue writing books.

## Feedback and Errata

I would highly appreciate if you'd let me know how you felt about this book, it would help to improve this book as well as my future attempts. Also, please do let me know if you spot any error or typo.

Issue Manager: [https://github.com/learnbyexample/learn_perl_oneliners/issues](https://github.com/learnbyexample/learn_perl_oneliners/issues)

E-mail: learnbyexample.net@gmail.com

Twitter: https://twitter.com/learn_byexample

## Author info

Sundeep Agarwal is a freelance trainer, author and mentor. His previous experience includes working as a Design Engineer at Analog Devices for more than 5 years. You can find his other works, primarily focused on Linux command line, text processing, scripting languages and curated lists, at [https://github.com/learnbyexample](https://github.com/learnbyexample). He has also been a technical reviewer for [Command Line Fundamentals](https://www.packtpub.com/application-development/command-line-fundamentals) book and video course published by Packt.

**List of books:** https://learnbyexample.github.io/books/

## License

This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/)

Code snippets are available under [MIT License](https://github.com/learnbyexample/learn_perl_oneliners/blob/main/LICENSE)

Resources mentioned in Acknowledgements section above are available under original licenses.

## Book version

1.5

See [Version_changes.md](https://github.com/learnbyexample/learn_perl_oneliners/blob/main/Version_changes.md) to track changes across book versions.

# One-liner introduction

This chapter will give an overview of `perl` syntax for command line usage and some examples to show what kind of problems are typically suited for one-liners.

## Why use Perl for one-liners?

I assume you are already familiar with use cases where command line is more productive compared to GUI. See also this series of articles titled [Unix as IDE](https://sanctum.geek.nz/arabesque/series/unix-as-ide/).

A shell utility like `bash` provides built-in commands and scripting features to easily solve and automate various tasks. External \*nix commands like `grep`, `sed`, `awk`, `sort`, `find`, `parallel`, etc can be combined to work with each other. Depending upon your familiarity with those tools, you can either use `perl` as a single replacement or complement them for specific use cases.

Here's some one-liners (options will be explained later):

* `perl -pe 's/(?:\x27;\x27|";")(*SKIP)(*F)|;/#/g'` — change `;` to `#` but don't change `;` within single or double quotes
* `perl -MList::Util=uniq -e 'print uniq <>'` — retain only first copy of duplicated lines, uses built-in module `List::Util`
* `perl -MRegexp::Common=net -nE 'say $& while /$RE{net}{IPv4}/g'` — extract only IPv4 addresses, using a third-party [Regexp::Common](https://metacpan.org/pod/Regexp::Common) module
* Some stackoverflow Q&A that I've answered over the years with simpler `perl` solution compared to other cli tools
    * [replace string with incrementing value](https://stackoverflow.com/q/42554684/4082052)
    * [sort rows in csv file without header & first column](https://stackoverflow.com/q/48920626/4082052)
    * [reverse matched pattern](https://stackoverflow.com/q/63681983/4082052)
    * [append zeros to list](https://stackoverflow.com/q/49765879/4082052)
    * [arithmetic replacement in a text file](https://stackoverflow.com/q/62241101/4082052)
    * [reverse complement DNA sequence for a specific field](https://stackoverflow.com/q/45571828/4082052)

The selling point of `perl` over tools like `grep`, `sed` and `awk` includes feature rich regular expression engine and standard/third-party modules. If you don't already know the syntax and idioms for `sed` and `awk`, learning command line options for `perl` would be the easier option. Another advantage is that `perl` is more portable, given the many differences between GNU, BSD, Mac and other such implementations. The main disadvantage is that `perl` is likely to be verbose and slower for features that are supported out of the box by those tools.

>![info](images/info.svg) See also [unix.stackexchange: when to use grep, sed, awk, perl, etc](https://unix.stackexchange.com/q/303044/109046)

## Installation and Documentation

If you are on a Unix like system, you are most likely to already have some version of Perl installed. See [cpan: Perl Source](https://www.cpan.org/src/README.html) for instructions to install the latest `perl` version from source. `perl v5.32.0` is used for all the examples shown in this book.

You can use `perldoc` command to access documentation from the command line. You can visit https://perldoc.perl.org/ if you wish to read it online, which also has a handy search feature. Here's some useful links to get started:

* [perldoc: overview](https://perldoc.perl.org/perl#Overview)
* [perldoc: perlintro](https://perldoc.perl.org/perlintro)
* [perldoc: faqs](https://perldoc.perl.org/perlfaq)

## Command line options

`perl -h` gives the list of all command line options, along with a brief description. See [perldoc: perlrun](https://perldoc.perl.org/perlrun) for documentation on these command switches.

| **Option**        | **Description** |
| ----------------- | --------------- |
| `-0[octal]`       | specify record separator (`\0`, if no argument) |
| `-a`              | autosplit mode with `-n` or `-p` (splits `$_` into `@F`) |
| `-C[number/list]` | enables the listed Unicode features |
| `-c`              | check syntax only (runs `BEGIN` and `CHECK` blocks) |
| `-d[:debugger]`   | run program under debugger |
| `-D[number/list]` | set debugging flags (argument is a bit mask or alphabets) |
| `-e program`      | one line of program (several `-e`'s allowed, omit programfile) |
| `-E program`      | like `-e`, but enables all optional features |
| `-f`              | don't do `$sitelib/sitecustomize.pl` at startup |
| `-F/pattern/`     | `split()` pattern for `-a` switch (`//`'s are optional) |
| `-i[extension]`   | edit `<>` files in place (makes backup if extension supplied) |
| `-Idirectory`     | specify `@INC/#include` directory (several `-I`'s allowed) |
| `-l[octal]`       | enable line ending processing, specifies line terminator |
| `-[mM][-]module`  | execute `use/no module...` before executing program |
| `-n`              | assume `while (<>) { ... }` loop around program |
| `-p`              | assume loop like `-n` but `print` line also, like `sed` |
| `-s`              | enable rudimentary parsing for switches after programfile |
| `-S`              | look for programfile using `PATH` environment variable |
| `-t`              | enable tainting warnings |
| `-T`              | enable tainting checks |
| `-u`              | dump core after parsing program |
| `-U`              | allow unsafe operations |
| `-v`              | print version, patchlevel and license |
| `-V[:variable]`   | print configuration summary (or a single `Config.pm` variable) |
| `-w`              | enable many useful warnings |
| `-W`              | enable all warnings |
| `-x[directory]`   | ignore text before `#!perl` line (optionally `cd` to directory) |
| `-X`              | disable all warnings |

This chapter will show examples with `-e`, `-l`, `-n`, `-p` and `-a` options. Some more options will be covered in later chapters, but not all of them are discussed in this book.

## Executing Perl code

If you want to execute a `perl` program file, one way is to pass the filename as argument to the `perl` command.

```bash
$ echo 'print "Hello Perl\n"' > hello.pl
$ perl hello.pl
Hello Perl
```

For short programs, you can also directly pass the code as an argument to the `-e` or `-E` options. See [perldoc: feature](https://perldoc.perl.org/feature) for details about the features enabled by the `-E` option.

```bash
$ perl -e 'print "Hello Perl\n"'
Hello Perl

$ # multiple statements can be issued separated by ;
$ # -l option will be covered in detail later, appends \n to 'print' here
$ perl -le '$x=25; $y=12; print $x**$y'
59604644775390625
$ # or, use -E and 'say' instead of -l and 'print'
$ perl -E '$x=25; $y=12; say $x**$y'
59604644775390625
```

## Filtering

`perl` one-liners can be used for filtering lines matched by a regexp, similar to `grep`, `sed` and `awk`. And similar to many command line utilities, `perl` can accept input from both `stdin` and file arguments.

```bash
$ # sample stdin data
$ printf 'gate\napple\nwhat\nkite\n'
gate
apple
what
kite

$ # print all lines containing 'at'
$ # same as: grep 'at' and sed -n '/at/p' and awk '/at/'
$ printf 'gate\napple\nwhat\nkite\n' | perl -ne 'print if /at/'
gate
what

$ # print all lines NOT containing 'e'
$ # same as: grep -v 'e' and sed -n '/e/!p' and awk '!/e/'
$ printf 'gate\napple\nwhat\nkite\n' | perl -ne 'print if !/e/'
what
```

By default, `grep`, `sed` and `awk` will automatically loop over input content line by line (with `\n` as the line distinguishing character). The `-n` or `-p` option will enable this feature for `perl`. [O module](#convert-one-liners-to-pretty-formatted-scripts) section shows the code Perl runs with these options.

As seen before, the `-e` option accepts code as command line argument. Many shortcuts are available to reduce the amount of typing needed. In the above examples, a regular expression (defined by the pattern between a pair of forward slashes) has been used to filter the input. When the input string isn't specified, the test is performed against special variable `$_`, which has the contents of the current input line here (the correct term would be input **record**, see [Record separators](#record-separators) chapter). `$_` is also the default argument for many functions like `print` and `say`. To summarize:

* `/REGEXP/FLAGS` is a shortcut for `$_ =~ m/REGEXP/FLAGS`
* `!/REGEXP/FLAGS` is a shortcut for `$_ !~ m/REGEXP/FLAGS`

>![info](images/info.svg) See [perldoc: match](https://perldoc.perl.org/perlop#m/PATTERN/msixpodualngc) for help on `m` operator. See [perldoc: special variables](https://perldoc.perl.org/perlvar#SPECIAL-VARIABLES) for documentation on `$_`, `$&`, etc.

Here's an example with file input instead of `stdin`.

```bash
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14

$ perl -nE 'say $& if /(?<!-)\d+$/' table.txt
42
14

$ # if the condition isn't required, capture groups can be used
$ perl -nE 'say /(\d+)$/' table.txt
42
7
14
```

>![info](images/info.svg) The [learn_perl_oneliners repo](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/example_files) has all the files used in examples (like `table.txt` in the above example).

## Substitution

Use `s` operator for search and replace requirements. By default, this operates on `$_` when the input string isn't provided. For these examples, `-p` option is used instead of `-n` option, so that the value of `$_` is automatically printed after processing each input line. See [perldoc: search and replace](https://perldoc.perl.org/perlop#s/PATTERN/REPLACEMENT/msixpodualngcer) for documentation and examples.

```bash
$ # for each input line, change only first ':' to '-'
$ # same as: sed 's/:/-/' and awk '{sub(/:/, "-")} 1'
$ printf '1:2:3:4\na:b:c:d\n' | perl -pe 's/:/-/'
1-2:3:4
a-b:c:d

$ # for each input line, change all ':' to '-'
$ # same as: sed 's/:/-/g' and awk '{gsub(/:/, "-")} 1'
$ printf '1:2:3:4\na:b:c:d\n' | perl -pe 's/:/-/g'
1-2-3-4
a-b-c-d
```

>![info](images/info.svg) The `s` operator modifies the input string it is acting upon if the pattern matches. In addition, it will return number of substitutions made if successful, otherwise returns a *false* value (empty string or `0`). You can use `r` flag to return string after substitution instead of in-place modification. As mentioned before, this book assumes you are already familiar with `perl` regular expressions. If not, see [perldoc: perlretut](https://perldoc.perl.org/perlretut) to get started.

## Field processing

Consider the sample input file shown below with fields separated by a single space character.

```bash
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14
```

Here's some examples that is based on specific field rather than the entire line. The `-a` option will cause the input line to be split based on whitespaces and the field contents can be accessed using `@F` special array variable. Leading and trailing whitespaces will be suppressed, so there's no possibility of empty fields. More details is discussed in [Default field separation](#default-field-separation) section.

```bash
$ # print the second field of each input line
$ # same as: awk '{print $2}' table.txt
$ perl -lane 'print $F[1]' table.txt
bread
cake
banana

$ # print lines only if the last field is a negative number
$ # same as: awk '$NF<0' table.txt
$ perl -lane 'print if $F[-1] < 0' table.txt
blue cake mug shirt -7

$ # change 'b' to 'B' only for the first field
$ # same as: awk '{gsub(/b/, "B", $1)} 1' table.txt
$ perl -lane '$F[0] =~ s/b/B/g; print "@F"' table.txt
Brown bread mat hair 42
Blue cake mug shirt -7
yellow banana window shoes 3.14
```

See [Output field separator](#output-field-separator) section for details on using array variable inside double quotes.

## BEGIN and END

You can use a `BEGIN{}` block when you need to execute something before input is read and a `END{}` block to execute something after all of the input has been processed.

```bash
$ # same as: awk 'BEGIN{print "---"} 1; END{print "%%%"}'
$ seq 4 | perl -pE 'BEGIN{say "---"} END{say "%%%"}'
---
1
2
3
4
%%%
```

## ENV hash

When it comes to automation and scripting, you'd often need to construct commands that can accept input from user, file, output of a shell command, etc. As mentioned before, this book assumes `bash` as the shell being used. To access environment variables of the shell, you can use the special hash variable `%ENV` with the name of the environment variable as a string key.

>![info](images/info.svg) Quotes won't be used around `hash` keys in this book. See [stackoverflow: are quotes around hash keys a good practice in Perl?](https://stackoverflow.com/q/401556/4082052) on possible issues if you don't quote the `hash` keys.

```bash
$ # existing environment variable
$ # output shown here is for my machine, would differ for you
$ perl -E 'say $ENV{HOME}'
/home/learnbyexample
$ perl -E 'say $ENV{SHELL}'
/bin/bash

$ # defined along with perl command
$ # note that the variable definition is placed before the shell command
$ word='hello' perl -E 'say $ENV{word}'
hello
$ # the characters are preserved as is
$ ip='hi\nbye' perl -E 'say $ENV{ip}'
hi\nbye
```

Here's another example when a regexp is passed as an environment variable content.

```bash
$ cat word_anchors.txt
sub par
spar
apparent effort
two spare computers
cart part tart mart

$ # assume 'r' is a shell variable that has to be passed to the perl command
$ r='\Bpar\B'
$ rgx="$r" perl -ne 'print if /$ENV{rgx}/' word_anchors.txt
apparent effort
two spare computers
```

You can also make use of the `-s` option to assign a `perl` variable.

```bash
$ r='\Bpar\B'
$ perl -sne 'print if /$rgx/' -- -rgx="$r" word_anchors.txt
apparent effort
two spare computers
```

>![info](images/info.svg) As an example, see my repo [ch: command help](https://github.com/learnbyexample/command_help/blob/master/ch) for a practical shell script, where commands are constructed dynamically.

## Executing external commands

You can execute external commands using the `system` function. See [perldoc: system](https://perldoc.perl.org/functions/system) for documentation and details like how string/list argument is processed before it is executed.

```bash
$ perl -e 'system("echo Hello World")'
Hello World

$ perl -e 'system("wc -w <word_anchors.txt")'
12

$ perl -e 'system("seq -s, 10 > out.txt")'
$ cat out.txt
1,2,3,4,5,6,7,8,9,10
```

Return value of `system` or special variable `$?` can be used to act upon exit status of command issued. As per documentation:

>![info](images/info.svg) The return value is the exit status of the program as returned by the `wait` call. To get the actual exit value, shift right by eight

```bash
$ perl -E '$es=system("ls word_anchors.txt"); say $es'
word_anchors.txt
0
$ perl -E 'system("ls word_anchors.txt"); say $?'
word_anchors.txt
0

$ perl -E 'system("ls xyz.txt"); say $?'
ls: cannot access 'xyz.txt': No such file or directory
512
```

To save the result of an external command, use backticks or `qx` operator. See [perldoc: qx](https://perldoc.perl.org/perlop#qx/STRING/) for documentation and details like separating out `STDOUT` and `STDERR`.

```bash
$ perl -e '$words = `wc -w <word_anchors.txt`; print $words'
12

$ perl -e '$nums = qx/seq 3/; print $nums'
1
2
3
```

>![info](images/info.svg) See also [stackoverflow: difference between backticks, system, and exec](https://stackoverflow.com/q/799968/4082052)

## Summary

This chapter introduced some of the common options for `perl` cli usage, along with typical cli text processing examples. While specific purpose cli tools like `grep`, `sed` and `awk` are usually faster, `perl` has a much more extensive standard library and ecosystem. And you do not have to learn a lot if you are already comfortable with `perl` but not familiar with those cli tools. The next section has a few exercises for you to practice the cli options and text processing use cases.

## Exercises

>![info](images/info.svg) Exercise related files are available from [exercises folder of learn_perl_oneliners repo](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/exercises).

>![info](images/info.svg) All the exercises are also collated together in one place at [Exercises.md](https://github.com/learnbyexample/learn_perl_oneliners/blob/main/exercises/Exercises.md). To see the solutions, visit [Exercise_solutions.md](https://github.com/learnbyexample/learn_perl_oneliners/blob/main/exercises/Exercise_solutions.md).

**a)** For the input file `ip.txt`, display all lines containing `is`.

```bash
$ cat ip.txt
Hello World
How are you
This game is good
Today is sunny
12345
You are funny

##### add your solution here
This game is good
Today is sunny
```

**b)** For the input file `ip.txt`, display first field of lines *not* containing `y`. Consider space as the field separator for this file.

```bash
##### add your solution here
Hello
This
12345
```

**c)** For the input file `ip.txt`, display all lines containing no more than 2 fields.

```bash
##### add your solution here
Hello World
12345
```

**d)** For the input file `ip.txt`, display all lines containing `is` in the second field.

```bash
##### add your solution here
Today is sunny
```

**e)** For each line of the input file `ip.txt`, replace first occurrence of `o` with `0`.

```bash
##### add your solution here
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

##### add your solution here
-923.16
```

**g)** Append `.` to all the input lines for the given `stdin` data.

```bash
$ printf 'last\nappend\nstop\n' | ##### add your solution here
last.
append.
stop.
```

**h)** Use contents of `s` variable to display all matching lines from the input file `ip.txt`. Assume that `s` doesn't have any regexp metacharacters. Construct the solution such that there's at least one word character immediately preceding the contents of `s` variable.

```bash
$ s='is'

##### add your solution here
This game is good
```

**i)** Use `system` to display contents of filename present in second field (space separated) of the given input line.

```bash
$ s='report.log ip.txt sorted.txt'
$ echo "$s" | ##### add your solution here
Hello World
How are you
This game is good
Today is sunny
12345
You are funny

$ s='power.txt table.txt'
$ echo "$s" | ##### add your solution here
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14
```

# Line processing

Now that you are familiar with basic `perl` cli usage, this chapter will dive deeper into line processing examples. You'll learn various ways for matching lines based on regular expressions, fixed string matching, line numbers, etc. You'll also see how to group multiple statements and learn about control flow keywords `next` and `exit`.

## Regexp based filtering

As mentioned before:

* `/REGEXP/FLAGS` is a shortcut for `$_ =~ m/REGEXP/FLAGS`
* `!/REGEXP/FLAGS` is a shortcut for `$_ !~ m/REGEXP/FLAGS`

If required, you can also use different delimiters. Quoting from [perldoc: match](https://perldoc.perl.org/perlop#m/PATTERN/msixpodualngc):

>If `/` is the delimiter then the initial `m` is optional. With the `m` you can use any pair of non-whitespace (ASCII) characters as delimiters. This is particularly useful for matching path names that contain `/`, to avoid LTS (**leaning toothpick syndrome**). If `?` is the delimiter, then a match-only-once rule applies, described in `m?PATTERN?` below. If `'` (single quote) is the delimiter, no variable interpolation is performed on the *PATTERN*. When using a delimiter character valid in an identifier, whitespace is required after the `m`. *PATTERN* may contain variables, which will be interpolated every time the pattern search is evaluated, except for when the delimiter is a single quote.

```bash
$ cat paths.txt
/foo/a/report.log
/foo/y/power.log
/foo/abc/errors.log

$ perl -ne 'print if /\/foo\/a\//' paths.txt
/foo/a/report.log

$ perl -ne 'print if m{/foo/a/}' paths.txt
/foo/a/report.log

$ perl -ne 'print if !m#/foo/a/#' paths.txt
/foo/y/power.log
/foo/abc/errors.log
```

## Extracting matched portions

You can use regexp related special variables to extract only the matching portions instead of filtering entire matching line. Consider this input file.

```bash
$ cat programming_quotes.txt
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it by Brian W. Kernighan

Some people, when confronted with a problem, think - I know, I will
use regular expressions. Now they have two problems by Jamie Zawinski

A language that does not affect the way you think about programming,
is not worth knowing by Alan Perlis

There are 2 hard problems in computer science: cache invalidation,
naming things, and off-by-1 errors by Leon Bambrick
```

Here's some examples of extracting only the matched portion(s).

```bash
$ # note that this will print only the first match for each input line
$ perl -nE 'say $& if /\bt\w*[et]\b/' programming_quotes.txt
twice
the
that

$ perl -nE 'say join "::", @{^CAPTURE} if /not (.+)y(.+)/i' programming_quotes.txt
smart enough to debug it b:: Brian W. Kernighan
affect the way ::ou think about programming,
worth knowing b:: Alan Perlis

$ # sometimes capture groups are enough, you don't need special variables
$ # @{^CAPTURE} isn't needed here, as it is assumed that every line has a match
$ perl -nE 'say /^(\w+ ).*?(\d+)$/' table.txt
brown 42
blue 7
yellow 14
$ # or add a custom separator
$ perl -nE 'say join ":", /^(\w+).*?(\d+)$/' table.txt
brown:42
blue:7
yellow:14
```

## Transliteration

The transliteration operator `tr` (or `y`) allows you to specify per character transformation rule. See [perldoc: tr](https://perldoc.perl.org/perlop#tr/SEARCHLIST/REPLACEMENTLIST/cdsr) for documentation.

```bash
$ # rot13
$ echo 'Uryyb Jbeyq' | perl -pe 'tr/a-zA-Z/n-za-mN-ZA-M/'
Hello World

$ # use 'c' option to complement specified characters
$ echo 'foo:123:baz' | perl -pe 'tr/0-9\n/-/c'
----123----

$ # use 'd' option to delete specified characters
$ echo 'foo:123:baz' | perl -pe 'tr/0-9\n//cd'
123

$ # use 's' option to squeeze repeated characters
$ echo 'APPLE gobbledygook' | perl -pe 'tr|A-Za-z||s'
APLE gobledygok
$ # transliterate as well as squeeze
$ echo 'APPLE gobbledygook' | perl -pe 'tr|A-Z|a-z|s'
aple gobbledygook
```

Similar to `s` operator, `tr` will return number of changes made. Use `r` option to prevent in-place modification and return the transliterated string instead.

```bash
$ # match lines containing 'b' 2 times
$ perl -ne 'print if tr/b// == 2' table.txt
brown bread mat hair 42

$ s='orange apple appleseed'
$ echo "$s" | perl -pe 's#\bapple\b(*SKIP)(*F)|\w+#$&=~tr/a-z/A-Z/r#ge'
ORANGE apple APPLESEED
```

See also:

* [stackoverflow: reverse complement DNA sequence for a specific field](https://stackoverflow.com/q/45571828/4082052)
* [unix.stackexchange: count the number of characters except specific characters](https://unix.stackexchange.com/q/396584/109046)
* [unix.stackexchange: scoring DNA data](https://unix.stackexchange.com/q/428085/109046)

## Conditional substitution

These examples combine line filtering and substitution in different ways. As noted before, `s` operator will modify the input string and the return value can be used to know how many substitutions were made. Use the `r` flag to prevent in-place modification and get string output after substitution, if any.

```bash
$ # change commas to hyphens if the input line does NOT contain '2'
$ # prints all input lines even if substitution fails
$ printf '1,2,3,4\na,b,c,d\n' | perl -pe 's/,/-/g if !/2/'
1,2,3,4
a-b-c-d

$ # prints filtered input lines, even if substitution fails
$ perl -ne 'print s/by/**/rg if /not/' programming_quotes.txt
** definition, not smart enough to debug it ** Brian W. Kernighan
A language that does not affect the way you think about programming,
is not worth knowing ** Alan Perlis

$ # print only if substitution succeeded
$ perl -ne 'print if s/1/one/g' programming_quotes.txt
naming things, and off-by-one errors by Leon Bambrick
```

## Multiple conditions

It is good to remember that Perl is a programming language. You have control structures and you can combine multiple conditions using logical operators. You don't have to create a single complex regexp.

```bash
$ perl -ne 'print if /not/ && !/it/' programming_quotes.txt
A language that does not affect the way you think about programming,
is not worth knowing by Alan Perlis

$ perl -ane 'print if /twice/ || $#F > 11' programming_quotes.txt
Debugging is twice as hard as writing the code in the first place.
Some people, when confronted with a problem, think - I know, I will

$ perl -ne 'print if /s/ xor /m/' table.txt
brown bread mat hair 42
yellow banana window shoes 3.14
```

## next

When `next` is executed, rest of the code will be skipped and the next input line will be fetched for processing. It doesn't affect `BEGIN` or `END` blocks as they are outside the file content loop. 

```bash
$ perl -nE 'if(/\bpar/){print "%% $_"; next}
            say /s/ ? "X" : "Y"' word_anchors.txt
%% sub par
X
Y
X
%% cart part tart mart
```

**Note** that `{}` is used in the above example to group multiple statements to be executed for a single `if` condition. You'll see many more examples with `next` in coming chapters.

## exit

The `exit` function is useful to avoid processing unnecessary input content when a termination condition is reached. See [perldoc: exit](https://perldoc.perl.org/functions/exit) for documentation.

```bash
$ # quits after an input line containing 'you' is found
$ perl -ne 'print; exit if /you/' programming_quotes.txt
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
$ # matching line won't be printed in this case
$ perl -pe 'exit if /you/' programming_quotes.txt
Debugging is twice as hard as writing the code in the first place.
```

Use `tac` to get all lines starting from last occurrence of the search string with respect to entire file content.

```bash
$ tac programming_quotes.txt | perl -ne 'print; exit if /not/' | tac
is not worth knowing by Alan Perlis

There are 2 hard problems in computer science: cache invalidation,
naming things, and off-by-1 errors by Leon Bambrick
```

You can optionally provide a status code as an argument to the `exit` function.

```bash
$ printf 'sea\neat\ndrop\n' | perl -ne 'print; exit(2) if /at/'
sea
eat
$ echo $?
2
```

Any code in `END` block will still be executed before exiting. This doesn't apply if `exit` was called from the `BEGIN` block.

```bash
$ perl -pE 'exit if /cake/' table.txt
brown bread mat hair 42

$ perl -pE 'exit if /cake/; END{say "bye"}' table.txt
brown bread mat hair 42
bye

$ perl -pE 'BEGIN{say "hi"; exit; say "hello"} END{say "bye"}' table.txt
hi
```

>![warning](images/warning.svg) Be careful if you want to use `exit` with multiple input files, as `perl` will stop even if there are other files remaining to be processed.

## Line number based processing

Line numbers can also be specified as a matching criteria using the `$.` special variable.

```bash
$ # print only the 3rd line
$ perl -ne 'print if $. == 3' programming_quotes.txt
by definition, not smart enough to debug it by Brian W. Kernighan

$ # print 2nd and 5th line
$ perl -ne 'print if $. == 2 || $. == 5' programming_quotes.txt
Therefore, if you write the code as cleverly as possible, you are,
Some people, when confronted with a problem, think - I know, I will

$ # transliterate only 2nd line
$ printf 'gates\nnot\nused\n' | perl -pe 'tr/a-z/*/ if $. == 2'
gates
***
used

$ # print from particular line number to the end of input
$ seq 14 25 | perl -ne 'print if $. >= 10'
23
24
25
```

Use `eof` function to check for end of file condition. See [perldoc: eof](https://perldoc.perl.org/perlfunc#eof) for documentation.

```bash
$ # same as: tail -n1 programming_quotes.txt
$ perl -ne 'print if eof' programming_quotes.txt
naming things, and off-by-1 errors by Leon Bambrick

$ perl -ne 'print "$.:$_" if eof' programming_quotes.txt
12:naming things, and off-by-1 errors by Leon Bambrick

$ # multiple file example
$ # same as: tail -q -n1 programming_quotes.txt table.txt
$ perl -ne 'print if eof' programming_quotes.txt table.txt
naming things, and off-by-1 errors by Leon Bambrick
yellow banana window shoes 3.14
```

For large input files, use `exit` to avoid processing unnecessary input lines.

```bash
$ seq 3542 4623452 | perl -ne 'if($. == 2452){print; exit}'
5993
$ seq 3542 4623452 | perl -ne 'print if $. == 250; if($. == 2452){print; exit}'
3791
5993

$ # here is a sample time comparison
$ time seq 3542 4623452 | perl -ne 'if($. == 2452){print; exit}' > f1
real    0m0.004s
$ time seq 3542 4623452 | perl -ne 'print if $. == 2452' > f2
real    0m0.740s
```

## Range operator

You can use range operator to select between pair of matching conditions like line numbers and regexp. See [perldoc: range](https://perldoc.perl.org/perlop#Range-Operators) for documentation.

```bash
$ # the range is automatically compared against $. in this context
$ # same as: perl -ne 'print if 3 <= $. <= 5'
$ seq 14 25 | perl -ne 'print if 3..5'
16
17
18

$ # the range is automatically compared against $_ in this context
$ # note that all the matching ranges are printed
$ perl -ne 'print if /are/ .. /by/' programming_quotes.txt
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it by Brian W. Kernighan
There are 2 hard problems in computer science: cache invalidation,
naming things, and off-by-1 errors by Leon Bambrick
```

>![info](images/info.svg) See [Records bounded by distinct markers](#records-bounded-by-distinct-markers) section for an alternate, flexible solution.

You can also mix line number and regexp conditions.

```bash
$ perl -ne 'print if 5 .. /use/' programming_quotes.txt
Some people, when confronted with a problem, think - I know, I will
use regular expressions. Now they have two problems by Jamie Zawinski

$ # same logic as: perl -pe 'exit if /ll/'
$ # inefficient, but this will work for multiple file inputs
$ perl -ne 'print if !(/ll/ .. eof)' programming_quotes.txt table.txt
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it by Brian W. Kernighan

brown bread mat hair 42
blue cake mug shirt -7
```

>![warning](images/warning.svg) Both conditions can match the same line too! Also, if the second condition doesn't match, lines starting from first condition to the last line of the input will be matched.

```bash
$ # 'worth' matches the 9th line
$ perl -ne 'print if 9 .. /worth/' programming_quotes.txt
is not worth knowing by Alan Perlis

$ # there's a line containing 'affect' but doesn't have matching pair
$ # so, all lines till the end of input is printed
$ perl -ne 'print if /affect/ .. /XYZ/' programming_quotes.txt
A language that does not affect the way you think about programming,
is not worth knowing by Alan Perlis

There are 2 hard problems in computer science: cache invalidation,
naming things, and off-by-1 errors by Leon Bambrick
```

## Working with fixed strings

You can surround a regexp pattern with `\Q` and `\E` to match it as a fixed string, similar to `grep -F` option. `\E` can be left out if there's no further pattern to be specified. Variables are still interpolated, so if your fixed string contains `$` or `@` forming possible variables, you'll run into issues. For such cases, you can pass the string as an environment value and then apply `\Q` to that variable. See [perldoc: quotemeta](https://perldoc.perl.org/functions/quotemeta) for documentation.

```bash
$ # no match, since [] are character class metacharacters
$ echo 'int a[5]' | perl -ne 'print if /a[5]/'

$ perl -E 'say "\Qa[5]"'
a\[5\]
$ echo 'int a[5]' | perl -ne 'print if /\Qa[5]/'
int a[5]
$ echo 'int a[5]' | perl -pe 's/\Qa[5]/b[12]/'
int b[12]

$ # $y and $z will be treated as variables here (default value empty string)
$ echo '$x = $y + $z' | perl -pe 's/\Q$y + $z/100/'
$x = $y100$z
$ echo '$x = $y + $z' | fs='$y + $z' perl -pe 's/\Q$ENV{fs}/100/'
$x = 100
$ # ENV is preferred since \\ is special in single quoted strings
$ perl -E '$x = q(x\y\\0z); say $x'
x\y\0z
$ x='x\y\\0z' perl -E 'say $ENV{x}'
x\y\\0z
```

If you just want to filter a line based on fixed string, you can also use the `index` function. This returns the matching position (which starts with `0`) and `-1` if the given string wasn't found. See [perldoc: index](https://perldoc.perl.org/functions/index) for documentation.

```bash
$ echo 'int a[5]' | perl -ne 'print if index($_, "a[5]") != -1'
int a[5]
```

The above `index` example uses double quotes for the string argument, which allows escape sequences like `\t`, `\n`, etc and interpolation. This isn't the case with single quoted string values. Using single quotes within the script from command line requires messing with shell metacharacters. So, use `q` operator instead or pass the fixed string to be matched as an environment variable.

```bash
$ # double quotes allow escape sequences and interpolation
$ perl -E '$x=5; say "value of x:\t$x"'
value of x:     5

$ # use 'q' operator as an alternate to specify single quoted string
$ s='$a = 2 * ($b + $c)'
$ echo "$s" | perl -ne 'print if index($_, q/($b + $c)/) != -1'
$a = 2 * ($b + $c)

$ # or pass the string as environment variable
$ echo "$s" | fs='($b + $c)' perl -ne 'print if index($_, $ENV{fs}) != -1'
$a = 2 * ($b + $c)
```

You can use the return value of `index` function to restrict the matching to the start or end of the input line. The line content in `$_` variable contains the `\n` line ending character as well. You can either use `chomp` function explicitly or use the `-l` command line option, which will be discussed in detail in [Record separators](#record-separators) chapter. For now, it is enough to know that `-l` will remove the line ending from `$_` and add it back when `print` is used.

```bash
$ cat eqns.txt
a=b,a-b=c,c*d
a+b,pi=3.14,5e12
i*(t+9-g)/8,4-a+b

$ # start of line
$ s='a+b' perl -ne 'print if index($_, $ENV{s})==0' eqns.txt
a+b,pi=3.14,5e12

$ # end of line
$ # same as: s='a+b' perl -ne 'print if /\Q$ENV{s}\E$/' eqns.txt
$ # length function returns number of characters, by default acts on $_
$ # -l option is needed here to remove \n from $_
$ s='a+b' perl -lne '$pos = length() - length($ENV{s});
                     print if index($_, $ENV{s}) == $pos' eqns.txt
i*(t+9-g)/8,4-a+b
```

Here's some more examples using the return value of `index` function.

```bash
$ # since 'index' returns '-1' if there's no match,
$ # you need to add >=0 check as well for < or <= comparison
$ perl -ne '$i = index($_, "="); print if 0 <= $i <= 5' eqns.txt
a=b,a-b=c,c*d

$ # > or >= comparison is easy to specify
$ # if you use 3rd argument to 'index', you'll still have to check != -1
$ s='a+b' perl -ne 'print if index($_, $ENV{s})>=1' eqns.txt
i*(t+9-g)/8,4-a+b
```

If you need to match entire input line or field, you can use string comparison operators.

```bash
$ printf 'a.b\na+b\n' | perl -lne 'print if /^a.b$/'
a.b
a+b
$ printf 'a.b\na+b\n' | perl -lne 'print if $_ eq q/a.b/'
a.b
$ printf '1 a.b\n2 a+b\n' | perl -lane 'print if $F[1] ne q/a.b/'
2 a+b
```

To provide a fixed string in replacement section, environment variable comes in handy again. Or use `q` operator for directly providing the value, but you may have to workaround the delimiters being used and presence of `\\` characters.

```bash
$ # characters like $ and @ are special in replacement section
$ echo 'x+y' | perl -pe 's/\Qx+y/$x+@y/'
+

$ # provide replacement string as environment variable
$ echo 'x+y' | r='$x+@y' perl -pe 's/\Qx+y/$ENV{r}/'
$x+@y

$ # or, use 'e' flag to provide single quoted value as Perl code
$ echo 'x+y' | perl -pe 's/\Qx+y/q($x+@y)/e'
$x+@y

$ # need to workaround delimiters and \\ with 'q' operator based solution
$ echo 'x+y' | perl -pe 's/\Qx+y/q($x\/@y)/e'
$x/@y
$ echo 'x+y' | perl -pe 's|\Qx+y|q($x/@y)|e'
$x/@y
$ echo 'x+y' | perl -pe 's|\Qx+y|q($x/@y\\\z)|e'
$x/@y\\z
```

## Summary

This chapter showed various examples of processing only lines of interest instead of entire input file. Filtering can be specified using a regexp, fixed string, line number or a combination of them. `next` and `exit` are useful to change the flow of code.

## Exercises

**a)** Remove only the third line of given input.

```bash
$ seq 34 37 | ##### add your solution here
34
35
37
```

**b)** Display only fourth, fifth, sixth and seventh lines for the given input.

```bash
$ seq 65 78 | ##### add your solution here
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

##### add your solution here
Today is not sunny
You are not funny
```

**d)** For the given `stdin`, display only the first three lines. Avoid processing lines that are not relevant.

```bash
$ seq 14 25 | ##### add your solution here
14
15
16
```

**e)** For the input file `ip.txt`, display all lines from start of the file till the first occurrence of `game`.

```bash
##### add your solution here
Hello World
How are you
This game is good
```

**f)** For the input file `ip.txt`, display all lines that contain `is` but not `good`.

```bash
##### add your solution here
Today is sunny
```

**g)** For the input file `ip.txt`, extract the word before the whole word `is` as well as the word after it. If such a match is found, display the two words around `is` in reversed order. For example, `hi;1 is--234 bye` should be converted to `234:1`. Assume that whole word `is` will not be present more than once in a single line.

```bash
##### add your solution here
good:game
sunny:Today
```

**h)** For the given input string, replace `0xA0` with `0x7F` and `0xC0` with `0x1F`.

```bash
$ s='start address: 0xA0, func1 address: 0xC0'

$ echo "$s" | ##### add your solution here
start address: 0x7F, func1 address: 0x1F
```

**i)** Find the starting index of first occurrence of `is` or `the` or `was` or `to` for each input line of the file `idx.txt`. Assume all input lines will match at least one of these terms.

```bash
$ cat idx.txt
match after the last newline character
and then you want to test
this is good bye then
you were there to see?

##### add your solution here
12
4
2
9
```

**j)** Display all lines containing `[4]*` for the given `stdin` data.

```bash
$ printf '2.3/[4]*6\n2[4]5\n5.3-[4]*9\n' | ##### add your solution here
2.3/[4]*6
5.3-[4]*9
```

**k)** For the given input string, replace all lowercase alphabets to `x` only for words starting with `m`.

```bash
$ s='ma2T3a a2p kite e2e3m meet'
$ echo "$s" | ##### add your solution here
xx2T3x a2p kite e2e3m xxxx
```

**l)** For the input file `ip.txt`, delete all characters other than lowercase vowels and newline character. Perform this transformation only between a line containing `you` up to line number `4` (inclusive).

```bash
##### add your solution here
Hello World
oaeou
iaeioo
oaiu
12345
You are funny
```

# In-place file editing

In the examples presented so far, the output from `perl` was displayed on the terminal or redirected to another file. This chapter will discuss how to write back the changes to the input file(s) itself using the `-i` command line option. This option can be configured to make changes to the input file(s) with or without creating a backup of original contents. When backups are needed, the original filename can get a prefix or a suffix or both. And the backups can be placed in the same directory or some other directory as needed.

## With backup

You can use the `-i` option to write back the changes to the input file instead of displaying the output on terminal. When an extension is provided as an argument to `-i`, the original contents of the input file gets preserved as per the extension given. For example, if the input file is `ip.txt` and `-i.orig` is used, `ip.txt.orig` will be the backup filename.

```bash
$ cat colors.txt
deep blue
light orange
blue delight

$ # no output on terminal as -i option is used
$ # space is NOT allowed between -i and the extension
$ perl -i.bkp -pe 's/blue/-green-/' colors.txt
$ # changes are written back to 'colors.txt'
$ cat colors.txt
deep -green-
light orange
-green- delight

$ # original file is preserved in 'colors.txt.bkp'
$ cat colors.txt.bkp
deep blue
light orange
blue delight
```

Multiple input files are treated individually and the changes are written back to respective files.

```bash
$ cat t1.txt
have a nice day
bad morning
what a pleasant evening
$ cat t2.txt
worse than ever
too bad

$ perl -i.bkp -pe 's/bad/good/' t1.txt t2.txt
$ ls t?.*
t1.txt  t1.txt.bkp  t2.txt  t2.txt.bkp

$ cat t1.txt
have a nice day
good morning
what a pleasant evening
$ cat t2.txt
worse than ever
too good
```

## Without backup

Sometimes backups are not desirable. Using `-i` option on its own will not create backups. Be careful though, as changes made cannot be undone. In such cases, test the command with sample input before using `-i` option on actual file. You could also use the option with backup, compare the differences with a `diff` program and then delete the backup.

```bash
$ cat fruits.txt
banana
papaya
mango

$ perl -i -pe 's/an/AN/g' fruits.txt
$ cat fruits.txt
bANANa
papaya
mANgo
```

## Prefix backup name

A `*` character in the argument to `-i` option is special. It will get replaced with the input filename. This is helpful if you need to use a prefix instead of suffix for the backup filename. Or any other combination that may be needed.

```bash
$ ls *colors.txt*
colors.txt  colors.txt.bkp

$ # single quotes is used here as * is a special shell character
$ perl -i'bkp.*' -pe 's/-green-/yellow/' colors.txt
$ ls *colors.txt*
bkp.colors.txt  colors.txt  colors.txt.bkp
```

## Place backups in different directory

The `*` trick can also be used to place the backups in another directory instead of the parent directory of input files. The backup directory should already exist for this to work.

```bash
$ mkdir backups
$ perl -i'backups/*' -pe 's/good/nice/' t1.txt t2.txt
$ ls backups/
t1.txt  t2.txt
```

## Gory details of in-place editing

For more details about the `-i` option, see:

* [effectiveperlprogramming: In-place editing gets safer in v5.28](https://www.effectiveperlprogramming.com/2017/12/in-place-editing-gets-safer-in-v5-28/)
* [perldoc: -i option](https://perldoc.perl.org/perlrun#-i%5Bextension%5D) — documentation and underlying code
* [perldoc faq: Why does Perl let me delete read-only files? Why does -i clobber protected files? Isn't this a bug in Perl?](https://perldoc.perl.org/perlfaq5#Why-does-Perl-let-me-delete-read-only-files%3F-Why-does-i-clobber-protected-files%3F-Isn%27t-this-a-bug-in-Perl%3F)

## Summary

This chapter discussed about the `-i` option which is useful when you need to edit a file in-place. This is particularly useful in automation scripts. But, do ensure that you have tested the `perl` command before applying to actual files if you need to use this option without creating backups.

## Exercises

**a)** For the input file `text.txt`, replace all occurrences of `in` with `an` and write back the changes to `text.txt` itself. The original contents should get saved to `text.txt.orig`

```bash
$ cat text.txt
can ran want plant
tin fin fit mine line

##### add your solution here

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

##### add your solution here

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

##### add your solution here

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

# Field separators

This chapter will dive deep into field processing. You'll learn how to set input and output field separators, how to use regexps for defining fields and how to work with fixed length fields. 

## Default field separation

By default, the `-a` option splits based on one or more sequence of **whitespace** characters. In addition, whitespaces at the start or end of input gets trimmed and won't be part of field contents. Using `-a` is equivalent to `@F = split`. From [perldoc: split](https://perldoc.perl.org/functions/split):

>`split` emulates the default behavior of the command line tool `awk` when the PATTERN is either omitted or a string composed of a single space character (such as `' '` or `"\x20"`, but not e.g. `/ /`). In this case, any leading whitespace in EXPR is removed before splitting occurs, and the PATTERN is instead treated as if it were `/\s+/`; in particular, this means that any contiguous whitespace (not just a single space character) is used as a separator. However, this special treatment can be avoided by specifying the pattern `/ /` instead of the string `" "`, thereby allowing only a single space character to be a separator.

```bash
$ # $#F gives index of last element, i.e. size of array - 1
$ echo '   a   b   c   ' | perl -anE 'say $#F'
2
$ # note that leading whitespaces isn't part of field content
$ echo '   a   b   c   ' | perl -anE 'say $F[0]'
a
$ # note that trailing whitespaces isn't part of field content
$ echo '   a   b   c   ' | perl -anE 'say "$F[-1]."'
c.

$ # here's another example with more whitespace characters thrown in
$ # in scalar context, @F will return size of the array
$ printf '     one \t\f\v two\t\r\tthree \t\r ' | perl -anE 'say scalar @F'
3
$ printf '     one \t\f\v two\t\r\tthree \t\r ' | perl -anE 'say "$F[1]."'
two.
```

## Input field separator

You can use the `-F` command line option to specify a custom regexp field separator. Note that `-a` option implicitly sets `-n` and `-F` option implicitly sets `-n` and `-a` on newer versions of Perl. However, this book will always explicitly use these options.

```bash
$ # use ':' as input field separator
$ echo 'goal:amazing:whistle:kwality' | perl -F: -anE 'say "$F[0]\n$F[2]"'
goal
whistle

$ # use quotes to avoid clashes with shell special characters
$ echo 'one;two;three;four' | perl -F';' -anE 'say $F[2]'
three

$ echo 'load;err_msg--\ant,r2..not' | perl -F'\W+' -anE 'say $F[2]'
ant

$ echo 'hi.bye.hello' | perl -F'\.' -anE 'say $F[1]'
bye
```

You can also specify the regexp to `-F` option inside `//` delimiters as well as add `LIMIT` argument if needed.

```bash
$ # count number of vowels for each input line
$ # can also use: -F'(?i)[aeiou]'
$ printf 'COOL\nnice car\n' | perl -F'/[aeiou]/i' -anE 'say $#F'
2
3

$ # note that newline character is present as part of the last field content
$ echo 'goal:amazing:whistle:kwality' | perl -F'/:/,$_,2' -ane 'print $F[1]'
amazing:whistle:kwality
```

To get individual characters, you can use empty argument for the `-F` option.

```bash
$ echo 'apple' | perl -F -anE 'say $F[0]'
a
$ # -CS option will turn on UTF-8 for stdin/stdout/stderr streams
$ echo 'fox:αλεπού' | perl -CS -F -anE 'say @F[4..6]'
αλε
```

For more information about using `perl` with different encodings, see:

* [perldoc: -C option](https://perldoc.perl.org/perlrun#-C-%5Bnumber/list%5D)
* [unix.stackexchange: tr with unicode characters](https://unix.stackexchange.com/q/389615/109046)
* [stackoverflow: Why does modern Perl avoid UTF-8 by default?](https://stackoverflow.com/q/6162484/4082052)

>![warning](images/warning.svg) If the custom field separator with `-F` option doesn't affect the newline character, then the last element can contain the newline character.

```bash
$ # last element will not have newline character with default -a
$ # as leading/trailing whitespaces are trimmed with default split
$ echo 'cat dog' | perl -anE 'say "[$F[-1]]"'
[dog]

$ # last element will have newline character since field separator is ':'
$ echo 'cat:dog' | perl -F: -anE 'say "[$F[-1]]"'
[dog
]
$ # unless the input itself doesn't have newline character
$ printf 'cat:dog' | perl -F: -anE 'say "[$F[-1]]"'
[dog]
```

The newline character can also show up as the entire content of the last field.

```bash
$ # both leading and trailing whitespaces are trimmed
$ echo '  a b   c   ' | perl -anE 'say $#F'
2
$ # leading empty element won't be removed here
$ # and last element will have only newline character as its value
$ echo ':a:b:c:' | perl -F: -anE 'say $#F; say "[$F[-1]]"'
4
[
]
```

As mentioned before, the `-l` option is helpful if you wish to remove the newline character (more details will be discussed in [Record separators](#record-separators) chapter). A side effect of removing the newline character before applying `split` is that a trailing empty field will also get removed (you can explicitly call `split` function with `-1` as limit to prevent this).

```bash
$ # -l will remove the newline character
$ # -l will also cause 'print' to append the newline character
$ echo 'cat:dog' | perl -F: -lane 'print "[$F[-1]]"'
[dog]

$ # since newline character is chomped, last element is empty
$ # which is then removed due to default 'split' behavior
$ echo ':a:b:c:' | perl -F: -lane 'print scalar @F'
4
$ # explicit call to split with -1 as limit will preserve the empty element
$ echo ':a:b:c:' | perl -lne 'print scalar split/:/,$_,-1'
5
```

>![warning](images/warning.svg) As per [perldoc: -F option](https://perldoc.perl.org/perlrun#-Fpattern), "You can't use literal whitespace or NUL characters in the pattern." Here's some examples.

```bash
$ # only one element, field separator didn't match at all!!
$ echo 'pick eat rest laugh' | perl -F'/t /' -lane 'print $F[0]'
pick eat rest laugh
$ # number of splits is correct
$ # but the space character shouldn't be part of field here
$ echo 'pick eat rest laugh' | perl -F't ' -lane 'print $F[1]'
 res
$ # this gives the expected behavior
$ echo 'pick eat rest laugh' | perl -F't\x20' -lane 'print $F[1]'
res

$ # Error!!
$ echo 'pick eat rest laugh' | perl -F't[ ]' -lane 'print $F[1]'
Unmatched [ in regex; marked by <-- HERE in m/t[ <-- HERE /.
$ # no issues if 'split' is used explicitly
$ echo 'pick eat rest laugh' | perl -lne 'print((split /t[ ]/)[1])'
res

$ # example with NUL specified literally and as an escape sequence
$ printf 'a\0b\0c' | perl -F$'\0' -anE 'say join ",", @F' | cat -v
a,^@,b,^@,c
$ printf 'a\0b\0c' | perl -F'\0' -anE 'say join ",", @F' | cat -v
a,b,c
```

## Output field separator

There are a few ways to affect the separator to be used while displaying multiple values.

**Method 1**: The value of `$,` special variable is used as the separator when multiple arguments (or list/array) are passed to `print` and `say` functions. `$,` could be remembered easily by noting that `,` is used to separate multiple arguments. Note that `-l` option is used in the examples below as a good practice even when not needed.

>![info](images/info.svg) See [perldoc: perlvar](https://perldoc.perl.org/perlvar) for alternate names of special variables if you use [metacpan: English](https://metacpan.org/pod/English) module. For example, `$OFS` or `$OUTPUT_FIELD_SEPARATOR` instead of `$,`

```bash
$ perl -lane 'BEGIN{$,=" "} print $F[0], $F[2]' table.txt
brown mat
blue mug
yellow window

$ s='Sample123string42with777numbers'
$ echo "$s" | perl -F'\d+' -lane 'BEGIN{$,=","} print @F'
Sample,string,with,numbers

$ # default value of $, is undef
$ echo 'table' | perl -F -lane 'print @F[0..2]'
tab
```

**Method 2**: By using the `join` function.

```bash
$ s='Sample123string42with777numbers'
$ echo "$s" | perl -F'\d+' -lane 'print join ",", @F'
Sample,string,with,numbers

$ s='goal:amazing:whistle:kwality'
$ echo "$s" | perl -F: -lane 'print join "-", @F[-1, 1, 0]'
kwality-amazing-goal
$ echo "$s" | perl -F: -lane 'print join "::", @F, 42'
goal::amazing::whistle::kwality::42
```

**Method 3**: You can also manually build the output string within double quotes. Or use `$"` to specify the field separator for an array value within double quotes. `$"` could be remembered easily by noting that interpolation happens within double quotes.

```bash
$ s='goal:amazing:whistle:kwality'

$ echo "$s" | perl -F: -lane 'print "$F[0] $F[2]"'
goal whistle

$ # default value of $" is space
$ echo "$s" | perl -F: -lane 'print "@F[0, 2]"'
goal whistle

$ echo "$s" | perl -F: -lane 'BEGIN{$"="-"} print "msg: @F[-1, 1, 0]"'
msg: kwality-amazing-goal
```

## Changing number of fields

Manipulating `$#F` will change the number of fields for `@F` array.

```bash
$ s='goal:amazing:whistle:kwality'

$ # reducing fields
$ echo "$s" | perl -F: -lane '$#F=1; print join ",", @F'
goal,amazing

$ # increasing fields
$ echo "$s" | perl -F: -lane '$F[$#F+1]="sea"; print join ":", @F'
goal:amazing:whistle:kwality:sea

$ # empty fields will be created as needed
$ echo "$s" | perl -F: -lane '$F[7]="go"; print join ":", @F'
goal:amazing:whistle:kwality::::go
```

Assigning `$#F` to `-1` or lower will delete all the fields.

```bash
$ echo "1:2:3" | perl -F: -lane '$#F=-1; print "[@F]"'
[]
```

Here's an example of adding a new field based on existing fields.

```bash
$ cat marks.txt
Dept    Name    Marks
ECE     Raj     53
ECE     Joel    72
EEE     Moi     68
CSE     Surya   81
EEE     Tia     59
ECE     Om      92
CSE     Amy     67

$ # adds a new grade column based on marks in 3rd column
$ perl -anE 'BEGIN{$,="\t"; @g = qw(D C B A S)}
             say @F, $.==1 ? "Grade" : $g[$F[-1]/10 - 5]' marks.txt
Dept    Name    Marks   Grade
ECE     Raj     53      D
ECE     Joel    72      B
EEE     Moi     68      C
CSE     Surya   81      A
EEE     Tia     59      D
ECE     Om      92      S
CSE     Amy     67      C
```

## Defining field contents instead of using split

The `-F` option uses the `split` function to get field values from input content. In contrast, using `/regexp/g` allows you to define what should the fields be made up of. Quoting from [perldoc: Global matching](https://perldoc.perl.org/perlretut#Global-matching)

>In list context, `/g` returns a list of matched groupings, or if there are no groupings, a list of matches to the whole regexp.

```bash
$ s='Sample123string42with777numbers'

$ # define fields to be one or more consecutive digits
$ # can also use: perl -nE 'say((/\d+/g)[1])'
$ echo "$s" | perl -nE '@f=/\d+/g; say $f[1]'
42

$ # define fields to be one or more consecutive alphabets
$ echo "$s" | perl -lne 'print join ",", /[a-z]+/ig'
Sample,string,with,numbers
```

Here's some examples to display results only if there's a match. Without the `if` conditions, you'll get empty lines for non-matching lines. Quoting from [perldoc: The empty pattern //](https://perldoc.perl.org/perlop#The-empty-pattern-//)

>If the *PATTERN* evaluates to the empty string, the last successfully matched regular expression is used instead. In this case, only the `g` and `c` flags on the empty pattern are honored; the other flags are taken from the original pattern. If no match has previously succeeded, this will (silently) act instead as a genuine empty pattern (which will always match).

```bash
$ perl -nE 'say join "\n", //g if /\bm\w*\b/' table.txt
mat
mug

$ # /\bb\w*\b/ will come into play only if a word starting with 'h' isn't found
$ # so, first line matches 'hair' but not 'brown' or 'bread'
$ # other lines don't have words starting with 'h'
$ perl -nE 'say join "\n", //g if /\bh\w*\b/ || /\bb\w*\b/' table.txt
hair
blue
banana
```

As an alternate, you can use `while` loop with `g` flag. Quoting from [perldoc: Global matching](https://perldoc.perl.org/perlretut#Global-matching)

>In scalar context, successive invocations against a string will have `/g` jump from match to match, keeping track of position in the string as it goes along.

```bash
$ perl -nE 'say $& while /\bm\w*\b/g' table.txt
mat
mug

# note that this form isn't suited for priority extraction
$ perl -nE 'say $& while /\b[bh]\w*\b/g' table.txt
brown
bread
hair
blue
banana
```

A simple `split` fails for `csv` input where fields can contain embedded delimiter characters. For example, a field content `"fox,42"` when `,` is the delimiter.

```bash
$ s='eagle,"fox,42",bee,frog'
$ # simply using , as separator isn't sufficient
$ echo "$s" | perl -F, -lane 'print $F[1]'
"fox
```

While [metacpan: Text::CSV](https://metacpan.org/pod/Text::CSV) module should be preferred for robust `csv` parsing, regexp is enough for simple formats.

```bash
$ echo "$s" | perl -lne 'print((/"[^"]+"|[^,]+/g)[1])'
"fox,42"
```

## Fixed width processing

The `unpack` function is more than just a different way of string slicing. It supports various formats and pre-processing, see [perldoc: unpack](https://perldoc.perl.org/functions/unpack), [perldoc: pack](https://perldoc.perl.org/functions/pack) and [perldoc: perlpacktut](https://perldoc.perl.org/perlpacktut) for details.

In the example below, `a` indicates arbitrary binary string. The optional number that follows indicates length of the field.

```bash
$ cat items.txt
apple   fig banana
50      10  200

$ # here field widths have been assigned such that
$ # extra spaces are placed at the end of each field
$ # $_ is the default input string for 'unpack' function
$ perl -lne 'print join ",", unpack "a8a4a6"' items.txt
apple   ,fig ,banana
50      ,10  ,200
$ perl -lne 'print((unpack "a8a4a6")[1])' items.txt
fig 
10  
```

You can specify characters to be ignored with `x` followed by optional length.

```bash
$ # first field is 5 characters
$ # then 3 characters are ignored and 3 characters for second field
$ # then 1 character is ignored and 6 characters for third field
$ perl -lne 'print join ",", unpack "a5x3a3xa6"' items.txt
apple,fig,banana
50   ,10 ,200
```

Using `*` will cause remaining characters of that particular format to be consumed. Here `Z` is used to process ASCII NUL separated string.

```bash
$ printf 'banana\x0050\x00' | perl -nE 'say join ":", unpack "Z*Z*"'
banana:50

$ # first field is 5 characters, then 3 characters are ignored
$ # all the remaining characters are assigned to second field
$ perl -lne 'print join ",", unpack "a5x3a*"' items.txt
apple,fig banana
50   ,10  200
```

Unpacking isn't always needed, string slicing using `substr` may suffice. See [perldoc: substr](https://perldoc.perl.org/functions/substr) for documentation.

```bash
$ # same as: perl -F -anE 'say @F[2..4]'
$ echo 'b 123 good' | perl -nE 'say substr $_,2,3'
123
$ echo 'b 123 good' | perl -ne 'print substr $_,6'
good

$ # replacing arbitrary slice
$ echo 'b 123 good' | perl -pe 'substr $_,2,3,"gleam"'
b gleam good
```

See also [perldoc: Functions for fixed-length data or records](https://perldoc.perl.org/functions#Functions-for-fixed-length-data-or-records).

## Assorted field processing functions

Having seen command line options and features commonly used for field processing, this section will highlight some of the built-in functions. There's just too many to meaningfully cover them in all in detail, so consider this to be just a brief overview of features. See also [perldoc: Perl Functions by Category](https://perldoc.perl.org/functions#Perl-Functions-by-Category).

First up, the `grep` function that allows you to select fields based on a condition. In scalar context, it returns number of fields that matched the given condition. See [perldoc: grep](https://perldoc.perl.org/functions/grep) for documentation. See also [unix.stackexchange: create lists of words according to binary numbers](https://unix.stackexchange.com/q/397498/109046).

```bash
$ s='goal:amazing:42:whistle:kwality:3.14'

$ # fields containing 'in' or 'it' or 'is'
$ echo "$s" | perl -F: -lane 'print join ":", grep {/i[nts]/} @F'
amazing:whistle:kwality

$ # number of fields NOT containing a digit character
$ echo "$s" | perl -F: -lane 'print scalar grep {!/\d/} @F'
4

$ s='hour hand band mat heated apple'
$ echo "$s" | perl -lane 'print join "\n", grep {!/^h/ && length()<4} @F'
mat

$ echo '20 711 -983 5 21' | perl -lane 'print join ":", grep {$_ > 20} @F'
711:21

$ # maximum of one field containing 'r'
$ perl -lane 'print if 1 >= grep {/r/} @F' table.txt
blue cake mug shirt -7
yellow banana window shoes 3.14
```

The `map` function transforms each element according to the logic passed to it. See [perldoc: map](https://perldoc.perl.org/functions/map) for documentation.

```bash
$ s='goal:amazing:42:whistle:kwality:3.14'
$ echo "$s" | perl -F: -lane 'print join ":", map {uc} @F'
GOAL:AMAZING:42:WHISTLE:KWALITY:3.14
$ echo "$s" | perl -F: -lane 'print join ":", map {/^[gw]/ ? uc : $_} @F'
GOAL:amazing:42:WHISTLE:kwality:3.14

$ echo '23 756 -983 5' | perl -lane 'print join ":", map {$_ ** 2} @F'
529:571536:966289:25

$ echo 'AaBbCc' | perl -F -lane 'print join " ", map {ord} @F'
65 97 66 98 67 99
$ # for in-place modification of the input array
$ echo 'AaBbCc' | perl -F -lane 'map {$_ = ord} @F; print "@F"'
65 97 66 98 67 99

$ echo 'a b c' | perl -lane 'print join ",", map {qq/"$_"/} @F'
"a","b","c"
```

Here's an example with `grep` and `map` combined.

```bash
$ s='hour hand band mat heated pineapple'
$ echo "$s" | perl -lane 'print join "\n", map {y/ae/X/r} grep {/^h/} @F'
hour
hXnd
hXXtXd
$ # with 'grep' alone, provided the transformation doesn't affect the condition
$ # also, @F will be changed here, above map+grep code will not affect @F
$ echo "$s" | perl -lane 'print join "\n", grep {y/ae/X/; /^h/} @F'
hour
hXnd
hXXtXd
```

Here's some examples with `sort` and `reverse` functions for arrays and strings. See [perldoc: sort](https://perldoc.perl.org/functions/sort) and [perldoc: reverse](https://perldoc.perl.org/functions/reverse) for documentation.

```bash
$ # sorting numbers
$ echo '23 756 -983 5' | perl -lane 'print join " ", sort {$a <=> $b} @F'
-983 5 23 756

$ s='floor bat to dubious four'
$ # default alphabetic sorting in ascending order
$ echo "$s" | perl -lane 'print join ":", sort @F'
bat:dubious:floor:four:to

$ # sort by length of the fields in ascending order
$ echo "$s" | perl -lane 'print join ":", sort {length($a) <=> length($b)} @F'
to:bat:four:floor:dubious
$ # descending order
$ echo "$s" | perl -lane 'print join ":", sort {length($b) <=> length($a)} @F'
dubious:floor:four:bat:to

$ # same as: perl -F -lane 'print sort {$b cmp $a} @F'
$ echo 'foobar' | perl -F -lane 'print reverse sort @F'
roofba
```

Here's an example with multiple sorting conditions. If the transformation applied for each field is expensive, using [Schwartzian transform](https://en.wikipedia.org/wiki/Schwartzian_transform) can provide a faster result. See also [stackoverflow: multiple sorting conditions](https://stackoverflow.com/q/45951050/4082052).

```bash
$ s='try a bad to good i teal by nice how'

$ # longer words first, ascending alphabetic order as tie-breaker
$ echo "$s" | perl -anE 'say join ":",
                    sort {length($b) <=> length($a) or $a cmp $b} @F'
good:nice:teal:bad:how:try:by:to:a:i

$ # using Schwartzian transform
$ echo "$s" | perl -anE 'say join ":", map {$_->[0]}
                         sort {$b->[1] <=> $a->[1] or $a->[0] cmp $b->[0]}
                         map {[$_, length($_)]} @F'
good:nice:teal:bad:how:try:by:to:a:i
```

Here's an example for sorting in descending order based on header column names.

```bash
$ cat marks.txt
Dept    Name    Marks
ECE     Raj     53
ECE     Joel    72
EEE     Moi     68
CSE     Surya   81
EEE     Tia     59
ECE     Om      92
CSE     Amy     67

$ perl -lane '@i = sort {$F[$b] cmp $F[$a]} 0..$#F if $.==1;
              print join "\t", @F[@i]' marks.txt
Name    Marks   Dept
Raj     53      ECE
Joel    72      ECE
Moi     68      EEE
Surya   81      CSE
Tia     59      EEE
Om      92      ECE
Amy     67      CSE
```

>![info](images/info.svg) See [Using modules](#using-modules) chapter for more field processing functions.

## Summary

This chapter discussed various ways in which you can split (or define) the input into fields and manipulate them. Many more examples will be discussed in later chapters.

## Exercises

**a)** Extract only the contents between `()` or `)(` from each input line. Assume that `()` characters will be present only once every line.

```bash
$ cat brackets.txt
foo blah blah(ice) 123 xyz$ 
(almond-pista) choco
yo )yoyo( yo

##### add your solution here
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

##### add your solution here
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
##### add your solution here
Cy
Ith
```

**d)** Display the number of word characters for the given inputs. Word definition here is same as used in regular expressions. Can you construct two different solutions as indicated below?

```bash
$ # solve using 's' operator
$ echo 'hi there' | ##### add your solution here
7

$ # solve without using substitution or transliteration operator
$ echo 'u-no;co%."(do_12:as' | ##### add your solution here
12
```

**e)** Construct a solution that works for both the given sample inputs and the corresponding output shown.

```bash
$ s1='1 "grape" and "mango" and "guava"'
$ s2='("a 1""d""c-2""b")'

$ echo "$s1" | ##### add your solution here
"grape","guava","mango"
$ echo "$s2" | ##### add your solution here
"a 1","b","c-2","d"
```

**f)** Display only the third and fifth characters from each input line.

```bash
$ printf 'restore\ncat one\ncricket' | ##### add your solution here
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

##### add your solution here
1.3,rs,0.134563
3.8,NA,6
5.2,ye,8.2387
4.2,kt,45.1
```

**h)** For the input file `scores.csv`, display the header as well as any row which contains `b` or `t` (irrespective of case) in the first field.

```bash
##### add your solution here
Name,Maths,Physics,Chemistry
Blue,67,46,99
Ort,68,72,66
Ith,100,100,100
```

**i)** Extract all whole words that contains `42` but not at the edge of a word. Assume a word cannot contain `42` more than once.

```bash
$ s='hi42bye nice1423 bad42 cool_42a 42fake'
$ echo "$s" | ##### add your solution here
hi42bye
nice1423
cool_42a
```

**j)** For the input file `scores.csv`, add another column named `GP` which is calculated out of `100` by giving `50%` weightage to `Maths` and `25%` each for `Physics` and `Chemistry`.

```bash
##### add your solution here
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

##### add your solution here
rose lily
pink blue
car,mat
light green,brown
```

**l)** For the given space separated numbers, filter only numbers in the range `20` to `1000` (inclusive).

```bash
$ s='20 -983 5 756 634223'

##### add your solution here
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
##### add your solution here
bot
art

$ # descending order
##### add your solution here
toe
reed
```

**n)** For the given space separated words, extract the three longest words.

```bash
$ s='I bought two bananas and three mangoes'

$ echo "$s" | ##### add your solution here
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

##### add your solution here
apple,1,mango
apple,2,mango
apple,5,mango
wry,4,look
pencil,3,paper
pencil,8,paper
```

**p)** Generate string combinations as shown below for the given input string passed as an environment variable.

```bash
$ s='{x,y,z}{1,2,3}' ##### add your solution here
x1 x2 x3 y1 y2 y3 z1 z2 z3
```

# Record separators

So far, you've seen examples where `perl` automatically splits input data line by line based on the `\n` newline character. Just like you can control how those lines are further split into fields using `-a`, `-F` options and other features, `perl` provides a way to control what constitutes a line in the first place. In `perl` parlance, the term **record** is used to describe the contents that gets placed in the `$_` special variable with `-n` or `-p` options.

## Input record separator

By default, newline character is used as the input record separator. You can change the `$/` special variable to specify a different input record separator. Unlike field separators, you can only use a string value, regexp isn't allowed. See [perldoc faq: I put a regular expression into `$/` but it didn't work. What's wrong?](https://perldoc.perl.org/perlfaq6#I-put-a-regular-expression-into-$/-but-it-didn't-work.-What's-wrong?) for workarounds.

```bash
$ # changing input record separator to comma
$ # note the content of second record, newline is just another character
$ # also note that by default record separator stays with the record contents
$ printf 'this,is\na,sample' | perl -nE 'BEGIN{$/ = ","} say "$.)$_"'
1)this,
2)is
a,
3)sample

$ # use -l option to chomp the record separator
$ printf 'this,is\na,sample' | perl -lne 'BEGIN{$/ = ","} print "$.)$_"'
1)this
2)is
a
3)sample
```

Here's a multicharacter example:

```bash
$ cat report.log
blah blah Error: second record starts
something went wrong
some more details Error: third record
details about what went wrong

$ # uses 'Error:' as the input record separator
$ # print records that contain 'something'
$ perl -lne 'BEGIN{$/ = "Error:"} print if /something/' report.log
 second record starts
something went wrong
some more details 
```

## Single character separator with -0 option

The `-0` command line option can be used to specify a single character record separator, represented with zero to three octal digits. You can also use hexadecimal value. Quoting from [perldoc: -0 option](https://perldoc.perl.org/perlrun#-0%5Boctal/hexadecimal%5D):

>You can also specify the separator character using hexadecimal notation: `-0xHHH...`, where the `H` are valid hexadecimal digits. Unlike the octal form, this one may be used to specify any Unicode character, even those beyond `0xFF`. So if you really want a record separator of `0777`, specify it as `-0x1FF`. (This means that you cannot use the `-x` option with a directory name that consists of hexadecimal digits, or else Perl will think you have specified a hex number to `-0`.)

```bash
$ s='this:is:a:sample:string'

$ # '072' is octal for : character
$ # -l is used to chomp the separator
$ echo "$s" | perl -0072 -lnE 'say "$.) $_"'
1) this
2) is
3) a
4) sample
5) string

$ # print all records containing 'a'
$ echo "$s" | perl -0072 -lnE 'say $_ if /a/'
a
sample
```

>![info](images/info.svg) The character that gets appended to `print` function with `-l` option is based on the value of input record separator at that point. Here's some examples to clarify this point.

```bash
$ s='this:is:a:sample:string'

$ # here record separator is still the default \n when -l is used
$ # so \n gets appended for 'print' function usage
$ # note that chomp isn't affected by such differences in order
$ # same as: echo "$s" | perl -lne 'BEGIN{$/=":"} print if /a/'
$ echo "$s" | perl -l -0072 -ne 'print if /a/'
a
sample

$ # here -l is defined after -0, so : gets appended for 'print'
$ echo "$s" | perl -0072 -lne 'print if /a/'
a:sample:
```

Recall that default `-a` will split input record based on whitespaces and remove leading/trailing whitespaces. Now that you've seen how input record separator can be something other than newline, here's an example to show the full effect of default record splitting.

```bash
$ # ':' character is the input record separator here
$ s='   a\t\tb\n\t\n:1000\n\n\n\n123 7777:x  y \n \n z  '
$ printf '%b' "$s" | perl -0072 -lanE 'say join ",", @F'
a,b
1000,123,7777
x,y,z
```

## NUL separator and slurping

If the `-0` option is used without an argument, the ASCII NUL character will be considered as the input record separator.

```bash
$ printf 'foo\0bar\0' | cat -v
foo^@bar^@

$ # could be golfed to: perl -lp0e ''
$ # can't use -l0 as 0 will be treated as argument to -l
$ printf 'foo\0bar\0' | perl -ln0e 'print'
foo
bar
```

Any octal value of `400` and above will cause the entire input to be slurped as a single string. Idiomatically, `777` is used. This is same as setting `$/ = undef`. Slurping entire file makes it easier to solve some problems, but be careful to not use it for large files that might not fit available memory.

```bash
$ cat paths.txt
/foo/a/report.log
/foo/y/power.log
/foo/abc/errors.log
$ perl -0777 -pe 's|(?<!\A)/.+/|/|s' paths.txt
/foo/errors.log

$ # replicate entire input as many times as needed
$ seq 2 | perl -0777 -ne 'print $_ x 2'
1
2
1
2
```

## Paragraph mode

As a special case, using `-00` or setting `$/` to empty string will invoke paragraph mode. Two or more consecutive newline characters will act as the record separator. Consider the `programming_quotes.txt` sample file, shown here again for convenience:

```bash
$ cat programming_quotes.txt
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it by Brian W. Kernighan

Some people, when confronted with a problem, think - I know, I will
use regular expressions. Now they have two problems by Jamie Zawinski

A language that does not affect the way you think about programming,
is not worth knowing by Alan Perlis

There are 2 hard problems in computer science: cache invalidation,
naming things, and off-by-1 errors by Leon Bambrick
```

Here's some examples of processing the input file paragraph wise.

```bash
$ # all paragraphs containing 'you'
$ # note that the record separator is preserved as there's no chomp
$ perl -00 -ne 'print if /you/' programming_quotes.txt
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it by Brian W. Kernighan

A language that does not affect the way you think about programming,
is not worth knowing by Alan Perlis

$ # all paragraphs containing exactly two lines
$ perl -F'\n' -00 -ane 'print if $#F == 1' programming_quotes.txt
Some people, when confronted with a problem, think - I know, I will
use regular expressions. Now they have two problems by Jamie Zawinski

A language that does not affect the way you think about programming,
is not worth knowing by Alan Perlis

There are 2 hard problems in computer science: cache invalidation,
naming things, and off-by-1 errors by Leon Bambrick
```

>![info](images/info.svg) If the paragraphs are separated by more than two consecutive newlines, the extra newlines will not be part of the record content.

```bash
$ s='a\n\n\n\n\n\n\n\n12\n34\n\nhi\nhello\n'

$ # note again that -l option isn't being used here
$ printf '%b' "$s" | perl -00 -ne 'print if $. <= 2'
a

12
34

```

>![info](images/info.svg) Any leading newlines (only newlines, not other whitespace characters) in the input data file will be trimmed and not lead to empty records. This is similar to how `-a` treats whitespaces for default field separation.

```bash
$ s='\n\n\na\nb\n\n12\n34\n\nhi\nhello\n\n\n\n'

$ # note that -l is used to chomp the record separator here
$ printf '%b' "$s" | perl -00 -lnE 'say "$_\n---" if $. == 1'
a
b
---

$ # max. of two trailing newlines will be preserved if -l isn't used
$ printf '%b' "$s" | perl -00 -lnE 'say "$_\n---" if eof'
hi
hello
---

$ printf '%b' "$s" | perl -00 -nE 'END{say $.}'
3
$ printf '%b' "$s" | perl -00 -nE 'BEGIN{$/="\n\n"}; END{say $.}'
5
```

If you wish to avoid the extra empty line at the end of the output for paragraph mode (or similar situations with other custom record separators), you can either post process the output to remove the extra empty line or add some logic like shown below.

```bash
$ # single paragraph output, no empty line at the end
$ perl -l -00 -ne 'if(/code/){print $s, $_; $s="\n"}' programming_quotes.txt
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it by Brian W. Kernighan

$ # multiple paragraph output with an empty line between the paragraphs
$ perl -l -00 -ne 'if(/you/){print $s, $_; $s="\n"}' programming_quotes.txt
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it by Brian W. Kernighan

A language that does not affect the way you think about programming,
is not worth knowing by Alan Perlis
```

## Output record separator

Similar to `-0` option for input record separator, you can use `-l` option to specify a single character output record separator by passing an octal value as argument.

```bash
$ # comma as output record separator, won't have a newline at the end
$ # note that -l also chomps input record separator
$ seq 8 | perl -l054 -ne 'print if /[24]/'
2,4,

$ # null separator
$ seq 8 | perl -l0 -ne 'print if /[24]/' | cat -v
2^@4^@

$ # adding a final newline to output
$ seq 8 | perl -l054 -nE 'print if /[24]/; END{say}'
2,4,
```

You can use `$\` to specify a multicharacter string that gets appended to the `print` function. This is will override changes due to `-l` option, if any.

```bash
$ # recall that input record separator isn't removed by default
$ seq 2 | perl -ne 'print'
1
2
$ # this will add four more characters after the already present newline
$ # same as: perl -pe 'BEGIN{$\ = "---\n"}'
$ seq 2 | perl -ne 'BEGIN{$\ = "---\n"} print'
1
---
2
---

$ # change NUL record separator to dot and newline
$ # -l here helps to chomp the NUL character 
$ # -l also sets NUL to be added to print, but gets overridden in BEGIN block
$ printf 'foo\0bar\0' | perl -0lpe 'BEGIN{$\ = ".\n"}'
foo.
bar.
```

Many a times, you need to change output record separator depending upon contents of input record or some other condition. The `cond ? expr1 : expr2` ternary operator is often used in such scenarios. The below example assumes that input is evenly divisible, you'll have to add more logic if that is not the case.

```bash
$ # same as: perl -pe 's/\n/-/ if $. % 3'
$ seq 6 | perl -lpe '$\ = $. % 3 ? "-" : "\n"'
1-2-3
4-5-6
```

## Summary

This chapter showed you how to change the way input content is split into records and how to set the string to be appended when `print` is used. The paragraph mode is useful for processing multiline records separated by one or more empty lines. You also learned how to set ASCII NUL as the record separator and how to slurp entire input as a single string.

## Exercises

**a)** The input file `jumbled.txt` consists of words separated by various delimiters. Display all words that contain `an` or `at` or `in` or `it`, one per line.

```bash
$ cat jumbled.txt
overcoats;furrowing-typeface%pewter##hobby
wavering:concession/woof\retailer

##### add your solution here
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
##### add your solution here
Hello World,How are you,This game is good,Today is sunny,12345,You are funny

$ # if there's only one line in input, again make sure there's no trailing ','
$ # and that there's a newline character at the end of the line
$ printf 'foo' | paste -sd,
foo
$ printf 'foo' | ##### add your solution here
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
##### add your solution here
Just do-it
Believe it

Today is sunny
Not a bit funny
No doubt you like it too
```

**d)** For the input file `sample.txt`, change all paragraphs into single line by joining lines using `.` and a space character as the separator. And add a final `.` to each paragraph.

```bash
$ # note that there's no extra empty line at the end of expected output
##### add your solution here
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
$ printf "$s" | ##### add your solution here
mango:100;;grapes:75;; 
```

# Using modules

There are many standard modules available that come by default with Perl installation. And there's plenty of third-party modules available for wide variety of use cases. This chapter will discuss the `-M` command line option and show some examples with standard and third-party modules. You'll also see how to convert one-liners to full fledged script file.

## Standard modules

See [perldoc: modules](https://perldoc.perl.org/modules) for complete list of built-in modules. Quoting from [perldoc: -m and -M options](https://perldoc.perl.org/perlrun#-m%5B-%5Dmodule)

>`-Mmodule` executes `use module ;` before executing your program. This loads the module and calls its `import` method, causing the module to have its default effect, typically importing subroutines or giving effect to a pragma. You can use quotes to add extra code after the module name, e.g., `'-MMODULE qw(foo bar)'`.
>
>A little builtin syntactic sugar means you can also say `-mMODULE=foo,bar` or `-MMODULE=foo,bar` as a shortcut for `'-MMODULE qw(foo bar)'`. This avoids the need to use quotes when importing symbols. The actual code generated by `-MMODULE=foo,bar` is `use module split(/,/,q{foo,bar})`. Note that the `=` form removes the distinction between `-m` and `-M`; that is, `-mMODULE=foo,bar` is the same as `-MMODULE=foo,bar`

The `List::Util` module has handy functions for array processing. See [perldoc: List::Util](https://perldoc.perl.org/List::Util) for documentation. Here's some examples with `max`, `product` and `sum0`.

```bash
$ # same as: perl -F, -anE 'BEGIN{use List::Util qw(max)} say max @F'
$ echo '34,17,6' | perl -MList::Util=max -F, -anE 'say max @F'
34

$ echo '34,17,6' | perl -MList::Util=product -F, -anE 'say product @F'
3468

$ # 'sum0' returns '0' even if array is empty, whereas 'sum' returns 'undef'
$ echo '3.14,17,6' | perl -MList::Util=sum0 -F, -anE 'say sum0 @F'
26.14
```

Here's some examples for `shuffle`, `sample` and `uniq`.

```bash
$ s='floor bat to dubious four'
$ echo "$s" | perl -MList::Util=shuffle -lanE 'say join ":", shuffle @F'
bat:four:dubious:floor:to
$ echo 'foobar' | perl -MList::Util=shuffle -F -lanE 'say shuffle @F'
afbroo

$ # similar to shuffle, but can specify number of elements needed
$ echo "$s" | perl -MList::Util=sample -lanE 'say join ":", sample 2, @F'
dubious:bat

$ s='3,b,a,3,c,d,1,d,c,2,2,2,3,1,b'
$ # note that the input order of elements is preserved
$ echo "$s" | perl -MList::Util=uniq -F, -lanE 'say join ",",uniq @F'
3,b,a,c,d,1,2
```

Here's an example for `base64` encoding and decoding. See [perldoc: MIME::Base64](https://perldoc.perl.org/MIME::Base64) for documentation.

```bash
$ echo 'hello world' | base64
aGVsbG8gd29ybGQK

$ echo 'hello world' | perl -MMIME::Base64 -ne 'print encode_base64 $_'
aGVsbG8gd29ybGQK
$ echo 'aGVsbG8gd29ybGQK' | perl -MMIME::Base64 -ne 'print decode_base64 $_'
hello world
```

## Third party modules

The **Comprehensive Perl Archive Network** ([https://www.cpan.org/](https://www.cpan.org/)) has a huge collection of modules for various use cases. Before installing a new module, first check if the module is already installed or not:

```bash
$ # output modified here for presentation purposes
$ perl -MText::CSV -e ''
Can't locate Text/CSV.pm in @INC (you may need to install the Text::CSV module)
(@INC contains: <list of paths>).
BEGIN failed--compilation aborted.
```

If you are using the `perl` version that came installed with your OS, check if you can install a module from your platform repository. Here's an example for Ubuntu:

```bash
$ # search for Text::CSV module
$ apt-cache search perl text-csv
libspreadsheet-read-perl - reader for common spreadsheet formats
libtext-csv-encoded-perl - encoding-aware comma-separated values manipulator
libtext-csv-perl - comma-separated values manipulator (using XS or PurePerl)
libtext-csv-xs-perl - Perl C/XS module to process Comma-Separated Value files

$ # install the module of your choice
$ sudo apt install libtext-csv-xs-perl
```

The above process may fail to work with `perl` version that you manually installed or if a particular module isn't available from your platform repository. There are different options for such cases.

* [stackoverflow: easiest way to install a missing module](https://stackoverflow.com/q/65865/4082052) shows how to use the `cpan` command and has details for Windows platform too. You might need admin privileges.
* [metacpan: cpanm](https://metacpan.org/pod/cpanm) is also often recommended
* [metacpan: Carton](https://metacpan.org/pod/Carton) is a Perl module dependency manager (aka Bundler for Perl)

## CSV

For robustly parsing `csv` files, you can use [metacpan: Text::CSV](https://metacpan.org/pod/Text::CSV) or [metacpan: Text::CSV_XS](https://metacpan.org/pod/Text::CSV_XS) modules. `_XS` indicates a faster implementation, usually written in `C` language. The `Text::CSV` module uses `Text::CSV_XS` by default and uses `Text::CSV_PP` (pure Perl implementation) if `_XS` module isn't available.

Here's an example of parsing `csv` input with embedded comma characters. `ARGV` is a special filehandle that iterates over filenames passed as command line arguments, see [Multiple file input](#multiple-file-input) chapter for more details.

```bash
$ s='eagle,"fox,42",bee,frog\n1,2,3,4'
$ # note that -n or -p option isn't used here
$ printf '%b' "$s" | perl -MText::CSV_XS -E 'say $row->[1]
                     while $row = Text::CSV_XS->new->getline(*ARGV)'
fox,42
2
```

Here's an example with embedded newline characters. Quoting from documentation:

>**Important Note:** The default behavior is to accept only ASCII characters in the range from `0x20` (space) to `0x7E` (tilde). This means that the fields can not contain newlines. If your data contains newlines embedded in fields, or characters above `0x7E` (tilde), or binary data, you must set `binary => 1` in the call to `new`.

```bash
$ cat newline.csv
apple,"1
2
3",good
guava,"32
54",nice

$ perl -MText::CSV_XS -E '
        while($row = Text::CSV_XS->new({binary => 1})->getline(*ARGV))
        {say "$row->[1]\n-----"}' newline.csv
1
2
3
-----
32
54
-----
```

You can change field separator using the `sep_char` option.

```bash

$ perl -MText::CSV_XS -E '
        while($row = Text::CSV_XS->new({sep_char => "\t"})->getline(*ARGV))
        {say join ",", @$row if $row->[0] eq "CSE"}' marks.txt
CSE,Surya,81
CSE,Amy,67
```

## JSON

Newer versions of Perl come with [perldoc: JSON::PP](https://perldoc.perl.org/JSON::PP) module, which is a pure Perl implementation. Use [metacpan: JSON::XS](https://metacpan.org/pod/JSON::XS) for faster results. There's also [metacpan: Cpanel::JSON::XS](https://metacpan.org/pod/Cpanel::JSON::XS), which mentions the following reason:

>While it seems there are many JSON modules, none of them correctly handle all corner cases, and in most cases their maintainers are unresponsive, gone missing, or not listening to bug reports for other reasons.

Here's a simple example of parsing JSON from a single line of input data.

```bash
$ s='{"greeting":"hi","marks":[78,62,93]}'

$ # <> is same as <ARGV>, here it helps to get a line of input
$ echo "$s" | perl -MCpanel::JSON::XS -E '$ip=decode_json <>; say $ip->{greeting}'
hi

$ echo "$s" | perl -MCpanel::JSON::XS -E '$ip=decode_json <>;
              say join ":", @{$ip->{marks}}'
78:62:93
```

For multiline input, use `-0777` (or set `$/ = undef`) to pass entire input content as single string. You can create a shortcut to make it easier for one-liners.

```bash
$ # check if shortcut is available
$ type pj
bash: type: pj: not found

$ # add this to your ~/.bashrc (or the file you use for aliases/functions)
$ pj() { perl -MCpanel::JSON::XS -0777 -E '$ip=decode_json <>;'"$@" ; }

$ s='{"greeting":"hi","marks":[78,62,93]}'

$ echo "$s" | pj 'say $ip->{greeting}'
hi
```

Here's another example.

```bash
$ cat sample.json
{
    "fruit": "apple",
    "blue": ["toy", "flower", "sand stone"],
    "light blue": ["flower", "sky", "water"],
    "language": {
        "natural": ["english", "hindi", "spanish"],
        "programming": ["python", "kotlin", "ruby"]
    },
    "physics": 84
}

$ # order may be different than input as hash doesn't maintain key order
$ # process top-level keys not containing 'e'
$ pj 'for (keys %$ip){say "$_:$ip->{$_}" if !/e/}' sample.json
physics:84
fruit:apple

$ # process keys within 'language' key that contain 't'
$ pj '$"=","; while(($k,$v) = each %{$ip->{language}})
      {say "$k:@{$v}" if $k=~/t/}' sample.json
natural:english,hindi,spanish
```

Here's an example of converting possibly minified `json` input to a pretty printed output. You can use `json_pp` for `JSON::PP` and `json_xs` for `JSON::XS`.

```bash
$ s='{"greeting":"hi","marks":[78,62,93],"fruit":"apple"}'

$ # same as: echo "$s" | perl -MCpanel::JSON::XS -e '
$ #          print Cpanel::JSON::XS->new->pretty->encode(decode_json <>)'
$ echo "$s" | cpanel_json_xs
{
   "fruit" : "apple",
   "greeting" : "hi",
   "marks" : [
      78,
      62,
      93
   ]
}
```

If you need to preserve order, see:

* [stackoverflow: Hash::Ordered versus Tie::IxHash with JSON::XS encode](https://stackoverflow.com/q/38028559/4082052)
* [stackoverflow: decode and encode json preserving order](https://stackoverflow.com/q/51366750/4082052)

## Convert one-liners to pretty formatted scripts

The `O` module can be used to convert one-liners to full fledged programs. See [perldoc: O](https://perldoc.perl.org/O) for documentation. This is similar to `-o` option for `GNU awk`.

Here's how `-n` and `-p` options are implemented.

```bash
$ # note that input sources (stdin, filenames, etc) aren't needed here
$ perl -MO=Deparse -ne 'print if /at/'
LINE: while (defined($_ = readline ARGV)) {
    print $_ if /at/;
}
-e syntax OK

$ perl -MO=Deparse -pe 's/ /:/g'
LINE: while (defined($_ = readline ARGV)) {
    s/ /:/g;
}
continue {
    die "-p destination: $!\n" unless print $_;
}
-e syntax OK
```

>![info](images/info.svg) You can use `-MO=qq,Deparse` if you don't want to see the `-e syntax OK` message.

The `Deparse` output is very useful to debug record separator scripts.

```bash
$ perl -MO=Deparse -l -0072 -ne 'print if /a/'
BEGIN { $/ = ":"; $\ = "\n"; }
LINE: while (defined($_ = readline ARGV)) {
    chomp $_;
    print $_ if /a/;
}
-e syntax OK

$ perl -MO=Deparse -00 -ne 'print if /it/'
BEGIN { $/ = ""; $\ = undef; }
LINE: while (defined($_ = readline ARGV)) {
    print $_ if /it/;
}
-e syntax OK
```

Here's an alternate way to specify code to be executed after the `while` loop instead of using `END` block, when `-n` option is being used. This cannot be used with `-p` option because it will disrupt the `continue` block.

```bash
$ perl -MO=Deparse -ne 'print if /4/ }{ print "==> the end\n"'
LINE: while (defined($_ = readline ARGV)) {
    print $_ if /4/;
}
{
    print "==> the end\n";
}
-e syntax OK
```

Here's an example of saving the script to a file instead of displaying on the terminal.

```bash
$ perl -MO=Deparse -ne 'print if /4/' > script.pl
-e syntax OK
$ cat script.pl
LINE: while (defined($_ = readline ARGV)) {
    print $_ if /4/;
}

$ perl script.pl table.txt
brown bread mat hair 42
yellow banana window shoes 3.14
```

>![info](images/info.svg) ![info](images/info.svg) If you have noted the `Deparse` output very carefully, you'll see that the `while` loop has a `LINE` label. So, you can use `next LINE` to move onto the next input record even if you are inside other loops/blocks.

## Modules to explore

* [Awesome Perl](https://github.com/hachiojipm/awesome-perl) — curated list of awesome Perl5 frameworks, libraries and software
* [bioperl](https://bioperl.org/howtos/index.html) — practical descriptions of BioPerl modules
* [metacpan: XML::LibXML](https://metacpan.org/pod/XML::LibXML) — xml/html parsing
* [metacpan: String::Approx](https://metacpan.org/pod/String::Approx) — fuzzy matching
* [metacpan: Tie::IxHash](https://metacpan.org/pod/Tie::IxHash) — ordered associative arrays for Perl
* [unix.stackexchange: example for Algorithm::Combinatorics](https://unix.stackexchange.com/q/310840/109046)
* [unix.stackexchange: example for Text::ParseWords](https://unix.stackexchange.com/q/319301/109046)
* [unix.stackexchange: sort words by syllable count using Lingua::EN::Syllable](https://unix.stackexchange.com/q/280492/109046)
* [stackoverflow: regular expression modules](https://stackoverflow.com/q/3258847/4082052)

## Summary

This chapter showed how to enable modules via `-M` option and some examples for standard and third-party modules. You also saw how to convert cryptic one-liners to full fledged `perl` script using the `O` module.

## Exercises

**a)** For the given space separated words, display the max word determined by alphabetic order.

```bash
$ s='let in bat xml me lion'

$ echo "$s" | ##### add your solution here
xml
```

**b)** For the given space separated words, randomize the order of characters for each word.

```bash
$ s='this is a sample sentence'

$ # sample randomized output shown here, could be different for you
$ echo "$s" | ##### add your solution here
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

##### add your solution here
flower
sand stone
```

**d)** Display current time in the format shown below.

```bash
$ # output will be different for you
##### add your solution here
29-Oct-2020 14:23:17
```

>![info](images/info.svg) See [metacpan: DateTime](https://metacpan.org/pod/DateTime) for more comprehensive functions.

# Multiple file input

You have seen special blocks like `BEGIN`, `END` and control structures like `next` and `exit` that affect the entire input contents. This chapter will discuss features that help to make decisions around individual files when there are multiple files passed as input.

## @ARGV, $ARGV and ARGV

From [perldoc: @ARGV](https://perldoc.perl.org/variables/@ARGV):

>The array `@ARGV` contains the command-line arguments intended for the script. `$#ARGV` is generally the number of arguments minus one, because `$ARGV[0]` is the first argument, not the program's command name itself.

```bash
$ # note that only -E option is used here
$ perl -E 'say join "\n", @ARGV' f[1-3].txt greeting.txt
f1.txt
f2.txt
f3.txt
greeting.txt

$ # @ARGV continuously ejects the filename being processed
$ # f1.txt and f2.txt have 1 line each, table.txt has 3 lines
$ perl -nE 'say "$#ARGV: " . join ",", @ARGV' f[12].txt table.txt
1: f2.txt,table.txt
0: table.txt
-1: 
-1: 
-1: 
```

>![info](images/info.svg) See also [stackoverflow: referencing filename passed as arguments](https://stackoverflow.com/q/9151243/4082052) for more details about `@ARGV` behavior when `-n` or `-p` switch is active.

From [perldoc: $ARGV](https://perldoc.perl.org/variables/$ARGV):

>Contains the name of the current file when reading from `<>`.

From [perldoc: ARGV](https://perldoc.perl.org/variables/ARGV):

>The special filehandle that iterates over command-line filenames in `@ARGV`. Usually written as the null filehandle in the angle operator `<>`. Note that currently `ARGV` only has its magical effect within the `<>` operator; elsewhere it is just a plain filehandle corresponding to the last file opened by `<>`.

By closing `ARGV` at the end of each input file, you can reset the `$.` variable.

```bash
$ # logic to do something at the start of each input file
$ # closing ARGV will reset $.
$ perl -ne 'print "--- $ARGV ---\n" if $. == 1;
            print;
            close ARGV if eof' greeting.txt table.txt
--- greeting.txt ---
Hi there
Have a nice day
Good bye
--- table.txt ---
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14

$ # do something at the end of a file
$ # same as: tail -q -n1 greeting.txt table.txt
$ perl -ne 'print if eof' greeting.txt table.txt
Good bye
yellow banana window shoes 3.14
```

Here's some more examples.

```bash
$ # same as: awk 'FNR==2{print; nextfile}' greeting.txt table.txt
$ perl -ne 'print and close ARGV if $.==2' greeting.txt table.txt
Have a nice day
blue cake mug shirt -7

$ # same as: head -q -n1 and awk 'FNR>1{nextfile} 1'
$ # can also use: perl -pe 'close ARGV'
$ perl -pe 'close ARGV if $.>=1' greeting.txt table.txt
Hi there
brown bread mat hair 42
```

In scalar context, `<>` will return the next input record and in list context, `<>` returns all the remaining input records. If you need a single character instead of a record, you can use `getc` function. See [perldoc: getc](https://perldoc.perl.org/perlfunc#getc) for documentation.

```bash
$ # note that only -e option is used, same as: perl -e 'print scalar <>'
$ perl -e 'print scalar readline' greeting.txt
Hi there
$ perl -e '$line = <>; print "$line---\n"; print <>' greeting.txt
Hi there
---
Have a nice day
Good bye

$ # note that default filehandle for getc is STDIN
$ perl -E 'say getc' <greeting.txt
H
```

## STDIN

The `STDIN` filehandle is useful to distinguish between files passed as argument and `stdin` data. See [Comparing records](#comparing-records) section for more examples.

```bash
$ # with no file arguments, <> reads stdin data
$ printf 'apple\nmango\n' | perl -e 'print <>'
apple
mango

$ # with file arguments, <> doesn't read stdin data
$ printf 'apple\nmango\n' | perl -e 'print <>' greeting.txt
Hi there
Have a nice day
Good bye

$ printf 'apple\nmango\n' | perl -e 'print <STDIN>' greeting.txt
apple
mango
```

## Skipping remaining contents per file

You have seen examples where `exit` function is used to avoid processing unnecessary records for the current and any other files yet to be processed. Sometimes, you need to skip only contents for the current file and move on to next file for processing. The `close ARGV` example seen previously comes in handy for such cases.

```bash
$ # print filename if it contains 'I' anywhere in the file
$ # same as: grep -l 'I' f[1-3].txt greeting.txt
$ # same as: perl -0777 -nE 'say $ARGV if /I/'
$ # but slurping is dependent on size of input files and available memory
$ perl -nE 'if(/I/){say $ARGV; close ARGV}' f[1-3].txt greeting.txt
f1.txt
f2.txt

$ # print filename if it contains a word ending with 'e'
$ # and 'bat' or 'mat' (irrespective of case) anywhere in the file
$ # same as: perl -0777 -nE 'say $ARGV if /(?=.*?e\b)(?i).*[bm]at/s'
$ perl -nE '$m1=1 if /e\b/; $m2=1 if /[bm]at/i;
            if($m1 && $m2){say $ARGV; $m1=$m2=0; close ARGV; next};
            $m1=$m2=0 if eof' f[1-3].txt greeting.txt
f3.txt
```

## Summary

This chapter introduced features for processing multiple file inputs and constructing file level decisions. These will show up in many more examples in coming chapters.

## Exercises

**a)** Print the last field of first two lines for the input files passed as arguments to the `perl` script. Assume space as the field separators for these two files. To make the output more informative, print filenames and a separator as shown in the output below. Assume input files will have at least two lines.

```bash
$ # assume table.txt ip.txt are passed as file inputs
##### add your solution here
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
##### add your solution here
secrets.txt
ip.txt
table.txt
```

**c)** Print the first two lines for each of the input files `ip.txt`, `sample.txt` and `table.txt`. Also, add a separator between the results as shown below (note that the separator isn't present at the end of the output). Assume input files will have at least two lines.

```bash
##### add your solution here
Hello World
How are you
---
Hello World

---
brown bread mat hair 42
blue cake mug shirt -7
```

# Processing multiple records

Often, you need to consider multiple lines at a time to make a decision, such as the paragraph mode examples seen earlier. Sometimes, you need to match a particular record and then get records surrounding the matched record. Solution to these type of problems often take the form of state machines. See [softwareengineering: FSM examples](https://softwareengineering.stackexchange.com/questions/47806/examples-of-finite-state-machines) if you are not familiar with state machines.

## Processing consecutive records

You might need a condition that should satisfy something for one record and something else for the very next record. There are many ways to tackle this problem. One possible solution is to use a variable to save the previous record and then create the required conditional expression using that variable and `$_` which already has the current record content.

```bash
$ # match and print two consecutive records
$ # first record should contain 'as' and second record should contain 'not'
$ perl -ne 'print $p, $_ if /not/ && $p=~/as/; $p = $_' programming_quotes.txt
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it by Brian W. Kernighan

$ # same filtering as above, but print only the first record
$ perl -ne 'print $p if /not/ && $p=~/as/; $p = $_' programming_quotes.txt
Therefore, if you write the code as cleverly as possible, you are,

$ # same filtering as above, but print only the second record
$ perl -ne 'print if /not/ && $p=~/as/; $p = $_' programming_quotes.txt
by definition, not smart enough to debug it by Brian W. Kernighan
```

## Context matching

Sometimes you want not just the matching records, but the records relative to the matches as well. For example, it could be to see the comments at the start of a function block that was matched while searching a program file. Or, it could be to see extended information from a log file while searching for a particular error message.

Consider this sample input file:

```bash
$ cat context.txt
blue
    toy
    flower
    sand stone
light blue
    flower
    sky
    water
language
    english
    hindi
    spanish
    tamil
programming language
    python
    kotlin
    ruby
```

**Case 1:** Here's an example that emulates `grep --no-group-separator -A<n>` functionality. The `$n && $n--` trick used in the example below works like this:

* If initially `$n=2`
    * `2 && 2` --> evaluates to `true` and `$n` becomes `1`
    * `1 && 1` --> evaluates to `true` and `$n` becomes `0`
    * ``0 &&  `` --> evaluates to `false` and `$n` doesn't change
* Note that when conditionals are connected with logical `&&`, the second expression will not be executed at all if the first one turns out to be `false` because the overall result will always be `false`. Same is the case if the first expression evaluates to `true` with logical `||` operator. Such logical operators are also known as **short-circuit** operators. Thus, in the above case, `$n--` won't be executed when `$n` is `0` on the left hand side. This prevents `$n` going negative and `$n && $n--` will never become `true` unless `$n` is assigned again.

```bash
$ # same as: grep --no-group-separator -A1 'blue'
$ # print matching line as well as the one that follows it
$ perl -ne '$n=2 if /blue/; print if $n && $n--' context.txt
blue
    toy
light blue
    flower

$ # for overlapping cases, $n gets re-assigned before $n becomes 0
$ perl -ne '$n=2 if /toy|flower/; print if $n && $n--' context.txt
    toy
    flower
    sand stone
    flower
    sky
```

Once you've understood the above examples, the rest of the examples in this section should be easier to comprehend. They are all variations of the logic used above and re-arranged to solve the use case being discussed.

**Case 2:** Print `n` records after the matching record. This is similar to previous case, except that the matching record isn't printed.

```bash
$ # print 2 lines after the matching line
$ perl -ne 'print if $n && $n--; $n=2 if /prog/' context.txt
    python
    kotlin
```

**Case 3:** Printing `n`th record after the matching record.

```bash
$ # print only the 3rd line found after the matching line
$ # $n && !--$n will be true only when --$n yields 0
$ # overlapping cases won't work as $n gets re-assigned before going to 0
$ perl -ne 'print if $n && !--$n; $n=3 if /language/' context.txt
    spanish
    ruby
```

**Case 4:** Printing the matched record and `n` records before it.

```bash
$ # print matched record and 2 records before the match
$ perl -ne '$ip[$.]=$_; print @ip[$.-2 .. $.] if /stone/' context.txt
    toy
    flower
    sand stone

$ # this will work even if there are less than n records before a match
$ n=5 perl -ne '$i=$.-$ENV{n}; $i=0 if $i<0; $ip[$.]=$_;
                print @ip[$i .. $.] if /toy/' context.txt
blue
    toy
```

To prevent confusion with overlapping cases, you can add a separation line between the results.

```bash
$ n=2 perl -ne '$i=$.-$ENV{n}; $i=0 if $i<0; $ip[$.]=$_;
                if(/toy|flower/){print $s, @ip[$i .. $.]; $s="---\n"}' context.txt
blue
    toy
---
blue
    toy
    flower
---
    sand stone
light blue
    flower
```

**Case 5:** Print `n`th record before the matching record.

```bash
$ n=2 perl -ne '$i=$.-$ENV{n}; $i=0 if $i<0; $ip[$.]=$_;
                print $ip[$i] if /language/' context.txt
    sky
    spanish

$ # if the count is small enough, you can save them in variables
$ # this one prints 2nd line before the matching line
$ perl -ne 'print $p2 if /toy|flower/; $p2=$p1; $p1=$_' context.txt
blue
    sand stone
```

You can also use the logic from **Case 3** by applying `tac` twice. This avoids the need to use a hash variable.

```bash
$ tac context.txt | perl -ne 'print if $n && !--$n; $n=2 if /language/' | tac
    sky
    spanish
```

## Records bounded by distinct markers

This section will cover cases where the input file will always contain the same number of starting and ending patterns and arranged in alternating fashion. For example, there cannot be two starting patterns appearing without an ending pattern between them and vice versa. Zero or more records of text can appear inside such groups as well as in between the groups.

The sample file shown below will be used to illustrate examples in this section. For simplicity, assume that the starting pattern is marked by `start` and the ending pattern by `end`. They have also been given group numbers to make it easier to visualize the transformation between input and output for the commands discussed in this section.

```bash
$ cat uniform.txt
mango
icecream
--start 1--
1234
6789
**end 1**
how are you
have a nice day
--start 2--
a
b
c
**end 2**
par,far,mar,tar
```

**Case 1:** Processing all the groups of records based on the distinct markers, including the records matched by markers themselves. For simplicity, the below command will just print all such records.

```bash
$ perl -ne '$f=1 if /start/; print if $f; $f=0 if /end/' uniform.txt
--start 1--
1234
6789
**end 1**
--start 2--
a
b
c
**end 2**
```

>![info](images/info.svg) `perl -ne 'print if /start/../end/'` can be used as seen previously in [Range operator](#range-operator) section. The state machine format is more flexible for various cases to follow.

**Case 2:** Processing all the groups of records but excluding the records matched by markers themselves.

```bash
$ perl -ne '$f=0 if /end/; print "* $_" if $f; $f=1 if /start/' uniform.txt
* 1234
* 6789
* a
* b
* c
```

**Case 3-4:** Processing all the groups of records but excluding one of the markers.

```bash
$ perl -ne '$f=1 if /start/; $f=0 if /end/; print if $f' uniform.txt
--start 1--
1234
6789
--start 2--
a
b
c

$ perl -ne 'print if $f; $f=1 if /start/; $f=0 if /end/' uniform.txt
1234
6789
**end 1**
a
b
c
**end 2**
```

The next four cases are obtained by just using `if !$f` instead of `if $f` from the cases shown above.

**Case 5:** Processing all input records except the groups of records bound by the markers.

```bash
$ # same as: perl -ne 'print if !(/start/../end/)'
$ perl -ne '$f=1 if /start/; print if !$f; $f=0 if /end/' uniform.txt
mango
icecream
how are you
have a nice day
par,far,mar,tar
```

**Case 6** Processing all input records except the groups of records between the markers.

```bash
$ perl -ne '$f=0 if /end/; print if !$f; $f=1 if /start/' uniform.txt
mango
icecream
--start 1--
**end 1**
how are you
have a nice day
--start 2--
**end 2**
par,far,mar,tar
```

**Case 7-8:** Similar to case 6, but include only one of the markers.

```bash
$ perl -ne 'print if !$f; $f=1 if /start/; $f=0 if /end/' uniform.txt
mango
icecream
--start 1--
how are you
have a nice day
--start 2--
par,far,mar,tar

$ perl -ne '$f=1 if /start/; $f=0 if /end/; print if !$f' uniform.txt
mango
icecream
**end 1**
how are you
have a nice day
**end 2**
par,far,mar,tar
```

## Specific blocks

Instead of working with all the groups (or blocks) bound by the markers, this section will discuss how to choose blocks based on some additional criteria.

Here's how you can process only the first matching block. See also [stackoverflow: copy pattern between range only once](https://stackoverflow.com/q/38481155/4082052) and [stackoverflow: extract only first range](https://stackoverflow.com/a/63072979/4082052).

```bash
$ perl -ne '$f=1 if /start/; print if $f; exit if /end/' uniform.txt
--start 1--
1234
6789
**end 1**
$ # use other tricks discussed in previous section as needed
$ perl -ne 'exit if /end/; print if $f; $f=1 if /start/' uniform.txt
1234
6789
```

Getting last block alone involves lot more work, unless you happen to know how many blocks are present in the input file.

```bash
$ # reverse input linewise, change the order of comparison, reverse again
$ # can't be used if record separator has to be something other than newline
$ tac uniform.txt | perl -ne '$f=1 if /end/; print if $f; exit if /start/' | tac
--start 2--
a
b
c
**end 2**

$ # or, save the blocks in a buffer and print the last one alone
$ perl -ne 'if(/start/){$f=1; $buf=$_; next}
            $buf .= $_ if $f;
            $f=0 if /end/;
            END{print $buf}' uniform.txt
--start 2--
a
b
c
**end 2**
```

Only the `n`th block.

```bash
$ seq 30 | perl -ne 'BEGIN{$n=2; $c=0} $c++ if /4/; if($c==$n){print; exit if /6/}'
14
15
16
```

All blocks greater than `n`th block.

```bash
$ seq 30 | perl -ne 'BEGIN{$n=1; $c=0} if(/4/){$f=1; $c++}
                     print if $f && $c>$n; $f=0 if /6/'
14
15
16
24
25
26
```

Excluding `n`th block.

```bash
$ seq 30 | perl -ne 'BEGIN{$n=2; $c=0} if(/4/){$f=1; $c++}
                     print if $f && $c!=$n; $f=0 if /6/'
4
5
6
24
25
26
```

All blocks, only if the block matches an additional condition.

```bash
$ # additional condition here is '15' as one of the lines in the block
$ seq 30 | perl -ne 'if(/4/){$f=1; $buf=$_; next}
                     $buf .= $_ if $f;
                     if(/6/){$f=0; print $buf if $buf=~/^15$/m}'
14
15
16
```

## Broken blocks

Sometimes, you can have markers in random order and mixed in different ways. In such cases, to work with blocks without any other marker present in between them, the buffer approach comes in handy again.

```bash
$ cat broken.txt
qqqqqqqqqqqqqqqq
error 1
hi
error 2
1234
6789
state 1
bye
state 2
error 3
xyz
error 4
abcd
state 3
zzzzzzzzzzzzzzzz

$ perl -ne 'if(/error/){$f=1; $buf=$_; next}
            $buf .= $_ if $f;
            if(/state/){print $buf if $f; $f=0}' broken.txt
error 2
1234
6789
state 1
error 4
abcd
state 3
```

## Summary

This chapter covered various examples of working with multiple records. State machines play an important role in deriving solutions for such cases. Knowing various corner cases is also crucial, otherwise a solution that works for one input may fail for others.

Next chapter will discuss use cases where you need to process a file input based on contents of another file.

## Exercises

**a)** For the input file `sample.txt`, print a matching line containing `do` only if the previous line is empty and the line before that contains `you`.

```bash
##### add your solution here
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

##### add your solution here
No doubt you like it too
Much ado about nothing
```

**c)** For the input file `sample.txt`, print matching line as well as `n` lines around the matching lines. The value for `n` is passed to the `perl` command as an environment value.

```bash
$ # match a line containing 'are' or 'bit'
$ n=1 ##### add your solution here
Good day
How are you

Today is sunny
Not a bit funny
No doubt you like it too

$ # match a line containing 'World'
$ n=2 ##### add your solution here
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
##### add your solution here
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

$ n=2 ##### add your solution here
%%% broken.txt
top %%%
1234567890
bottom

$ n=4 ##### add your solution here
%%% mixed_fs.txt
pink blue white yellow
car,mat,ball,basket
```

**f)** For the input file `perl.md`, replace all occurrences of `perl` (irrespective of case) with `Perl`. But, do not replace any matches between ` ```perl ` and ` ``` ` lines (`perl` in these markers shouldn't be replaced either).

```bash
##### add your solution here, redirect the output to 'out.md'

$ diff -sq out.md expected.md 
Files out.md and expected.md are identical
```

**g)** Print the last two lines for each of the input files `ip.txt`, `sample.txt` and `table.txt`. Also, add a separator between the results as shown below (note that the separator isn't present at the end of the output). Assume input files will have at least two lines.

```bash
##### add your solution here
12345
You are funny
---
Much ado about nothing
He he he
---
blue cake mug shirt -7
yellow banana window shoes 3.14
```

# Two file processing

This chapter focuses on solving problems which depend upon contents of two or more files. These are usually based on comparing records and fields. Sometimes, record number plays a role too. You'll also see some examples where entire file content is used.

## Comparing records

Consider the following input files which will be compared line wise to get common lines and unique lines.

```bash
$ cat color_list1.txt
teal
light blue
green
yellow

$ cat color_list2.txt
light blue
black
dark green
yellow
```

If you do not wish to use modules, you can make use of hash to compare records between two files.

```bash
$ # common lines
$ # same as: grep -Fxf color_list1.txt color_list2.txt
$ # for two file input, $#ARGV will be 0 only for the first file
$ # note that 'exists' isn't strictly necessary here
$ perl -ne 'if(!$#ARGV){$h{$_}=1; next}
            print if exists $h{$_}' color_list1.txt color_list2.txt
light blue
yellow

$ # lines from color_list2.txt not present in color_list1.txt
$ # same as: grep -vFxf color_list1.txt color_list2.txt
$ perl -ne 'if(!$#ARGV){$h{$_}=1; next}
            print if !exists $h{$_}' color_list1.txt color_list2.txt
black
dark green

$ # reversing the order of input files gives
$ # lines from color_list1.txt not present in color_list2.txt
$ perl -ne 'if(!$#ARGV){$h{$_}=1; next}
            print if !exists $h{$_}' color_list2.txt color_list1.txt
teal
green
```

Here's some alternate ways to construct a solution for above examples.

```bash
$ # using if-else instead of next
$ perl -ne 'if(!$#ARGV){ $h{$_}=1 }
            else{ print if exists $h{$_} }' color_list1.txt color_list2.txt
light blue
yellow

$ # read all lines from first file passed as STDIN in BEGIN block
$ perl -ne 'BEGIN{ $h{$_}=1 while <STDIN> }
            print if exists $h{$_}' <color_list1.txt color_list2.txt
light blue
yellow
```

## Using modules for set operations

You can use `uniq` function from `List::Util` module to preserve only one copy of duplicates from one or more input files. See [Dealing with duplicates](#dealing-with-duplicates) chapter for field based duplicate processing.

```bash
$ # input order of lines is preserved
$ # this is same as performing union between two sets
$ perl -MList::Util=uniq -e 'print uniq <>' color_list1.txt color_list2.txt
teal
light blue
green
yellow
black
dark green
```

The [metacpan: List::Compare](https://metacpan.org/pod/List::Compare) module supports set operations like **union**, **intersection**, **symmetric difference** etc. See also [metacpan: Array::Utils](https://metacpan.org/pod/Array::Utils).

```bash
$ # union, input order of lines is NOT preserved
$ # note that only -e option is used and one of the files is passed as stdin
$ perl -MList::Compare -e '@a1=<STDIN>; @a2=<>;
         print List::Compare->new(\@a1, \@a2)->get_union
        ' <color_list1.txt color_list2.txt
black
dark green
green
light blue
teal
yellow

$ # intersection (common lines)
$ perl -MList::Compare -e '@a1=<STDIN>; @a2=<>;
         print List::Compare->new(\@a1, \@a2)->get_intersection
        ' <color_list1.txt color_list2.txt
light blue
yellow

$ # lines from color_list1.txt not present in color_list2.txt
$ perl -MList::Compare -e '@a1=<STDIN>; @a2=<>;
         print List::Compare->new(\@a1, \@a2)->get_unique      
        ' <color_list1.txt color_list2.txt
green
teal
```

## Comparing fields

In the previous sections, you saw how to compare whole contents of records between two files. This section will focus on comparing only specific field(s). The below sample file will be one of the two file inputs for examples in this section. Consider whitespace as the field separator, so `-a` option is enough to get the fields.

```bash
$ cat marks.txt
Dept    Name    Marks
ECE     Raj     53
ECE     Joel    72
EEE     Moi     68
CSE     Surya   81
EEE     Tia     59
ECE     Om      92
CSE     Amy     67
```

To start with, here's a single field comparison. The problem statement is to fetch all the records from `marks.txt` if the first field matches any of the departments listed in `dept.txt` file.

```bash
$ cat dept.txt
CSE
ECE

$ perl -ane 'if(!$#ARGV){ $h{$F[0]}=1 }
             else{ print if exists $h{$F[0]} }' dept.txt marks.txt
ECE     Raj     53
ECE     Joel    72
CSE     Surya   81
ECE     Om      92
CSE     Amy     67
```

For multiple field comparison, you can use comma separated values to construct the hash keys. The special variable `$;` (whose default is `\034`) will be used to join these values. The `\034` character is usually not present in text files. If you cannot guarantee absence of this character, you can use some other character or use hash of hashes. See also [stackoverflow: using array as hash key](https://stackoverflow.com/q/17081212/4082052).

```bash
$ cat dept_name.txt
EEE Moi
CSE Amy
ECE Raj

$ # don't use array slice as hash keys
$ perl -anE '$h{@F[0..1]}=1; say join ",", keys %h' dept_name.txt | cat -v
Moi
Moi,Amy
Moi,Raj,Amy
$ # default $; value is \034, same as SUBSEP in awk
$ perl -anE '$h{$F[0],$F[1]}=1; say join ",", keys %h' dept_name.txt | cat -v
EEE^\Moi
CSE^\Amy,EEE^\Moi
ECE^\Raj,CSE^\Amy,EEE^\Moi

$ perl -ane 'if(!$#ARGV){ $h{$F[0],$F[1]}=1 }
             else{ print if exists $h{$F[0],$F[1]} }' dept_name.txt marks.txt
ECE     Raj     53
EEE     Moi     68
CSE     Amy     67
```

Here's an alternate method with hash of hashes. See also [perldoc: REFERENCES](https://perldoc.perl.org/perldsc#REFERENCES).

```bash
$ perl -ane 'if(!$#ARGV){ $h{$F[0]}{$F[1]}=1 }
             else{ print if exists $h{$F[0]}{$F[1]} }' dept_name.txt marks.txt
ECE     Raj     53
EEE     Moi     68
CSE     Amy     67
```

In this example, one of the fields is used for numerical comparison.

```bash
$ cat dept_mark.txt
ECE 70
EEE 65
CSE 80

$ # match Dept and minimum marks specified in dept_mark.txt
$ perl -ane 'if(!$#ARGV){ $h{$F[0]}=$F[1] }
             else{ print if exists $h{$F[0]} && $F[2]>=$h{$F[0]} }
            ' dept_mark.txt marks.txt
ECE     Joel    72
EEE     Moi     68
CSE     Surya   81
ECE     Om      92
```

Here's an example of adding a new field.

```bash
$ cat role.txt
Raj class_rep
Amy sports_rep
Tia placement_rep

$ # $.=0 is needed to allow header line checking for second file
$ perl -lane 'if(!$#ARGV){ $r{$F[0]}=$F[1]; $.=0 }
              else{ print join "\t", @F, $.==1 ? "Role" : $r{$F[1]} }
             ' role.txt marks.txt
Dept    Name    Marks   Role
ECE     Raj     53      class_rep
ECE     Joel    72
EEE     Moi     68
CSE     Surya   81
EEE     Tia     59      placement_rep
ECE     Om      92
CSE     Amy     67      sports_rep
```

## Based on line number

Here's an example that shows how you can replace `m`th line from a file with `n`th line from another file.

```bash
$ # replace 3rd line of table.txt with
$ # 2nd line of greeting.txt
$ perl -pe 'BEGIN{ $m=3; $n=2; $s = <STDIN> for 1..$n }
            $_ = $s if $. == $m' <greeting.txt table.txt
brown bread mat hair 42
blue cake mug shirt -7
Have a nice day
```

Here's an example where two files are processed simultaneously.

```bash
$ # print line from greeting.txt if the last column of corresponding line
$ # from table.txt is a positive number
$ perl -ne 'print if (split " ", <STDIN>)[-1] > 0' <table.txt greeting.txt
Hi there
Good bye
```

## Multiline fixed string substitution

You can use file slurping for fixed string multiline search and replace requirements. The below example is substituting complete lines. The solution will work for partial lines as well, provided there is no newline character at the end of `search.txt` and `repl.txt` files.

```bash
$ head -n2 table.txt > search.txt
$ cat repl.txt
2$1$&3
wise ice go goa

$ perl -0777 -ne '$#ARGV==1 ? $s=$_ : $#ARGV==0 ? $r=$_ :
                  print s/\Q$s/$r/gr' search.txt repl.txt table.txt
2$1$&3
wise ice go goa
yellow banana window shoes 3.14
```

>![warning](images/warning.svg) Don't save contents of `search.txt` and `repl.txt` in shell variables for passing them to the `perl` script. Trailing newlines and ASCII NUL characters will cause issues. See [stackoverflow: pitfalls of reading file into shell variable](https://stackoverflow.com/a/22607352/4082052) for details.

## Add file content conditionally

**Case 1:** replace each matching line with entire contents of `STDIN`.

```bash
$ # same as: sed -e '/[ot]/{r dept.txt' -e 'd}' greeting.txt
$ perl -pe 'BEGIN{$r = join "", <STDIN>} $_=$r if /[ot]/' <dept.txt greeting.txt
CSE
ECE
Have a nice day
CSE
ECE
```

**Case 2:** insert entire contents of `STDIN` before each matching line.

```bash
$ # same as: sed '/nice/e cat dept.txt' greeting.txt
$ perl -pe 'BEGIN{$r = join "", <STDIN>}
            print $r if /nice/' <dept.txt greeting.txt
Hi there
CSE
ECE
Have a nice day
Good bye
```

**Case 3:** append entire contents of `STDIN` after each matching line.

```bash
$ # same as: sed '/nice/r dept.txt' greeting.txt
$ perl -pe 'BEGIN{$r = join "", <STDIN>}
            $_ .= $r if /nice/' <dept.txt greeting.txt
Hi there
Have a nice day
CSE
ECE
Good bye
```

## Summary

This chapter discussed use cases where you need to process the contents of two or more files based on entire record/file or field(s). The value of `$#ARGV` is handy for such cases (formula is `n-2` to match first file passed among `n` input files). The next chapter discusses more such examples, based solely on occurrences of duplicate values.

## Exercises

**a)** Use contents of `match_words.txt` file to display matching lines from `jumbled.txt` and `sample.txt`. The matching criteria is that the second word of lines from these files should match the third word of lines from `match_words.txt`.

```bash
$ cat match_words.txt
%whole(Hello)--{doubt}==ado==
just,\joint*,concession<=nice

$ # 'concession' is one of the third words from 'match_words.txt'
$ # and second word from 'jumbled.txt'
##### add your solution here
wavering:concession/woof\retailer
No doubt you like it too
```

**b)** Interleave contents of `secrets.txt` with the contents of a file passed as `stdin` in the format as shown below.

```bash
##### add your solution here, use 'table.txt' for stdin data
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
##### add your solution here
row
at

$ # ip: search_terms.txt ip.txt sample.txt oops.txt
##### add your solution here
hello
you
is
```

**d)** Replace third to fifth lines of input file `ip.txt` with second to fourth lines from file `para.txt`

```bash
##### add your solution here
Hello World
How are you
Start working on that
project you always wanted
to, do not let it end
You are funny
```

**e)** Insert one line from `jumbled.txt` before every two lines of `copyright.txt`

```bash
##### add your solution here
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

##### add your solution here
print this
but not that or this
overcoats;furrowing-typeface%pewter##hobby
wavering:concession/woof\retailer
if print this
but not that
overcoats;furrowing-typeface%pewter##hobby
wavering:concession/woof\retailer
```

# Dealing with duplicates

Often, you need to eliminate duplicates from input file(s), based on entire line content, field(s), etc. These are typically solved with `sort` and `uniq` commands. Advantage with `perl` include regexp based field separators, record separator other than newline, input doesn't have to be sorted, and in general more flexibility because it is a programming language.

## Whole line duplicates

You can use `uniq` function from `List::Util` module or use a hash to retain only first copy of duplicates from one or more input files.

```bash
$ cat purchases.txt
coffee
tea
washing powder
coffee
toothpaste
tea
soap
tea

$ # same as: perl -MList::Util=uniq -e 'print uniq <>' purchases.txt
$ # can also use: perl -ne 'print if !exists $h{$_}; $h{$_}=1'
$ perl -ne 'print if !$h{$_}++' purchases.txt
coffee
tea
washing powder
toothpaste
soap
```

## Column wise duplicates

The hash based solution is easy to adapt for removing field based duplicates. Just change `$_` to the required field(s) after setting the appropriate field separator.

```bash
$ cat duplicates.txt
brown,toy,bread,42
dark red,ruby,rose,111
blue,ruby,water,333
dark red,sky,rose,555
yellow,toy,flower,333
white,sky,bread,111
light red,purse,rose,333

$ # based on last field
$ # -l isn't needed if all the lines end with newline character
$ perl -F, -ane 'print if !$h{$F[-1]}++' duplicates.txt
brown,toy,bread,42
dark red,ruby,rose,111
blue,ruby,water,333
dark red,sky,rose,555
```

Multiple fields example. As seen in [Comparing fields](#comparing-fields) section, you can either use comma separated values to construct the hash key or use hash of hashes.

```bash
$ # based on first and third field
$ # can also use: perl -F, -ane 'print if !$h{$F[0]}{$F[2]}++'
$ perl -F, -ane 'print if !$h{$F[0],$F[2]}++' duplicates.txt
brown,toy,bread,42
dark red,ruby,rose,111
blue,ruby,water,333
yellow,toy,flower,333
white,sky,bread,111
light red,purse,rose,333
```

## Duplicate count

In this section, how many times a duplicate record is found plays a role in determining the output. First up, printing only a specific numbered duplicate.

```bash
$ # print only the second occurrence of duplicates based on 2nd field
$ perl -F, -ane 'print if ++$h{$F[1]} == 2' duplicates.txt
blue,ruby,water,333
yellow,toy,flower,333
white,sky,bread,111

$ # print only the third occurrence of duplicates based on last field
$ perl -F, -ane 'print if ++$h{$F[-1]} == 3' duplicates.txt
light red,purse,rose,333
```

Next, printing only the last copy of duplicate. Since the count isn't known, the `tac` command comes in handy again.

```bash
$ # reverse the input line-wise, retain first copy and then reverse again
$ tac duplicates.txt | perl -F, -ane 'print if !$h{$F[-1]}++' | tac
brown,toy,bread,42
dark red,sky,rose,555
white,sky,bread,111
light red,purse,rose,333
```

To get all the records based on a duplicate count, you can pass the input file twice. Then use the two file processing tricks to make decisions.

```bash
$ # all duplicates based on last column
$ perl -F, -ane '!$#ARGV ? $h{$F[-1]}++ :
                 $h{$F[-1]}>1 && print' duplicates.txt duplicates.txt
dark red,ruby,rose,111
blue,ruby,water,333
yellow,toy,flower,333
white,sky,bread,111
light red,purse,rose,333

$ # all duplicates based on last column, minimum 3 duplicates
$ perl -F, -ane '!$#ARGV ? $h{$F[-1]}++ :
                 $h{$F[-1]}>2 && print' duplicates.txt duplicates.txt
blue,ruby,water,333
yellow,toy,flower,333
light red,purse,rose,333

$ # only unique lines based on 3rd column
$ perl -F, -ane '!$#ARGV ? $h{$F[2]}++ :
                 $h{$F[2]}==1 && print' duplicates.txt duplicates.txt
blue,ruby,water,333
yellow,toy,flower,333
```

## Summary

This chapter showed how to work with duplicate contents, both record and field based. If you don't need regexp based separators and if your input is too big to handle, then specialized command line tools `sort` and `uniq` will be better suited.

## Exercises

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

##### add your solution here
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

##### add your solution here
hehe haha
door floor
6;8 3-4
true blue
hehe bebe
tru eblue
```

**c)** For the input file `twos.txt`, display only unique lines. Assume space as field separator with two fields on each line. Compare the lines irrespective of order of the fields. For example, `hehe haha` and `haha hehe` will be considered as duplicates.

```bash
##### add your solution here
true blue
hehe bebe
tru eblue
```

# Perl rename command

This chapter will show a few examples for renaming files using the `rename` command. There are several implementations for this particular command. So, check `man rename` to see if you get the Perl based `rename` documentation as shown below:

```bash
NAME
       rename - renames multiple files

SYNOPSIS
       rename [ -h|-m|-V ] [ -v ] [ -0 ] [ -n ] [ -f ] [ -d ]
       [ -e|-E perlexpr]*|perlexpr [ files ]

DESCRIPTION
       "rename" renames the filenames supplied according to the rule
       specified as the first argument.  The perlexpr argument is a
       Perl expression which is expected to modify the $_ string in
       Perl for at least some of the filenames specified.  If a given
       filename is not modified by the expression, it will not be
       renamed.  If no filenames are given on the command line,
       filenames will be read via standard input.
```

If you don't have the command installed, check your distribution's repository or you can install it from [metacpan: File::Rename](https://metacpan.org/pod/distribution/File-Rename/rename.PL). Here's a couple of implementations on my system:

```bash
$ rename --version
/usr/bin/rename using File::Rename version 1.10

$ rename.ul --version
rename.ul from util-linux 2.34
```

>![info](images/info.svg) See also: [askubuntu: What's the difference between the different "rename" commands?](https://askubuntu.com/questions/956010/whats-the-difference-between-the-different-rename-commands)

>![info](images/info.svg) See also [F2: a cross-platform tool for batch renaming files and directories quickly and safely](https://github.com/ayoisaiah/f2)

## Basic example and sanity check

>![info](images/info.svg) For this chapter, use an empty folder to follow along the examples presented. Delete the created files before moving on to the next illustration.

The below example formats the filenames to consistently have three digits, so that the sorted filename display works for the numbers as well. The `-n` option allows you to do a sanity check without renaming the files.

```bash
$ touch 1.png 3.png 25.png 100.png
$ ls
100.png  1.png  25.png  3.png

$ # sanity check
$ # note that 100.png isn't part of the output, since it isn't affected
$ rename -n 's/\d+/sprintf "%03d", $&/e' *.png
rename(1.png, 001.png)
rename(25.png, 025.png)
rename(3.png, 003.png)

$ # remove -n option after sanity check to actually rename the files
$ rename 's/\d+/sprintf "%03d", $&/e' *.png
$ ls
001.png  003.png  025.png  100.png

$ rm *.png
```

>![info](images/info.svg) For a more pleasing visual of the sanity check, pipe the output to `column -ts,` as shown below (assuming filenames don't have comma in them).

```bash
$ rename -n 's/\d+/sprintf "%03d", $&/e' *.png | column -ts,
rename(1.png    001.png)
rename(25.png   025.png)
rename(3.png    003.png)
```

## Verbose mode

The `-v` option shows how the files have been renamed, similar to the `-n` option. The difference is that the `-v` option shows the result after the files have been renamed.

```bash
$ touch a.b.c.d.txt 1.2.3.txt

$ # replace all dot characters except the extension
$ # sanity check
$ rename -n 's/\.(?=.*\.)/_/g' *.txt
rename(1.2.3.txt, 1_2_3.txt)
rename(a.b.c.d.txt, a_b_c_d.txt)
$ # verbose mode
$ rename -v 's/\.(?=.*\.)/_/g' *.txt
1.2.3.txt renamed as 1_2_3.txt
a.b.c.d.txt renamed as a_b_c_d.txt

$ ls
1_2_3.txt  a_b_c_d.txt

$ rm *.txt
```

## File already exists

If a renaming operation matches a filename that already exists, such a renaming won't go through by default. You can override this behavior by using the `-f` option.

```bash
$ touch report_v1.log report_v2.log

$ rename 's/v1/v2/' report_v1.log
report_v1.log not renamed: report_v2.log already exists
$ ls
report_v1.log  report_v2.log

$ rename -f 's/v1/v2/' report_v1.log
$ ls
report_v2.log

$ rm *.log
```

## Rename only filename component

If you are passing filenames with path components in them, you can use `-d` option to affect only filename portion. Otherwise, the logic you are using might affect directory names as well.

```bash
$ mkdir scripts
$ touch scripts/{toc.sh,reports.py}

$ # uppercase first character of the filename
$ rename -n -d 's/./\u$&/' scripts/*
rename(scripts/reports.py, scripts/Reports.py)
rename(scripts/toc.sh, scripts/Toc.sh)

$ # without -d option, directory name is affected
$ rename -n 's/./\u$&/' scripts/*
rename(scripts/reports.py, Scripts/reports.py)
rename(scripts/toc.sh, Scripts/toc.sh)

$ rm -r scripts
```

## Incrementing numbers

Unlike the normal `perl` one-liners, the `rename` command allows only `strict` mode. So, you'll have to declare variables before using them. However, you can cheat a little by using the `$a` and `$b` global variables (see [stackoverflow: Where do the $a and $b variables come from?](https://stackoverflow.com/q/26127617/4082052) for details).

The below example replaces first occurrence of numbers in the filename with an incrementing sequence.

```bash
$ touch 1.png 3.png 25.png 100.png

$ rename -n 's/\d+/sprintf "%03d", ++$a/e' *.png
rename(100.png, 001.png)
rename(1.png, 002.png)
rename(25.png, 003.png)
rename(3.png, 004.png)

$ rm *.png
```

However, the above approach can lead to issues if a number already exists. You cannot use `-f` option, since that'll lead to the file being overwritten instead of just being renamed. An example of such a problem is shown below.

```bash
$ touch 1.png 3.png 25.png 100.png

$ rename -n 's/\d+/++$a/e' *.png
100.png not renamed: 1.png already exists
rename(1.png, 2.png)
25.png not renamed: 3.png already exists
rename(3.png, 4.png)

# OOPS, 2 files have disappeared!!
$ rename -f 's/\d+/++$a/e' *.png
$ ls
2.png  4.png

$ rm *.png
```

One of the ways to solve this issue is a two step process shown below. An extra unique string is added to the filenames, so that it cannot clash with existing filenames. The unique string is then removed afterwards.

```bash
$ touch 1.png 3.png 25.png 100.png

$ rename -n 's/\d+/"op_" . ++$a/e' *.png
rename(100.png, op_1.png)
rename(1.png, op_2.png)
rename(25.png, op_3.png)
rename(3.png, op_4.png)

$ rename 's/\d+/"op_" . ++$a/e' *.png
$ rename 's/op_//' *.png

$ ls
1.png  2.png  3.png  4.png

$ rm *.png
```

## Exercises

**a)** Determine and implement the rename logic based on the filenames and expected output shown below.

```bash
$ touch ' (2020) Report part 1 . txt ' 'analysis Part 3 (2018).log'

##### add your solution here
$ ls
2020_report_part_1.txt  analysis_part_3_2018.log
```

**b)** See [unix.stackexchange: rename Q&A sorted by votes](https://unix.stackexchange.com/questions/tagged/rename?tab=Votes) for further reading as well as a source for exercises.

