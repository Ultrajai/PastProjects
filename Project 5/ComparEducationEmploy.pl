#!/usr/bin/perl
use strict;
use warnings;
use version;   our $VERSION = qv('5.16.0');   # This is the version of Perl to be used
use Text::CSV  1.32;  

#
#
#
#
#
#
#
#

my $EMPTY 	= q{};
my $COMMA 	= q{,};
my $csv 	= Text::CSV->new({ sep_char => $COMMA });

my @dates;
my @values;
my @sexes;
my @educations;
my @employments;
my @master_fields;

my $line_num 	= -1;
my $total_value = 0;

my $file_name 			= $EMPTY;
my $line 				= $EMPTY;
my $time_step 			= $EMPTY;
my $time_start 			= $EMPTY;
my $time_end 			= $EMPTY;
my $female_file_name 	= $EMPTY;
my $male_file_name	 	= $EMPTY;
my $both_file_name 		= $EMPTY;
my $sex_current 		= $EMPTY;
my $education_current 	= $EMPTY;

if($#ARGV != 3){
	print "not enough arguements were given";
	exit;
}
else{
	$file_name 	= $ARGV[0];
	$time_start = $ARGV[1];
	$time_end 	= $ARGV[2];
	$time_step 	= $ARGV[3];
}

if($time_step eq "0")
{
	print "Whoops you almost caused a terrible infinite loop. The time step cannot be 0, be careful!\n";
	exit;
}

open my $fh, "<", $file_name
	or die "couldn't open file: $file_name\n";

while ($line = <$fh> ) {
	chomp $line;
	if($csv->parse($line)){
		@master_fields = $csv->fields();
		$line_num++;
		$dates[$line_num] 		= $master_fields[0];
		$employments[$line_num] = $master_fields[2];
		$educations[$line_num] 	= $master_fields[3];
		$sexes[$line_num] 		= $master_fields[4];
		$values[$line_num] 		= $master_fields[6];
	}
}

close $fh
	or die "\nUnable to close: $file_name\n";
	
print "What file name would you like to save the female values in?\n";
$female_file_name = <STDIN>;
chomp $female_file_name;
print "What file name would you like to save the male values in?\n";
$male_file_name = <STDIN>;
chomp $male_file_name;
print "What file name would you like to save the \"both sexes\" values in?\n";
$both_file_name = <STDIN>;
chomp $both_file_name;

open my $fe_fh, ">>", $female_file_name
	or die "unable to write to: $female_file_name\n";
	
print $fe_fh "education,year,value\n"
	or die "couldn't write to file\n";
	
open my $ma_fh, ">>", $male_file_name
	or die "unable to write to: $male_file_name\n";
	
print $ma_fh "education,year,value\n"
	or die "couldn't write to file\n";

open my $bo_fh, ">>", $both_file_name
	or die "unable to write to: $both_file_name\n";
	
print $bo_fh "education,year,value\n"
	or die "couldn't write to file\n";
	
$sex_current = $sexes[1];
$education_current = $educations[1];
	
while ($time_start <= $time_end){

	foreach my $i (1..$line_num){
		if($sexes[$i] eq "Males" && $dates[$i] =~ m/$time_start/){
			
			if($sex_current ne $sexes[$i] || $education_current ne $educations[$i])
			{
				write_in_file($sex_current, $education_current, $employments[$i - 1], $time_start, $total_value);
				$sex_current = $sexes[$i];
				$education_current = $educations[$i];
				$total_value = 0;
			}
			
			if($values[$i] ne "x"){
				$total_value += $values[$i];
			}
			
			
		}
		elsif($sexes[$i] eq "Females" && $dates[$i] =~ m/$time_start/){
			
			if($sex_current ne $sexes[$i] || $education_current ne $educations[$i])
			{
				write_in_file($sex_current, $education_current, $employments[$i - 1], $time_start, $total_value);
				$sex_current = $sexes[$i];
				$education_current = $educations[$i];
				$total_value = 0;
			}
				
			if($values[$i] ne "x"){
				$total_value += $values[$i];
			}

			
		}
		elsif($sexes[$i] eq "Both sexes" && $dates[$i] =~ m/$time_start/){
			
			if($sex_current ne $sexes[$i] || $education_current ne $educations[$i])
			{
				write_in_file($sex_current, $education_current, $employments[$i - 1], $time_start, $total_value);
				$sex_current = $sexes[$i];
				$education_current = $educations[$i];
				$total_value = 0;
			}
			
			if($values[$i] ne "x"){
				$total_value += $values[$i];
			}
			
		}

	}
	
	$time_start += $time_step;

}

sub write_in_file{


	if($_[0] eq "Males"){
		print $ma_fh "\"".$_[1]." (".$_[2].")\",".$_[3].",".($_[4] / 12)."\n"
			or die "couldn't write to file";
	}
	elsif($_[0] eq "Females"){
		print $fe_fh "\"".$_[1]." (".$_[2].")\",".$_[3].",".($_[4] / 12)."\n"
			or die "couldn't write to file";
	}
	else{
		print $bo_fh "\"".$_[1]." (".$_[2].")\",".$_[3].",".($_[4] / 12)."\n"
			or die "couldn't write to file";
	}

}