module EnvironmentsHelper
  def job_options(jobs, owns)
    owns = owns.map { |o| o.name }
    out = ''
    jobs.each do |job|
      out << if owns.include?(job.name)
               "<option selected=\"true\" class=\"selected\">#{job.name}</option>"
      else
        "<option>#{job.name}</option>"
      end
    end
    out
  end
end
