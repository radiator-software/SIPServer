#!/usr/bin/perl
# 
# patron_status: check status of valid patron and invalid patron

use strict;
use warnings;

use Sip::Constants qw(:all);
use SIPtest qw($datepat);

my @tests = (
	     $SIPtest::login_test,
	     $SIPtest::sc_status_test,
	     { id => 'valid Patron Status',
	       msg => '2300120060101    084237AOUWOLS|AAdjfiander|AD6789|AC|',
	       pat => qr/^24 [ Y]{13}\d{3}$datepat/,
	       fields => [
			  $SIPtest::field_specs{(FID_INST_ID)},
			  $SIPtest::field_specs{(FID_SCREEN_MSG)},
			  $SIPtest::field_specs{(FID_PRINT_LINE)},
			  { field    => 'AE',
			    pat      => qr/^David J\. Fiander$/,
			    required => 1, },
			  { field    => 'AA',
			    pat      => qr/^djfiander$/,
			    required => 1, },
			  { field    => 'BL',
			    pat      => qr/^Y$/,
			    required => 0, },
			  { field    => 'CQ',
			    pat      => qr/^Y$/,
			    required => 0, },
			  { field    => 'BH',
			    pat      => qr/^.{3}$/,
			    required => 0, },
			  { field    => 'BV',
			    pat      => qr/^[0-9.]+$/,
			    required => 0, },
			  ], },
	     { id => 'invalid password Patron Status',
	       msg => '2300120060101    084237AOUWOLS|AAdjfiander|AC|ADbadw',
	       pat => qr/^24[ Y]{14}\d{3}$datepat/,
	       fields => [
			  { field    => FID_PERSONAL_NAME,
			    pat      => qr/^David J\. Fiander$/,
			    required => 1, },
			  { field    => FID_PATRON_ID,
			    pat      => qr/^djfiander$/,
			    required => 1, },
			  { field    => FID_INST_ID,
			    pat      => qr/^UWOLS$/,
			    required => 1, },
			  { field    => FID_VALID_PATRON_PWD,
			    pat      => qr/^N$/,
			    required => 1, },
			  { field    => FID_VALID_PATRON,
			    pat      => qr/^Y$/,
			    required => 1, },
			  ], },
	     { id => 'invalid Patron Status',
	       msg => '2300120060101    084237AOUWOLS|AAwshakespeare|AC|',
	       pat => qr/^24Y[ Y]{13}\d{3}$datepat/,
	       fields => [
			  { field    => FID_PERSONAL_NAME,
			    pat      => qr/^$/,
			    required => 1, },
			  { field    => FID_PATRON_ID,
			    pat      => qr/^wshakespeare$/,
			    required => 1, },
			  { field    => FID_INST_ID,
			    pat      => qr/^UWOLS$/,
			    required => 1, },
			  ], },
	     );

SIPtest::run_sip_tests(@tests);

1;
