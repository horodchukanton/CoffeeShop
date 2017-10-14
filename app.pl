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

my $condvar = AnyEvent->condvar();

CoffeeShop::start(%conf);

$SIG{INT} = sub {
  $condvar->send(1);
};

print "Started $CONFIG->{name} \n";

$condvar->recv()