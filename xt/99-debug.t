use Test;
use WebServices::GitHub;
use WebServices::GitHub::Role::Debug;

my $gh = WebServices::GitHub.new;

# enable debug
$gh does WebServices::GitHub::Role::Debug;

my $res = $gh.request('/users/fayland');
my $data = $res.data;
diag $data.perl;
is $data<login>, 'fayland';

done-testing;