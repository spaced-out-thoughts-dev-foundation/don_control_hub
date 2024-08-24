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

get '/diagnostics' do
  @version = DONControlHub::VERSION
  erb :diagnostics
end

def cpu_usage
  top_output = `top -bn1 | grep "Cpu(s)"`
  cpu_idle = top_output.match(/id,\s*(\d+\.\d+)/)[1].to_f
  100.0 - cpu_idle
end

def memory_usage
  meminfo = File.read('/proc/meminfo')
  total_memory = meminfo.match(/MemTotal:\s+(\d+)/)[1].to_i
  free_memory = meminfo.match(/MemFree:\s+(\d+)/)[1].to_i
  used_memory = total_memory - free_memory
  (used_memory.to_f / total_memory * 100).round(2)
end

def disk_usage
  df_output = `df / | grep -v Filesystem`
  usage_percentage = df_output.match(/\s+(\d+)%/)[1].to_i
end

get '/data' do
  content_type :json

  # Generate dummy data for demonstration; replace with actual data collection
  data = {
    cpu: cpu_usage,
    disk: memory_usage,
    memory: disk_usage
  }

  data.to_json
end