#!/usr/bin/perl
open(OUT,">gapQuadPrimes_v4.txt")||die "open fail OUT\n";

%p = ();  # hash of primes initialized
foreach $cand (2..30000){  # loop over candidates 
    $verdict = &isPrime($cand);  # is $cand prime? 0/1 result
    next unless $verdict==1;
    $p{$cand}=1; # prime is now defined in the hash %p
}

@firstElts = @lastElts = @sets = ();  # create empty lists
foreach $num (sort{$a<=>$b}keys %p){   # loop over ascending numeric primes
    if ($p{$num+2} && $p{$num+6} && $p{$num+12}){ # do all 3 primes exist?
	$str = join(",",$num,$num+2,$num+6,$num+12);
	push @sets , $str;
	push @firstElts , $num; push @lastElts , $num+12;
    }
}
print OUT "Prime quadruples up to 30,000:\n";
print OUT join("\n",@sets); print OUT "\n";   # output 15 sets
print OUT "GAPS BTWN FIRST ELTS: ";
foreach $i (0..$#firstElts-1){
    print OUT $firstElts[$i+1]-$firstElts[$i], ",";
}
print OUT "\n";
print OUT "FIRST ELEMENTS OF THE QUADRUPLES:\n";
foreach $i (0..$#firstElts){
    print OUT "$firstElts[$i],";
}
print OUT "\n";

########################################
sub isPrime{
    local($n) = @_;  # work with local copy of input argument
    if ($n <= 1){ return 0; } # not prime, by defn
    if ($n <= 3){ return 1; } # 2 and 3 are both prime

    if (($n % 2) == 0){  # modulo
	return 0; # not prime
    }
    if (($n % 3) == 0){
	return 0; # not prime
    }
    
    $i = 5;
    while( $i * $i <= $n){  # loop increments to square root of $n
	if (($n % $i)==0){  # modulo
	    return 0; # not prime
	}
	if (($n % ($i+2))==0){
	    return 0; # not prime
	}
	$i = $i + 6;
    }
    return 1;  # fall thru means *prime*
}
