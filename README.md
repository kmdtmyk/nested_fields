# NestedFields

## Usage

```ruby
class Book < ApplicationRecord
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true
end
```

```erb
<%= form.nested_fields :comments do |f| %>
  <%= f.text_field :content %>
  <%= f.remove_nested_fields_link %>
<% end %>

<%= form.add_nested_fields_link :comments %>
```

## Installation

Gemfile

```ruby
gem 'nested_fields', git: 'https://github.com/kmdtmyk/nested_fields'
```

app/assets/config/manifest.js

```js
//= link_directory ../javascripts .js
```

app/assets/javascripts/application.js

```js
//= require nested_fields
```

app/views/layouts/application.html.erb

```erb
= javascript_include_tag 'application'
```

## License

MIT
