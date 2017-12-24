module JobsHelper
  def build_link(build)
    return '/' unless build
    "/jobs/#{build.name}/build/#{build.number}"
  end
end
