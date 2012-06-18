## Librato Annotations Hook

Simple Sinatra app to map third-party service webhooks to Librato
Metric's [annotations API](http://dev.librato.com/v1/annotations).

## Supported Services

### Heroku HTTP Post Hook

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
