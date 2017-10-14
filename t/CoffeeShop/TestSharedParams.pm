package CoffeeShop::TestSharedParams;
use strict;
use warnings FATAL => 'all';

=head1 NAME

  BukinistTestBaseClass

=head2 SYNOPSIS

   inherits including and loading all libs and files needed for correct test work

=cut

our $path;
BEGIN {
  our ($Bin);
  use FindBin '$Bin';
  $path = $Bin;
  
  #Set env
  $ENV{'COFFEE_SHOP_DB'} = 'bukinist';
  $ENV{'COFFEE_SHOP_DB_HOST'} = '192.168.1.109';
  $ENV{'COFFEE_SHOP_DB_USER'} = 'bukinist_db_user';
  $ENV{'COFFEE_SHOP_DB_PASS'} = 'bukinist_db_password';
}

use lib $path . '/../lib';
use lib $path . '/';

use Exporter;
use parent 'Exporter';

use constant {
  TEST_CUSTOMER_PARAMS => {
    name    => 'Городчук Антон',
    account => 5,
    chat_id => 181908976
  },
  
  TEST_PAYMENT_SUM     => 1.5,
  
  TEST_GOOD_PARAMS     => {
    id           => 1,
    name         => 'Латте',
    price        => '5',
    time_to_make => 1
  }
};

our @EXPORT_OK = qw/
  TEST_CUSTOMER_PARAMS
  TEST_PAYMENT_SUM
  TEST_GOOD_PARAMS
  /;

our @EXPORT = @EXPORT_OK;

our %EXPORT_TAGS = (all => \@EXPORT_OK);

1;