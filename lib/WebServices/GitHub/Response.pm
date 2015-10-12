use v6;

use JSON::Tiny; # from-json

class WebServices::GitHub::Response {
    has $.raw;

    method data {
        from-json($.raw.content);
    }
}