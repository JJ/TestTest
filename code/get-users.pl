#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(/home/jmerelo/Code/CPAN/perl-git-commit);

use Git::Repo::Commits;
use Time::Piece;

my $home = shift || "/home/jmerelo/Asignaturas/";

my %repos = ('infraestructura-virtual/IV-2015-16' => ['practicas',
						      ['1','2','3','4','5']],
	     'infraestructura-virtual/IV16-17' => ['practicas',
						    ['0','1','2','3','4','5']],
	     'infraestructura-virtual/IV-17-18' => ['proyectos',
						    ['hito-0','hito-1','hito-2','hito-3','hito-4','hito-5']]);

say "User, Class, Milestone, Changes";
my %user_stats;
for my $r ( keys %repos ) {
  my $preffix = $repos{$r}[0];
  my ($class) = ($r =~ m{/(\S+)});
  for my $h ( @{$repos{$r}[1]} ) {
    my ($milestone) = ($h =~ /(\d+)/);
    my @files = ("$preffix/$h.md");
    my $commits_obj = new Git::Repo::Commits "$home/$r", \@files;
    my @committers = map( $_->{'author'}, @{$commits_obj->commits});
    for my $d ( @committers ) {
      $user_stats{"$d, $class, $milestone"}++;
    }
  }
}

for my $d ( sort { $user_stats{$a} <=> $user_stats{$b} } keys %user_stats ) {
  next if ($d =~ /(Merelo|Naveros|klyone)/);
  say "$d, $user_stats{$d}\n";
}
