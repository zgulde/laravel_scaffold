# Laravel Scaffolding

This is a ruby script to quickly generate scaffolding for a laravel resource.

## What?

It's a ruby script that uses a ruby templating language to generate a php
templating language that generates php that generates html that... turns into
cat picutes or something. Still with me?

## How?

invoke it like so

```
./generate.rb -r article -a headline.varchar.required -a 'story.text.required|min:50' --belongs-to=author --has-many=comment
```

and it will spit out a model, controller, migration, and associated views for
the resource.

The end product will of course have to be looked over, but should generate a
quick scaffold. The views will be basic bootstrappy forms.

## TODO

