#!/usr/bin/env perl

use 5.010;
use strict;
use DBI;

# Path to sqlite3 database file.
my $temper_db_file = "/home/runeni/gits/brew-temper/temper.db";

my $dbh = DBI->connect("dbi:SQLite:$temper_db_file", "", "",
  {RaiseError => 1, AutoCommit => 1});

my $all = $dbh->selectall_arrayref("SELECT created_at, temp FROM measures;");

foreach my $row (@$all) {
  my ($id, $first, $last) = @$row;
  print "$id|$first|$last\n";
}
$dbh->disconnect();
