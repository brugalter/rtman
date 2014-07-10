#!/usr/bin/perl

use strict;
use warnings;

## this program is to install rtman and needs to be ran as root
## creates /usr/local/bin/rtman
## adds config file /etc/rtman.conf

open (CONFIG, '>>');
print CONFIG "this should work";
close (CONFIG);
