## Comparing records

cat color_list1.txt

cat color_list2.txt

perl -ne 'if(!$#ARGV){$h{$_}=1; next}
          print if exists $h{$_}' color_list1.txt color_list2.txt

perl -ne 'if(!$#ARGV){$h{$_}=1; next}
          print if !exists $h{$_}' color_list1.txt color_list2.txt

perl -ne 'if(!$#ARGV){$h{$_}=1; next}
          print if !exists $h{$_}' color_list2.txt color_list1.txt

perl -ne 'if(!$#ARGV){ $h{$_}=1 }
          else{ print if exists $h{$_} }' color_list1.txt color_list2.txt

perl -ne 'BEGIN{ $h{$_}=1 while <STDIN> }
          print if exists $h{$_}' <color_list1.txt color_list2.txt

## Using modules for set operations

perl -MList::Util=uniq -e 'print uniq <>' color_list1.txt color_list2.txt

perl -MList::Compare -e '@a1=<STDIN>; @a2=<>;
       print List::Compare->new(\@a1, \@a2)->get_union
      ' <color_list1.txt color_list2.txt

perl -MList::Compare -e '@a1=<STDIN>; @a2=<>;
       print List::Compare->new(\@a1, \@a2)->get_intersection
      ' <color_list1.txt color_list2.txt

perl -MList::Compare -e '@a1=<STDIN>; @a2=<>;
       print List::Compare->new(\@a1, \@a2)->get_unique      
      ' <color_list1.txt color_list2.txt

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

## Based on line number

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

