require 'json'

data = open('./_l1_topology.json') do |file|
  JSON.load(file)
end

edges = []

data['edges'].each do |edge|
	n1 = edge['node1']
	n2 = edge['node2']
	edges.push({ node1: n1, node2: n2 })
	edges.push({ node1: n2, node2: n1 })
end

puts JSON.pretty_generate({ edges: edges })
