#! /usr/bin/env perl

use strict;
use warnings;

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
    }
close $fh;

open ($fh, '<', $whatsmyname) or die $!;
while (my $line = <$fh>){
    chomp $line;
    $line =~ s/www.//;
    $sites{$line}++;
    }
close $fh;

print("Total sites: $counter\n");
my $unique = keys %sites;
print("Unique sites: $unique\n");

@sites = sort keys %sites;

open ($fh, '>', 'unique.txt') or die $!;
foreach (@sites){
    print $fh "$_\n";
    }
