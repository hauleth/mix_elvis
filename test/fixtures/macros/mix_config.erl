-module(mix_config).

-include("test.hrl").

-export([a/0]).

b() ->
    ?START_SPAN(#{<<"b">> => <<"a">>}).
