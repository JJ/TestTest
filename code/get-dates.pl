#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(/home/jmerelo/Code/CPAN/perl-git-commit);

use Git::Repo::Commits;
use Time::Piece;

my $home = shift || "/home/jmerelo/Asignaturas";

my %repos = ( 'infraestructura-virtual/IV16-17' => ['practicas',
						    ['0','1','2','3','4','5']],
	      'infraestructura-virtual/IV-17-18' => ['proyectos',
						    ['hito-10','hito-1','hito-2','hito-3','hito-4','hito-5']]);

say "Class,milestone,date,weekday";
for my $r ( keys %repos ) {
  my $preffix = $repos{$r}[0];
  for my $h ( @{$repos{$r}[1]} ) {
    my @files = ("$preffix/$h.md");
    my $commits_obj = new Git::Repo::Commits "$home/$r", \@files;
    my @commit_dates = map( $_->{'commit_date'}, @{$commits_obj->commits});
    for my $d ( @commit_dates ) {
      my ($weekday, $rest) = ($d =~ /(\w+)\s+(.+)/);
      my $t = Time::Piece->strptime( $rest, "%b %d %H:%M:%S %Y %z");
      say "$r, $h, $t, $weekday";
    }
  }
}
