# Introduction

For text processing, Perl is very handy.

```perl
$ perl -e 'print "Hello Perl\n"'
Hello Perl

$ printf 'gate\napple\nwhat\nkite\n' | perl -ne 'print if !/e/'
what
```

## Field processing

Perl comes loaded with awesome cli options. Enjoy learning Perl.

```perl
$ s='goal:amazing:whistle:kwality'
$ echo "$s" | perl -F: -lane 'print join "-", @F[-1, 1, 0]'
kwality-amazing-goal
```

