package CoffeeShop::Goods;
use strict;
use warnings FATAL => 'all';

=head1 NAME

  CoffeeShop::Goods - 

=head2 SYNOPSIS

  Goods controller

=cut

use CoffeeShop::DB qw/resultset/;
my $Controller = resultset('Good');

#**********************************************************
=head2 get_by_id($good_id)

=cut
#**********************************************************
#@returns CoffeeShop::Schema::Result::Good
sub get_by_id {
  return $Controller->find(shift);
}

#@returns CoffeeShop::Schema::Result::Good
sub get_by_name {
  return $Controller->single({name => shift});
}

#@returns CoffeeShop::Schema::Result::Good
sub add {
  return $Controller->create(shift);
}
1;