module ServicesHelper
  def job_options(jobs)
    out = ''
    jobs.each do |job|
      out << "<option>#{job.name}</option>"
    end
    out
  end
end
