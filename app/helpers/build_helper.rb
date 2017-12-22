module BuildHelper
  def change_set
    @build.change_set.inspect
  end

  def change_set?
    !@build.change_set.nil?
  end

  def author
    @build.author_full_name
  end

  def author_email
    @build.author_email
  end

  def date
    @build.date
  end

  def comment
    @build.comment
  end

  def commit
    @build.commit_id
  end
end
