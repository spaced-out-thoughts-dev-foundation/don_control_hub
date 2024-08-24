require 'sinatra'
require 'net/http'
require 'json'
require 'git'
require './version.rb'

get '/' do
  repo = 'spaced-out-thoughts-dev-foundation/don_control_hub'
  branch = 'main'

  # GitHub API endpoint to fetch the latest commit
  url = "https://api.github.com/repos/#{repo}/commits/#{branch}"

  uri = URI(url)
  response = Net::HTTP.get(uri)
  commit = JSON.parse(response)

  @latest_commit_sha = commit['sha']
  @latest_commit_message = commit['commit']['message']

  @version = DONControlHub::VERSION

  erb :index
end
