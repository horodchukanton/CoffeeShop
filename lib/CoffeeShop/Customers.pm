package CoffeeShop::Customers;
use strict;
use warnings FATAL => 'all';

=head1 NAME

  CoffeeShop::Customers

=head2 SYNOPSIS

  Customers controller

=cut

use CoffeeShop::DB qw/resultset/;
my CoffeeShop::Schema::Result::Customer $Customers = resultset('Customer');;

#**********************************************************
=head2 register($customer_params_hash_ref)

  Arguments:
    $customer_params_hash_ref -
    
  Returns:
  
=cut
#**********************************************************
#@returns CoffeeShop::Schema::Result::Customer
sub register {
  my ( $customer_params_hash_ref ) = @_;
  return $Customers->create($customer_params_hash_ref);
}

#**********************************************************
=head2 get_by_id($customer_id)

  Arguments:
    $customer_id -
    
  Returns:
  
=cut
#**********************************************************
#@returns CoffeeShop::Schema::Result::Customer
sub get_by_id {;
  return $Customers->find(shift);
}

#**********************************************************
=head2 get_account($customer_id)

  Arguments:
    $customer_id -
    
  Returns:
  
=cut
#**********************************************************
#@returns CoffeeShop::Schema::Result::Customer
sub get_account {;
  return get_by_id(shift)->account;
}

#**********************************************************
=head2 get_by_chat_id($chat_id)

  Arguments:
    $chat_id - customer by Telegram chat id
    
  Returns:
    Customer or undef
    
=cut
#**********************************************************
#@returns CoffeeShop::Schema::Result::Customer
sub get_by_chat_id {
  return $Customers->find({ chat_id => shift }, { key => 'chat_id' });
}


#**********************************************************
=head2 add_payment($customer_id, $amount)

  Arguments:
    $customer_id, $amount -
    
  Returns:
    number - new balance
  
=cut
#**********************************************************
sub add_payment {
  my ( $customer_id, $amount ) =  @_;
  
  my $customer = get_by_id($customer_id);
  
  return $customer->account if !$amount;
  
  # Update object
  $customer->set_account($customer->account + $amount);
  
  return $customer->account;
}


1;