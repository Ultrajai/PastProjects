#!/usr/bin/perl

use strict;
use warnings;
use version; our $VERSION = qv('5.16.0');	# Version of Perl to be used
use Text::CSV 1.32;

#
#
#
#
#

my $EMPTY	= q{};
my $COMMA	= q{,};
my $csv 	= Text::CSV->new({sep_char => $COMMA});

my @dates;
my @geos;
my @characteristics;
my @educations;
my @sexes;
my @ages;
my @values;
my @master_fields;

my @cad_vals;
my @cad_education;
my @cad_year;
my @prov_vals;
my @prov_names;
my @prov_education;
my @prov_year;

my $line_num 			= -1;
my $total_value 		= 0;
my $start_time 			= 0;
my $end_time 			= 0;
my $num_of_cad_vals 	= 0;
my $num_of_prov			= 0;


my $file_name 			= $EMPTY;
my $line 				= $EMPTY;
my $education_current	= $EMPTY;
my $geo_current			= $EMPTY;
my $education 			= $EMPTY;
my $done				= $EMPTY;
my $province			= $EMPTY;
	
if($#ARGV != 2){
	print "not enough arguements\n"
		or die "cannot print\n";
	exit;
}
else{
	$file_name	= $ARGV[0];
	$start_time = $ARGV[1];
	$end_time	= $ARGV[2];
}

open my $fh, "<", $file_name 
	or die "couldn't open file: $file_name\n";

while ($line = <$fh>) 
{
    chomp $line;

    if ($csv->parse($line))
    {
        @master_fields = $csv->fields();
        $line_num++;
        $dates[$line_num] = $master_fields[0];
        $geos[$line_num] = $master_fields[1];
        $educations[$line_num] = $master_fields[3];
        $values[$line_num] = $master_fields[6];
    }
}
 
close $fh
    or die "\nUnable to close: $file_name\n";

$education_current = $educations[1];
$geo_current = $geos[1];

while($start_time <= $end_time){	
	foreach my $i (1..$line_num){
		
		if ($dates[$i] =~ m/$start_time/){

			if(($education_current ne $educations[$i] || $geo_current ne $geos[$i]) && (($geos[$i] eq "Canada" && $geo_current ne "Canada") || ($geos[$i] ne "Canada" && $geo_current ne "Canada"))){
				$prov_vals[$num_of_prov] = $total_value / 12;
				$prov_names[$num_of_prov] = $geo_current;
				$prov_year[$num_of_prov] = $start_time;
				$prov_education[$num_of_prov] = $education_current;
				$num_of_prov++;
				$total_value = 0;
				$geo_current = $geos[$i];
				$education_current = $educations[$i];
			}
			elsif(($education_current ne $educations[$i] || $geo_current ne $geos[$i]) && (($geos[$i] ne "Canada" && $geo_current eq "Canada") || ($geos[$i] eq "Canada" && $geo_current eq "Canada"))){
				$cad_vals[$num_of_cad_vals] = $total_value / 12;
				$cad_year[$num_of_cad_vals] = $start_time;
				$cad_education[$num_of_cad_vals] = $education_current;
				$num_of_cad_vals++;
				$total_value = 0;
				$geo_current = $geos[$i];
				$education_current = $educations[$i];
			}


			if ($values[$i] ne "x"){
				$total_value += $values[$i];
			}
		}
		
	}
	
	$start_time++;
}
while($done !~ m/.\/done/i){

	print "\nwhat type of education: ";
	$education = <STDIN>;
	chomp $education;
	print "which province: ";
	$province = <STDIN>;
	chomp $province;
	
	print "Year|     Canada     |     Province   \n";
	print "-----------------------------------------\n";

	foreach my $i(0..($num_of_prov - 1)){

		foreach my $j(0..($num_of_cad_vals - 1)){
			if($prov_education[$i] eq $cad_education[$j] && $prov_year[$i] == $cad_year[$j] && $prov_education[$i] eq $education && $cad_education[$j] eq $education && $prov_names[$i] eq $province){
				printf "$prov_year[$i]|     %.2f%%     ", (($prov_vals[$i] / $cad_vals[$j]) * 100);
				
				foreach my $k(0..($num_of_prov - 1)){
					if($prov_names[$k] eq $prov_names[$i] && $prov_education[$k] eq "Total, all education levels" && $prov_year[$i] == $prov_year[$k]){
						printf "|      %.2f%%     \n", (($prov_vals[$i] / $prov_vals[$k]) * 100);
					}
				}
				
			}
		
		}
	}
	
	print "are you done searching(type ./done when done): ";
	$done = <STDIN>;
	chomp $done;

}


exit;