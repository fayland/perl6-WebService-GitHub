use v6;

use WebService::GitHub;
use WebService::GitHub::Role;

use Data::Dump::Tree; # delete if you've finished debugging.


class WebService::GitHub::Issues does WebService::GitHub::Role {

    method show(Str :$repo!, Str :$state = "open") {
	die X::AdHoc.new("State does not exist").throw if $state ne "open"|"closed"|"all" ;
	my $request = '/repos/' ~ $repo ~ '/issues';
	my $payload = '?state='~$state;
	self.request( $request ~ $payload ).data;
    }

    method single-issue(Str :$repo, Int :$issue ) {
	self.request('/repos/' ~ $repo ~ '/issues/' ~ $issue ).data[0];
    }

    method all-issues(Str $repo ) {
	my @issues = self.show( repo => $repo, state => 'all' ).Array;
	my @issue-data;
	for @issues -> $issue {
	    die "Limit exceeded, please use auth" if !rate-limit-remaining();
	    my $this-issue = self.single-issue( repo => $repo, issue => $issue<number> );
	    for $this-issue.kv -> $k, $value { # merge issues
		if ( ! $issue{$k} ) {
		    $issue{$k} = $value;
		}
	    }
	    @issue-data.push( $issue );

	}
	return @issue-data.sort( *<number> );
    }
}
