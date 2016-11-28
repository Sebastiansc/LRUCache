# LRUCache

LRUCache built on ruby using HashMap + LinkList

##Usage

cache = LRUCache.new(cache_size)
cache.add(key, value)
cache.each{ |val| yields value } 
