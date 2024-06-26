# GitHub Prettier Action

[![CodeFactor](https://www.codefactor.io/repository/github/TimVanMourik/pretty-quick-gh-action/badge/master)](https://www.codefactor.io/repository/github/TimVanMourik/pretty-quick-gh-action/overview/master)
[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)
[![License MIT](https://img.shields.io/github/license/TimVanMourik/pretty-quick-gh-action)](https://github.com/TimVanMourik/pretty-quick-gh-action/blob/master/LICENSE)
[![Latest Release](https://img.shields.io/github/v/release/TimVanMourik/pretty-quick-gh-action)](https://github.com/TimVanMourik/pretty-quick-gh-action/releases)
[![Contributors](https://img.shields.io/github/contributors-anon/TimVanMourik/pretty-quick-gh-action)](https://github.com/TimVanMourik/pretty-quick-gh-action/graphs/contributors)
[![Issues](https://img.shields.io/github/issues/TimVanMourik/pretty-quick-gh-action)](https://github.com/TimVanMourik/pretty-quick-gh-action/issues)

A GitHub action for styling files with [prettier](https://prettier.io) by means of [pretty-quick](https://github.com/azz/pretty-quick).

## Usage

### Parameters

| Parameter            | Required | Default | Description                                                      |
| -------------------- | :------: | :-----: | ---------------------------------------------------------------- |
| prettier_version     |   :x:    |  False  | Specific prettier version (by default use latest)                |
| pretty_quick_version |   :x:    |  False  | Specific pretty-quick version (by default use latest)            |
| pretty_quick_options |   :x:    |   ""    | Prettier options (by default it applies to the whole repository) |
| root                 |   :x:    |   "."   | The root from where `pretty-quick` is run                        |

### Example Config

```yaml
name: Continuous Integration

# This action works with pull requests and pushes
on:
  pull_request:
  push:
    branches:
      - master

jobs:
  prettier:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          # Make sure the actual branch is checked out when running on pull requests
          ref: ${{ github.head_ref }}

      - name: Prettify code
        uses: CTcue/pretty-quick-gh-action@v1.4
        with:
          prettier_version: 3.3.2
          pretty_quick_version: 4.0.0
          # This part is also where you can pass other options, for example:
          prettier_options: --write **/*.{ts,md}
          root: .
```

## Update action

* Create PR and review
* Once merged add a new version tag
* Reference new version in workflows
