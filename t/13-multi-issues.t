use Test; # -*- mode: perl6 -*-
use WebService::GitHub;
use WebService::GitHub::Issues;

ok(1);

if ( %*ENV<TRAVIS> && rate-limit-remaining() ) || %*ENV<GH_TOKEN>  {
    diag "running on travis or with token";
    my $gh = WebService::GitHub::Issues.new;
    my @all-issues = $gh.all-issues('jnthn/rakudo-debugger');
    cmp-ok @all-issues.elems, ">", 21, "Non-null number of issues (big)";
    @all-issues = $gh.all-issues('JJ/perl6em');
    cmp-ok @all-issues.elems, ">", 10, "Non-null number of issues (small)";
    is @all-issues[0]<state>, "closed", "State of first issue is closed";
    cmp-ok +@all-issues.grep( *<state> eq 'closed' ), ">=", 2, "More than 2 issues closed";
}

done-testing();
