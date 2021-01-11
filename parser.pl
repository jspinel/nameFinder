#! /usr/bin/env perl

use strict;
use warnings;

use HTTP::Tiny;

my $sherlock = "sherlock.txt";
my $whatsmyname = "whatsmyname.txt";

my %sites;
my @sites;
my $counter=0;


open (my $fh, '<', $sherlock) or die $!;
while (my $line = <$fh>){
    chomp $line;
    $line =~ s/www.//;
    $sites{$line}++ unless $line !~ /https/;
    $counter++ unless $line !~ /https/;
    }
close $fh;

open ($fh, '<', $whatsmyname) or die $!;
while (my $line = <$fh>){
    chomp $line;
    $sites{$line}++ unless $line !~ /https/;
    $counter++ unless $line !~ /https/;
    }
close $fh;




@sites = sort keys %sites;

open ($fh, '>', 'unique.txt') or die $!;
foreach (@sites){
    my $response = HTTP::Tiny->new->get($_);
    if ($response->{success}){
        print $fh "$_\n";
    }
    else{
        print("Failed request on $_\n");
        delete($sites{$_});
    }
}

my $unique = keys %sites;
print("Total results: $counter\n");
print("Unique sites: $unique\n");
