#!/usr/bin/perl
=head1 NAME

  app.pl - bootstrap for CoffeShop application
  
=cut
BEGIN {
  our $Bin;
  use FindBin '$Bin';
  
  unshift (@INC, $Bin);
  unshift (@INC, $Bin . '/lib');
}

use CoffeeShop;
use strict;
use warnings FATAL => 'all';

use AnyEvent;
use Config::Any::Perl;

my $base_dir = '';

print "Loading $base_dir" . "config.pl \n";

my $CONFIG = Config::Any::Perl->load($base_dir . 'config.pl');

our %conf = %$CONFIG;

CoffeeShop::start(%conf);
print "Started $CONFIG->{name} \n";

use CoffeeShop::Webinterface;
CoffeeShop::Webinterface->dance();
