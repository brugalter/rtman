#!/usr/bin/perl

use strict;
use warnings;

## this program is to install rtman and needs to be ran as root
## creates /usr/local/bin/rtman
## adds config file /etc/rtman.conf

#write data to the config file
sub wd  {
  open (CONFIG, '>>rtman.conf');
  print CONFIG "@_\n";
  close (CONFIG);
}

sub create_config  {
 wd '#rtman.conf';
 wd '#written by brugalter';
 wd();
 wd '#move this file to /etc when you\'re done editing it';
 wd();
 wd '#host name or ip';
 wd 'host=';
 wd();
 wd '#user name on remote host';
 wd 'user=';
}

## create the config file in the current dir
create_config();
