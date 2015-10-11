use Test;

die 'export GITHUB_ACCESS_TOKEN' unless %*ENV<GITHUB_ACCESS_TOKEN>;

use WebServices::GitHub;

my $gh = WebServices::GitHub.new(
    access-token => %*ENV<GITHUB_ACCESS_TOKEN>
);

my $res = $gh.request('/user');
say $res.perl;