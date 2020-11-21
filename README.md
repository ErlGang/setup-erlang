# setup-erlang
[![](https://github.com/ErlGang/setup-erlang/workflows/CI/badge.svg)](https://github.com/ErlGang/setup-erlang/actions?query=workflow%3ACI)

This action sets up an Erlang environment.

**Note** Currently, this action supports only `ubuntu-*` runtimes.

## Usage

See [action.yml](action.yml).

**Note** The OTP release version specification is [relatively
complex](http://erlang.org/doc/system_principles/versions.html#version-scheme).
For best results, it is recommended that one specifies OTP versions using YAML strings, as these examples do,
so that numbers like `23.0` don't end up being parsed as `23`, which is not equivalent.

For a full list of supported OTP versions, see (versions prefixed with `OTP-`):

* [ubuntu-20.04](https://repo.hex.pm/builds/otp/ubuntu-20.04/builds.txt)
* [ubuntu-18.04](https://repo.hex.pm/builds/otp/ubuntu-18.04/builds.txt)
* [ubuntu-16.04](https://repo.hex.pm/builds/otp/ubuntu-16.04/builds.txt)

### Basic example

```yaml
on: push

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: ErlGang/setup-erlang@master
        with:
          otp-version: '22.2'
      - run: command -v erl
```

### Matrix example

```yaml
on: push

jobs:
  test:
    name: OTP ${{matrix.otp}} on ${{ matrix.os }}
    strategy:
      matrix:
        otp: ['23.0', '23', '22.2']
        os: ['ubuntu-20.04', 'ubuntu-18.04']
    runs-on: ${{ matrix.os }}
    steps:
      - uses: actions/checkout@v2
      - uses: ErlGang/setup-erlang@master
        with:
          otp-version: ${{ matrix.otp }}
      - run: command -v erl
```

## License

This project is released under the [MIT license](LICENSE.txt).

## Credits

This GitHub action is based on [setup-elixir](https://github.com/actions/setup-elixir/tree/v1.5.0) action

