use strict;
use warnings;
use JSON;
use LWP::UserAgent;
use Carp qw(croak);
use Digest::SHA qw( hmac_sha512_hex);
use WWW::Mechanize;
my $apikey="PEMFNC9A-U3E5Y3J5-6V054246-9W3GXUVY-3EJGJZU3";
my $secretkey="05f1e5b0a88e16b8b1490732f77a976c68f0fc8243411b6f0fa25fe857792e30";
our $json = JSON->new->allow_nonref;


my $mech = WWW::Mechanize->new();
$mech->stack_depth(0);
$mech->agent_alias('Windows IE 6');
my $nonce = time;
my $url = "https://btc-e.com/tapi";
my $data = "method=getInfo&nonce=".$nonce;
my $hash = hmac_sha512_hex($data,$secretkey);
$mech->add_header('Key' => $apikey);
$mech->add_header('Sign' => $hash);
$mech->post($url, ['method' => 'getInfo', 'nonce' => $nonce]);
my %apireturn = %{$json->decode($mech->content())};

foreach my $key(keys %apireturn)
{
	print "$key: $apireturn{$key}";
}

