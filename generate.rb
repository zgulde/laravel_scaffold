require 'erb'
require 'active_support/inflector'

if ARGF.argv.length < 1
  puts "give me a resource name!"
  exit 1
end

# add to routes file

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

resource, *attributes = *ARGF.argv

attributes = attributes
  .map {|a| a.split('.')}
  .map {|a| {name: a[0], type: a[1], rules: a[2]}}


file = IO.read('./form.blade.php.erb')

puts ERB.new(file).result(binding)
