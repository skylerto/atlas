module ServicesHelper
  BAD_VALUES = [
    '#',
    '-'
  ].freeze

  def order_versions(versions)
    bad = 0
    versions.sort_by do |v|
      val = if bad_values?(v.name)
        bad += 1
        "0.0.0.#{bad}"
      else
        v.name
      end
      Gem::Version.new(val)
    end.reverse!
  end

  private

  def bad_values?(name)
    res = false
    BAD_VALUES.each do |val|
      res = name.include?(val)
      break if res
    end
    res
  end
end
