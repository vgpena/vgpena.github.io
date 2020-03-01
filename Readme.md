# hey it's violet

A simple personal blog built in [Middleman](https://middlemanapp.com/).

## Installation

This project requires Ruby (recommended v2.6, controlled via [rvm](https://rvm.io/)).

Run `bundle install` to get all dependencies.

## Usage

All development should occur on the `unbuilt` branch (see the Deployment section for details).

Run `middleman server` to start a local, hotreloading server on port 4567.

Run `middleman article "TITLE_OF_ARTICLE"` to create a new blog post at the current datetime.

### Deployment

🤠*Please note that I plan to revamp this process ([#7](https://github.com/vgpena/vgpena.github.io/issues/7))* 🤠

This project currently uses the [middleman-gh-pages](https://github.com/edgecase/middleman-gh-pages) gem for deployment.

This means that all development is done on the `unbuilt` branch, and `master` is used _only_ for Github Pages.

To deploy a change:

1. Commit all changes normally.
1. Run `rake build`.
1. Push changes to the `unbuilt` branch on Github.
1. run `rake publish BRANCH_NAME=master`.

This last step will push changes to the `master` branch and kick off a site rebuild.
