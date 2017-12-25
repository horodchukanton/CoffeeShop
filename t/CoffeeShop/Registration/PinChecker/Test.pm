package CoffeeShop::Registration::PinChecker::Test;
use strict;
use warnings FATAL => 'all';

use base qw/Test::Class/;
use Test::More;

=head1 NAME

  CoffeeShop::Registration::Test - 

=head2 SYNOPSIS

  This package  

=cut

use CoffeeShop::Registration::PinChecker;

my $text_to_check = 'text to check';

sub prepare : Test(setup => 0){
  my $Res = CoffeeShop::Registration::PinChecker->new();
  shift->{res} = $Res;
}

sub check_correct_pin : Tests(1){
  my CoffeeShop::Registration::PinChecker $Res = shift->{res};
  my $pin = $Res->create_request($text_to_check);
  is($Res->check_pin($pin), $text_to_check);
}

sub check_double_request : Tests(2){
  my CoffeeShop::Registration::PinChecker $Res = shift->{res};
  my $pin = $Res->create_request($text_to_check);
  is($Res->check_pin($pin), $text_to_check);
  isnt($Res->check_pin($pin), $text_to_check);
}

sub check_wrong_pin:Tests(1){
  my CoffeeShop::Registration::PinChecker $Res = shift->{res};
  isnt($Res->check_pin('anypinvalue123'), $text_to_check);
}









1;