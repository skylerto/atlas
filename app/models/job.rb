require 'octicons'

class Job
  ICON_WIDTH = 32
  ICON_HEIGHT = 32

  attr_accessor :name
  attr_accessor :status

  def initialize(
    job:,
    name:
  )
    @name = name
    @job = job
  end

  def status
    @status ||= @job.get_current_build_status name
  end

  def current_build_number
    @current_build_number ||= @job.get_current_build_number name
  end

  def current_build
    @current_build ||= @job.get_build_details(name, current_build_number)
  rescue JenkinsApi::Exceptions::NotFound => e
    Rails.logger.error e
    @current_build = {}
  end

  def current_version
    @current_version = self.current_build['displayName'] || 0
  end

  def full_display_name
    @full_display_name ||= self.current_build['fullDisplayName']
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
