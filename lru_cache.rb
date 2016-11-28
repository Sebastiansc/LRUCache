require_relative './link_list'

class LRUCache
  attr_reader :cache, :list

  def initialize
    @max = 200
    @cache = {}
    @list = LinkList.new
  end

  #If key already exists it updates is position in the list to be the MRU.
  #Else it creates both a pointer in the hash and a Link.
  def add(key, value)
    if @cache[key]
      @list.freshen(@cache[key], value)
    else
      link = @list.append(key,value)
      @cache[key] = link
      eject! if @cache.length > @max
    end
  end

  def each
    @list.each{ |link| yield link.val }
  end

  def [](key)
    @cache[key]
  end

  def eject!
    link = @list.first
    @cache.delete(link.key)
    @list.pop
  end
end
