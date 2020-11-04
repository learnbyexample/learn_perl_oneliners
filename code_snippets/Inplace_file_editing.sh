## With backup

cat colors.txt

perl -i.bkp -pe 's/blue/-green-/' colors.txt

cat colors.txt

cat colors.txt.bkp

cat t1.txt

cat t2.txt

perl -i.bkp -pe 's/bad/good/' t1.txt t2.txt

ls t?.*

cat t1.txt

cat t2.txt

## Without backup

cat fruits.txt

perl -i -pe 's/an/AN/g' fruits.txt

cat fruits.txt

## Prefix backup name

ls *colors.txt*

perl -i'bkp.*' -pe 's/-green-/yellow/' colors.txt

ls *colors.txt*

## Place backups in different directory

mkdir backups

perl -i'backups/*' -pe 's/good/nice/' t1.txt t2.txt

ls backups/

