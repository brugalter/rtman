#!/usr/bin/perl

use strict;
use warnings;

## this program is to install rtman and needs to be ran as root
## you will want to move rtman.conf to /etc/
## and cp rtman.pl to /usr/local/bin/rtman

#write data to the config file
sub wd  {
  open (CONFIG, '>rtman.conf');
  print CONFIG "@_";
  close (CONFIG);
}

sub getSettings {
  print "this script will create the configuration file needed for rtman to function";
  print "please enter the hostname you will be using for this script:";
  my $host = <STDIN>;

  print "please enter the username you will be using on the remote host:";
  my $user = <STDIN>;
  
  my @returns;
  $returns[0]=$host;
  $returns[1]=$user;
  return @returns;
}

sub createConf  {
  my $host = @_[0];
  my $user= @_[1];
  print "$host";
  print "$user";

wd "#rtman.conf
#written by brugalter
#move rtman.conf file to /etc when you\'re done editing it\n
#host name or ip
host=$host\n
#user name on remote host
user=$user";
}


## create the config file in the current dir
my @settings = getSettings();
createConf @settings;
