class Build
  ICON_WIDTH = 32
  ICON_HEIGHT = 32

  attr_accessor :status
  attr_accessor :name
  attr_accessor :change_set

  [
    :_class,
   :actions,
   :artifacts,
   :building,
   :description,
   :display_name,
   :duration,
   :estimated_duration,
   :executor,
   :full_display_name,
   :id,
   :keep_log,
   :number,
   :queue_id,
   :result,
   :timestamp,
   :url,
   :built_on,
   :changeSet,
   :culprits
  ].each do |key|
    define_method(key) do
      @details[key.to_s.camelize(:lower)]
    end
  end

  def initialize(
    name:,
    details: {},
    job:
  )
    @name = name
    @details = details
    @job = job
    @status = self.result || 'failure'
    @change_set = ChangeSet.new hash: self.changeSet
  end

  def author_full_name
    author = @change_set.find_change_set_item(:author)
    return 'Anonymous' if author.nil?
    author.full_name
  end

  def author_email
    author = @change_set.find_change_set_item(:author_email)
    return 'Anonymous' if author.nil?
    author.email
  end

  def date
    date = @change_set.find_change_set_item(:date)
    return 'Date not available' if date.nil?
    date.value
  end

  def comment
    comment = @change_set.find_change_set_item(:comment)
    return 'Comment not available' if comment.nil?
    comment.value
  end

  def commit_id
    commit = @change_set.find_change_set_item(:commit_id)
    return 'Commit ID not available' if commit.nil?
    commit.id
  end

  def icon(width: ICON_WIDTH, height: ICON_HEIGHT)
    if @status.upcase.eql? ('SUCCESS')
      Octicons::Octicon.new('check', width: width, height: height).to_svg
    else
      Octicons::Octicon.new('x', width: width, height: height).to_svg
    end
  end

  def console_output
    out = @job.get_console_output @name, number
    out['output'] if out.respond_to?(:[])
  end
end
