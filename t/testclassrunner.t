#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

=head1 NAME

  testclassrunner.t - 

=head2 SYNOPSIS

  This package  

=cut

our $libpath;

BEGIN {
  our $Bin;
  use FindBin '$Bin';
  
  $libpath = $Bin . '/../';
  
  use lib $Bin;
  use lib $Bin . '/../lib';
  
}

use CoffeeShop::Customers::Test;
use CoffeeShop::Goods::Test;
use CoffeeShop::Registration::PinChecker::Test;

Test::Class->runtests();

1;