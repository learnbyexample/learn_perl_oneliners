# Preface

This book features plenty of Perl one-liners for solving text processing tasks from the command line. You can use Perl as a single alternate to tools like `grep`, `sed` and `awk`. Syntax and features of these tools (along with languages like `C` and `bash`) were inspirations for Perl, so prior experience with them would make it easier to get comfortable with Perl one-liners.

You'll learn about various command line options and Perl features that make it possible to write compact CLI scripts. Learning to use Perl from the command line will also allow you to construct solutions where Perl is just another tool in the shell ecosystem.

## Prerequisites

You should be comfortable with programming basics and have prior experience working with Perl. You should know concepts like scalar, array, hash, special variables and be familiar with control structures, regular expressions, etc. To get started with Perl and regular expressions, check out the following resources:

* [perldoc: perlintro](https://perldoc.perl.org/perlintro)
* [learnxinyminutes: perl](https://learnxinyminutes.com/docs/perl/)
* [perldoc: perlretut](https://perldoc.perl.org/perlretut)

You should also be familiar with command line usage in a Unix-like environment. You should also be comfortable with concepts like file redirection and command pipelines. Knowing the basics of the `grep`, `sed` and `awk` commands will come in handy as well.

## Conventions

* The examples presented here have been tested with Perl version **5.38.0** and includes features not available in earlier versions.
* Code snippets are copy pasted from the `GNU bash` shell and modified for presentation purposes. Some commands are preceded by comments to provide context and explanations. Blank lines to improve readability, only `real` time shown for speed comparisons, output skipped/modified for certain commands and so on.
* Unless otherwise noted, all examples and explanations are meant for **ASCII** input.
    * See also [stackoverflow: why does modern Perl avoid utf-8 by default](https://stackoverflow.com/q/6162484/4082052).
* External links are provided throughout the book for you to explore certain topics in more depth.
* The [learn_perl_oneliners repo](https://github.com/learnbyexample/learn_perl_oneliners) has all the code snippets and files used in examples, exercises and other details related to the book. If you are not familiar with the `git` command, click the **Code** button on the webpage to get the files.

## Acknowledgements

* [Perl documentation](https://perldoc.perl.org/) — manuals, tutorials and examples
* [stackoverflow](https://stackoverflow.com/) and [unix.stackexchange](https://unix.stackexchange.com/) — for getting answers to pertinent questions on Perl and related commands
* [tex.stackexchange](https://tex.stackexchange.com/) — for help on [pandoc](https://github.com/jgm/pandoc/) and `tex` related questions
* [/r/perl/](https://old.reddit.com/r/perl/) — helpful forum
* [canva](https://www.canva.com/) — cover image
* [oxipng](https://github.com/shssoichiro/oxipng), [pngquant](https://pngquant.org/) and [svgcleaner](https://github.com/RazrFalcon/svgcleaner) — optimizing images
* [Warning](https://commons.wikimedia.org/wiki/File:Warning_icon.svg) and [Info](https://commons.wikimedia.org/wiki/File:Info_icon_002.svg) icons by [Amada44](https://commons.wikimedia.org/wiki/User:Amada44) under public domain

A heartfelt thanks to all my readers. Your valuable support has significantly eased my financial concerns and allows me to continue working on programming ebooks.

## Feedback and Errata

I would highly appreciate it if you'd let me know how you felt about this book. It could be anything from a simple thank you, pointing out a typo, mistakes in code snippets, which aspects of the book worked for you (or didn't!) and so on. Reader feedback is essential and especially so for self-published authors.

You can reach me via:

* Issue Manager: [https://github.com/learnbyexample/learn_perl_oneliners/issues](https://github.com/learnbyexample/learn_perl_oneliners/issues)
* E-mail: learnbyexample.net@gmail.com
* Twitter: [https://twitter.com/learn_byexample](https://twitter.com/learn_byexample)

## Author info

Sundeep Agarwal is a lazy being who prefers to work just enough to support his modest lifestyle. He accumulated vast wealth working as a Design Engineer at Analog Devices and retired from the corporate world at the ripe age of twenty-eight. Unfortunately, he squandered his savings within a few years and had to scramble trying to earn a living. Against all odds, selling programming ebooks saved his lazy self from having to look for a job again. He can now afford all the fantasy ebooks he wants to read and spends unhealthy amount of time browsing the internet.

When the creative muse strikes, he can be found working on yet another programming ebook (which invariably ends up having at least one example with regular expressions). Researching materials for his ebooks and everyday social media usage drowned his bookmarks, so he maintains curated resource lists for sanity sake. He is thankful for free learning resources and open source tools. His own contributions can be found at [https://github.com/learnbyexample](https://github.com/learnbyexample).

**List of books:** https://learnbyexample.github.io/books/

## License

This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/).

Code snippets are available under [MIT License](https://github.com/learnbyexample/learn_perl_oneliners/blob/main/LICENSE).

Resources mentioned in Acknowledgements section are available under original licenses.

## Book version

2.0

See [Version_changes.md](https://github.com/learnbyexample/learn_perl_oneliners/blob/main/Version_changes.md) to track changes across book versions.

# One-liner introduction

This chapter will give an overview of Perl syntax for command line usage. You'll see examples to understand what kind of problems are typically suited for one-liners.

## Why use Perl for one-liners?

I assume that you are already familiar with use cases where the command line is more productive compared to GUI. See also this series of articles titled [Unix as IDE](https://blog.sanctum.geek.nz/series/unix-as-ide/).

A shell utility like Bash provides built-in commands and scripting features to easily solve and automate various tasks. External commands like `grep`, `sed`, `awk`, `sort`, `find`, `parallel`, etc help to solve a wide variety of text processing tasks. These tools are often combined to work together along with shell features like pipelines, wildcards and loops. You can use Perl as an alternative to such external tools and also complement them for some use cases.

Here are some sample text processing tasks that you can solve using Perl one-liners. Options and related details will be explained later.

```bash
# change ; to #
# but don't change ; within single or double quotes
perl -pe 's/(?:\x27;\x27|";")(*SKIP)(*F)|;/#/g'

# retain only the first copy of duplicated lines
# uses the built-in module List::Util
perl -MList::Util=uniq -e 'print uniq <>'

# extract only IPv4 addresses
# uses a third-party module Regexp::Common
perl -MRegexp::Common=net -nE 'say $& while /$RE{net}{IPv4}/g'
```

Here are some stackoverflow questions that I've answered with simpler Perl solution compared to other CLI tools:

* [replace string with incrementing value](https://stackoverflow.com/q/42554684/4082052)
* [sort rows in csv file without header & first column](https://stackoverflow.com/q/48920626/4082052)
* [reverse matched pattern](https://stackoverflow.com/q/63681983/4082052)
* [append zeros to list](https://stackoverflow.com/q/49765879/4082052)
* [arithmetic replacement in a text file](https://stackoverflow.com/q/62241101/4082052)
* [reverse complement DNA sequence for a specific field](https://stackoverflow.com/q/45571828/4082052)

The selling point of Perl over tools like `grep`, `sed` and `awk` includes feature rich regular expression engine and standard/third-party modules. Another advantage is that Perl is more portable, given the many differences between GNU, BSD and other such implementations. The main disadvantage is that Perl is likely to be verbose and slower for features that are supported out of the box by those tools.

>![info](images/info.svg) See also [unix.stackexchange: when to use grep, sed, awk, perl, etc](https://unix.stackexchange.com/q/303044/109046).

## Installation and Documentation

If you are on a Unix-like system, you are most likely to already have some version of Perl installed. See [cpan: Perl Source](https://www.cpan.org/src/README.html) for instructions to install the latest Perl version from source. `perl v5.38.0` is used for all the examples shown in this book.

You can use the `perldoc` command to access documentation from the command line. You can visit https://perldoc.perl.org/ if you wish to read it online, which also has a handy search feature. Here are some useful links to get started:

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
| `-d[t][:MOD]`     | run program under debugger or module `Devel::MOD` |
| `-D[number/letters]` | set debugging flags (argument is a bit mask or alphabets) |
| `-e commandline`  | one line of program (several `-e`'s allowed, omit programfile) |
| `-E commandline`  | like `-e`, but enables all optional features |
| `-f`              | don't do `$sitelib/sitecustomize.pl` at startup |
| `-F/pattern/`     | `split()` pattern for `-a` switch (`//`'s are optional) |
| `-g`              | read all input in one go (slurp), rather than line-by-line |
|                   | (alias for `-0777`) |
| `-i[extension]`   | edit `<>` files in place (makes backup if extension supplied) |
| `-Idirectory`     | specify `@INC/#include` directory (several `-I`'s allowed) |
| `-l[octnum]`      | enable line ending processing, specifies line terminator |
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

This chapter will show examples with the `-e`, `-E`, `-l`, `-n`, `-p` and `-a` options. Some more options will be covered in later chapters, but not all of them are discussed in this book.

## Executing Perl code

If you want to execute a Perl program file, one way is to pass the filename as an argument to the `perl` command.

```bash
$ echo 'print "Hello Perl\n"' > hello.pl
$ perl hello.pl
Hello Perl
```

For short programs, you can also directly pass the code as an argument to the `-e` and `-E` options. See [perldoc: feature](https://perldoc.perl.org/feature) for details about the features enabled by the `-E` option.

```bash
$ perl -e 'print "Hello Perl\n"'
Hello Perl

# multiple statements can be issued separated by ;
# -l option will be covered in detail later, appends \n to 'print' here
$ perl -le '$x=25; $y=12; print $x**$y'
59604644775390625
# or, use -E and 'say' instead of -l and 'print'
$ perl -E '$x=25; $y=12; say $x**$y'
59604644775390625
```

## Filtering

Perl one-liners can be used for filtering lines matched by a regular expression (regexp), similar to the `grep`, `sed` and `awk` commands. And similar to many command line utilities, Perl can accept input from both stdin and file arguments.

```bash
# sample stdin data
$ printf 'gate\napple\nwhat\nkite\n'
gate
apple
what
kite

# print lines containing 'at'
# same as: grep 'at' and sed -n '/at/p' and awk '/at/'
$ printf 'gate\napple\nwhat\nkite\n' | perl -ne 'print if /at/'
gate
what

# print lines NOT containing 'e'
# same as: grep -v 'e' and sed -n '/e/!p' and awk '!/e/'
$ printf 'gate\napple\nwhat\nkite\n' | perl -ne 'print if !/e/'
what
```

By default, `grep`, `sed` and `awk` automatically loop over the input content line by line (with newline character as the default line separator). To do so with Perl, you can use the `-n` and `-p` options. The [O module](#convert-one-liners-to-pretty-formatted-scripts) section shows the code Perl runs with these options.

As seen before, the `-e` option accepts code as a command line argument. Many shortcuts are available to reduce the amount of typing needed. In the above examples, a regular expression (defined by the pattern between a pair of forward slashes) has been used to filter the input. When the input string isn't specified, the test is performed against the special variable `$_` which has the contents of the current input line (the correct term would be input **record**, as discussed in the [Record separators](#record-separators) chapter). `$_` is also the default argument for many functions like `print` and `say`. To summarize:

* `/REGEXP/FLAGS` is a shortcut for `$_ =~ m/REGEXP/FLAGS`
* `!/REGEXP/FLAGS` is a shortcut for `$_ !~ m/REGEXP/FLAGS`

>![info](images/info.svg) See [perldoc: match](https://perldoc.perl.org/perlop#m/PATTERN/msixpodualngc) for help on the `m` operator.

Here's an example with file input instead of stdin.

```bash
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14

# digits at the end of lines that are not preceded by -
$ perl -nE 'say $& if /(?<!-)\d+$/' table.txt
42
14
# if the condition isn't required, capture groups can be used
$ perl -nE 'say /(\d+)$/' table.txt
42
7
14
```

>![info](images/info.svg) The [example_files](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/example_files) directory has all the files used in the examples (like `table.txt` in the above illustration).

## Substitution

Use the `s` operator for search and replace requirements. By default, this operates on `$_` when the input string isn't provided. For these examples, the `-p` option is used instead of `-n`, so that the value of `$_` is automatically printed after processing each input line. See [perldoc: search and replace](https://perldoc.perl.org/perlop#s/PATTERN/REPLACEMENT/msixpodualngcer) for documentation and examples.

```bash
# for each input line, change only the first ':' to '-'
# same as: sed 's/:/-/' and awk '{sub(/:/, "-")} 1'
$ printf '1:2:3:4\na:b:c:d\n' | perl -pe 's/:/-/'
1-2:3:4
a-b:c:d

# for each input line, change all ':' to '-'
# same as: sed 's/:/-/g' and awk '{gsub(/:/, "-")} 1'
$ printf '1:2:3:4\na:b:c:d\n' | perl -pe 's/:/-/g'
1-2-3-4
a-b-c-d
```

>![info](images/info.svg) The `s` operator modifies the input string it is acting upon if the pattern matches. In addition, it will return the number of substitutions made if successful, otherwise returns a *falsy* value (empty string or `0`). You can use the `r` flag to return the string after substitution instead of in-place modification. As mentioned before, this book assumes you are already familiar with Perl regular expressions. If not, see [perldoc: perlretut](https://perldoc.perl.org/perlretut) to get started.

## Special variables

Brief descriptions for some of the special variables are given below:

* `$_` contains the input record content
* `@F` array containing fields (with the `-a` and `-F` options)
    * `$F[0]` first field
    * `$F[1]` second field and so on
    * `$F[-1]` last field
    * `$F[-2]` second last field and so on
    * `$#F` index of the last field
* `$.` number of records (i.e. line number)
* `$1` backreference to the first capture group
* `$2` backreference to the second capture group and so on
* `$&` backreference to the entire matched portion
* `%ENV` hash containing environment variables

See [perldoc: special variables](https://perldoc.perl.org/perlvar#SPECIAL-VARIABLES) for documentation.

## Field processing

Consider the sample input file shown below with fields separated by a single space character.

```bash
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14
```

Here are some examples that are based on specific fields rather than the entire line. The `-a` option will cause the input line to be split based on whitespaces and the field contents can be accessed using the `@F` special array variable. Leading and trailing whitespaces will be suppressed, so there's no possibility of empty fields. More details are discussed in the [Default field separation](#default-field-separation) section.

```bash
# print the second field of each input line
# same as: awk '{print $2}' table.txt
$ perl -lane 'print $F[1]' table.txt
bread
cake
banana

# print lines only if the last field is a negative number
# same as: awk '$NF<0' table.txt
$ perl -lane 'print if $F[-1] < 0' table.txt
blue cake mug shirt -7

# change 'b' to 'B' only for the first field
# same as: awk '{gsub(/b/, "B", $1)} 1' table.txt
$ perl -lane '$F[0] =~ s/b/B/g; print "@F"' table.txt
Brown bread mat hair 42
Blue cake mug shirt -7
yellow banana window shoes 3.14
```

See the [Output field separator](#output-field-separator) section for details on using array variables inside double quotes.

## BEGIN and END

You can use a `BEGIN{}` block when you need to execute something before the input is read and an `END{}` block to execute something after all of the input has been processed.

```bash
# same as: awk 'BEGIN{print "---"} 1; END{print "%%%"}'
$ seq 4 | perl -pE 'BEGIN{say "---"} END{say "%%%"}'
---
1
2
3
4
%%%
```

## ENV hash

When it comes to automation and scripting, you'd often need to construct commands that can accept input from users, use data from files and the output of a shell command and so on. As mentioned before, this book assumes `bash` as the shell being used. To access environment variables of the shell, you can use the special hash variable `%ENV` with the name of the environment variable as a string key.

>![info](images/info.svg) Quotes won't be used around `hash` keys in this book. See [stackoverflow: are quotes around hash keys a good practice in Perl?](https://stackoverflow.com/q/401556/4082052) on possible issues if you don't quote the `hash` keys.

```bash
# existing environment variables
# output shown here is for my machine, would differ for you
$ perl -E 'say $ENV{HOME}'
/home/learnbyexample
$ perl -E 'say $ENV{SHELL}'
/bin/bash

# defined along with the command
# note that the variable definition is placed before the command
$ word='hello' perl -E 'say $ENV{word}'
hello
# the characters are preserved as is
$ ip='hi\nbye' perl -E 'say $ENV{ip}'
hi\nbye
```

Here's another example when a regexp is passed as an environment variable content.

```bash
$ cat anchors.txt
sub par
spar
apparent effort
two spare computers
cart part tart mart

# assume 'r' is a shell variable containing user provided regexp
$ r='\Bpar\B'
$ rgx="$r" perl -ne 'print if /$ENV{rgx}/' anchors.txt
apparent effort
two spare computers
```

You can also make use of the `-s` option to assign a Perl variable.

```bash
$ r='\Bpar\B'
$ perl -sne 'print if /$rgx/' -- -rgx="$r" anchors.txt
apparent effort
two spare computers
```

>![info](images/info.svg) As an example, see my repo [ch: command help](https://github.com/learnbyexample/command_help/blob/master/ch) for a practical shell script, where commands are constructed dynamically.

## Executing external commands

You can execute external commands using the `system` function. See [perldoc: system](https://perldoc.perl.org/functions/system) for documentation and details like how string/list arguments are processed before execution.

```bash
$ perl -e 'system("echo Hello World")'
Hello World

$ perl -e 'system("wc -w <anchors.txt")'
12

$ perl -e 'system("seq -s, 10 > out.txt")'
$ cat out.txt
1,2,3,4,5,6,7,8,9,10
```

The return value of `system` or the special variable `$?` can be used to act upon the exit status of the command being executed. As per documentation:

>![info](images/info.svg) The return value is the exit status of the program as returned by the `wait` call. To get the actual exit value, shift right by eight

```bash
$ perl -E '$es=system("ls anchors.txt"); say $es'
anchors.txt
0
$ perl -E 'system("ls anchors.txt"); say $?'
anchors.txt
0

$ perl -E 'system("ls xyz.txt"); say $?'
ls: cannot access 'xyz.txt': No such file or directory
512
```

To save the result of an external command, use backticks or the `qx` operator. See [perldoc: qx](https://perldoc.perl.org/perlop#qx/STRING/) for documentation and details like separating out `STDOUT` and `STDERR`.

```bash
$ perl -e '$words = `wc -w <anchors.txt`; print $words'
12

$ perl -e '$nums = qx/seq 3/; print $nums'
1
2
3
```

>![info](images/info.svg) See also [stackoverflow: difference between backticks, system, and exec](https://stackoverflow.com/q/799968/4082052).

## Summary

This chapter introduced some of the common options for Perl CLI usage, along with some of the typical text processing examples. While specific purpose CLI tools like `grep`, `sed` and `awk` are usually faster, Perl has a much more extensive standard library and ecosystem. And you do not have to learn a lot if you are already comfortable with Perl but not familiar with those CLI tools. The next section has a few exercises for you to practice the CLI options and text processing use cases.

## Exercises

>![info](images/info.svg) All the exercises are also collated together in one place at [Exercises.md](https://github.com/learnbyexample/learn_perl_oneliners/blob/main/exercises/Exercises.md). For solutions, see [Exercise_solutions.md](https://github.com/learnbyexample/learn_perl_oneliners/blob/main/exercises/Exercise_solutions.md).

>![info](images/info.svg) The [exercises](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/exercises) directory has all the files used in this section.

**1)** For the input file `ip.txt`, display all lines containing `is`.

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

**2)** For the input file `ip.txt`, display the first field of lines *not* containing `y`. Consider space as the field separator for this file.

```bash
##### add your solution here
Hello
This
12345
```

**3)** For the input file `ip.txt`, display all lines containing no more than 2 fields.

```bash
##### add your solution here
Hello World
12345
```

**4)** For the input file `ip.txt`, display all lines containing `is` in the second field.

```bash
##### add your solution here
Today is sunny
```

**5)** For each line of the input file `ip.txt`, replace the first occurrence of `o` with `0`.

```bash
##### add your solution here
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

##### add your solution here
-923.16
```

**7)** Append `.` to all the input lines for the given stdin data.

```bash
$ printf 'last\nappend\nstop\ntail\n' | ##### add your solution here
last.
append.
stop.
tail.
```

**8)** Use the contents of the `s` variable to display all matching lines from the input file `ip.txt`. Assume that `s` doesn't have any regexp metacharacters. Construct the solution such that there's at least one word character immediately preceding the contents of the `s` variable.

```bash
$ s='is'

##### add your solution here
This game is good
```

**9)** Use `system` to display the contents of the filename present in the second field of the given input line. Consider space as the field separator.

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

Now that you are familiar with basic Perl CLI usage, this chapter will dive deeper into line processing examples. You'll learn various ways for matching lines based on regular expressions, fixed string matching, line numbers, etc. You'll also see how to group multiple statements and learn about the control flow keywords `next` and `exit`.

>![info](images/info.svg) The [example_files](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/example_files) directory has all the files used in the examples.

## Regexp based filtering

As mentioned before:

* `/REGEXP/FLAGS` is a shortcut for `$_ =~ m/REGEXP/FLAGS`
* `!/REGEXP/FLAGS` is a shortcut for `$_ !~ m/REGEXP/FLAGS`

Here are some examples:

```bash
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14

$ perl -ne 'print if /ow\b/' table.txt
yellow banana window shoes 3.14

$ perl -ne 'print if !/[ksy]/' table.txt
brown bread mat hair 42
```

If required, you can also use different delimiters. Quoting from [perldoc: match](https://perldoc.perl.org/perlop#m/PATTERN/msixpodualngc):

>If `/` is the delimiter then the initial `m` is optional. With the `m` you can use any pair of non-whitespace (ASCII) characters as delimiters. This is particularly useful for matching path names that contain `/`, to avoid LTS (**leaning toothpick syndrome**). If `?` is the delimiter, then a match-only-once rule applies, described in `m?PATTERN?` below. If `'` (single quote) is the delimiter, no variable interpolation is performed on the *PATTERN*. When using a delimiter character valid in an identifier, whitespace is required after the `m`. *PATTERN* may contain variables, which will be interpolated every time the pattern search is evaluated, except for when the delimiter is a single quote.

```bash
$ cat paths.txt
/home/joe/report.log
/home/ram/power.log
/home/rambo/errors.log

# leaning toothpick syndrome
$ perl -ne 'print if /\/home\/ram\//' paths.txt
/home/ram/power.log

# using a different delimiter makes it more readable here
$ perl -ne 'print if m{/home/ram/}' paths.txt
/home/ram/power.log

$ perl -ne 'print if !m#/home/ram/#' paths.txt
/home/joe/report.log
/home/rambo/errors.log
```

## Extracting matched portions

You can use regexp related special variables to extract only the matching portions. Consider this input file:

```bash
$ cat ip.txt
it is a warm and cozy day
listen to what I say
go play in the park
come back before the sky turns dark

There are so many delights to cherish
Apple, Banana and Cherry
Bread, Butter and Jelly
Try them all before you perish
```

Here are some examples of extracting only the matched portions.

```bash
# note that this will print only the first match for each input line
$ perl -nE 'say $& if /\b[a-z]\w*[ty]\b/' ip.txt
it
what
play
sky
many

$ perl -nE 'say join "::", @{^CAPTURE} if /(\b[bdp]\w+).*((?1))/i' ip.txt
play::park
back::dark
Bread::Butter
before::perish
```

Special variables to work with capture groups aren't always needed. For example, when every line has a match.

```bash
$ perl -nE 'say /^(\w+ ).*?(\d+)$/' table.txt
brown 42
blue 7
yellow 14

# with a custom separator
$ perl -nE 'say join ":", /^(\w+).*?(\d+)$/' table.txt
brown:42
blue:7
yellow:14
```

## Transliteration

The transliteration operator `tr` (or `y`) helps you perform transformations character-wise. See [perldoc: tr](https://perldoc.perl.org/perlop#tr/SEARCHLIST/REPLACEMENTLIST/cdsr) for documentation.

```bash
# rot13
$ echo 'Uryyb Jbeyq' | perl -pe 'tr/a-zA-Z/n-za-mN-ZA-M/'
Hello World

# 'c' option complements the specified characters
$ echo 'apple:123:banana' | perl -pe 'tr/0-9\n/-/c'
------123-------

# 'd' option deletes the characters
$ echo 'apple:123:banana' | perl -pe 'tr/0-9\n//cd'
123

# 's' option squeezes repeated characters
$ echo 'APPLE gobbledygook' | perl -pe 'tr|A-Za-z||s'
APLE gobledygok
# transliteration as well as squeeze
$ echo 'APPLE gobbledygook' | perl -pe 'tr|A-Z|a-z|s'
aple gobbledygook
```

Similar to the `s` operator, `tr` returns the number of changes made. Use the `r` option to prevent in-place modification and return the transliterated string instead.

```bash
# match lines containing 'b' 2 times
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

These examples combine line filtering and substitution in different ways. As noted before, the `s` operator modifies the input string and the return value can be used to know how many substitutions were made. Use the `r` flag to prevent in-place modification and get the string output after substitution.

```bash
# change commas to hyphens if the input line does NOT contain '2'
# prints all input lines even if the substitution fails
$ printf '1,2,3,4\na,b,c,d\n' | perl -pe 's/,/-/g if !/2/'
1,2,3,4
a-b-c-d

# perform substitution only for the filtered lines
# prints filtered input lines, even if the substitution fails
$ perl -ne 'print s/ark/[$&]/rg if /the/' ip.txt
go play in the p[ark]
come back before the sky turns d[ark]
Try them all before you perish

# print only if the substitution succeeds
$ perl -ne 'print if s/\bw\w*t\b/{$&}/g' ip.txt
listen to {what} I say
```

## Multiple conditions

It is good to remember that Perl is a programming language. You can make use of control structures and combine multiple conditions using logical operators. You don't have to create a single complex regexp.

```bash
$ perl -ne 'print if /ark/ && !/sky/' ip.txt
go play in the park

$ perl -ane 'print if /\bthe\b/ || $#F == 5' ip.txt
go play in the park
come back before the sky turns dark
Try them all before you perish

$ perl -ne 'print if /s/ xor /m/' table.txt
brown bread mat hair 42
yellow banana window shoes 3.14
```

## next

When the `next` statement is executed, rest of the code will be skipped and the next input line will be fetched for processing. It doesn't affect the `BEGIN` and `END` blocks as they are outside the file content loop. 

```bash
$ perl -nE 'if(/\bpar/){print "%% $_"; next} say /s/ ? "X" : "Y"' anchors.txt
%% sub par
X
Y
X
%% cart part tart mart
```

**Note** that `{}` is used in the above example to group multiple statements to be executed for a single `if` condition. You'll see many more examples with `next` in the coming chapters.

## exit

The `exit` function is useful to avoid processing unnecessary input content when a termination condition is reached. See [perldoc: exit](https://perldoc.perl.org/functions/exit) for documentation.

```bash
# quits after an input line containing 'say' is found
$ perl -ne 'print; exit if /say/' ip.txt
it is a warm and cozy day
listen to what I say

# the matching line won't be printed in this case
$ perl -pe 'exit if /say/' ip.txt
it is a warm and cozy day
```

Use `tac` to get all lines starting from the last occurrence of the search string in the entire file.

```bash
$ tac ip.txt | perl -ne 'print; exit if /an/' | tac
Bread, Butter and Jelly
Try them all before you perish
```

You can optionally provide a status code as an argument to the `exit` function.

```bash
$ printf 'sea\neat\ndrop\n' | perl -ne 'print; exit(2) if /at/'
sea
eat
$ echo $?
2
```

Any code in the `END` block will still be executed before exiting. This doesn't apply if `exit` was called from the `BEGIN` block.

```bash
$ perl -pE 'exit if /cake/' table.txt
brown bread mat hair 42

$ perl -pE 'exit if /cake/; END{say "bye"}' table.txt
brown bread mat hair 42
bye

$ perl -pE 'BEGIN{say "hi"; exit; say "hello"} END{say "bye"}' table.txt
hi
```

>![warning](images/warning.svg) Be careful if you want to use `exit` with multiple input files, as Perl will stop even if there are other files remaining to be processed.

## Line number based processing

Line numbers can also be specified as a matching criteria by using the `$.` special variable.

```bash
# print only the third line
$ perl -ne 'print if $. == 3' ip.txt
go play in the park

# print the second and sixth lines
$ perl -ne 'print if $. == 2 || $. == 6' ip.txt
listen to what I say
There are so many delights to cherish

# transliterate only the second line
$ printf 'gates\nnot\nused\n' | perl -pe 'tr/a-z/*/ if $. == 2'
gates
***
used

# print from a particular line number to the end of the input
$ seq 14 25 | perl -ne 'print if $. >= 10'
23
24
25
```

Use the `eof` function to check for the end of the file condition. See [perldoc: eof](https://perldoc.perl.org/perlfunc#eof) for documentation.

```bash
# same as: tail -n1 ip.txt
$ perl -ne 'print if eof' ip.txt
Try them all before you perish

$ perl -ne 'print "$.:$_" if eof' ip.txt
9:Try them all before you perish

# multiple file example
# same as: tail -q -n1 ip.txt table.txt
$ perl -ne 'print if eof' ip.txt table.txt
Try them all before you perish
yellow banana window shoes 3.14
```

For large input files, you can use `exit` to avoid processing unnecessary input lines.

```bash
$ seq 3542 4623452 | perl -ne 'if($. == 2452){print; exit}'
5993
$ seq 3542 4623452 | perl -ne 'print if $. == 250; if($. == 2452){print; exit}'
3791
5993

# here is a sample time comparison
$ time seq 3542 4623452 | perl -ne 'if($. == 2452){print; exit}' > f1
real    0m0.005s
$ time seq 3542 4623452 | perl -ne 'print if $. == 2452' > f2
real    0m0.496s
$ rm f1 f2
```

## Range operator

You can use the range operator to select between a pair of matching conditions like line numbers and regexp. See [perldoc: range](https://perldoc.perl.org/perlop#Range-Operators) for documentation.

```bash
# the range is automatically compared against $. in this context
# same as: perl -ne 'print if 3 <= $. <= 5'
$ seq 14 25 | perl -ne 'print if 3..5'
16
17
18

# the range is automatically compared against $_ in this context
# note that all the matching ranges are printed
$ perl -ne 'print if /to/ .. /pl/' ip.txt
listen to what I say
go play in the park
There are so many delights to cherish
Apple, Banana and Cherry
```

>![info](images/info.svg) See the [Records bounded by distinct markers](#records-bounded-by-distinct-markers) section for an alternate solution.

Line numbers and regexp filtering can be mixed.

```bash
$ perl -ne 'print if 6 .. /utter/' ip.txt
There are so many delights to cherish
Apple, Banana and Cherry
Bread, Butter and Jelly

# same logic as: perl -pe 'exit if /\bba/'
# inefficient, but this will work for multiple file inputs
$ perl -ne 'print if !(/\bba/ .. eof)' ip.txt table.txt
it is a warm and cozy day
listen to what I say
go play in the park
brown bread mat hair 42
blue cake mug shirt -7
```

Both conditions can match the same line too! Use `...` if you don't want the second condition to be matched against the starting line. Also, if the second condition doesn't match, lines starting from the first condition to the last line of the input will be matched.

```bash
# 'and' matches the 7th line
$ perl -ne 'print if 7 .. /and/' ip.txt
Apple, Banana and Cherry

# 'and' will be tested against 8th line onwards
$ perl -ne 'print if 7 ... /and/' ip.txt
Apple, Banana and Cherry
Bread, Butter and Jelly

# there's a line containing 'Banana' but the matching pair isn't found
# so, all lines till the end of the input is printed
$ perl -ne 'print if /Banana/ .. /XYZ/' ip.txt
Apple, Banana and Cherry
Bread, Butter and Jelly
Try them all before you perish
```

## Working with fixed strings

You can surround a regexp pattern with `\Q` and `\E` to match it as a fixed string, similar to the `grep -F` option. `\E` can be left out if there's no further pattern to be specified. Variables are still interpolated, so if your fixed string contains `$` or `@` forming possible variables, you'll run into issues. For such cases, one workaround is to pass the search string as an environment value and then apply `\Q` to that variable. See [perldoc: quotemeta](https://perldoc.perl.org/functions/quotemeta) for documentation.

```bash
# no match, since [] are character class metacharacters
$ printf 'int a[5]\nfig\n1+4=5\n' | perl -ne 'print if /a[5]/'

$ perl -E 'say "\Qa[5]"'
a\[5\]
$ printf 'int a[5]\nfig\n1+4=5\n' | perl -ne 'print if /\Qa[5]/'
int a[5]
$ printf 'int a[5]\nfig\n1+4=5\n' | perl -pe 's/\Qa[5]/b[12]/'
int b[12]
fig
1+4=5

# $y and $z will be treated as uninitialized variables here
$ echo '$x = $y + $z' | perl -pe 's/\Q$y + $z/100/'
$x = $y100$z
$ echo '$x = $y + $z' | fs='$y + $z' perl -pe 's/\Q$ENV{fs}/100/'
$x = 100
# ENV is preferred since \\ is special in single quoted strings
$ perl -E '$x = q(x\y\\0z); say $x'
x\y\0z
$ x='x\y\\0z' perl -E 'say $ENV{x}'
x\y\\0z
```

If you just want to filter a line based on fixed strings, you can also use the `index` function. This returns the matching position (which starts with `0`) and `-1` if the given string wasn't found. See [perldoc: index](https://perldoc.perl.org/functions/index) for documentation.

```bash
$ printf 'int a[5]\nfig\n1+4=5\n' | perl -ne 'print if index($_, "a[5]") != -1'
int a[5]
```

The above `index` example uses double quotes for the string argument, which allows escape sequences like `\t`, `\n`, etc and interpolation. This isn't the case with single quoted string values. Using single quotes within the script from command line requires messing with shell metacharacters. So, use the `q` operator instead or pass the fixed string to be matched as an environment variable.

```bash
# double quotes allow escape sequences and interpolation
$ perl -E '$x=5; say "value of x:\t$x"'
value of x:     5

# use the 'q' operator as an alternate for single quoted strings
$ s='$a = 2 * ($b + $c)'
$ echo "$s" | perl -ne 'print if index($_, q/($b + $c)/) != -1'
$a = 2 * ($b + $c)

# or pass the string as an environment variable
$ echo "$s" | fs='($b + $c)' perl -ne 'print if index($_, $ENV{fs}) != -1'
$a = 2 * ($b + $c)
```

You can use the return value of the `index` function to restrict the matching to the start or end of the input line. The line content in the `$_` variable contains the `\n` line ending character as well. You can remove the line separator using the `chomp` function or the `-l` command line option (which will be discussed in detail in the [Record separators](#record-separators) chapter). For now, it is enough to know that `-l` will remove the line separator and add it back when `print` is used.

```bash
$ cat eqns.txt
a=b,a-b=c,c*d
a+b,pi=3.14,5e12
i*(t+9-g)/8,4-a+b

# start of the line
$ s='a+b' perl -ne 'print if index($_, $ENV{s})==0' eqns.txt
a+b,pi=3.14,5e12

# end of the line
# same as: s='a+b' perl -ne 'print if /\Q$ENV{s}\E$/' eqns.txt
# length function returns the number of characters, by default acts on $_
# -l option is needed here to remove \n from $_
$ s='a+b' perl -lne '$pos = length() - length($ENV{s});
                     print if index($_, $ENV{s}) == $pos' eqns.txt
i*(t+9-g)/8,4-a+b
```

Here are some more examples using the return value of the `index` function.

```bash
# since 'index' returns '-1' if there's no match,
# you need to add >=0 check as well for < or <= comparison
$ perl -ne '$i = index($_, "="); print if 0 <= $i <= 5' eqns.txt
a=b,a-b=c,c*d

# > or >= comparison is easy to specify
# if you pass the third argument to 'index', you'll still have to check != -1
$ s='a+b' perl -ne 'print if index($_, $ENV{s})>=1' eqns.txt
i*(t+9-g)/8,4-a+b
```

If you need to match the entire input line or a particular field, you can use the string comparison operators.

```bash
$ printf 'a.b\na+b\n' | perl -lne 'print if /^a.b$/'
a.b
a+b
$ printf 'a.b\na+b\n' | perl -lne 'print if $_ eq q/a.b/'
a.b
$ printf '1 a.b\n2 a+b\n' | perl -lane 'print if $F[1] ne q/a.b/'
2 a+b
```

To provide a fixed string in the replacement section, environment variables come in handy again. Or, use the `q` operator for directly providing the value, but you may have to workaround the delimiters being used and the presence of `\\` characters.

```bash
# characters like $ and @ are special in the replacement section
$ echo 'x+y' | perl -pe 's/\Qx+y/$x+@y/'
+

# provide replacement string as an environment variable
$ echo 'x+y' | r='$x+@y' perl -pe 's/\Qx+y/$ENV{r}/'
$x+@y

# or, use the 'e' flag to provide a single quoted value as Perl code
$ echo 'x+y' | perl -pe 's/\Qx+y/q($x+@y)/e'
$x+@y

# need to workaround delimiters and \\ for the 'q' operator based solution
$ echo 'x+y' | perl -pe 's/\Qx+y/q($x\/@y)/e'
$x/@y
$ echo 'x+y' | perl -pe 's|\Qx+y|q($x/@y)|e'
$x/@y
$ echo 'x+y' | perl -pe 's|\Qx+y|q($x/@y\\\z)|e'
$x/@y\\z
```

## Summary

This chapter showed various examples of processing only the lines of interest instead of the entire input file. Filtering can be specified using a regexp, fixed string, line number or a combination of them. The `next` and `exit` statements are useful to change the flow of code.

## Exercises

>![info](images/info.svg) The [exercises](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/exercises) directory has all the files used in this section.

**1)** For the given input, display except the third line.

```bash
$ seq 34 37 | ##### add your solution here
34
35
37
```

**2)** Display only the fourth, fifth, sixth and seventh lines for the given input.

```bash
$ seq 65 78 | ##### add your solution here
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

##### add your solution here
Today is not sunny
You are not funny
```

**4)** For the given stdin, display only the first three lines. Avoid processing lines that are not relevant.

```bash
$ seq 14 25 | ##### add your solution here
14
15
16
```

**5)** For the input file `ip.txt`, display all lines from the start of the file till the first occurrence of `game`.

```bash
##### add your solution here
Hello World
How are you
This game is good
```

**6)** For the input file `ip.txt`, display all lines that contain `is` but not `good`.

```bash
##### add your solution here
Today is sunny
```

**7)** For the input file `ip.txt`, extract the word before the whole word `is` as well as the word after it. If such a match is found, display the two words around `is` in reversed order. For example, `hi;1 is--234 bye` should be converted to `234:1`. Assume that the whole word `is` will not be present more than once in a single line.

```bash
##### add your solution here
good:game
sunny:Today
```

**8)** For the input file `hex.txt`, replace all occurrences of `0xA0` with `0x50` and `0xFF` with `0x7F`.

```bash
$ cat hex.txt
start: 0xA0, func1: 0xA0
end: 0xFF, func2: 0xB0
restart: 0xA010, func3: 0x7F

##### add your solution here
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

##### add your solution here
12
4
2
9
```

**10)** Display all lines containing `[4]*` for the given stdin data.

```bash
$ printf '2.3/[4]*6\n2[4]5\n5.3-[4]*9\n' | ##### add your solution here
2.3/[4]*6
5.3-[4]*9
```

**11)** For the given input string, replace all lowercase alphabets to `x` only for words starting with `m`.

```bash
$ s='ma2T3a a2p kite e2e3m meet'
$ echo "$s" | ##### add your solution here
xx2T3x a2p kite e2e3m xxxx
```

**12)** For the input file `ip.txt`, delete all characters other than lowercase vowels and the newline character. Perform this transformation only between a line containing `you` up to line number `4` (inclusive).

```bash
##### add your solution here
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

##### add your solution here
Hello World

Good day
```

**14)** For the input file `sample.txt`, display from the last occurrence of `do` till the end of the file.

```bash
##### add your solution here
Much ado about nothing
He he he
```

**15)** For the input file `sample.txt`, display from the 9th line till a line containing `you`.

```bash
##### add your solution here
Today is sunny
Not a bit funny
No doubt you like it too
```

**16)** Display only the odd numbered lines from `ip.txt`.

```bash
##### add your solution here
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

##### add your solution here
1
3
```

**18)** For the input file `table.txt`, calculate the sum of numbers in the last column, excluding the second line.

```bash
##### add your solution here
45.14
```

**19)** Print the second and fourth line for every block of five lines.

```bash
$ seq 15 | ##### add your solution here
2
4
7
9
12
14
```

**20)** For the input file `ip.txt`, display all lines containing `e` or `u` but not both.

```bash
##### add your solution here
Hello World
This game is good
Today is sunny
```

# In-place file editing

In the examples presented so far, the output from Perl was displayed on the terminal or redirected to another file. This chapter will discuss how to write back the changes to the input files using the `-i` command line option. This option can be configured to make changes to the input files with or without creating a backup of original contents. When backups are needed, the original filename can get a prefix or a suffix or both. And the backups can be placed in the same directory or some other directory as needed.

>![info](images/info.svg) The [example_files](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/example_files) directory has all the files used in the examples.

## With backup

You can use the `-i` option to write back the changes to the input file instead of displaying the output on terminal. When an extension is provided as an argument to `-i`, the original contents of the input file gets preserved as per the extension given. For example, if the input file is `ip.txt` and `-i.orig` is used, the backup file will be named as `ip.txt.orig`.

```bash
$ cat colors.txt
deep blue
light orange
blue delight

# no output on the terminal as -i option is used
# space is NOT allowed between -i and the extension
$ perl -i.bkp -pe 's/blue/-green-/' colors.txt
# changes are written back to 'colors.txt'
$ cat colors.txt
deep -green-
light orange
-green- delight

# original file is preserved in 'colors.txt.bkp'
$ cat colors.txt.bkp
deep blue
light orange
blue delight
```

## Without backup

Sometimes backups are not desirable. In such cases, you can use the `-i` option without an argument. Be careful though, as changes made cannot be undone. It is recommended to test the command with sample inputs before applying the `-i` option on the actual file. You could also use the option with backup, compare the differences with a `diff` program and then delete the backup.

```bash
$ cat fruits.txt
banana
papaya
mango

$ perl -i -pe 's/(..)\1/\U$&/g' fruits.txt
$ cat fruits.txt
bANANa
PAPAya
mango
```

## Multiple files

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

## Prefix backup name

A `*` character in the argument to the `-i` option is special. It will get replaced with the input filename. This is helpful if you need to use a prefix instead of a suffix for the backup filename. Or any other combination that may be needed.

```bash
$ ls *colors.txt*
colors.txt  colors.txt.bkp

# single quotes is used here as * is a special shell character
$ perl -i'bkp.*' -pe 's/-green-/yellow/' colors.txt

$ ls *colors.txt*
bkp.colors.txt  colors.txt  colors.txt.bkp
```

## Place backups in a different directory

The `*` trick can also be used to place the backups in another directory instead of the parent directory of input files. The backup directory should already exist for this to work.

```bash
$ mkdir backups
$ perl -i'backups/*' -pe 's/good/nice/' t1.txt t2.txt
$ ls backups/
t1.txt  t2.txt
```

## Gory details of in-place editing

For more details about the `-i` option, see:

* [Effective Perl Programming: In-place editing gets safer in v5.28](https://www.effectiveperlprogramming.com/2017/12/in-place-editing-gets-safer-in-v5-28/)
* [perldoc: -i option](https://perldoc.perl.org/perlrun#-i%5Bextension%5D) — documentation and underlying code
* [perldoc faq: Why does Perl let me delete read-only files? Why does -i clobber protected files? Isn't this a bug in Perl?](https://perldoc.perl.org/perlfaq5#Why-does-Perl-let-me-delete-read-only-files%3F-Why-does-i-clobber-protected-files%3F-Isn%27t-this-a-bug-in-Perl%3F)

## Summary

This chapter discussed about the `-i` option which is useful when you need to edit a file in-place. This is particularly useful in automation scripts. But, do ensure that you have tested the Perl command before applying to actual files if you need to use this option without creating backups.

## Exercises

>![info](images/info.svg) The [exercises](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/exercises) directory has all the files used in this section.

**1)** For the input file `text.txt`, replace all occurrences of `in` with `an` and write back the changes to `text.txt` itself. The original contents should get saved to `text.txt.orig`

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

**2)** For the input file `text.txt`, replace all occurrences of `an` with `in` and write back the changes to `text.txt` itself. Do not create backups for this exercise. Note that you should have solved the previous exercise before starting this one.

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

**3)** For the input file `copyright.txt`, replace `copyright: 2018` with `copyright: 2020` and write back the changes to `copyright.txt` itself. The original contents should get saved to `2018_copyright.txt.bkp`

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

**4)** In the code sample shown below, two files are created by redirecting the output of the `echo` command. Then a Perl command is used to edit `b1.txt` in-place as well as create a backup named `bkp.b1.txt`. Will the Perl command work as expected? If not, why?

```bash
$ echo '2 apples' > b1.txt
$ echo '5 bananas' > -ibkp.txt
$ perl -ibkp.* -pe 's/2/two/' b1.txt
```

**5)** For the input file `pets.txt`, remove the first occurrence of `I like ` from each line and write back the changes to `pets.txt` itself. The original contents should get saved with the same filename inside the `bkp` directory. Assume that you do not know whether `bkp` exists or not in the current working directory.

```bash
$ cat pets.txt
I like cats
I like parrots
I like dogs

##### add your solution here

$ cat pets.txt
cats
parrots
dogs
$ cat bkp/pets.txt
I like cats
I like parrots
I like dogs
```

# Field separators

This chapter will dive deep into field processing. You'll learn how to set input and output field separators, how to use regexps for defining fields and how to work with fixed length fields. 

>![info](images/info.svg) The [example_files](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/example_files) directory has all the files used in the examples.

## Default field separation

Using the `-a` option is equivalent to `@F = split`. So, the input will be split based on one or more sequence of **whitespace** characters. Also, leading and trailing whitespaces will be removed (you can use the `LIMIT` argument to preserve trailing empty fields). From [perldoc: split](https://perldoc.perl.org/functions/split):

>`split` emulates the default behavior of the command line tool `awk` when the PATTERN is either omitted or a string composed of a single space character (such as `' '` or `"\x20"`, but not e.g. `/ /`). In this case, any leading whitespace in EXPR is removed before splitting occurs, and the PATTERN is instead treated as if it were `/\s+/`; in particular, this means that any contiguous whitespace (not just a single space character) is used as a separator. However, this special treatment can be avoided by specifying the pattern `/ /` instead of the string `" "`, thereby allowing only a single space character to be a separator.

```bash
# $#F gives the index of the last element, i.e. size of array - 1
$ echo '   a   b   c   ' | perl -anE 'say $#F'
2

# note that the leading whitespaces aren't part of the field content
$ echo '   a   b   c   ' | perl -anE 'say "($F[0])"'
(a)
# trailing whitespaces are removed as well
$ echo '   a   b   c   ' | perl -anE 'say "($F[-1])"'
(c)

# here's another example with more whitespace characters thrown in
# in scalar context, @F will return the size of the array
$ printf '     one \t\f\v two\t\r\tthree \t\r ' | perl -anE 'say scalar @F'
3
$ printf '     one \t\f\v two\t\r\tthree \t\r ' | perl -anE 'say "$F[1]."'
two.
```

## Input field separator

You can use the `-F` command line option to specify a custom regexp field separator. Note that the `-a` option implicitly sets `-n` and the `-F` option implicitly sets `-n` and `-a` on newer versions of Perl. However, this book will always explicitly use these options.

```bash
# use ':' as the input field separator
$ echo 'goal:amazing:whistle:kwality' | perl -F: -anE 'say "$F[0]\n$F[2]"'
goal
whistle

# use quotes to avoid clashes with shell special characters
$ echo 'one;two;three;four' | perl -F';' -anE 'say $F[2]'
three

$ echo 'load;err_msg--\ant,r2..not' | perl -F'\W+' -anE 'say $F[2]'
ant

$ echo 'hi.bye.hello' | perl -F'\.' -anE 'say $F[1]'
bye
```

You can also specify the regexp to the `-F` option within `//` delimiters as well. This is useful to add flags and the `LIMIT` argument if needed.

```bash
# count the number of vowels for each input line
# can also use: -F'(?i)[aeiou]'
$ printf 'COOL\nnice car\n' | perl -F'/[aeiou]/i' -anE 'say $#F'
2
3

# LIMIT=2
# note that the newline character is present as part of the last field content
$ echo 'goal:amazing:whistle:kwality' | perl -F'/:/,$_,2' -ane 'print $F[1]'
amazing:whistle:kwality
```

## Character-wise separation

To get individual characters, you can provide an empty argument to the `-F` option.

```bash
$ echo 'apple' | perl -F -anE 'say $F[0]'
a

# -CS turns on UTF-8 for stdin/stdout/stderr streams
$ echo 'fox:αλεπού' | perl -CS -F -anE 'say @F[4..6]'
αλε
```

For more information about using Perl with different encodings, see:

* [perldoc: -C option](https://perldoc.perl.org/perlrun#-C-%5Bnumber/list%5D)
* [unix.stackexchange: tr with unicode characters](https://unix.stackexchange.com/q/389615/109046)
* [stackoverflow: Why does modern Perl avoid UTF-8 by default?](https://stackoverflow.com/q/6162484/4082052)

## Newline character in the last field

If the custom field separator doesn't affect the newline character, then the last element can contain the newline character.

```bash
# last element will not have the newline character with the -a option
# as leading/trailing whitespaces are trimmed with default split
$ echo 'cat dog' | perl -anE 'say "[$F[-1]]"'
[dog]

# last element will have the newline character since field separator is ':'
$ echo 'cat:dog' | perl -F: -anE 'say "[$F[-1]]"'
[dog
]
# unless the input itself doesn't have the newline character
$ printf 'cat:dog' | perl -F: -anE 'say "[$F[-1]]"'
[dog]
```

The newline character can also show up as the entire content of the last field.

```bash
# both leading and trailing whitespaces are trimmed
$ echo '  a b   c   ' | perl -anE 'say $#F'
2

# leading empty element won't be removed here
# and the last element will have only the newline character as the value
$ echo ':a:b:c:' | perl -F: -anE 'say $#F; say "[$F[-1]]"'
4
[
]
```

## Using the -l option for field splitting

As mentioned before, the `-l` option is helpful if you wish to remove the newline character (more details will be discussed in the [Record separators](#record-separators) chapter). A side effect of removing the newline character before applying `split` is that the trailing empty fields will also get removed (you can set `LIMIT` as `-1` to prevent this).

```bash
# -l will remove the newline character
# -l will also cause 'print' to append the newline character
$ echo 'cat:dog' | perl -F: -lane 'print "[$F[-1]]"'
[dog]

# since the newline character is chomped, the last element is empty
# which is then removed due to the default 'split' behavior
$ echo ':a:b:c:' | perl -F: -lane 'print scalar @F'
4

# set LIMIT as -1 to preserve trailing empty fields
# can also use: perl -F'/:/,$_,-1' -lane 'print scalar @F'
$ echo ':a:b:c:' | perl -lne 'print scalar split/:/,$_,-1'
5
```

## Whitespace and NUL characters in field separation

As per [perldoc: -F option](https://perldoc.perl.org/perlrun#-Fpattern), "You can't use literal whitespace or NUL characters in the pattern." Here are some examples with whitespaces being used as part of the field separator.

```bash
$ s='pick eat rest laugh'

# only one element, field separator didn't match at all!!
$ echo "$s" | perl -F'/t /' -lane 'print $F[0]'
pick eat rest laugh
# number of splits is correct
# but the space character shouldn't be part of field here
$ echo "$s" | perl -F't ' -lane 'print $F[1]'
 res
# this gives the expected behavior
$ echo "$s" | perl -F't\x20' -lane 'print $F[1]'
res

# Error!!
$ echo "$s" | perl -F't[ ]' -lane 'print $F[1]'
Unmatched [ in regex; marked by <-- HERE in m/t[ <-- HERE /.
# no issues if the split function is used explicitly
$ echo "$s" | perl -lne 'print((split /t[ ]/)[1])'
res
```

And here's an example with the ASCII NUL character being used as the field separator:

```bash
# doesn't work as expected when NUL is passed as a literal character
$ printf 'aa\0b\0c' | perl -F$'\0' -anE 'say join ",", @F' | cat -v
a,a,^@,b,^@,c

# no issues when passed as an escape sequence
$ printf 'aa\0b\0c' | perl -F'\0' -anE 'say join ",", @F' | cat -v
aa,b,c
```

## Output field separator

There are a few ways to affect the separator to be used while displaying multiple values.

**Method 1**: The value of the `$,` special variable is used as the separator when multiple arguments (or list/array) are passed to the `print` and `say` functions. `$,` could be remembered easily by noting that `,` is used to separate multiple arguments. Note that the `-l` option is used in the examples below as a good practice even when not needed.

```bash
$ perl -lane 'BEGIN{$,=" "} print $F[0], $F[2]' table.txt
brown mat
blue mug
yellow window

$ s='Sample123string42with777numbers'
$ echo "$s" | perl -F'\d+' -lane 'BEGIN{$,=","} print @F'
Sample,string,with,numbers

# default value of $, is undef
$ echo 'table' | perl -F -lane 'print @F[0..2]'
tab
```

>![info](images/info.svg) See [perldoc: perlvar](https://perldoc.perl.org/perlvar) for alternate names of special variables if you use the [metacpan: English](https://metacpan.org/pod/English) module. For example, `$OFS` or `$OUTPUT_FIELD_SEPARATOR` instead of `$,`

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

# default value of $" is a space character
$ echo "$s" | perl -F: -lane 'print "@F[0, 2]"'
goal whistle

$ echo "$s" | perl -F: -lane 'BEGIN{$"="-"} print "msg: @F[-1, 1, 0]"'
msg: kwality-amazing-goal
```

## Manipulating $#F

Changing the value of `$#F` will affect the `@F` array. Here are some examples:

```bash
$ s='goal:amazing:whistle:kwality'

# reducing fields
$ echo "$s" | perl -F: -lane '$#F=1; print join ",", @F'
goal,amazing

# increasing fields
$ echo "$s" | perl -F: -lane '$F[$#F+1]="sea"; print join ":", @F'
goal:amazing:whistle:kwality:sea

# empty fields will be created as needed
$ echo "$s" | perl -F: -lane '$F[7]="go"; print join ":", @F'
goal:amazing:whistle:kwality::::go
```

Assigning `$#F` to `-1` or lower will delete all the fields.

```bash
$ echo "1:2:3" | perl -F: -lane '$#F=-1; print "[@F]"'
[]
```

Manipulating `$#F` isn't always needed. Here's an example of simply printing the additional field instead of modifying the array.

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

# adds a new grade column based on marks in the third column
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

## Defining field contents instead of splitting

The `-F` option uses the `split` function to generate the fields. In contrast, you can use `/regexp/g` to define what should the fields be made up of. Quoting from [perldoc: Global matching](https://perldoc.perl.org/perlretut#Global-matching):

>In list context, `/g` returns a list of matched groupings, or if there are no groupings, a list of matches to the whole regexp.

Here are some examples:

```bash
$ s='Sample123string42with777numbers'
# define fields to be one or more consecutive digits
# can also use: perl -nE 'say((/\d+/g)[1])'
$ echo "$s" | perl -nE '@f=/\d+/g; say $f[1]'
42

$ s='coat Bin food tar12 best Apple fig_42'
# whole words made up of lowercase alphabets and digits only
$ echo "$s" | perl -nE 'say join ",", /\b[a-z0-9]+\b/g'
coat,food,tar12,best

$ s='items: "apple" and "mango"'
# get the first double quoted item
$ echo "$s" | perl -nE '@f=/"[^"]+"/g; say $f[0]'
"apple"
```

Here are some examples for displaying results only if there's a match. Without the `if` conditions, you'll get empty lines for non-matching lines. Quoting from [perldoc: The empty pattern](https://perldoc.perl.org/perlop#The-empty-pattern-//)

>If the *PATTERN* evaluates to the empty string, the last successfully matched regular expression is used instead. In this case, only the `g` and `c` flags on the empty pattern are honored; the other flags are taken from the original pattern. If no match has previously succeeded, this will (silently) act instead as a genuine empty pattern (which will always match).

```bash
$ perl -nE 'say join "\n", //g if /\bm\w*\b/' table.txt
mat
mug

# /\bb\w*\b/ will come into play only if a word starting with 'h' isn't found
# so, first line matches 'hair' but not 'brown' or 'bread'
# other lines don't have words starting with 'h'
$ perl -nE 'say join "\n", //g if /\bh\w*\b/ || /\bb\w*\b/' table.txt
hair
blue
banana
```

As an alternate, you can use a `while` loop with the `g` flag. Quoting from [perldoc: Global matching](https://perldoc.perl.org/perlretut#Global-matching):

>In scalar context, successive invocations against a string will have `/g` jump from match to match, keeping track of position in the string as it goes along.

```bash
$ perl -nE 'say $& while /\bm\w*\b/g' table.txt
mat
mug

# note that this form isn't suited for priority-based extraction
$ perl -nE 'say $& while /\b[bh]\w*\b/g' table.txt
brown
bread
hair
blue
banana
```

A simple `split` fails for CSV input where fields can contain embedded delimiter characters. For example, a field content `"fox,42"` when `,` is the delimiter.

```bash
$ s='eagle,"fox,42",bee,frog'
# simply using , as separator isn't sufficient
$ echo "$s" | perl -F, -lane 'print $F[1]'
"fox
```

While [metacpan: Text::CSV](https://metacpan.org/pod/Text::CSV) module should be preferred for robust CSV parsing, regexp is enough for simple formats.

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

# here field widths have been assigned such that
# extra spaces are placed at the end of each field
# $_ is the default input string for the 'unpack' function
$ perl -lne 'print join ",", unpack "a8a4a6"' items.txt
apple   ,fig ,banana
50      ,10  ,200

$ perl -lne 'print((unpack "a8a4a6")[1])' items.txt
fig 
10  
```

You can specify characters to be ignored with `x` followed by an optional length.

```bash
# first field is 5 characters
# then 3 characters are ignored and 3 characters for the second field
# then 1 character is ignored and 6 characters for the third field
$ perl -lne 'print join ",", unpack "a5x3a3xa6"' items.txt
apple,fig,banana
50   ,10 ,200
```

Using `*` will cause remaining characters of that particular format to be consumed. Here `Z` is used to process strings that are separated by the ASCII NUL character.

```bash
$ printf 'banana\x0050\x00' | perl -nE 'say join ":", unpack "Z*Z*"'
banana:50

# first field is 5 characters, then 3 characters are ignored
# all the remaining characters are assigned to the second field
$ perl -lne 'print join ",", unpack "a5x3a*"' items.txt
apple,fig banana
50   ,10  200
```

Unpacking isn't always needed, string slicing using `substr` may suffice. See [perldoc: substr](https://perldoc.perl.org/functions/substr) for documentation.

```bash
# same as: perl -F -anE 'say @F[2..4]'
$ echo 'b 123 good' | perl -nE 'say substr $_,2,3'
123
$ echo 'b 123 good' | perl -ne 'print substr $_,6'
good

# replace arbitrary slice
$ echo 'b 123 good' | perl -pe 'substr $_,2,3,"gleam"'
b gleam good
```

See also [perldoc: Functions for fixed-length data or records](https://perldoc.perl.org/functions#Functions-for-fixed-length-data-or-records).

## Assorted field processing functions

Having seen command line options and features commonly used for field processing, this section will highlight some of the built-in functions. There are just too many to meaningfully cover them in all in detail, so consider this to be just a brief overview of features. See also [perldoc: Perl Functions by Category](https://perldoc.perl.org/functions#Perl-Functions-by-Category).

First up, the `grep` function that allows you to select fields based on a condition. In scalar context, it returns the number of fields that matched the given condition. See [perldoc: grep](https://perldoc.perl.org/functions/grep) for documentation. See also [unix.stackexchange: create lists of words according to binary numbers](https://unix.stackexchange.com/q/397498/109046).

```bash
$ s='goal:amazing:42:whistle:kwality:3.14'

# fields containing 'in' or 'it' or 'is'
$ echo "$s" | perl -F: -lane 'print join ":", grep {/i[nts]/} @F'
amazing:whistle:kwality

# number of fields NOT containing a digit character
$ echo "$s" | perl -F: -lane 'print scalar grep {!/\d/} @F'
4

$ s='hour hand band mat heated apple hit'
$ echo "$s" | perl -lane 'print join "\n", grep {!/^h/ && length()<4} @F'
mat

$ echo '20 711 -983 5 21' | perl -lane 'print join ":", grep {$_ > 20} @F'
711:21

# no more than one field can contain 'r'
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
# for in-place modification of the input array
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
# with 'grep' alone, provided the transformation doesn't affect the condition
# also, @F will be changed here, above map+grep code will not affect @F
$ echo "$s" | perl -lane 'print join "\n", grep {y/ae/X/; /^h/} @F'
hour
hXnd
hXXtXd
```

Here are some examples with `sort` and `reverse` functions for arrays and strings. See [perldoc: sort](https://perldoc.perl.org/functions/sort) and [perldoc: reverse](https://perldoc.perl.org/functions/reverse) for documentation.

```bash
# sorting numbers
$ echo '23 756 -983 5' | perl -lane 'print join " ", sort {$a <=> $b} @F'
-983 5 23 756

$ s='floor bat to dubious four'
# default alphabetic sorting in ascending order
$ echo "$s" | perl -lane 'print join ":", sort @F'
bat:dubious:floor:four:to

# sort by length of the fields in ascending order
$ echo "$s" | perl -lane 'print join ":", sort {length($a) <=> length($b)} @F'
to:bat:four:floor:dubious
# descending order
$ echo "$s" | perl -lane 'print join ":", sort {length($b) <=> length($a)} @F'
dubious:floor:four:bat:to

# same as: perl -F -lane 'print sort {$b cmp $a} @F'
$ echo 'dragon' | perl -F -lane 'print reverse sort @F'
rongda
```

Here's an example with multiple sorting conditions. If the transformation applied for each field is expensive, using [Schwartzian transform](https://en.wikipedia.org/wiki/Schwartzian_transform) can provide a faster result. See also [stackoverflow: multiple sorting conditions](https://stackoverflow.com/q/45951050/4082052).

```bash
$ s='try a bad to good i teal by nice how'

# longer words first, ascending alphabetic order as tie-breaker
$ echo "$s" | perl -anE 'say join ":",
                    sort {length($b) <=> length($a) or $a cmp $b} @F'
good:nice:teal:bad:how:try:by:to:a:i

# using Schwartzian transform
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

>![info](images/info.svg) See the [Using modules](#using-modules) chapter for more field processing functions.

## Summary

This chapter discussed various ways in which you can split (or define) the input into fields and manipulate them. Many more examples will be discussed in later chapters.

## Exercises

>![info](images/info.svg) The [exercises](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/exercises) directory has all the files used in this section.

**1)** For the input file `brackets.txt`, extract only the contents between `()` or `)(` from each input line. Assume that `()` characters will be present only once every line.

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

##### add your solution here
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
##### add your solution here
Cy
Ith
```

**4)** Display the number of word characters for the given inputs. Word definition here is same as used in regular expressions. Can you construct two different solutions as indicated below?

```bash
# solve using the 's' operator
$ echo 'hi there' | ##### add your solution here
7

# solve without using the substitution or transliteration operators
$ echo 'u-no;co%."(do_12:as' | ##### add your solution here
12
```

**5)** For the input file `quoted.txt`, extract the sequence of characters surrounded by double quotes and display them in the format shown below.

```bash
$ cat quoted.txt
1 "grape" and "mango" and "guava"
("c 1""d""a-2""b")

##### add your solution here
"grape","guava","mango"
"a-2","b","c 1","d"
```

**6)** Display only the third and fifth characters from each input line as shown below.

```bash
$ printf 'restore\ncat one\ncricket' | ##### add your solution here
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

##### add your solution here
1.3,rs,0.134563
3.8,NA,6
5.2,ye,8.2387
4.2,kt,45.1
```

**8)** For the input file `scores.csv`, display the header as well as any row which contains `b` or `t` (irrespective of case) in the first field.

```bash
##### add your solution here
Name,Maths,Physics,Chemistry
Blue,67,46,99
Ort,68,72,66
Ith,100,100,100
```

**9)** Extract all whole words containing `42` but not at the edge of a word. Assume a word cannot contain `42` more than once.

```bash
$ s='hi42bye nice1423 bad42 cool_42a 42fake'
$ echo "$s" | ##### add your solution here
hi42bye
nice1423
cool_42a
```

**10)** For the input file `scores.csv`, add another column named **GP** which is calculated out of 100 by giving 50% weightage to Maths and 25% each for Physics and Chemistry.

```bash
##### add your solution here
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

##### add your solution here
rose lily
pink blue
car,mat
light green,brown
apple,banana
```

**12)** For the given space separated numbers, filter only numbers in the range `20` to `1000` (inclusive).

```bash
$ s='20 -983 5 756 634223 1000'

$ echo "$s" | ##### add your solution here
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
##### add your solution here
bot
art

# descending order
##### add your solution here
toe
reed
```

**14)** For the given space separated words, extract the three longest words.

```bash
$ s='I bought two bananas and three mangoes'

$ echo "$s" | ##### add your solution here
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

##### add your solution here
apple,1,mango
apple,2,mango
apple,5,mango
wry,4,look
pencil,3,paper
pencil,8,paper
```

**16)** Generate string combinations as shown below for the given input string passed as an environment variable.

```bash
$ s='{x,y,z}{1,2,3}' ##### add your solution here
x1 x2 x3 y1 y2 y3 z1 z2 z3
```

**17)** For the input file `varying_fields.txt`, construct a solution to get the output shown below.

```bash
$ cat varying_fields.txt
hi,bye,there,was,here,to
1,2,3,4,5

##### add your solution here
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

##### add your solution here
42
twelve:a2b
we:be:he:0:a:b
apple:banana-42:cherry
dragon:unicorn:centaur
```

**19)** The sample string shown below uses `cat` as the field separator (irrespective of case). Use space as the output field separator and add `42` as the last field.

```bash
$ s='applecatfigCaT12345cAtbanana'
$ echo "$s" | ##### add your solution here
apple fig 12345 banana 42
```

**20)** For the input file `sample.txt`, filter lines containing 5 or more lowercase vowels.

```bash
##### add your solution here
How are you
Believe it
No doubt you like it too
Much ado about nothing
```

# Record separators

So far, you've seen examples where Perl automatically splits input line by line based on the newline character. Just like you can control how those lines are further split into fields using the `-a`, `-F` options and other features, Perl provides a way to control what constitutes a line in the first place. The term **record** is used to describe the contents that gets placed in the `$_` special variable with the `-n` or `-p` options.

>![info](images/info.svg) The [example_files](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/example_files) directory has all the files used in the examples.

## Input record separator

By default, the newline character is used as the input record separator. You can change the `$/` special variable to specify a different input record separator. Unlike field separators, you can only use a string value, regexp isn't allowed. See [perldoc faq: I put a regular expression into `$/` but it didn't work. What's wrong?](https://perldoc.perl.org/perlfaq6#I-put-a-regular-expression-into-$/-but-it-didn't-work.-What's-wrong?) for workarounds.

```bash
# change the input record separator to a comma character
# note the content of the 2nd record where newline is just another character
# by default, the record separator stays with the record contents
$ printf 'this,is\na,sample,text' | perl -nE 'BEGIN{$/ = ","} say "$.)$_"'
1)this,
2)is
a,
3)sample,
4)text

# use the -l option to chomp the record separator
$ printf 'this,is\na,sample,text' | perl -lne 'BEGIN{$/ = ","} print "$.)$_"'
1)this
2)is
a
3)sample
4)text
```

Here's an example where the record separator has multiple characters:

```bash
$ cat report.log
blah blah Error: second record starts
something went wrong
some more details Error: third record
details about what went wrong

# uses 'Error:' as the input record separator
# print all the records containing 'something'
$ perl -lne 'BEGIN{$/ = "Error:"} print if /something/' report.log
 second record starts
something went wrong
some more details 
```

## Single character separator with the -0 option

The `-0` command line option can be used to specify a single character record separator, represented with zero to three octal digits. You can also use hexadecimal value. Quoting from [perldoc: -0 option](https://perldoc.perl.org/perlrun#-0%5Boctal/hexadecimal%5D):

>You can also specify the separator character using hexadecimal notation: `-0xHHH...`, where the `H` are valid hexadecimal digits. Unlike the octal form, this one may be used to specify any Unicode character, even those beyond `0xFF`. So if you really want a record separator of `0777`, specify it as `-0x1FF`. (This means that you cannot use the `-x` option with a directory name that consists of hexadecimal digits, or else Perl will think you have specified a hex number to `-0`.)

```bash
$ s='this:is:a:sample:string'

# the : character is represented by 072 in octal
# -l is used here to chomp the separator
$ echo "$s" | perl -0072 -lnE 'say "$.) $_"'
1) this
2) is
3) a
4) sample
5) string

# print all records containing 'a'
$ echo "$s" | perl -0072 -lnE 'say $_ if /a/'
a
sample
```

The character that gets appended to the `print` function with the `-l` option is based on the value of input record separator at that point. Here are some examples to clarify this point.

```bash
$ s='this:is:a:sample:string'

# here, the record separator is still the default \n when -l is used
# so \n gets appended when 'print' is used
# note that chomp isn't affected by such differences in order
# same as: echo "$s" | perl -lne 'BEGIN{$/=":"} print if /a/'
$ echo "$s" | perl -l -0072 -ne 'print if /a/'
a
sample

# here -l is defined after -0, so : gets appended for 'print'
$ echo "$s" | perl -0072 -lne 'print if /a/'
a:sample:
```

By default, the `-a` option will split the input record based on whitespaces and remove leading/trailing whitespaces. Now that you've seen how the input record separator can be something other than newline, here's an example to show the full effect of the default record splitting.

```bash
# ':' character is the input record separator here
$ s='   a\t\tb:1000\n\n\t \n\n123 7777:x  y \n \n z  :apple banana cherry'
$ printf '%b' "$s" | perl -0072 -lanE 'say join ",", @F'
a,b
1000,123,7777
x,y,z
apple,banana,cherry
```

## NUL separator

If the `-0` option is used without an argument, the ASCII NUL character will be considered as the input record separator.

```bash
$ printf 'apple\0banana\0' | cat -v
apple^@banana^@

# can also be golfed to: perl -lp0e ''
# don't use -l0 as 0 will be treated as an argument to -l
$ printf 'apple\0banana\0' | perl -ln0e 'print'
apple
banana
```

## Slurping entire input

Any octal value of `400` and above will cause the entire input to be slurped as a single string. Idiomatically, `777` is used. This is same as setting `$/ = undef`. Slurping the entire file makes it easier to solve some problems, but be careful to not use it for large files, as that might cause memory issues.

```bash
$ cat paths.txt
/home/joe/report.log
/home/ram/power.log
/home/rambo/errors.log
$ perl -0777 -pe 's|(?<!\A)/.+/|/|s' paths.txt
/home/errors.log

# replicate entire input as many times as needed
$ seq 2 | perl -0777 -ne 'print $_ x 2'
1
2
1
2
```

As an alternate, Perl 5.36 introduced the `-g` option for slurping the entire input.

```bash
$ seq 2 | perl -gne 'print $_ x 2'
1
2
1
2
```

## Paragraph mode

As a special case, using `-00` or setting `$/` to an empty string will invoke paragraph mode. Two or more consecutive newline characters will act as the record separator. Consider the below sample file:

```bash
$ cat para.txt
Hello World

Hi there
How are you

Just do-it
Believe it

banana
papaya
mango

Much ado about nothing
He he he
Adios amigo
```

Here are some examples of processing the input file paragraph wise.

```bash
# all paragraphs containing 'do'
# note that the record separator is preserved as there's no chomp
$ perl -00 -ne 'print if /do/' para.txt
Just do-it
Believe it

Much ado about nothing
He he he
Adios amigo

# all paragraphs containing exactly two lines
# note that there's an empty line after the last line
$ perl -F'\n' -00 -ane 'print if $#F == 1' para.txt
Hi there
How are you

Just do-it
Believe it

```

If the paragraphs are separated by more than two consecutive newlines, the extra newlines will not be part of the record content.

```bash
$ s='a\n\n\n\n\n\n\n\n12\n34\n\nhi\nhello\n'

# note that the -l option isn't being used here
$ printf '%b' "$s" | perl -00 -ne 'print if $. <= 2'
a

12
34

```

Any leading newlines (only newlines, not other whitespace characters) in the input data file will be trimmed and not lead to empty records. This is similar to how `-a` treats whitespaces for default field separation.

```bash
$ s='\n\n\na\nb\n\n12\n34\n\nhi\nhello\n\n\n\n'

# note that -l is used to chomp the record separator here
$ printf '%b' "$s" | perl -00 -lnE 'say "$_\n---" if $. == 1'
a
b
---

# max. of two trailing newlines will be preserved if -l isn't used
$ printf '%b' "$s" | perl -00 -lnE 'say "$_\n---" if eof'
hi
hello
---

$ printf '%b' "$s" | perl -00 -nE 'END{say $.}'
3
$ printf '%b' "$s" | perl -00 -nE 'BEGIN{$/="\n\n"}; END{say $.}'
5
```

The empty line at the end is a common problem when dealing with custom record separators. You could either process the output further to remove it or add extra logic to handle the issue. Here's one possible workaround:

```bash
# single paragraph output, no empty line at the end
$ perl -l -00 -ne 'if(/are/){print $s, $_; $s="\n"}' para.txt
Hi there
How are you

# multiple paragraph output with an empty line between the paragraphs
$ perl -l -00 -ne 'if(/are|an/){print $s, $_; $s="\n"}' para.txt
Hi there
How are you

banana
papaya
mango
```

## Output record separator

Similar to the `-0` option used for setting the input record separator, you can use the `-l` option to specify a single character output record separator by passing an octal value as the argument.

```bash
# comma as output record separator, won't have a newline at the end
# note that -l also chomps the input record separator
$ seq 8 | perl -l054 -ne 'print if /[24]/'
2,4,

# null separator
$ seq 8 | perl -l0 -ne 'print if /[24]/' | cat -v
2^@4^@

# adding a final newline to output
$ seq 8 | perl -l054 -nE 'print if /[24]/; END{say}'
2,4,
```

You can use the `$\` special variable to specify a multicharacter string that gets appended to the `print` function. This is will override changes due to the `-l` option, if any.

```bash
# recall that the input record separator isn't removed by default
$ seq 2 | perl -ne 'print'
1
2
# this will add four more characters after the already present newline
# same as: perl -pe 'BEGIN{$\ = "---\n"}'
$ seq 2 | perl -ne 'BEGIN{$\ = "---\n"} print'
1
---
2
---

# change the NUL character to a dot and newline characters
# -l here helps to chomp the NUL character 
# -l also sets NUL to be added to print, but gets overridden in BEGIN block
$ printf 'apple\0banana\0' | perl -0lpe 'BEGIN{$\ = ".\n"}'
apple.
banana.
```

Many a times, you'd need to change the output record separator depending upon the contents of the input record or some other condition. The `cond ? expr1 : expr2` ternary operator is often used in such scenarios. The below example assumes that the input is evenly divisible, you'll have to add more logic if that is not the case.

```bash
# same as: perl -pe 's/\n/-/ if $. % 3'
$ seq 6 | perl -lpe '$\ = $. % 3 ? "-" : "\n"'
1-2-3
4-5-6
```

## Summary

This chapter showed you how to change the way the input content is split into records and how to set the string to be appended when `print` is used. The paragraph mode is useful for processing multiline records separated by one or more empty lines. You also learned how to set ASCII NUL as the record separator and how to slurp the entire input as a single string.

## Exercises

>![info](images/info.svg) The [exercises](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/exercises) directory has all the files used in this section.

**1)** The input file `jumbled.txt` consists of words separated by various delimiters. Display all words that contain `an` or `at` or `in` or `it`, one per line.

```bash
$ cat jumbled.txt
overcoats;furrowing-typeface%pewter##hobby
wavering:concession/woof\retailer
joint[]seer{intuition}titanic

##### add your solution here
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
##### add your solution here
Hello World,How are you,This game is good,Today is sunny,12345,You are funny

# if there's only one line in input, again make sure there's no trailing ','
# and that there's a newline character at the end of the line
$ printf 'fig' | paste -sd,
fig
$ printf 'fig' | ##### add your solution here
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
##### add your solution here
Just do-it
Believe it

Today is sunny
Not a bit funny
No doubt you like it too
```

**4)** For the input file `sample.txt`, change each paragraph to a single line by joining lines using `.` and a space character as the separator. Also, add a final `.` to each paragraph.

```bash
# note that there's no extra empty line at the end of the output
##### add your solution here
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
$ printf "$s" | ##### add your solution here
mango:100;;grapes:75;; 
```

**6)** The input file `f1.txt` has varying amount of empty lines between the records, change them to be always two empty lines. Also, remove the empty lines at the start and end of the file.

```bash
##### add your solution here
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
$ echo "$s" | ##### add your solution here
fig

banana

:mango
```

# Using modules

By default, Perl provides plenty of standard modules. And there are many more third-party modules available for a wide variety of use cases. This chapter will discuss the `-M` command line option and show some examples with the standard and third-party modules. You'll also see how to convert one-liners to a full fledged script file.

>![info](images/info.svg) The [example_files](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/example_files) directory has all the files used in the examples.

## Standard modules

See [perldoc: modules](https://perldoc.perl.org/modules) for a complete list of built-in modules. Quoting from [perldoc: -m and -M options](https://perldoc.perl.org/perlrun#-m%5B-%5Dmodule):

>`-Mmodule` executes `use module ;` before executing your program. This loads the module and calls its `import` method, causing the module to have its default effect, typically importing subroutines or giving effect to a pragma. You can use quotes to add extra code after the module name, e.g., `'-MMODULE qw(foo bar)'`.
>
>A little builtin syntactic sugar means you can also say `-mMODULE=foo,bar` or `-MMODULE=foo,bar` as a shortcut for `'-MMODULE qw(foo bar)'`. This avoids the need to use quotes when importing symbols. The actual code generated by `-MMODULE=foo,bar` is `use module split(/,/,q{foo,bar})`. Note that the `=` form removes the distinction between `-m` and `-M`; that is, `-mMODULE=foo,bar` is the same as `-MMODULE=foo,bar`

The `List::Util` module has handy functions for array processing. See [perldoc: List::Util](https://perldoc.perl.org/List::Util) for documentation. Here are some examples with `max`, `product` and `sum0`.

```bash
# same as: perl -F, -anE 'BEGIN{use List::Util qw(max)} say max @F'
$ echo '34,17,6' | perl -MList::Util=max -F, -anE 'say max @F'
34

$ echo '34,17,6' | perl -MList::Util=product -F, -anE 'say product @F'
3468

# 'sum0' returns '0' even if the array is empty, whereas 'sum' returns 'undef'
$ echo '3.14,17,6' | perl -MList::Util=sum0 -F, -anE 'say sum0 @F'
26.14
```

Here are some examples for `shuffle`, `sample` and `uniq`.

```bash
$ s='floor bat to dubious four'
$ echo "$s" | perl -MList::Util=shuffle -lanE 'say join ":", shuffle @F'
bat:four:dubious:floor:to

$ echo 'dragon' | perl -MList::Util=shuffle -F -lanE 'say shuffle @F'
rogdan

# similar to shuffle, but can specify the number of elements needed
$ echo "$s" | perl -MList::Util=sample -lanE 'say join ":", sample 2, @F'
dubious:bat

$ s='3,b,a,3,c,d,1,d,c,2,2,2,3,1,b'
# note that the input order of elements is preserved
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
# output shown here is modified for presentation purposes
$ perl -MText::CSV -e ''
Can't locate Text/CSV.pm in @INC (you may need to install the Text::CSV module)
(@INC entries checked: <list of paths>).
BEGIN failed--compilation aborted.
```

If you are using the Perl version that came installed with your operating system, check if you can install a module from your platform repository. Here's an example for Ubuntu:

```bash
# search for the Text::CSV module
$ apt-cache search perl text-csv
libspreadsheet-read-perl - reader for common spreadsheet formats
libtext-csv-encoded-perl - encoding-aware comma-separated values manipulator
libtext-csv-perl - comma-separated values manipulator (using XS or PurePerl)
libtext-csv-xs-perl - Perl C/XS module to process Comma-Separated Value files

# install the module of your choice
$ sudo apt install libtext-csv-xs-perl
```

The above process may fail to work with the Perl version that you manually installed or if a particular module isn't available from your platform repository. There are different options for such cases.

* [stackoverflow: easiest way to install a missing module](https://stackoverflow.com/q/65865/4082052) shows how to use the `cpan` command and has details for Windows platform too. You might need admin privileges.
* [metacpan: cpanm](https://metacpan.org/pod/cpanm) is also often recommended
* [metacpan: Carton](https://metacpan.org/pod/Carton) is a Perl module dependency manager (aka Bundler for Perl)

## CSV

For robustly parsing CSV files, you can use [metacpan: Text::CSV](https://metacpan.org/pod/Text::CSV) or [metacpan: Text::CSV_XS](https://metacpan.org/pod/Text::CSV_XS) modules. `_XS` indicates a faster implementation, usually written in the `C` language. The `Text::CSV` module uses `Text::CSV_XS` by default and uses `Text::CSV_PP` (pure Perl implementation) if the `_XS` module isn't available.

Here's an example of parsing CSV input with embedded comma characters. `ARGV` is a special filehandle that iterates over filenames passed as command line arguments (see the [Multiple file input](#multiple-file-input) chapter for more details).

```bash
$ s='eagle,"fox,42",bee,frog\n1,2,3,4'
# note that neither -n or -p is used here
$ printf '%b' "$s" | perl -MText::CSV_XS -E 'say $row->[1]
                     while $row = Text::CSV_XS->new->getline(*ARGV)'
fox,42
2
```

Here's an example with embedded newline characters. Quoting from the documentation:

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

You can change the field separator using the `sep_char` option.

```bash

$ perl -MText::CSV_XS -E '
        while($row = Text::CSV_XS->new({sep_char => "\t"})->getline(*ARGV))
        {say join ",", @$row if $row->[0] eq "CSE"}' marks.txt
CSE,Surya,81
CSE,Amy,67
```

## JSON

Newer versions of Perl come with the [perldoc: JSON::PP](https://perldoc.perl.org/JSON::PP) module, which is a pure Perl implementation. Use [metacpan: JSON::XS](https://metacpan.org/pod/JSON::XS) for faster results. There's also [metacpan: Cpanel::JSON::XS](https://metacpan.org/pod/Cpanel::JSON::XS), which mentions the following reason:

>While it seems there are many JSON modules, none of them correctly handle all corner cases, and in most cases their maintainers are unresponsive, gone missing, or not listening to bug reports for other reasons.

Here's a simple example of parsing JSON from a single line of input data.

```bash
$ s='{"greeting":"hi","marks":[78,62,93]}'

# <> is same as <ARGV>, here it helps to get a line of input
$ echo "$s" | perl -MCpanel::JSON::XS -E '$ip=decode_json <>; say $ip->{greeting}'
hi

$ echo "$s" | perl -MCpanel::JSON::XS -E '$ip=decode_json <>;
              say join ":", @{$ip->{marks}}'
78:62:93
```

For multiline input, use `-0777` (or set `$/ = undef` or `-g` with newer Perl versions) to pass the entire input content as single string. You can also create a shortcut to make it easier for one-liners.

```bash
# check if a shortcut is available
$ type pj
bash: type: pj: not found

# add this to your ~/.bashrc (or the file you use for aliases/functions)
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

# order may be different than input as hash doesn't maintain key order
# process top-level keys not containing 'e'
$ pj 'for (keys %$ip){say "$_:$ip->{$_}" if !/e/}' sample.json
physics:84
fruit:apple

# process keys within 'language' key that contain 't'
$ pj '$"=","; while(($k,$v) = each %{$ip->{language}})
      {say "$k:@{$v}" if $k=~/t/}' sample.json
natural:english,hindi,spanish
```

Here's an example of converting possibly minified `json` input to a pretty printed output. You can use `json_pp` for `JSON::PP` and `json_xs` for `JSON::XS`.

```bash
$ s='{"greeting":"hi","marks":[78,62,93],"fruit":"apple"}'

# same as: echo "$s" | perl -MCpanel::JSON::XS -e '
#          print Cpanel::JSON::XS->new->pretty->encode(decode_json <>)'
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

The `O` module can be used to convert one-liners to full fledged programs. See [perldoc: O](https://perldoc.perl.org/O) for documentation. This is similar to the `-o` option provided by `GNU awk`.

Here's how the `-n` and `-p` options are implemented.

```bash
# note that input sources (stdin, filenames, etc) aren't needed here
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

Here's an alternate way to specify some code to be executed after the `while` loop instead of using the `END` block, when the `-n` option is being used. This cannot be used with the `-p` option because it will disrupt the `continue` block.

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

>![info](images/info.svg) ![info](images/info.svg) If you have noted the `Deparse` output very carefully, you'll see that the `while` loop has a `LINE` label. So, you can use `next LINE` to move onto the next input record even if you are inside other loops and blocks.

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

This chapter showed how to enable modules via the `-M` option and some examples for the standard and third-party modules. You also saw how to convert cryptic one-liners to full fledged Perl scripts using the `O` module.

## Exercises

>![info](images/info.svg) The [exercises](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/exercises) directory has all the files used in this section.

**1)** For the given space separated words, display the max word determined by alphabetic order.

```bash
$ s='let in bat xml me lion'

$ echo "$s" | ##### add your solution here
xml
```

**2)** For the given space separated words, randomize the order of characters for each word.

```bash
$ s='this is a sample sentence'

# sample randomized output shown here, could be different for you
$ echo "$s" | ##### add your solution here
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

##### add your solution here
flower
sand stone
```

**4)** Display the current time in the format shown below.

```bash
# output will be different for you
##### add your solution here
12-Sep-2023 11:01:14
```

>![info](images/info.svg) See [metacpan: DateTime](https://metacpan.org/pod/DateTime) for more comprehensive functions.

# Multiple file input

You have already seen blocks like `BEGIN`, `END` and statements like `next` and `exit`. This chapter will discuss features that are useful to make decisions around each file when there are multiple files passed as input.

>![info](images/info.svg) The [example_files](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/example_files) directory has all the files used in the examples.

## @ARGV, $ARGV and ARGV

From [perldoc: @ARGV](https://perldoc.perl.org/variables/@ARGV):

>The array `@ARGV` contains the command-line arguments intended for the script. `$#ARGV` is generally the number of arguments minus one, because `$ARGV[0]` is the first argument, not the program's command name itself.

```bash
# note that only the -E option is used here
$ perl -E 'say join "\n", @ARGV' f[1-3].txt greeting.txt
f1.txt
f2.txt
f3.txt
greeting.txt

# @ARGV continuously ejects the filename being processed
# f1.txt and f2.txt have 1 line each, table.txt has 3 lines
$ perl -nE 'say "$#ARGV: " . join ",", @ARGV' f[12].txt table.txt
1: f2.txt,table.txt
0: table.txt
-1: 
-1: 
-1: 
```

>![info](images/info.svg) See also [stackoverflow: referencing filename passed as arguments](https://stackoverflow.com/q/9151243/4082052) for more details about `@ARGV` behavior when the `-n` or `-p` switches are active.

From [perldoc: $ARGV](https://perldoc.perl.org/variables/$ARGV):

>Contains the name of the current file when reading from `<>`.

From [perldoc: ARGV](https://perldoc.perl.org/variables/ARGV):

>The special filehandle that iterates over command-line filenames in `@ARGV`. Usually written as the null filehandle in the angle operator `<>`. Note that currently `ARGV` only has its magical effect within the `<>` operator; elsewhere it is just a plain filehandle corresponding to the last file opened by `<>`.

By closing `ARGV` at the end of each input file, you can reset the `$.` variable.

```bash
# logic to do something at the start of each input file
# closing ARGV will reset $.
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

# do something at the end of a file
# same as: tail -q -n1 greeting.txt table.txt
$ perl -ne 'print if eof' greeting.txt table.txt
Good bye
yellow banana window shoes 3.14
```

Here are some more examples.

```bash
# same as: awk 'FNR==2{print; nextfile}' greeting.txt table.txt
$ perl -ne 'print and close ARGV if $.==2' greeting.txt table.txt
Have a nice day
blue cake mug shirt -7

# same as: head -q -n1 and awk 'FNR>1{nextfile} 1'
# can also use: perl -pe 'close ARGV'
$ perl -pe 'close ARGV if $.>=1' greeting.txt table.txt
Hi there
brown bread mat hair 42
```

In scalar context, `<>` will return the next input record and in list context, `<>` returns all the remaining input records. If you need a single character instead of a record, you can use the `getc` function. See [perldoc: getc](https://perldoc.perl.org/perlfunc#getc) for documentation.

```bash
# note that only the -e option is used, same as: perl -e 'print scalar <>'
$ perl -e 'print scalar readline' greeting.txt
Hi there
$ perl -e '$line = <>; print "$line---\n"; print <>' greeting.txt
Hi there
---
Have a nice day
Good bye

# note that the default filehandle for getc is STDIN
$ perl -E 'say getc' <greeting.txt
H
```

## STDIN

The `STDIN` filehandle is useful to distinguish between files passed as arguments and the stdin data. See the [Comparing records](#comparing-records) section for more examples.

```bash
# with no file arguments, <> reads the stdin data
$ printf 'apple\nmango\n' | perl -e 'print <>'
apple
mango

# with file arguments, <> doesn't read the stdin data
$ printf 'apple\nmango\n' | perl -e 'print <>' greeting.txt
Hi there
Have a nice day
Good bye

$ printf 'apple\nmango\n' | perl -e 'print <STDIN>' greeting.txt
apple
mango
```

## Skipping remaining contents per file

You have seen examples where the `exit` function was used to avoid processing unnecessary records for the current and any other files yet to be processed. Sometimes, you need to skip only the contents for the current file and move on to the next file for processing. The `close ARGV` example seen previously comes in handy for such cases.

```bash
# avoids unnecessary processing compared to perl -ne 'print if !(/\bba/ .. eof)'
# same as: awk '/\<ba/{nextfile} 1' ip.txt table.txt
$ perl -ne '/\bba/ ? close ARGV : print' ip.txt table.txt
it is a warm and cozy day
listen to what I say
go play in the park
brown bread mat hair 42
blue cake mug shirt -7

# print filename if it contains 'I' anywhere in the file
# same as: grep -l 'I' f[1-3].txt greeting.txt
# same as: perl -0777 -nE 'say $ARGV if /I/'
# but slurping is dependent on size of input files and available memory
$ perl -nE 'if(/I/){say $ARGV; close ARGV}' f[1-3].txt greeting.txt
f1.txt
f2.txt

# print filename if it contains a word ending with 'e'
# and 'bat' or 'mat' (irrespective of case) anywhere in the file
# same as: perl -0777 -nE 'say $ARGV if /(?=.*?e\b)(?i).*[bm]at/s'
$ perl -nE '$m1=1 if /e\b/; $m2=1 if /[bm]at/i;
            if($m1 && $m2){say $ARGV; $m1=$m2=0; close ARGV; next};
            $m1=$m2=0 if eof' f[1-3].txt greeting.txt
f3.txt
```

## Summary

This chapter introduced features for processing multiple file inputs and constructing file level decisions. These will also show up in more examples in the coming chapters.

## Exercises

>![info](images/info.svg) The [exercises](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/exercises) directory has all the files used in this section.

**1)** Print the last field of first two lines for the input files `table.txt` and `ip.txt`. Assume space as the field separators for these two files. To make the output more informative, print filenames and a separator as shown in the output below. Assume that the input files will have at least two lines.

```bash
# assume table.txt ip.txt are passed as file inputs
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

**2)** For the input files `sample.txt`, `secrets.txt`, `ip.txt` and `table.txt`, display only the names of files that contain `at` or `fun` in the third field. Assume space as the field separator.

```bash
##### add your solution here
secrets.txt
ip.txt
table.txt
```

**3)** Print the first two lines for each of the input files `ip.txt`, `sample.txt` and `table.txt`. Also, add a separator between the results as shown below (note that the separator isn't present at the end of the output). Assume that the input files will have at least two lines.

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

**4)** Print only the second field of the third line, if any, from these input files: `ip.txt`, `sample.txt` and `copyright.txt`. Consider space as the field separator.

```bash
##### add your solution here
game
day
bla
```

# Processing multiple records

Often, you need to consider multiple lines at a time to make a decision, such as the paragraph mode examples seen earlier. Sometimes, you need to match a particular record and then get records surrounding the matched record. Solution to these type of problems often use state machines. See [softwareengineering: FSM examples](https://softwareengineering.stackexchange.com/questions/47806/examples-of-finite-state-machines) if you are not familiar with state machines.

>![info](images/info.svg) The [example_files](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/example_files) directory has all the files used in the examples.

## Processing consecutive records

You might need to define a condition that should satisfy something for one record and something else for the very next record. There are many ways to tackle this problem. One possible solution is to use variables to save the previous records and then create the required conditional expression using those variables and `$_` which has the current record content.

```bash
# match and print two consecutive records
# the first record should contain 'he' and the second one should contain 'you'
$ perl -ne 'print $p, $_ if /you/ && $p=~/he/; $p = $_' para.txt
Hi there
How are you

# same filtering as above, but print only the first record
$ perl -ne 'print $p if /you/ && $p=~/he/; $p = $_' para.txt
Hi there

# same filtering as above, but print only the second record
$ perl -ne 'print if /you/ && $p=~/he/; $p = $_' para.txt
How are you
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

* If initially `$n=2`, then we get
    * `2 && 2` — evaluates to `true` and `$n` becomes `1`
    * `1 && 1` — evaluates to `true` and `$n` becomes `0`
    * `0 && ` — evaluates to `false` and `$n` doesn't change
* Note that when conditionals are connected with logical `&&`, the second expression will not be executed at all if the first one turns out to be `false` because the overall result will always be `false`. Same is the case if the first expression evaluates to `true` with the logical `||` operator. Such logical operators are also known as **short-circuit** operators. Thus, in the above case, `$n--` won't be executed when `$n` is `0` on the left hand side. This prevents `$n` going negative and `$n && $n--` will never become `true` unless `$n` is assigned again.

```bash
# same as: grep --no-group-separator -A1 'blue'
# print the matching line as well as the one that follows it
$ perl -ne '$n=2 if /blue/; print if $n && $n--' context.txt
blue
    toy
light blue
    flower

# for overlapping cases, $n gets re-assigned before $n becomes 0
$ perl -ne '$n=2 if /toy|flower/; print if $n && $n--' context.txt
    toy
    flower
    sand stone
    flower
    sky
```

Once you've understood the above examples, the rest of the examples in this section should be easier to comprehend. They are all variations of the logic used above and re-arranged to solve the use case being discussed.

**Case 2:** Print `n` records after the matching record. This is similar to the previous case, except that the matching record isn't printed.

```bash
# print 2 lines after the matching line
$ perl -ne 'print if $n && $n--; $n=2 if /prog/' context.txt
    python
    kotlin
```

**Case 3:** Printing the `n`th record after the matching record.

```bash
# print only the 3rd line found after the matching line
# $n && !--$n will be true only when --$n yields 0
# overlapping cases won't work as $n gets re-assigned before going to 0
$ perl -ne 'print if $n && !--$n; $n=3 if /language/' context.txt
    spanish
    ruby
```

**Case 4:** Printing the matched record and `n` records before it.

```bash
# print matched record and 2 records before the match
$ perl -ne '$ip[$.]=$_; print @ip[$.-2 .. $.] if /stone/' context.txt
    toy
    flower
    sand stone

# this will work even if there are less than n records before a match
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

# if the count is small enough, you can save them in variables
# this one prints the 2nd line before the matching line
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

This section will cover cases where the input file will always contain the same number of starting and ending patterns, arranged in an alternating fashion. For example, there cannot be two starting patterns appearing without an ending pattern between them and vice versa. Lines of text inside and between such groups are optional.

The sample file shown below will be used to illustrate examples in this section. For simplicity, assume that the starting pattern is marked by `start` and the ending pattern by `end`. They have also been given group numbers to make it easier to analyze the output.

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

>![info](images/info.svg) `perl -ne 'print if /start/../end/'` can be used as seen previously in the [Range operator](#range-operator) section. The state machine format is more flexible for the various cases to follow.

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
# same as: perl -ne 'print if !(/start/../end/)'
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

Instead of working with all the groups (or blocks) bound by the markers, this section will discuss how to choose blocks based on an additional criteria.

Here's how you can process only the first matching block. See also [stackoverflow: copy pattern between range only once](https://stackoverflow.com/q/38481155/4082052) and [stackoverflow: extract only first range](https://stackoverflow.com/a/63072979/4082052).

```bash
$ perl -ne '$f=1 if /start/; print if $f; exit if /end/' uniform.txt
--start 1--
1234
6789
**end 1**

# use other tricks discussed in the previous section as needed
$ perl -ne 'exit if /end/; print if $f; $f=1 if /start/' uniform.txt
1234
6789
```

Getting the last block alone involves a lot more work, unless you happen to know how many blocks are present in the input file.

```bash
# reverse input linewise, change the order of comparison, reverse again
# difficult to adjust if the record separator is something other than newline
$ tac uniform.txt | perl -ne '$f=1 if /end/; print if $f; exit if /start/' | tac
--start 2--
a
b
c
**end 2**

# or, save the blocks in a buffer and print the last one alone
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

All blocks greater than the `n`th block.

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

Excluding the `n`th block.

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

All blocks, only if the records between the markers match an additional condition.

```bash
# additional condition here is a record with entire content as '15'
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

>![info](images/info.svg) The [exercises](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/exercises) directory has all the files used in this section.

**1)** For the input file `sample.txt`, print lines containing `do` only if the previous line is empty and the line before that contains `you`.

```bash
##### add your solution here
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

##### add your solution here
No doubt you like it too
Much ado about nothing
```

**3)** For the input file `sample.txt`, print the matching line as well as `n` lines around the matching lines. The value for `n` is passed to the Perl command as an environment value.

```bash
# match a line containing 'are' or 'bit'
$ n=1 ##### add your solution here
Good day
How are you

Today is sunny
Not a bit funny
No doubt you like it too

# match a line containing 'World'
$ n=2 ##### add your solution here
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
##### add your solution here
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

**6)** For the input file `perl.md`, replace all occurrences of `perl` (irrespective of case) with `Perl`. But, do not replace any matches between ` ```perl ` and ` ``` ` lines (`perl` in these markers shouldn't be replaced either). Save the output in `out.md`.

```bash
##### add your solution here, redirect the output to 'out.md'

$ diff -sq out.md expected.md 
Files out.md and expected.md are identical
```

**7)** Print the last two lines for each of the input files `ip.txt`, `sample.txt` and `table.txt`. Also, add a separator between the results as shown below (note that the separator isn't present at the end of the output). Assume that the input files will have at least two lines.

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

##### add your solution here
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

##### add your solution here
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

# Two file processing

This chapter focuses on solving problems which depend upon the contents of two or more files. These are usually based on comparing records and fields. Sometimes, record number plays a role too. You'll also see some examples where the entire file content is used.

>![info](images/info.svg) The [example_files](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/example_files) directory has all the files used in the examples.

## Comparing records

Consider the following input files which will be compared line wise to get the common and unique lines.

```bash
$ cat colors_1.txt
teal
light blue
green
yellow

$ cat colors_2.txt
light blue
black
dark green
yellow
```

If you do not wish to use modules, you can make use of a hash to compare the records.

```bash
# common lines
# same as: grep -Fxf colors_1.txt colors_2.txt
# for two file input, $#ARGV will be 0 only for the first file
# note that 'exists' isn't strictly necessary here
$ perl -ne 'if(!$#ARGV){$h{$_}=1; next}
            print if exists $h{$_}' colors_1.txt colors_2.txt
light blue
yellow

# lines from colors_2.txt not present in colors_1.txt
# same as: grep -vFxf colors_1.txt colors_2.txt
$ perl -ne 'if(!$#ARGV){$h{$_}=1; next}
            print if !exists $h{$_}' colors_1.txt colors_2.txt
black
dark green

# reversing the order of input files gives
# lines from colors_1.txt not present in colors_2.txt
$ perl -ne 'if(!$#ARGV){$h{$_}=1; next}
            print if !exists $h{$_}' colors_2.txt colors_1.txt
teal
green
```

Here are some alternate ways to construct a solution for above examples.

```bash
# using if-else instead of next
$ perl -ne 'if(!$#ARGV){ $h{$_}=1 }
            else{ print if exists $h{$_} }' colors_1.txt colors_2.txt
light blue
yellow

# read all lines from the first file passed as STDIN in the BEGIN block
$ perl -ne 'BEGIN{ $h{$_}=1 while <STDIN> }
            print if exists $h{$_}' <colors_1.txt colors_2.txt
light blue
yellow
```

## Using modules for set operations

You can use the `uniq` function from the `List::Util` module to preserve only one copy of duplicates from one or more input files. See the [Dealing with duplicates](#dealing-with-duplicates) chapter for field based duplicate processing.

```bash
# input order of lines is preserved
# this is same as performing union between two sets
$ perl -MList::Util=uniq -e 'print uniq <>' colors_1.txt colors_2.txt
teal
light blue
green
yellow
black
dark green
```

The [metacpan: List::Compare](https://metacpan.org/pod/List::Compare) module supports set operations like **union**, **intersection**, **symmetric difference** etc. See also [metacpan: Array::Utils](https://metacpan.org/pod/Array::Utils).

```bash
# union, input order of lines is NOT preserved
# note that only the -e option is used and one of the files is passed as stdin
$ perl -MList::Compare -e '@a1=<STDIN>; @a2=<>;
         print List::Compare->new(\@a1, \@a2)->get_union
        ' <colors_1.txt colors_2.txt
black
dark green
green
light blue
teal
yellow

# intersection (common lines)
$ perl -MList::Compare -e '@a1=<STDIN>; @a2=<>;
         print List::Compare->new(\@a1, \@a2)->get_intersection
        ' <colors_1.txt colors_2.txt
light blue
yellow

# lines from colors_1.txt not present in colors_2.txt
$ perl -MList::Compare -e '@a1=<STDIN>; @a2=<>;
         print List::Compare->new(\@a1, \@a2)->get_unique      
        ' <colors_1.txt colors_2.txt
green
teal
```

## Comparing fields

In the previous sections, you saw how to compare the contents of whole records between two files. This section will focus on comparing only specific fields. The below sample file will be one of the two file inputs for examples in this section. Consider whitespace as the field separator, so the `-a` option is enough to get the fields.

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

To start with, here's an example with a single field comparison. The problem statement is to fetch all records from `marks.txt` if the first field matches any of the departments listed in the `dept.txt` file.

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

For multiple field comparison, you can use comma separated values to construct the hash keys. The special variable `$;` (whose default is `\034`) will be used to join these values. The `\034` character is usually not present in text files. If you cannot guarantee the absence of this character, you can use some other character or use a hash of hashes. See also [stackoverflow: using array as hash key](https://stackoverflow.com/q/17081212/4082052).

```bash
$ cat dept_name.txt
EEE Moi
CSE Amy
ECE Raj

# don't use array slice as hash keys
$ perl -anE '$h{@F[0..1]}=1; say join ",", keys %h' dept_name.txt | cat -v
Moi
Moi,Amy
Moi,Raj,Amy
# default value of $; is \034, same as SUBSEP in awk
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

Here's an alternate solution with a hash of hashes. See also [perldoc: REFERENCES](https://perldoc.perl.org/perldsc#REFERENCES).

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

# match Dept and minimum marks specified in dept_mark.txt
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

# $.=0 is needed to allow header line comparison for the second file
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

## Based on line numbers

Here's an example that shows how you can replace the `m`th line from a file with the `n`th line from another file.

```bash
# replace 3rd line of table.txt with 2nd line of greeting.txt
$ perl -pe 'BEGIN{ $m=3; $n=2; $s = <STDIN> for 1..$n }
            $_ = $s if $. == $m' <greeting.txt table.txt
brown bread mat hair 42
blue cake mug shirt -7
Have a nice day
```

Here's an example where two files are processed simultaneously.

```bash
# print line from greeting.txt if the last column of corresponding line
# from table.txt is a positive number
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

>![warning](images/warning.svg) Don't save the contents of `search.txt` and `repl.txt` in shell variables for passing them to the Perl script. Trailing newlines and ASCII NUL characters will cause issues. See [stackoverflow: pitfalls of reading file into shell variable](https://stackoverflow.com/a/22607352/4082052) for details.

## Add file content conditionally

**Case 1:** replace each matching line with the entire contents of `STDIN`.

```bash
# same as: sed -e '/[ot]/{r dept.txt' -e 'd}' greeting.txt
$ perl -pe 'BEGIN{$r = join "", <STDIN>} $_=$r if /[ot]/' <dept.txt greeting.txt
CSE
ECE
Have a nice day
CSE
ECE
```

**Case 2:** insert the entire contents of `STDIN` before each matching line.

```bash
# same as: sed '/nice/e cat dept.txt' greeting.txt
$ perl -pe 'BEGIN{$r = join "", <STDIN>}
            print $r if /nice/' <dept.txt greeting.txt
Hi there
CSE
ECE
Have a nice day
Good bye
```

**Case 3:** append the entire contents of `STDIN` after each matching line.

```bash
# same as: sed '/nice/r dept.txt' greeting.txt
$ perl -pe 'BEGIN{$r = join "", <STDIN>}
            $_ .= $r if /nice/' <dept.txt greeting.txt
Hi there
Have a nice day
CSE
ECE
Good bye
```

## Summary

This chapter discussed use cases where you need to process the contents of two or more files based on entire record/file or fields. The value of `$#ARGV` is handy for such cases (formula is `n-2` to match the first file passed among `n` input files). The next chapter discusses more such examples, based solely on occurrences of duplicate values.

## Exercises

>![info](images/info.svg) The [exercises](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/exercises) directory has all the files used in this section.

**1)** Use the contents of `match_words.txt` file to display matching lines from `jumbled.txt` and `sample.txt`. The matching criteria is that the second word of lines from these files should match the third word of lines from `match_words.txt`.

```bash
$ cat match_words.txt
%whole(Hello)--{doubt}==ado==
just,\joint*,concession<=nice

# 'concession' is one of the third words from 'match_words.txt'
# and second word from 'jumbled.txt'
##### add your solution here
wavering:concession/woof\retailer
No doubt you like it too
```

**2)** Interleave the contents of `secrets.txt` with the contents of a file passed as stdin in the format as shown below.

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

**3)** The file `search_terms.txt` contains one search string per line, and these terms have no regexp metacharacters. Construct a solution that reads this file and displays the search terms (matched case insensitively) that were found in every file passed as the arguments after `search_terms.txt`. Note that these terms should be matched anywhere in the line (so, don't use word boundaries).

```bash
$ cat search_terms.txt
hello
row
you
is
at

# ip: search_terms.txt jumbled.txt mixed_fs.txt secrets.txt table.txt oops.txt
##### add your solution here
row
at

# ip: search_terms.txt ip.txt sample.txt oops.txt
##### add your solution here
hello
you
is
```

**4)** Replace the third to fifth lines of the input file `ip.txt` with the second to fourth lines from the file `para.txt`.

```bash
##### add your solution here
Hello World
How are you
Start working on that
project you always wanted
to, do not let it end
You are funny
```

**5)** Insert one line from `jumbled.txt` before every two lines of `copyright.txt`.

```bash
##### add your solution here
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

##### add your solution here
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

##### add your solution here
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

##### add your solution here
Amy,maths,89
John,physics,91
Yui,maths,92
```

**9)** Insert the contents of `hex.txt` before a line matching `cake` of the input file `table.txt`

```bash
##### add your solution here
brown bread mat hair 42
start: 0xA0, func1: 0xA0
end: 0xFF, func2: 0xB0
restart: 0xA010, func3: 0x7F
blue cake mug shirt -7
yellow banana window shoes 3.14
```

**10)** For the input file `ip.txt`, replace lines containing `are` with the contents of `hex.txt`.

```bash
##### add your solution here
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

# Dealing with duplicates

Often, you need to eliminate duplicates from an input file. This could be based on the entire line content or based on certain fields. These are typically solved with the `sort` and `uniq` commands. Advantages with Perl include regexp based field separator, record separator other than newline, input doesn't have to be sorted, and in general more flexibility because it is a programming language.

>![info](images/info.svg) The [example_files](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/example_files) directory has all the files used in the examples.

## Whole line duplicates

You can use the `uniq` function from the `List::Util` module or use a hash to retain only the first copy of duplicates from one or more input files.

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

# same as: perl -MList::Util=uniq -e 'print uniq <>' purchases.txt
# can also use: perl -ne 'print if !exists $h{$_}; $h{$_}=1'
$ perl -ne 'print if !$h{$_}++' purchases.txt
coffee
tea
washing powder
toothpaste
soap
```

>![info](images/info.svg) See also [huniq](https://github.com/koraa/huniq), a faster alternative for removing line based duplicates.

## Column wise duplicates

The hash based solution is easy to adapt for removing field based duplicates. Just change `$_` to the required fields after setting the appropriate field separator.

```bash
$ cat duplicates.txt
brown,toy,bread,42
dark red,ruby,rose,111
blue,ruby,water,333
dark red,sky,rose,555
yellow,toy,flower,333
white,sky,bread,111
light red,purse,rose,333

# based on the last field
# -l isn't needed if all the lines end with a newline character
$ perl -F, -ane 'print if !$h{$F[-1]}++' duplicates.txt
brown,toy,bread,42
dark red,ruby,rose,111
blue,ruby,water,333
dark red,sky,rose,555
```

Multiple fields example. As seen in the [Comparing fields](#comparing-fields) section, you can either use comma separated values to construct the hash key or use a hash of hashes.

```bash
# based on the first and third fields
# can also use: perl -F, -ane 'print if !$h{$F[0]}{$F[2]}++'
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
# print only the second occurrence of duplicates based on the second field
$ perl -F, -ane 'print if ++$h{$F[1]} == 2' duplicates.txt
blue,ruby,water,333
yellow,toy,flower,333
white,sky,bread,111

# print only the third occurrence of duplicates based on the last field
$ perl -F, -ane 'print if ++$h{$F[-1]} == 3' duplicates.txt
light red,purse,rose,333
```

Next, printing only the last copy of duplicate. Since the count isn't known, the `tac` command comes in handy again.

```bash
# reverse the input line-wise, retain the first copy and then reverse again
$ tac duplicates.txt | perl -F, -ane 'print if !$h{$F[-1]}++' | tac
brown,toy,bread,42
dark red,sky,rose,555
white,sky,bread,111
light red,purse,rose,333
```

To get all the records based on a duplicate count, you can pass the input file twice. Then use the two file processing tricks to make decisions.

```bash
# all duplicates based on the last column
$ perl -F, -ane '!$#ARGV ? $h{$F[-1]}++ :
                 $h{$F[-1]}>1 && print' duplicates.txt duplicates.txt
dark red,ruby,rose,111
blue,ruby,water,333
yellow,toy,flower,333
white,sky,bread,111
light red,purse,rose,333

# all duplicates based on the last column, minimum 3 duplicates
$ perl -F, -ane '!$#ARGV ? $h{$F[-1]}++ :
                 $h{$F[-1]}>2 && print' duplicates.txt duplicates.txt
blue,ruby,water,333
yellow,toy,flower,333
light red,purse,rose,333

# only unique lines based on the third column
$ perl -F, -ane '!$#ARGV ? $h{$F[2]}++ :
                 $h{$F[2]}==1 && print' duplicates.txt duplicates.txt
blue,ruby,water,333
yellow,toy,flower,333
```

## Summary

This chapter showed how to work with duplicate contents for records and fields. If you don't need regexp based separators and if your input is too big to handle, then specialized command line tools like `sort` and `uniq` will be better suited.

## Exercises

>![info](images/info.svg) The [exercises](https://github.com/learnbyexample/learn_perl_oneliners/tree/main/exercises) directory has all the files used in this section.

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

##### add your solution here
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

##### add your solution here
hehe haha
door floor
6;8 3-4
true blue
hehe bebe
tru eblue
```

**3)** For the input file `twos.txt`, display only the unique lines. Assume space as the field separator with exactly two fields per line. Compare the lines irrespective of the order of the fields. For example, `hehe haha` and `haha hehe` should be considered as duplicates.

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

If you don't have the command installed, check your distribution's repository or you can install it from [metacpan: File::Rename](https://metacpan.org/pod/File::Rename). Here are couple of implementations on my system:

```bash
$ rename --version
/usr/bin/rename using File::Rename version 1.10

$ rename.ul --version
rename.ul from util-linux 2.34
```

>![info](images/info.svg) See also: [askubuntu: What's the difference between the different "rename" commands?](https://askubuntu.com/questions/956010/whats-the-difference-between-the-different-rename-commands)

>![info](images/info.svg) See also [F2: a cross-platform tool for batch renaming files and directories quickly and safely](https://github.com/ayoisaiah/f2).

## Basic example and sanity check

>![info](images/info.svg) For this chapter, use an empty folder to follow along the examples presented. Delete the created files before moving on to the next illustration.

The below example formats the filenames to consistently have three digits, so that the sorted filename display works for the numbers as well. The `-n` option allows you to do a sanity check without renaming the files.

```bash
$ touch 1.png 3.png 25.png 100.png
$ ls
100.png  1.png  25.png  3.png

# sanity check
# note that 100.png isn't part of the output, since it isn't affected
$ rename -n 's/\d+/sprintf "%03d", $&/e' *.png
rename(1.png, 001.png)
rename(25.png, 025.png)
rename(3.png, 003.png)

# remove the -n option after sanity check to actually rename the files
$ rename 's/\d+/sprintf "%03d", $&/e' *.png
$ ls
001.png  003.png  025.png  100.png

$ rm *.png
```

>![info](images/info.svg) For a more pleasing visual of the sanity check, pipe the output to `column -ts,` as shown below (assuming filenames don't have comma in them).
> 
> ```bash
> $ rename -n 's/\d+/sprintf "%03d", $&/e' *.png | column -ts,
> rename(1.png    001.png)
> rename(25.png   025.png)
> rename(3.png    003.png)
> ```

## Verbose mode

The `-v` option shows how the files have been renamed, similar to the `-n` option. The difference is that the `-v` option shows the result after the files have been renamed.

```bash
$ touch a.b.c.d.txt 1.2.3.txt

# replace all dot characters except the extension
# sanity check
$ rename -n 's/\.(?=.*\.)/_/g' *.txt
rename(1.2.3.txt, 1_2_3.txt)
rename(a.b.c.d.txt, a_b_c_d.txt)
# verbose mode
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

## Rename only the filename component

If you are passing filenames with path components in them, use the `-d` option to affect only filename portion. Otherwise, the logic you are using might affect directory names as well.

```bash
$ mkdir scripts
$ touch scripts/{toc.sh,reports.py}

# uppercase the first character of the filename
$ rename -n -d 's/./\u$&/' scripts/*
rename(scripts/reports.py, scripts/Reports.py)
rename(scripts/toc.sh, scripts/Toc.sh)

# without the -d option, directory name is affected
$ rename -n 's/./\u$&/' scripts/*
rename(scripts/reports.py, Scripts/reports.py)
rename(scripts/toc.sh, Scripts/toc.sh)

$ rm -r scripts
```

## Incrementing numbers

Unlike the normal Perl one-liners, the `rename` command allows only `strict` mode. So, you'll have to declare variables before using them. However, you can cheat a little by using the `$a` and `$b` global variables (see [stackoverflow: Where do the $a and $b variables come from?](https://stackoverflow.com/q/26127617/4082052) for details).

The below example replaces the first occurrence of numbers in the filename with an incrementing sequence.

```bash
$ touch 1.png 3.png 25.png 100.png

$ rename -n 's/\d+/sprintf "%03d", ++$a/e' *.png
rename(100.png, 001.png)
rename(1.png, 002.png)
rename(25.png, 003.png)
rename(3.png, 004.png)

$ rm *.png
```

However, the above approach can lead to issues if a number already exists. You cannot use the `-f` option, since that'll lead to the file being overwritten instead of just being renamed. An example of such a problem is shown below.

```bash
$ touch 1.png 3.png 25.png 100.png

$ rename -n 's/\d+/++$a/e' *.png
100.png not renamed: 1.png already exists
rename(1.png, 2.png)
25.png not renamed: 3.png already exists
rename(3.png, 4.png)

# oops, 2 files have disappeared!!
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

**1)** Determine and implement the rename logic based on the filenames and expected output shown below.

```bash
$ touch ' (2020) Report part 1 . txt ' 'analysis Part 3 (2018) .log'

##### add your solution here

$ ls
2020_report_part_1.txt  analysis_part_3_2018.log
```

**2)** See [unix.stackexchange: rename Q&A sorted by votes](https://unix.stackexchange.com/questions/tagged/rename?tab=Votes) for further reading as well as a source for exercises.

