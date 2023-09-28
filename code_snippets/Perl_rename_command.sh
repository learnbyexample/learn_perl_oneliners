## Basic example and sanity check

touch 1.png 3.png 25.png 100.png

ls

rename -n 's/\d+/sprintf "%03d", $&/e' *.png

rename 's/\d+/sprintf "%03d", $&/e' *.png

ls

rm *.png

rename -n 's/\d+/sprintf "%03d", $&/e' *.png | column -ts,

## Verbose mode

touch a.b.c.d.txt 1.2.3.txt

rename -n 's/\.(?=.*\.)/_/g' *.txt

rename -v 's/\.(?=.*\.)/_/g' *.txt

ls

rm *.txt

## File already exists

touch report_v1.log report_v2.log

rename 's/v1/v2/' report_v1.log

ls

rename -f 's/v1/v2/' report_v1.log

ls

rm *.log

## Rename only the filename component

mkdir scripts

touch scripts/{toc.sh,reports.py}

rename -n -d 's/./\u$&/' scripts/*

rename -n 's/./\u$&/' scripts/*

rm -r scripts

## Incrementing numbers

touch 1.png 3.png 25.png 100.png

rename -n 's/\d+/sprintf "%03d", ++$a/e' *.png

rm *.png

touch 1.png 3.png 25.png 100.png

rename -n 's/\d+/++$a/e' *.png

rename -f 's/\d+/++$a/e' *.png

ls

rm *.png

touch 1.png 3.png 25.png 100.png

rename -n 's/\d+/"op_" . ++$a/e' *.png

rename 's/\d+/"op_" . ++$a/e' *.png

rename 's/op_//' *.png

ls

rm *.png

