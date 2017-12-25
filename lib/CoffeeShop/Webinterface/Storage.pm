package CoffeeShop::Webinterface::Storage;
use strict;
use warnings FATAL => 'all';

use Dancer2 appname => 'CoffeeShop::Webinterface';
use CoffeeShop::DB qw/resultset/;
my $Vendor = resultset('Vendor');

prefix '/storage';

get '/vendors' => sub {
    my @vendors = $Vendor->search()->all;
    my $vendors = '';
    foreach my $vendor (@vendors){
      $vendors .= $vendor->name() . "<br>";
    }
    my %TEMPLATE_PARAMS = ( VENDORS => $vendors );
    template vendors => \%TEMPLATE_PARAMS;
    
  };

post '/vendors' => sub {
    my $vendor = param('vendor');
    eval {
      $Vendor->create( { name => $vendor} );
    };
    redirect '/storage/vendors';
  };

1;