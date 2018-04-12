use v6;

use JSON::Fast; # from-json

class WebService::GitHub::Response {
    has $.raw;

    method data {
	my $data;
	for $.raw.Array -> $results {
	    # say to-json(from-json($results.content));
	    my $content =  from-json($results.content);
	    # say "This content is ", $content.^name;
	    # say "elems in this result -> ", $content.elems;
	    # say $content.^name;
	    # say "First element";
	    # ddt $content[0];
	    # ddt $content;
	    if $content ~~ Array {
		$data.append: $content.Array;
	    } else {
		$data.append: $content;
	    }
	    # say "Elems in data→ ", $data.elems;
	}
	if $data.elems == 1 {
	    return $data[0];
	} else {
	    return $data;
	}
    }

    method header(Str $field) { $!raw[0].field($field).Str }
    method is-success { $!raw[0].is-success }

    submethod get-link-header($rel) {
        state %link-header;
        return %link-header{$rel} if %link-header.elems;

        # Link: <https://api.github.com/user/repos?page=3&per_page=100>; rel="next",
        # <https://api.github.com/user/repos?page=50&per_page=100>; rel="last"
        my $raw_link_header = self.header('Link') || return;
        for $raw_link_header.split(',') -> $part {
            my ($link, $rel) = ($part ~~ /\<(.+)\>\;\s*rel\=\"(\w+)\"/)[0, 1];
            %link-header{$rel} = $link;
        }
        return %link-header{$rel};
    }

    method first-page-url { $.get-link-header('first') }
    method prev-page-url  { $.get-link-header('prev')  }
    method next-page-url  { $.get-link-header('next')  }
    method last-page-url  { $.get-link-header('last')  }

    method x-ratelimit-limit     { $.header('X-RateLimit-Limit')     }
    method x-ratelimit-remaining { $.header('X-RateLimit-Remaining') }
    method x-ratelimit-reset     { $.header('X-RateLimit-Reset')     }

    # has $.auto_pagination = 0;
    # method next {
    #     state @items;
    #     state $is_data_init = 0;

    #     return @items.shift if @items.elems;

    #     if ($is_data_init and $!auto_pagination) {
    #         # get next-page
    #     }

    #     unless ($is_data_init) {
    #         my $data = $.data;
    #         @items = @($data<items>) if $data<items>.defined;
    #         @items = ($data) unless @items;

    #         $is_data_init = 1;
    #         return @items.shift;
    #     }

    # }

}
