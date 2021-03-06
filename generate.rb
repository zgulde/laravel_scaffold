#!/usr/bin/env ruby

require 'erb'
require 'active_support/inflector'
require 'optparse'

resource = ''
attributes = []
belongs_to = []
has_many = []
pagination = false
pagination_number = 10

OptionParser.new do |opts|
  opts.banner = "Usage:\ngenerator.rb -r resource -a attribute.type.rules ..."

  opts.on('-r resource', '--resource=resource', 'Give the name of the resource') do |r|
    resource = r
  end

  opts.on('-t model_name', '--belongs-to=model_name', 'Define a belongs to relationship') do |m|
    belongs_to << m
  end

  opts.on('-m model_name', '--has-many=model_name', 'Define a has many relationship') do |m|
    has_many << m
  end

  opts.on('-a attr', '--attribute=attr', 'Define a attribute for the resource (see the help for the syntax)') do |a|
    attributes << a
  end

  opts.on('-p[ num_pages]', '--paginate[=num_pages]', 'Include Pagination (default 10)') do |p|
    pagination = true
    pagination_number = p || 10
  end

  opts.on("-h", "--help", "Print the help and exit") do
    puts "Quickly scaffold a Laravel resource with a model, controller, migration, and several views"
    puts opts
    puts
    puts "Format for one attribute"
    puts "  attribute_name.data_type|args.rules"
    puts "  where the args for the data type are optional, and the rules are optional"
    puts
    puts "Examples"
    puts "  generator.rb -r article -a 'headline.string|100.required|min:5' -a body.text.required --belongs-to=user --has-many=comment"
    exit
  end
end.parse!

# TODO: add resource to routes file

if resource == ''
  puts 'You must specify a resource name (try -h for help)'
  exit 1
end

def render(filepath, a, resource)
  ERB.new(IO.read(filepath)).result(binding)
end

attributes
  .map!{|a| a.split('.')}
  .map!{|a| {name: a[0],
             type: {name: a[1].split('|').first, params: a[1].split('|')[1..-1]},
             rules: a[2]}}

index_query = "#{resource.capitalize}::"
if ! has_many.empty?
  index_query += has_many.map{|m| "with('#{m}')"}.join('->')
  index_query += '->'
end
index_query += pagination ? "paginate(#{pagination_number})" : 'all()'

# generate the files
files = {
  controller: ERB.new(IO.read('templates/Controller.php.erb')).result(binding),
  model:      ERB.new(IO.read('templates/Model.php.erb')).result(binding),
  migration:  ERB.new(IO.read('templates/migration.php.erb')).result(binding),
  views: {
    index:  ERB.new(IO.read('templates/index.blade.php.erb')).result(binding),
    show:   ERB.new(IO.read('templates/show.blade.php.erb')).result(binding),
    edit:   ERB.new(IO.read('templates/edit.blade.php.erb')).result(binding),
    create: ERB.new(IO.read('templates/create.blade.php.erb')).result(binding),
    form:   ERB.new(IO.read('templates/form.blade.php.erb')).result(binding)
  }
}

# write the files
IO.write("out/#{resource.pluralize.capitalize}Controller.php", files[:controller])
IO.write("out/#{resource.capitalize}.php", files[:model])
IO.write("out/create_#{resource.pluralize}_table.php", files[:migration])
IO.write("out/index.blade.php", files[:views][:index])
IO.write("out/show.blade.php", files[:views][:show])
IO.write("out/edit.blade.php", files[:views][:edit])
IO.write("out/create.blade.php", files[:views][:create])
IO.write("out/form.blade.php", files[:views][:form])

