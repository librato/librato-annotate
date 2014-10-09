## Librato Annotations Hook

Simple Sinatra app to map third-party service webhooks to Librato
Metric's [annotations API](http://dev.librato.com/v1/annotations).

To deploy this app to Heroku:

```shell
$ git clone https://github.com/librato/librato-annotate.git
Cloning into 'librato-annotate'...
remote: Counting objects: 27, done.
remote: Compressing objects: 100% (16/16), done.
remote: Total 27 (delta 9), reused 26 (delta 8)
Unpacking objects: 100% (27/27), done.

$ cd librato-annotate

$ heroku create
Creating evening-chamber-4158... done, stack is cedar
http://evening-chamber-4158.herokuapp.com/ | git@heroku.com:evening-chamber-4158.git
Git remote heroku added

$ git push heroku master
```

## Supported Services

### Heroku HTTP Post Hook

**NOTE**: If you are using the [Librato Heroku Addon](https://addons.heroku.com/librato) or have setup a [log-drain](http://support.metrics.librato.com/knowledgebase/articles/265391-heroku-native-and-custom-metrics-without-the-libra) for your app, release annotations are now [published to your Librato account](http://blog.librato.com/posts/heroku-status-codes-and-release-annotations) automatically.

Supports Heroku's [HTTP Post
Hook](https://devcenter.heroku.com/articles/deploy-hooks#http_post_hook).

Route: `POST /heroku`

Required Parameters:

* `email`: Your Librato Metrics email address.
* `token`: Your Librato Metrics API token.
* `name`: Annotation stream name to create annotations under.

Optional Parameters:

* `github_repo`: URL of a backing GH repo, for example:
  `https://github.com/librato/myapp`. If this is set a link will be
  added that points to the deployed commit.

To add as a deploy hook to a Heroku app:

```shell
$ heroku addons:add deployhooks:http --url="http://evening-chamber-4158.herokuapp.com/heroku?email=[email]&token=[token]&name=[name]&github_repo=[github repo]"
```
