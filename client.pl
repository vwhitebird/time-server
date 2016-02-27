#!/usr/bin/perl -w
# Valerie Whitebird
# CS 5651
use strict; 
use IO::Socket;

my ($sock,$data,$option);

# auto-flush on
$| = 1;

# create socket
$sock = IO::Socket::INET->new(
						PeerHost => 'localhost',
						PeerPort => 'daytime',
						Proto => 'tcp',
						) or die("IO::Socket: $@\n");

# read data 
 $data = <$sock>; 
 
 #print Server's message
  while($data ne "\n") {
	print "$data";
  	$data = <$sock>;
 } 
	
 	$option = <STDIN>;			# select menu option
 	print $sock "$option"; 		# write option
 	print <$sock>, "\n";			# read data
 
$sock->close();					# read close tcp connection					
