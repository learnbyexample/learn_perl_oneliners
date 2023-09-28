## Comparing records

cat colors_1.txt

cat colors_2.txt

perl -ne 'if(!$#ARGV){$h{$_}=1; next}
          print if exists $h{$_}' colors_1.txt colors_2.txt

perl -ne 'if(!$#ARGV){$h{$_}=1; next}
          print if !exists $h{$_}' colors_1.txt colors_2.txt

perl -ne 'if(!$#ARGV){$h{$_}=1; next}
          print if !exists $h{$_}' colors_2.txt colors_1.txt

perl -ne 'if(!$#ARGV){ $h{$_}=1 }
          else{ print if exists $h{$_} }' colors_1.txt colors_2.txt

perl -ne 'BEGIN{ $h{$_}=1 while <STDIN> }
          print if exists $h{$_}' <colors_1.txt colors_2.txt

## Using modules for set operations

perl -MList::Util=uniq -e 'print uniq <>' colors_1.txt colors_2.txt

perl -MList::Compare -e '@a1=<STDIN>; @a2=<>;
       print List::Compare->new(\@a1, \@a2)->get_union
      ' <colors_1.txt colors_2.txt

perl -MList::Compare -e '@a1=<STDIN>; @a2=<>;
       print List::Compare->new(\@a1, \@a2)->get_intersection
      ' <colors_1.txt colors_2.txt

perl -MList::Compare -e '@a1=<STDIN>; @a2=<>;
       print List::Compare->new(\@a1, \@a2)->get_unique      
      ' <colors_1.txt colors_2.txt

## Comparing fields

cat marks.txt

cat dept.txt

perl -ane 'if(!$#ARGV){ $h{$F[0]}=1 }
           else{ print if exists $h{$F[0]} }' dept.txt marks.txt

cat dept_name.txt

perl -anE '$h{@F[0..1]}=1; say join ",", keys %h' dept_name.txt | cat -v

perl -anE '$h{$F[0],$F[1]}=1; say join ",", keys %h' dept_name.txt | cat -v

perl -ane 'if(!$#ARGV){ $h{$F[0],$F[1]}=1 }
           else{ print if exists $h{$F[0],$F[1]} }' dept_name.txt marks.txt

perl -ane 'if(!$#ARGV){ $h{$F[0]}{$F[1]}=1 }
           else{ print if exists $h{$F[0]}{$F[1]} }' dept_name.txt marks.txt

cat dept_mark.txt

perl -ane 'if(!$#ARGV){ $h{$F[0]}=$F[1] }
           else{ print if exists $h{$F[0]} && $F[2]>=$h{$F[0]} }
          ' dept_mark.txt marks.txt

cat role.txt

perl -lane 'if(!$#ARGV){ $r{$F[0]}=$F[1]; $.=0 }
            else{ print join "\t", @F, $.==1 ? "Role" : $r{$F[1]} }
           ' role.txt marks.txt

## Based on line numbers

perl -pe 'BEGIN{ $m=3; $n=2; $s = <STDIN> for 1..$n }
          $_ = $s if $. == $m' <greeting.txt table.txt

perl -ne 'print if (split " ", <STDIN>)[-1] > 0' <table.txt greeting.txt

## Multiline fixed string substitution

head -n2 table.txt > search.txt

cat repl.txt

perl -0777 -ne '$#ARGV==1 ? $s=$_ : $#ARGV==0 ? $r=$_ :
                print s/\Q$s/$r/gr' search.txt repl.txt table.txt

## Add file content conditionally

perl -pe 'BEGIN{$r = join "", <STDIN>} $_=$r if /[ot]/' <dept.txt greeting.txt

perl -pe 'BEGIN{$r = join "", <STDIN>}
          print $r if /nice/' <dept.txt greeting.txt

perl -pe 'BEGIN{$r = join "", <STDIN>}
          $_ .= $r if /nice/' <dept.txt greeting.txt

