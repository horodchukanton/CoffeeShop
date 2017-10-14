package CoffeeShop::DB;
use strict;
use warnings;

use CoffeeShop::Schema;

use Exporter;
use parent 'Exporter';

# Singletone instance

our @EXPORT_OK = qw/
  resultset
  /;
our @EXPORT = (@EXPORT_OK, qw/schema execute_raw_sql/);

our $schema;

my $db_name = $ENV{'COFFEE_SHOP_DB'} || 'bukinist';
my $db_host = $ENV{'COFFEE_SHOP_DB_HOST'} || 'localhost';
my $db_user = $ENV{'COFFEE_SHOP_DB_USER'} || 'bukinist_db_user';
my $db_pass = $ENV{'COFFEE_SHOP_DB_PASS'} || 'bukinist_db_password'; #"4T)AX}F5ULdarL[g"

# db singleton
#@returns CoffeeShop::Schema;
sub schema {
  $schema ||= CoffeeShop::Schema->connect("dbi:mysql:host=$db_host;dbname=" . $db_name, $db_user, $db_pass, {
      quote_names       => 1,
#      mysql_enable_utf8 => 1,
    });
}

sub resultset {
  return schema()->resultset(shift);
}

sub execute_raw_sql {
  my $statement = shift;
  schema()->storage->dbh_do(
    sub {
      my (undef, $dbh) = @_;
      $dbh->do($statement);
    },
  );
}

1;