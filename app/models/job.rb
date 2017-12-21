require 'octicons'

class Job
  ICON_WIDTH = 32
  ICON_HEIGHT = 32

  attr_accessor :name
  attr_accessor :status
  attr_accessor :current_build_number
  attr_accessor :current_build
  attr_accessor :current_version

  def initialize(
    job:,
    name:
  )
    @name = name
    @job = job
    begin
      threads = []
      threads << Thread.new do
        @status = job.get_current_build_status name
      end

      threads << Thread.new do
        @current_build_number = job.get_current_build_number name
        @current_build = job.get_build_details(name, @current_build_number)
        @current_version = @current_build['displayName']
      end

      threads.each(&:join)
    rescue JenkinsApi::Exceptions::NotFound => e
      puts e
    end
  end

  def full_display_name
    @current_build['fullDisplayName']
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
end
