class Jenkin < ApplicationRecord
  def jobs
    jobs = []
    names = client.job.list_all
    names.each do |name|
      jobs << self.job(name)
    end
    jobs
  end

  def job(name)
    Job.new name: name, job: client.job
  end

  def client
    @client = @client || JenkinsApi::Client.new(
      server_ip: self.server_ip,
      username: self.username,
      password: self.password
    )
    @client
  end
end
