#! /usr/bin/env perl

use strict;
use warnings;

use HTTP::Tiny;


my $sherlock = "sherlock.txt";
my $whatsmyname = "whatsmyname.txt";

my %sites;
my @sites;
my $counter=0;

print("Removing duplicate entries\n");

open (my $fh, '<', $sherlock) or die $!;
while (my $line = <$fh>){
    chomp $line;
    # Remove www from any adress to avoid confusion
    $line =~ s/www.//;
    # Remove trailing /
    $line =~ s/\/$//;
    $sites{$line}++ unless $line !~ /https/;
    }
close $fh;

open ($fh, '<', $whatsmyname) or die $!;
while (my $line = <$fh>){
    chomp $line;
    $line =~ s/www.//;
    $sites{$line}++ unless $line !~ /https/;
    }
close $fh;




print("Removing Error 404 False Positives\n");
@sites = sort keys %sites;

open ($fh, '>', 'unique.txt') or die $!;
foreach (@sites){
    my $response = HTTP::Tiny->new->get($_);
    if ($response->{success}){
        print $fh "$_\n";
    }
}
close $fh;

print("New list available at unique.txt\n");
