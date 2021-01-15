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
    $line =~ s/www.//;
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
    print("$_\n");
    if ($response->{success}){
        print $fh "$_\n";
    }
    else{
        # Eliminates 404 errors
        delete($sites{$_});
    }
}

print("New list available at unique.txt\n");
