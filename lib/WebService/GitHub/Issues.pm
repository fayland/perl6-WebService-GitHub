use v6;

use WebService::GitHub::Role;

class WebService::GitHub::Issues does WebService::GitHub::Role {

    method show($repo?) {
      self.request($repo ?? '/repos/' ~ $repo ~ '/issues' !! '/issues/' )
    }

    method single-issue(Str :$repo, Int :$issue ) {
      self.request('/repos/' ~ $repo ~ '/issues/' ~ $issue )
    }

    method all-issues(Str $repo ) {
	my $issues = self.show($repo).data;
    }
}
