use v6;

use JSON::Tiny; # from-json

class WebServices::GitHub::Response {
    has $.raw;

    has $.auto_pagination = 0;

    method data {
        from-json($.raw.content);
    }


}