package CoffeeShop::Base::Controller;
use strict;
use warnings FATAL => 'all';

=head1 NAME

  CoffeeShop::Base::Controller - 

=head2 SYNOPSIS

  This package  

=cut

use CoffeeShop::DB qw/resultset execute_raw_sql/;

sub import(){
  my ($resultset) = @_;
  
}

1;