SocialHackDay
==========

This is a source code for the front end web service of SocialHackDay

Features
--------
- [Unify][unify] theme (version 4) which is compiled by [Middleman][middleman]

Requirements
------------

* [Middleman 4.x][middleman-docs]
* [Ruby 2.x][rbenv]
* [Node 6.x][nvm]
* [Gulp CLI][gulp-cli]

Environments
------------

There are two types of way to see the HTML.
1. server mode
  If you run `bundle exec middleman server` at root, you will see compiled HTML files in your browser. It will track source modifications and reload the browser automatically.

2. build mode
  If you run `bundle exec middleman build` at root, you will find compiled HTML files in `./build` directory.

Deployment
----------

- Updating `develop` branch will automatically deploy them to the staging server.
- Updating `master` branch will automatically deploy them to the production server.

**Do not directly commit to those branches. Use pull requests**

Development
-----------
[Setup](Setup.md) environment

(1) Create new branch
(2) Modify sources in the source directory.

### directory structure
| Directories  | Usage  |
|-----|-----|
| Gemfile | gems |
| Gemfile.lock | gems' version |
| bin | setup comannd |
| build | html files will be created after build |
| config.rb | middleman setting |
| data | data folder for middleman |
| environments | settings for environments |
| gulpfile.js | used in build phase |
| helpers | middleman helpers |
| lib | libraries copied from Unify theme |
| node_modules | will be created by node install |
| package.json | node modules |
| package-lock.json | node modules' versions |
| **source** | source folder |
| spec | middleman spec (don't use) |
| vendor | will be created after bundle install |

(3) Run `bundle exec middleman start`
Check changes via launched browser.

(4) Commit and push the branch to this repository.

(5) Send a pull request.

Setup
-----
Please see [SETUP.md](SETUP.md)

[middleman]: https://middlemanapp.com/
[unify]: https://htmlstream.com/preview/unify-v2.5.1/all-demos.html#cbpf=.unify-main
[gitlabci]: https://about.gitlab.com/features/gitlab-ci-cd/
[middleman-docs]: https://middlemanapp.com/basics/install/
[rbenv]: https://github.com/rbenv/rbenv#readme
[nvm]: https://github.com/creationix/nvm#readme
[gulp-cli]: https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md#getting-started
