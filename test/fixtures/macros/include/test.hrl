-define(MFA_SPAN_NAME, ?FUNCTION_NAME).

-define(START_SPAN(Attrs),
        ?MFA_SPAN_NAME,
        ?MFA_SPAN_NAME
       ).
