#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(/home/jmerelo/Code/CPAN/perl-git-commit);

use Git::Repo::Commits;
use Time::Piece;

my $home = shift || "/home/jmerelo/txt/docencia/";

my %repos = ( 'infraestructura-virtual/IV16-17' => ['practicas',
						    ['0','1','2','3','4','5']],
	      'infraestructura-virtual/IV-17-18' => ['proyectos',
						    ['hito-0','hito-1','hito-2','hito-3','hito-4','hito-5']]);

say "Day, Class, Milestone, Changes";
my %events;
for my $r ( keys %repos ) {
  my $preffix = $repos{$r}[0];
  for my $h ( @{$repos{$r}[1]} ) {
    my @files = ("$preffix/$h.md");
    my $commits_obj = new Git::Repo::Commits "$home/$r", \@files;
    my @commit_dates = map( $_->{'commit_date'}, @{$commits_obj->commits});
    for my $d ( @commit_dates ) {
      my ($weekday, $mon, $day, $year) = ($d =~ /(\w+)\s+(\w+)\s+(\w+)\s+\S+\s+(\d+)/);
      $year++ if ( $r eq 'infraestructura-virtual/IV16-17' );
      my $t = Time::Piece->strptime( "$mon $day $year", "%b %d %Y");
      $events{$t->mdy("/").", $r, $h"}++;
    }
  }
}

for my $d ( sort { Time::Piece->strptime(substr($a,0,10), "%m/%d/%Y") <=> Time::Piece->strptime(substr($b,0,10), "%m/%d/%Y") } keys %events ) {
  say "$d, $events{$d}\n";
}
