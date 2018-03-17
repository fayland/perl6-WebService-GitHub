use v6;

use WebService::GitHub::Role;

class WebService::GitHub::Issues does WebService::GitHub::Role {

    method show(Str :$repo!, Str :$state = "open") {
	die X::AdHoc.new("State does not exist").throw if $state ne "open"|"closed"|"all" ;
	my $request = '/repos/' ~ $repo ~ '/issues';
	my $payload = '?state='~$state;
	self.request( $request ~ $payload ) ;
    }

    method single-issue(Str :$repo, Int :$issue ) {
      self.request('/repos/' ~ $repo ~ '/issues/' ~ $issue )
    }

    method all-issues(Str $repo ) {
	my $issues = self.show( repo => $repo, state => 'all' );
	my @issues;
	for $issues -> $i {
	    
	}
    }
}
