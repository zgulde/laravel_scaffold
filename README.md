# Laravel Scaffolding

This is a ruby script to quickly generate scaffolding for a laravel resource.

## What?

It's a ruby script that uses a ruby templating language to run ruby code to
generate a php templating language that generates php that generates html
that... turns into cat pictures or something. Still with me?

## Why?

Mostly because I can.

Check out the [way
generators](https://github.com/laracasts/Laravel-5-Generators-Extended) or
[laravel crud](https://github.com/kEpEx/laravel-crud-generator) for similar
projects that are actually written in php and tie into laravel through an
artisan command.

## How?

From the root directory, invoke it like so

```
./generate.rb -r category -a name.string.required -t product
```

more detailed example

```
./generate.rb --resource=article\
    --attribute='headline.string|100.required|max:100'\
    --attribute='story.text.required|min:50'\
    --attribute='topic.enum|["sports", "politics", "entertainment"].required'\
    --belongs-to=author\
    --has-many=comment\
    --paginate=4
```

and it will spit out a model, controller, migration, and associated views for
the resource.

The end product will of course have to be looked over, but should generate a
quick scaffold. The views will be basic bootstrappy forms.

See the help , `./generate.rb -h`, for more information

## TODO

- generate a select with options if the attribute's data type is an enum
- place generated files in their proper places
    - maybe pass in the laravel project filepath as a parameter?
- make this a gem
- be more intelligent with database data types
- add a resource entry to the routes file
