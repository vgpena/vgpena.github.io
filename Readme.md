# hey it's violet

A simple personal blog built in [Middleman](https://middlemanapp.com/).

## Installation

This project requires Ruby (recommended v2.6, controlled via [rvm](https://rvm.io/)).

Run `bundle install` to get all dependencies.

## Usage

Run `middleman server` to start a local, hotreloading server on port 4567.

Run `middleman article "TITLE_OF_ARTICLE"` to create a new blog post at the current datetime.

## Deployment

Run `middleman build --build-dir=docs` to rebuild the site to a folder that Github Pages can read from.
