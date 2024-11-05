dev-env +args:
    docker compose --env-file dev.env -f docker-compose.dev.yml {{args}}

setup:
    mix deps.get
    (cd examples/echo_bot && mix deps.get)

check:
    just format
    mix credo --mute-exit-status
    mix dialyzer
    just mix-for echo_bot dialyzer

run-echo-bot:
    (cd examples/echo_bot \
        && rm -rf _build/dev/lib/plug \
        && iex -S mix)

clean:
    mix clean
    rm -rf _build
    just mix-for echo_bot clean
    (cd examples/echo_bot && rm -rf _build)

mix-for $example_app='' +args='':
    (cd examples/$example_app && mix {{args}})

cd-format path='':
    (cd {{path}} && mix format)

format:
    mix format
    just cd-format examples/echo_bot
