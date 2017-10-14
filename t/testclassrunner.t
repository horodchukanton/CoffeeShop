#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

=head1 NAME

  testclassrunner.t - 

=head2 SYNOPSIS

  This package  

=cut

BEGIN {
  our $Bin;
  use FindBin '$Bin';
  use lib $Bin;
}

use CoffeeShop::Customers::Test;
use CoffeeShop::Goods::Test;

Test::Class->runtests();

1;