package CoffeeShop;
use strict;
use warnings FATAL => 'all';

use CoffeeShop::DB qw/resultset execute_raw_sql/;
use CoffeeShop::Schema::Result::Customer;

use CoffeeShop::Customers;


#use Telegram;

my %ORDER_STATUS = (
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
#  my $TelegramBot = Telegram->new(%config);
  # Set authorize code
#  $TelegramBot->start();

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
  
  my CoffeeShop::Schema::Result::Order $new_order = $Orders->create({
    customer_id => $customer_id,
    status_id   => $ORDER_STATUS{CREATING}
  });
  
  return $new_order->id;
}

#**********************************************************
=head2 send_message($admin_id, $message)

  Arguments:
    $admin_id, $message -
    
  Returns:
  
=cut
#**********************************************************
sub send_message {
  my ( $admin_id, $message ) = @_;
  
  # use Telegram
  
  
}



1;