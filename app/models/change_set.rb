class ChangeSet

  attr_accessor :items

  [
    :_class, :kind
  ].each do |key|
    define_method(key) do
      @hash[key.to_s.camelize(:lower)]
    end
  end

  def initialize(hash:)
    @hash = hash
    @items = collect_items
  end

  def find_change_set_item(name)
    change = @items.select { |c| c.name.eql?(name.to_s) }
    return change.first unless change.nil?
  end

  private

  def collect_items
    @items = []
    @hash['items'].each do |item|
      item.keys.each do |key|
        @items << ChangeSetItem.new(name: key, hash: item[key])
      end
    end if @hash.is_a?(Hash)
    @items
  end
end
