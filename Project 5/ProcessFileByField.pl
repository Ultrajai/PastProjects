#!/usr/bin/perl
use strict;
use warnings;
use version;   our $VERSION = qv('5.16.0');   # This is the version of Perl to be used
use Text::CSV  1.32;  

#
#	1) This script will be able to inform the user about how to set up a CSV file for the scripts we create
#	   to further process the data.
#
#	2) It will also process a CSV file based on the user inputs about what fields they want.
#


my $EMPTY 	= q{};
my $COMMA 	= q{,};
my $csv 	= Text::CSV->new({ sep_char => $COMMA });


my $file_to_read		= $EMPTY;
my $file_to_write 		= $EMPTY;
my $field 				= $EMPTY;
my $line 				= $EMPTY;
my $num_fields 			= 0;
my $total_read_fh_lines = 0;
my $total_lines_read 	= 0;


my @fields_to_look_for;
my @field_contents;
my @master_fields;
my @fields_to_look;
my @fields_to_compare;


if($#ARGV != 1){
	print "\nA file to read and/or a file to write was not given\n"
		or die "couldn't print";
	exit;
}
else{
	$file_to_read 	= $ARGV[0];
	$file_to_write 	= $ARGV[1];
}

#find the total amount of lines in the input file
open my $read_fh, "<", $file_to_read
	or die "\ncouldn't open file: $file_to_read\n";
	
while(<$read_fh>)
{
	$total_read_fh_lines++;
}

close $read_fh
	or die "\nUnable to close: $file_to_read\n";
	
#actually start the code prompting the user for information
open $read_fh, "<", $file_to_read
	or die "\ncouldn't open file: $file_to_read\n";
	
open my $write_fh, ">>", $file_to_write
	or die "\nCouldn't create/overwrite file: $file_to_write\n";

print "\nwhat fields would you like to look for?\n"
	or die "couldn't print";

while($field !~ m/.\/done/i){

	$field = <STDIN>;
	chomp $field;
	$fields_to_look_for[$num_fields] = $field;
	$num_fields++;
	
}

foreach my $i (0..($num_fields - 2)){

	print "What would you like to look for in \"".$fields_to_look_for[$i]."\"(REGEX):"
		or die "couldn't print";
		
	print $write_fh $fields_to_look_for[$i];
	if($i != ($num_fields - 2)){
		print $write_fh ",";
	}
	
	$field_contents[$i] = <STDIN>;
	chomp $field_contents[$i];
	
}

print $write_fh "\n";
	
while ($line = <$read_fh> ) {
	chomp $line;
	
	if($csv->parse($line)){
		@master_fields = $csv->fields();
		read_what_fields($total_lines_read, $num_fields, scalar(@master_fields));
		add_fields($total_lines_read, scalar(@fields_to_look));
	}

	$total_lines_read++;
	
	printf "\rProcessing: %.2f", ((($total_lines_read) / $total_read_fh_lines) * 100);
}

close $read_fh
	or die "\nUnable to close: $file_to_read\n";
	
close $write_fh
	or die "\nUnable to close: $file_to_write\n";

exit;
	
sub read_what_fields{

my $num_of_fields = 0;

	if($_[0] == 0){
		foreach my $i (0..($_[1] - 2)){
			foreach my $j (0..($_[2] - 1)){
			
				if($fields_to_look_for[$i] eq $master_fields[$j]){
				
					$fields_to_look[$num_of_fields] = $j;
					$fields_to_compare[$num_of_fields] = $i;
					$num_of_fields++;
					
				}
				
			}
		}
	}
}

sub add_fields{

	my $amount_same = -1;
	
	foreach my $i(0..($_[1] - 1)){
	
	if($master_fields[$fields_to_look[$i]] =~ m/$field_contents[$fields_to_compare[$i]]/ || $field_contents[$fields_to_compare[$i]] =~ m/.\/all/i){
		$amount_same++;
	}
	
	}
	
	if($amount_same == ($_[1] - 1) && $_[0] != 0){
		foreach my $i(0..($_[1] - 1)){
		
			if($master_fields[$fields_to_look[$i]] !~ m/,/)
			{
				print $write_fh $master_fields[$fields_to_look[$i]];
			}
			else{
				print $write_fh "\"".$master_fields[$fields_to_look[$i]]."\"";
			}
			
			
			if($i != ($_[1] - 1)){
				print $write_fh ",";
			}
		}
		print $write_fh "\n";
	}

}