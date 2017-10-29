package CoffeeShop::Webinterface;
use strict;
use warnings FATAL => 'all';


use Dancer2;

get '/' => sub {
#    template 'index';
    return "Hello world";
  };

get '/auth' => sub {
    #    template 'index';
    return "Auth page";
  };

1;