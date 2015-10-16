use Test;
use WebServices::GitHub::Response;
use HTTP::Response;

my $search_json_file = $?FILE.IO.dirname ~ '/test_data/search.response';
my $raw = HTTP::Response.new;
$raw.parse(slurp $search_json_file);

my $response = WebServices::GitHub::Response.new(raw => $raw);
is $response.next-page-url, 'https://api.github.com/search/repositories?q=perl&page=2';
is $response.last-page-url, 'https://api.github.com/search/repositories?q=perl&page=34';
is $response.x-ratelimit-limit, 10;
is $response.x-ratelimit-remaining, 9;
is $response.x-ratelimit-reset, 1445000633;

done-testing();