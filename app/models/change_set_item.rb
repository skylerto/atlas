class ChangeSetItem
  attr_accessor :name

  def initialize(name:, hash: hash)
    @name = name
    @hash = hash
  end

  def method_missing(method, *args, &block)
    return @hash unless @hash.is_a?(Hash)
    @hash[method.to_s.camelize(:lower)]
  end
end
