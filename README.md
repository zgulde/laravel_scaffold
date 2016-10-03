# Laravel Scaffolding

This is a ruby script to quickly generate scaffolding for a laravel resource.

The end goal is to invoke the script like so:

```
./generate.rb post -f title -f body:text --belongs-to=user --has-many=comment
```

and have it spit out a model, controller, migration, and associated views for
the resource.

The end product will of course have to be looked over, but should generate a
quick scaffold. The views will be basic bootstrappy forms.
