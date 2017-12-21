class Jenkin < ApplicationRecord
  def list_jobs
    client.job.list_all
  end

  def job(name)
    client.job.list(name)
  end

  private

  def client
    @client = @client || JenkinsApi::Client.new(
      server_ip: self.server_ip,
      username: self.username,
      password: self.password
    )
    @client
  end
end
