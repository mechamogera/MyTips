require 'rubygems'
require 'rest-client'
require 'json'
require 'uri'

class JenkinsAPI
  def initialize(base_url)
    @base_url = base_url
  end
  
  def jobnames_at_view(view)
    view_str = URI.escape(view)
    view_data = JSON.parse(RestClient.get("#{@base_url}/view/#{view_str}/api/json"))
    view_data['jobs'].map { |x| x['name'] }
  end 

  def newest_job_result(job_name)
    job_str = URI.escape(job_name)
    job_data = JSON.parse(RestClient.get("#{@base_url}/job/#{job_str}/api/json"))
    build_data = JSON.parse(RestClient.get("#{job_data['lastBuild']['url']}api/json"))
  end
end


