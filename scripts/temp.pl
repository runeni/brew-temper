#!/usr/bin/env perl

use 5.010;
use strict;
use DBI;

# Path to temper binary.
my $temper_binary = "/home/runeni/bin/temper";

# Path to sqlite3 database file.
my $temper_db_file = "/home/runeni/gits/templogger/temper.db";

my %months =  (
  "Jan" => "01",
  "Feb" => "02",
  "Mar" => "03",
  "Apr" => "04",
  "May" => "05",
  "Jun" => "06",
  "Jul" => "07",
  "Aug" => "08",
  "Sep" => "09",
  "Oct" => "10",
  "Nov" => "11",
  "Dec" => "12"
);
open(TEMPER, "$temper_binary|");
my ($when, $temp) = split ",", <TEMPER>;
$when =~ s/(\d+)\-(\w+)-(\d+)/$3-$months{$2}-$1/;
$temp = sprintf("%.2f", $temp);
#say $when;
#say $temp;
close(TEMPER);

my $dbh = DBI->connect("dbi:SQLite:$tempe_db_file", "", "",
  {RaiseError => 1, AutoCommit => 1});
$dbh->do("INSERT INTO measures(temp, created_at) VALUES ($temp, '$when')");
$dbh->disconnect();
