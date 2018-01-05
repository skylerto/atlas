require 'octicons'

class Job
  ICON_WIDTH = 32
  ICON_HEIGHT = 32
  BUILD_COUNT = 10

  attr_accessor :name
  attr_accessor :status
  attr_accessor :current_build
  attr_accessor :job

  def initialize(
    job:,
    name:
  )
    @name = name
    @job = job
    @status ||= @job.get_current_build_status name
    begin
      @current_build = Build.new(
        name: name,
        job: job,
        details: @job.get_build_details(name, current_build_number)
      )
    rescue JenkinsApi::Exceptions::NotFound => e
      Rails.logger.error e
      @current_build = Build.new(name: name, job: job, details: {})
    end
  end

  def build(name:)
    Build.new(
      name: @name,
      job: @job,
      details: @job.get_build_details(@name, name)
    )
  end

  ##
  # Build a job with parameters
  #
  # @params [Hash] parameters to run the job with
  def run_build(params = {})
    @job.build(@name, params)
  end

  def current_build_number
    @current_build_number ||= @job.get_current_build_number name
  end

  def icon
    if @status.upcase.eql? ('SUCCESS')
      Octicons::Octicon.new('check', width: ICON_WIDTH, heigh: ICON_HEIGHT).to_svg
    else
      Octicons::Octicon.new('x', width: ICON_WIDTH, heigh: ICON_HEIGHT).to_svg
    end
  end

  def console_output
    out = @job.get_console_output @name, @current_build_number
    out['output'] if out.respond_to?(:[])
  end

  def builds(max = BUILD_COUNT)
    count = 0
    builds = []
    threads = []

    bs = @job.get_builds(name) || []
    bs.each do |build|
      count += 1
      if count <= max
        threads << Thread.new do
          begin
            builds << Build.new(
              name: @name,
              job: @job,
              details: @job.get_build_details(@name, build['number'].to_s)
            )
          rescue JenkinsApi::Exceptions::NotFound => e
            Rails.logger.error e
          end
        end
      end
    end
    threads.each(&:join)
    builds.sort { |f, s| s.display_name <=> f.display_name }
  end
end
