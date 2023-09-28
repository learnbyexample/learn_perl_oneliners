## Standard modules

echo '34,17,6' | perl -MList::Util=max -F, -anE 'say max @F'

echo '34,17,6' | perl -MList::Util=product -F, -anE 'say product @F'

echo '3.14,17,6' | perl -MList::Util=sum0 -F, -anE 'say sum0 @F'

s='floor bat to dubious four'

echo "$s" | perl -MList::Util=shuffle -lanE 'say join ":", shuffle @F'

echo 'dragon' | perl -MList::Util=shuffle -F -lanE 'say shuffle @F'

echo "$s" | perl -MList::Util=sample -lanE 'say join ":", sample 2, @F'

s='3,b,a,3,c,d,1,d,c,2,2,2,3,1,b'

echo "$s" | perl -MList::Util=uniq -F, -lanE 'say join ",",uniq @F'

echo 'hello world' | base64

echo 'hello world' | perl -MMIME::Base64 -ne 'print encode_base64 $_'

echo 'aGVsbG8gd29ybGQK' | perl -MMIME::Base64 -ne 'print decode_base64 $_'

## Third party modules

perl -MText::CSV -e ''

apt-cache search perl text-csv

sudo apt install libtext-csv-xs-perl

## CSV

s='eagle,"fox,42",bee,frog\n1,2,3,4'

printf '%b' "$s" | perl -MText::CSV_XS -E 'say $row->[1]
                   while $row = Text::CSV_XS->new->getline(*ARGV)'

cat newline.csv

perl -MText::CSV_XS -E '
      while($row = Text::CSV_XS->new({binary => 1})->getline(*ARGV))
      {say "$row->[1]\n-----"}' newline.csv

perl -MText::CSV_XS -E '
      while($row = Text::CSV_XS->new({sep_char => "\t"})->getline(*ARGV))
      {say join ",", @$row if $row->[0] eq "CSE"}' marks.txt

## JSON

s='{"greeting":"hi","marks":[78,62,93]}'

echo "$s" | perl -MCpanel::JSON::XS -E '$ip=decode_json <>; say $ip->{greeting}'

echo "$s" | perl -MCpanel::JSON::XS -E '$ip=decode_json <>;
            say join ":", @{$ip->{marks}}'

type pj

pj() { perl -MCpanel::JSON::XS -0777 -E '$ip=decode_json <>;'"$@" ; }

s='{"greeting":"hi","marks":[78,62,93]}'

echo "$s" | pj 'say $ip->{greeting}'

cat sample.json

pj 'for (keys %$ip){say "$_:$ip->{$_}" if !/e/}' sample.json

pj '$"=","; while(($k,$v) = each %{$ip->{language}})
    {say "$k:@{$v}" if $k=~/t/}' sample.json

s='{"greeting":"hi","marks":[78,62,93],"fruit":"apple"}'

echo "$s" | cpanel_json_xs

## Convert one-liners to pretty formatted scripts

perl -MO=Deparse -ne 'print if /at/'

perl -MO=Deparse -pe 's/ /:/g'

perl -MO=Deparse -l -0072 -ne 'print if /a/'

perl -MO=Deparse -00 -ne 'print if /it/'

perl -MO=Deparse -ne 'print if /4/ }{ print "==> the end\n"'

perl -MO=Deparse -ne 'print if /4/' > script.pl

cat script.pl

perl script.pl table.txt

