all:
	./rebar compile skip_deps=true

clean:
	./rebar clean

.PHONY: test

test:
	./rebar eunit skip_deps=true

bench:
	./rebar compile skip_deps=true
	erl -pa ebin -s parsexml bench

PLT_NAME=.parsexml.plt

$(PLT_NAME):
	@ERL_LIBS=deps dialyzer --build_plt --output_plt $@ \
		--apps kernel stdlib crypto || true

dialyze: $(PLT_NAME)
	@dialyzer ebin --plt $(PLT_NAME) --no_native \
		-Werror_handling -Wunderspecs

