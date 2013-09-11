require 'libraries'
require 'uri'

module LibratoAnnotateHook
  class App < Sinatra::Base
    set :app_file, __FILE__

    set :uri, ENV["METRICS_API"] || "metrics-api.librato.com"

    helpers do
      def abort(status, type, msg)
        halt(status)
      end

      def bad_request!
        abort(400, :request, "Bad Request")
      end
    end

    post '/heroku' do
      unless params[:email] && params[:token] && params[:name]
        bad_request!
      end

      conn = Faraday.new(:url => "https://#{settings.uri}") do |builder|
        builder.request  :json
        builder.adapter  Faraday.default_adapter
      end

      conn.basic_auth params[:email], params[:token]

      body = {
        :title => "#{params[:user]} deployed #{params[:app]}",
        :description => params[:git_log],
        :links => [{ :label => "App URL", :rel => 'heroku',
                     :href => params[:url]}]
      }

      if params[:github_repo]
        body[:links] << {
          :label => "Github Commit",
          :rel => 'github',
          :href => "#{params[:github_repo]}/commit/#{params[:head_long]}"
        }
      end

      resp = conn.post "/v1/annotations/#{params[:name]}", body do |req|
      end

      content_type 'application/json'
      halt(resp.status, resp.body)
    end

  end
end
