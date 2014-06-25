#!/usr/bin/perl

use strict;
use warnings;

## file written to manage rtorrent locally, or remotly
## enjoy

use Data::Dumper;

#run remote command
sub remoteCommand  {
  my %configs = readConf();
  my ($command) = shift;

  my $return = `ssh $configs{user}\@$configs{host} $command`;
}

#read config /etc/rtman.conf
sub readConf {
  my @conf;
  my %configs;

  open CONFIG, "/etc/rtman.conf" or die "was not able to open such and such ";
  foreach (<CONFIG>) {
    if ($_ =~ /^[^#\s]/) {
      if ( $_ =~ /^host/) {   
        @conf = split '=', $_; 
        chomp $conf[1];
        $configs{'host'} = $conf[1]; 
      }
      if ( $_ =~ /^user/) { 
        @conf = split '=', $_;
        chomp $conf[1];
        $configs{'user'} = $conf[1];
      }
    }
  }
  return %configs;
}

#check if rtorrent is running
sub chkRunning  {
  my $pid = remoteCommand('pidof rtorrent');
  return $pid;
}

#start rtorrent 
sub start  {
  my $pid = chkRunning();
  if ($pid eq '') { 
    remoteCommand('screen -d -m rtorrent');
  } else { print STDERR "Rtorrent already running, PID: " . $pid;}
}

# show help menu
sub help  {
  print "(start|stop|restart|status|-h|--help)\n";
}

#check status of rtorrent
sub status {
  my $pid = remoteCommand ('pidof rtorrent');
  if (! $pid eq '') {
    print "rtorrent is running\n";
  } else { 
    print "rtorrent is not running\n";
  }
}

## read config and setup host

my $total = $#ARGV;
if ( $total == -1 ) { help(); } 
elsif ( $ARGV[0] =~ /^start$/  ) { start();  }
elsif ( $ARGV[0] =~ /^stop$/  ) { remoteCommand('pkill rtorrent') }
elsif ( $ARGV[0] =~ /^restart$/  ) { stop(); start(); }
elsif ( $ARGV[0] =~ /^--help$/ ) { help(); }
elsif ( $ARGV[0] =~ /^-h$/ ) { help(); }
elsif ( $ARGV[0] =~ /^status$/ ) { status(); }
else { help(); }
