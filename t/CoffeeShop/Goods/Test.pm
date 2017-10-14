package CoffeeShop::Goods::Test;
use strict;
use warnings FATAL => 'all';

use base qw/Test::Class/;
use Test::More;

=head1 NAME

  Test - 

=head2 SYNOPSIS

  This package  

=cut

use CoffeeShop::Goods;
use CoffeeShop::TestSharedParams qw/TEST_GOOD_PARAMS/;

sub prepare : Test(setup => 1) {
  
  my $test_good = CoffeeShop::Goods::get_by_name(TEST_GOOD_PARAMS->{id});
  if ( $test_good ) {
    $test_good->delete()
  }
  
  my $good = CoffeeShop::Goods::add(TEST_GOOD_PARAMS);
  ok($good, 'Registered a good');
  shift->{test_good} = $good;
}

1;