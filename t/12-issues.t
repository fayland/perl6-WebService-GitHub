use Test;
use WebService::GitHub;
use WebService::GitHub::Issues;

ok(1);

if (%*ENV<TRAVIS> && rate-limit-remaining()) {
    diag "running on travis";
    my $gh = WebService::GitHub::Issues.new;
    my $issues = $gh.show('fayland/perl6-WebService-GitHub').data;
    cmp-ok $issues.elems, ">", 0, "Non-null number of issues";
    my $first-issue = $gh.single-issue(repo => 'fayland/perl6-WebService-GitHub', issue => 1).data;
    is $first-issue<created_at>, "2015-10-26T19:45:45Z", "First issue OK";
}

done-testing();
