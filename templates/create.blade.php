
<form class="form" method="POST" action="{{ action('<%= resource.pluralize.capitalize %>Controller@store') }}">
  @include('<%= resource.pluralize %>.form')
</form>
