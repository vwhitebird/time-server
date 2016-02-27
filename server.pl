#!/usr/bin/perl 
# Valerie Whitebird
# CS 5651
use strict;
use IO::Socket;

my ($sock, $client, $data, $query);

# auto-flush
$| = 1;

# create socket
$sock = IO::Socket::INET->new(
				LocalAdder	=> 'localhost',
				LocalPort	=> 'daytime', 
				Proto			=> 'tcp',
				Listen		=> 5) || die("IO::SOCKET: $@\n");
				
 my $welcome_msg = "Welcome to the Time Server\n".
 						 "\t1)Query NIST Time Server\n".
 						 "\t2)Query Network Local Time\n" .
 						 "\t3)Exit\n" .
 						 "Please Select your option: \n" . "\n"; # eof = "\n"
# listen
while(1) {
	$client = $sock->accept();	
	$data = $welcome_msg;
	
	$client->send($data); 	# write wel_msg to client
	$data = <$client>;		# read client

	if($data == "1") {  		#Query NIST Time Server
		
		$query = IO::Socket::INET->new(
						PeerHost => 'time.nist.gov',
						PeerPort => 'daytime',
						Proto => 'tcp',
						) or die("IO::SOCKET: $@\n");
		
		# send the query to client
		select($client);
		print <$query>, "\n";		 
		$query->close();
		$client->close();					 			
	
		} elsif ($data == "2") {					# Query Local Time
			print $client scalar localtime, "\n";
			$client->close();				
		} else {
			select($client);							# Exit
			print "EXITING: $data\n";
			$client->close();				
		}
$client->close();	
	}