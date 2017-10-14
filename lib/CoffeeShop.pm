package CoffeeShop;
use strict;
use warnings FATAL => 'all';

use CoffeeShop::DB qw/resultset execute_raw_sql/;
use CoffeeShop::Schema::Result::Customer;

use CoffeeShop::Customers;

use Telegram;

my %STATUS = (
  'CREATING'  => 0,
  'CREATED'   => 1,
  'CONFIRMED' => 2,
  'IN_ORDER'  => 3,
  'IN_WORK'   => 4,
  'READY'     => 5
);


#**********************************************************
=head2 start(%config)

=cut
#**********************************************************
sub start {
  my (%config) = @_;
  
  # Start telegram bot
  my $TelegramBot = Telegram->new(%config);
  
  # Set authorize code
  
  $TelegramBot->start();
  
}

#**********************************************************
=head2 create_order($customer_id) - creates new order

  Arguments:
    $customer_id   - Customer unique ID
    
  Returns:
    order_id
  
=cut
#**********************************************************
sub create_order {
  my ($customer_id) = @_;
  
  return { error => 'Wrong customer_id' } unless ( $customer_id );
  
  my $customer = CoffeeShop::Customers::get_by_id($customer_id);
  
  return { error => 'Customer not found' } unless ( $customer );
  
  my CoffeeShop::Schema $Orders = resultset('Order');
  
  # TODO Check this customer's desired drink name and size
  my CoffeeShop::Schema::Result::Order $new_order = $Orders->create({
    customer_id => $customer_id,
    status_id   => $STATUS{CREATING}
  });
  
  return $new_order->id;
}

1;