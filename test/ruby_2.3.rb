o = {'object':{'type':{'class':'string'}}}
result = o.dig('object','type','class')
puts result
puts result == 'string'
