require 'pp'
# frozen_string_literal: true

require 'set'
def read_input_data
  file = File.open('input.txt')
  file_data = file.readlines.map(&:chomp)
  file.close
  file_data
end

class Node
  attr_accessor :child_nodes, :parent_nodes, :color

  def initialize(color)
    @color = color
    @child_nodes = Set.new
    @parent_nodes = Set.new
  end

  def add_child_node(color_and_count)
    @child_nodes << color_and_count
  end

  def add_parent_node(color)
    @parent_nodes << color
  end

  def to_s
    "#{@color} p[#{@child_nodes.length}] c[#{parent_nodes.length}]"
  end
end

def parse_rule(line)
  line.sub!(' bags contain ', ',')
  line.gsub!(' bag, ',  ',')
  line.gsub!(' bags,',  ',')
  line.gsub!(' bags.',  ',')
  line.gsub!(' bag.',  ',')
  line.gsub!('.', ',')
  colors = line.split(',')

  outer = colors.shift
  inner = {}

  colors.each do |c|
    c.strip!
    break if c == "no other"
    inner[c[2..-1]] = c[0]
  end

  { outer: outer, inner: inner }
end

def find_all_parents nodes, color 
  result = []
  nodes[color].parent_nodes.to_a.each do |parent|
    result << parent
    result = result + find_all_parents(nodes, parent)
  end
  result
end

def count_all_children nodes, color
  result = 0
  # puts "looking for children of #{color}"
  nodes[color].child_nodes.to_a.each do |child|
    children = child.values.first.to_i
    grandchildren = count_all_children(nodes, child.first.first)
    result = result + children + (children * grandchildren)
  end
  result
end

nodes = {}

data = read_input_data
data.each do |line|
  break if line.strip.empty?
  parsed = parse_rule line
  nodes[parsed[:outer]] = Node.new parsed[:outer] if nodes[parsed[:outer]].nil?

  parsed[:inner].each do | color, count |
    nodes[color] = Node.new color if nodes[color].nil?
    nodes[parsed[:outer]].add_child_node color => count
    nodes[color].add_parent_node parsed[:outer]
  end
end

shiny_gold_parents = find_all_parents(nodes, "shiny gold").sort.uniq
puts "parent count: #{shiny_gold_parents.length}"

shiny_gold_children = count_all_children(nodes, "shiny gold")
puts "child count: #{shiny_gold_children}"