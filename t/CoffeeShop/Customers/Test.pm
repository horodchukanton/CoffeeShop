package CoffeShop::Customers::Test;
use strict;
use warnings FATAL => 'all';

use base qw/Test::Class/;
use Test::More;

=head1 NAME

  TestCoffeShop -

=head2 SYNOPSIS

  This package tests coffeshop

=cut

use CoffeeShop;
use CoffeeShop::DB qw/resultset/;

use CoffeeShop::Schema::Result::Customer;
use CoffeeShop::Schema::Result::Good;

use CoffeeShop::TestSharedParams qw/TEST_CUSTOMER_PARAMS TEST_PAYMENT_SUM TEST_GOOD_PARAMS/;

sub can_connect_to_db : Tests(1) {
  ok(resultset('Customer'));
}

sub prepare: Test(setup => 1) {
  # Clear test customer id
  my $test_customer = CoffeeShop::Customers::get_by_chat_id(TEST_CUSTOMER_PARAMS->{chat_id});
  if ( $test_customer ) {
    $test_customer->delete()
  }
  
  my CoffeeShop::Schema::Result::Customer $customer = CoffeeShop::Customers::register(TEST_CUSTOMER_PARAMS);
  ok($customer, 'Registered a customer');
  
  shift->{customer} = $customer;
}

sub create_customer : Tests(3){
  my CoffeeShop::Schema::Result::Customer $customer = shift->{customer};
  
  ok($customer->name eq TEST_CUSTOMER_PARAMS->{name}, 'name equals');
  ok($customer->account eq TEST_CUSTOMER_PARAMS->{account}, 'account equals');
  ok($customer->chat_id eq TEST_CUSTOMER_PARAMS->{chat_id}, 'chat_id equals');
}

sub check_customer_info: Tests(no_plan) {
  my CoffeeShop::Schema::Result::Customer $customer = shift->{customer};
  
  my $params = TEST_CUSTOMER_PARAMS;
  my @keys = keys %{ $params };
  
  foreach my $key ( @keys ) {
    next if ($key eq 'account');
    
    my ($db_val, $test_val) = ($customer->$key(), TEST_CUSTOMER_PARAMS->{$key});
    ok($db_val eq $test_val, "$db_val eq $test_val. $key equals");
  }
}

sub add_payment: Tests(4){
  my CoffeeShop::Schema::Result::Customer $customer = shift->{customer};
  
  # Check balance
  ok ($customer->account == TEST_CUSTOMER_PARAMS->{account}, 'Customer account is fresh');
  
  # Add payment
  my $new_balance = CoffeeShop::Customers::add_payment($customer->id, TEST_PAYMENT_SUM);
  ok($new_balance && ($new_balance == TEST_CUSTOMER_PARAMS->{account} + TEST_PAYMENT_SUM), 'Balance sum is ok after payment');
  
  my $balance_for_customer = CoffeeShop::Customers::get_account($customer->id);
  ok($balance_for_customer && $balance_for_customer == $new_balance, 'Customers account returns new value');
  
  # Try to reset account
  $customer->set_account(TEST_CUSTOMER_PARAMS->{account});
  ok ($customer->account == TEST_CUSTOMER_PARAMS->{account}, 'Customer account is fresh');
}


1;