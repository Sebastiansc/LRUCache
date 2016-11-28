require_relative './link'

class LinkList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  #Sets link to be the MRU item. Reconnects links connected to it to point to one another. Attaches link to tail
  def freshen(link, value)
    link.prev.next = link.next
    link.next.prev = link.prev
    attach_to_tail(link)
    link.val = value
    link
  end

  #Deletes link next to head. This is the LRU item
  def pop
    first.next.prev = @head
    @head.next = first.next
  end

  def append(key, val)
    link = Link.new(key, val)
    attach_to_tail(link)
    link
  end

  def attach_to_tail(link)
    @tail.prev.next = link
    link.prev = @tail.prev
    @tail.prev = link
    link.next = @tail
  end

  def update(key, val)
    link = @head.next
    each do |link|
      if link.key == key
        link.val = val
        return link
      end
    end
    nil
  end

  def first
    @head.next
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    link = @head.next
    each{ |link| return link if link.key == key }
    nil
  end

  def include?(key)
    link = @head.next
    each{ |link| return true if link.key == key }
    false
  end

  def remove(key)
    link = @head.next
    each do |link|
      if link.key == key
        link.remove
        return link
      end
    end
    false
  end

  def each
    link = @head.next
    while link
      yield link
      link = link.next
    end
  end
end
