use v6;

use JSON::Fast; # from-json

class WebServices::GitHub::Response {
    has $.raw;

    has $.auto_pagination = 0;

    method data {
        from-json($.raw.content);
    }

    submethod get-link-header($rel) {
        state %link-header;
        return %link-header{$rel} if %link-header.elems;

        # Link: <https://api.github.com/user/repos?page=3&per_page=100>; rel="next",
        # <https://api.github.com/user/repos?page=50&per_page=100>; rel="last"
        my $raw_link_header = $!raw.field('Link').Str || return;
        for $raw_link_header.split(',') -> $part {
            my ($link, $rel) = ($part ~~ /\<(.+)\>\;\s*rel\=\"(\w+)\"/)[0, 1];
            %link-header{ $rel } = $link;
        }
        return %link-header{$rel};
    }

    method first-page-url { $.get-link-header('first'); }
    method prev-page-url  { $.get-link-header('prev');  }
    method next-page-url  { $.get-link-header('next');  }
    method last-page-url  { $.get-link-header('last');  }

    method x-ratelimit-limit     { $!raw.field('X-RateLimit-Limit').Str;     }
    method x-ratelimit-remaining { $!raw.field('X-RateLimit-Remaining').Str; }
    method x-ratelimit-reset     { $!raw.field('X-RateLimit-Reset').Str;     }

    method next {
        state @items;

        return @items.shift if @items.elems;

        my $data = $.data;
        @items = @($data<items>) if $data<items>.defined;
        @items = ($data) unless @items;

        return @items.shift;
    }

}