#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(/home/jmerelo/Code/CPAN/perl-git-commit);

use Git::Repo::Commits;

my $home = shift || "/home/jmerelo/txt/docencia";

my %repos = ( 'infraestructura-virtual/IV16-17' => ['practicas',
						    ['0','1','2','3','4','5']],
	      'infraestructura-virtual/IV-17-18' => ['proyectos',
						    ['hito-10','hito-1','hito-2','hito-3','hito-4','hito-5']]);

say "Class,milestone,date";
for my $r ( keys %repos ) {
  my $preffix = $repos{$r}[0];
  for my $h ( @{$repos{$r}[1]} ) {
    my @files = ("$preffix/$h.md");
    my $commits_obj = new Git::Repo::Commits "$home/$r", \@files;
    my @commit_dates = map( $_->{'commit_date'}, @{$commits_obj->commits});
    for my $d ( @commit_dates ) {
      say "$r, $h, $d";
    }
  }
}
