#!/usr/bin/env bash

FAI="resources/aaegypti-AaegL5-ensembl-61/genome.fa.gz.fai"
OUT="resources/aaegypti-AaegL5-ensembl-61.genome_intervals.bed"

# Predefined centromere midpoints (bp)
# taken as the midpoint of centromere intervals from https://doi.org/10.1038/s41586-018-0692-z
declare -A CENTRO
CENTRO["1"]=152000000
CENTRO["2"]=229500000
CENTRO["3"]=198500000

# Write output header (optional)
# echo -e "#chrom\tstart\tend" > "$OUT"

awk -v OFS="\t" -v c1="${CENTRO[1]}" -v c2="${CENTRO[2]}" -v c3="${CENTRO[3]}" '
function print_two(chrom, size, mid) {
    # Interval 1: 0 to mid
    print chrom, 0, mid
    # Interval 2: mid to size
    print chrom, mid, size
}
{
    chrom=$1
    size=$2

    # For chromosomes 1, 2, 3, split at given midpoints
    if (chrom == "1") {
        print_two(chrom, size, c1)
    } else if (chrom == "2") {
        print_two(chrom, size, c2)
    } else if (chrom == "3") {
        print_two(chrom, size, c3)
    } else {
        # All other contigs: single interval
        print chrom, 0, size
    }
}
' "$FAI" > "$OUT"

