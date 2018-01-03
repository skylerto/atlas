module ServicesHelper
  def order_versions(versions)
    bad = 0
    versions.sort_by do |v|
      val = if v.name.include? '#'
        bad += 1
        "0.0.0.#{bad}"
      else
        v.name
      end
      Gem::Version.new(val)
    end.reverse!
  end
end
