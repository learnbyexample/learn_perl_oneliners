## Processing consecutive records

perl -ne 'print $p, $_ if /you/ && $p=~/he/; $p = $_' para.txt

perl -ne 'print $p if /you/ && $p=~/he/; $p = $_' para.txt

perl -ne 'print if /you/ && $p=~/he/; $p = $_' para.txt

## Context matching

cat context.txt

perl -ne '$n=2 if /blue/; print if $n && $n--' context.txt

perl -ne '$n=2 if /toy|flower/; print if $n && $n--' context.txt

perl -ne 'print if $n && $n--; $n=2 if /prog/' context.txt

perl -ne 'print if $n && !--$n; $n=3 if /language/' context.txt

perl -ne '$ip[$.]=$_; print @ip[$.-2 .. $.] if /stone/' context.txt

n=5 perl -ne '$i=$.-$ENV{n}; $i=0 if $i<0; $ip[$.]=$_;
              print @ip[$i .. $.] if /toy/' context.txt

n=2 perl -ne '$i=$.-$ENV{n}; $i=0 if $i<0; $ip[$.]=$_;
              if(/toy|flower/){print $s, @ip[$i .. $.]; $s="---\n"}' context.txt

n=2 perl -ne '$i=$.-$ENV{n}; $i=0 if $i<0; $ip[$.]=$_;
              print $ip[$i] if /language/' context.txt

perl -ne 'print $p2 if /toy|flower/; $p2=$p1; $p1=$_' context.txt

tac context.txt | perl -ne 'print if $n && !--$n; $n=2 if /language/' | tac

## Records bounded by distinct markers

cat uniform.txt

perl -ne '$f=1 if /start/; print if $f; $f=0 if /end/' uniform.txt

perl -ne '$f=0 if /end/; print "* $_" if $f; $f=1 if /start/' uniform.txt

perl -ne '$f=1 if /start/; $f=0 if /end/; print if $f' uniform.txt

perl -ne 'print if $f; $f=1 if /start/; $f=0 if /end/' uniform.txt

perl -ne '$f=1 if /start/; print if !$f; $f=0 if /end/' uniform.txt

perl -ne '$f=0 if /end/; print if !$f; $f=1 if /start/' uniform.txt

perl -ne 'print if !$f; $f=1 if /start/; $f=0 if /end/' uniform.txt

perl -ne '$f=1 if /start/; $f=0 if /end/; print if !$f' uniform.txt

## Specific blocks

perl -ne '$f=1 if /start/; print if $f; exit if /end/' uniform.txt

perl -ne 'exit if /end/; print if $f; $f=1 if /start/' uniform.txt

tac uniform.txt | perl -ne '$f=1 if /end/; print if $f; exit if /start/' | tac

perl -ne 'if(/start/){$f=1; $buf=$_; next}
          $buf .= $_ if $f;
          $f=0 if /end/;
          END{print $buf}' uniform.txt

seq 30 | perl -ne 'BEGIN{$n=2; $c=0} $c++ if /4/; if($c==$n){print; exit if /6/}'

seq 30 | perl -ne 'BEGIN{$n=1; $c=0} if(/4/){$f=1; $c++}
                   print if $f && $c>$n; $f=0 if /6/'

seq 30 | perl -ne 'BEGIN{$n=2; $c=0} if(/4/){$f=1; $c++}
                   print if $f && $c!=$n; $f=0 if /6/'

seq 30 | perl -ne 'if(/4/){$f=1; $buf=$_; next}
                   $buf .= $_ if $f;
                   if(/6/){$f=0; print $buf if $buf=~/^15$/m}'

## Broken blocks

cat broken.txt

perl -ne 'if(/error/){$f=1; $buf=$_; next}
          $buf .= $_ if $f;
          if(/state/){print $buf if $f; $f=0}' broken.txt

