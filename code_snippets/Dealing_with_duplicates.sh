## Whole line duplicates

cat purchases.txt

perl -ne 'print if !$h{$_}++' purchases.txt

## Column wise duplicates

cat duplicates.txt

perl -F, -ane 'print if !$h{$F[-1]}++' duplicates.txt

perl -F, -ane 'print if !$h{$F[0],$F[2]}++' duplicates.txt

## Duplicate count

perl -F, -ane 'print if ++$h{$F[1]} == 2' duplicates.txt

perl -F, -ane 'print if ++$h{$F[-1]} == 3' duplicates.txt

tac duplicates.txt | perl -F, -ane 'print if !$h{$F[-1]}++' | tac

perl -F, -ane '!$#ARGV ? $h{$F[-1]}++ :
               $h{$F[-1]}>1 && print' duplicates.txt duplicates.txt

perl -F, -ane '!$#ARGV ? $h{$F[-1]}++ :
               $h{$F[-1]}>2 && print' duplicates.txt duplicates.txt

perl -F, -ane '!$#ARGV ? $h{$F[2]}++ :
               $h{$F[2]}==1 && print' duplicates.txt duplicates.txt

