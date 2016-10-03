require 'erb'
require 'active_support/inflector'
require 'optparse'

resource = ''
attributes = []
belongs_to = []
has_many = []

OptionParser.new do |opts|
  opts.banner = "Usage:\ngenerator.rb -r resource -a attribute.type.rules ..."

  opts.on('-b model_name', '--belongs-to=model_name', 'Define a belongs to relationship') do |m|
    belongs_to << m
  end

  opts.on('-h model_name', '--has-many=model_name', 'Define a has many relationship') do |m|
    has_many << m
  end

  opts.on('-r resource', '--resource=resource', 'Give the name of the resource') do |r|
    resource = r
  end

  opts.on('-a attr', '--attribute=attr', 'Define a attribute for the resource (see the help for the syntax)') do |a|
    attributes << a
  end

  opts.on("-h", "--help", "Print the help and exit") do
    puts "Quickly scaffold a Laravel resource with a model, controller, migration, and several views"
    puts opts
    puts
    puts "Examples"
    puts "  generator.rb post -a 'title.varchar.required|min:5' -a body.text.required --belongs-to=user"
    exit
  end
end.parse!

# TODO: add resource to routes file

# files = {
#   controller: IO.read('Controller.php.erb'),
#   model:      IO.read('Model.php.erb'),
#   migration:  IO.read('Migration.php.erb'),
#   seeder:     IO.read('Seeder.php.erb'),
#   views: {
#     index: IO.read('index.blade.php.erb'),
#     show:  IO.read('show.blade.php.erb'),
#     edit:  IO.read('edit.blade.php.erb'),
#   }
# }

if resource == ''
  puts 'You must specify a resource name (try -h for help)'
  exit 1
end

attributes
  .map!{|a| a.split('.')}
  .map!{|a| {name: a[0], type: a[1], rules: a[2]}}

file = IO.read('./migration.php.erb')

puts ERB.new(file).result(binding)
