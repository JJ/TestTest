#!/usr/bin/env perl

use strict;
use warnings;

use lib qw(/home/jmerelo/Code/CPAN/perl-git-commit);

use Git::Repo::Commit;

my $repo = shift || ".";
my $file = shift || die "I need a file to work on it";
