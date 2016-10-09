# Laravel Scaffolding

This is a ruby script to quickly generate scaffolding for a laravel resource.

## What?

It's a ruby script that uses a ruby templating language to run ruby code to
generate a php templating language that generates php that generates html
that... turns into cat picutes or something. Still with me?

## How?

invoke it like so

```
./generate.rb -r category -a name.string.required -t product
```

more detailed example

```
./generate.rb -r article\
    --attribute='headline.string|100.required|max:100'\
    --attribute='story.text.required|min:50'\
    --attribute='topic.enum|["sports", "politics", "entertainment"].required'\
    --belongs-to=author\
    --has-many=comment\
    --paginate=4
```

see the help , `./generate.rb -h`, for more information

and it will spit out a model, controller, migration, and associated views for
the resource.

The end product will of course have to be looked over, but should generate a
quick scaffold. The views will be basic bootstrappy forms.

## TODO

- generate a option with selects if the attribute's data type is an enum
