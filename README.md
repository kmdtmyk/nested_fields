[![Test](https://github.com/kmdtmyk/nested_fields/workflows/Test/badge.svg)](https://github.com/kmdtmyk/nested_fields/actions)

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
  <%= f.remove_nested_fields_button 'remove' %>
<% end %>

<%= form.add_nested_fields_button :comments, 'add' %>
```

## Installation

Gemfile

```ruby
gem 'nested_fields', git: 'https://github.com/kmdtmyk/nested_fields', ref: '<commit_hash>'
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

## Example

Change html tag

```erb
<ul>
  <%= form.nested_fields :comments, tag: :li do |f| %>
    <%= f.text_field :content %>
    <%= f.remove_nested_fields_button 'remove' %>
  <% end %>
</div>
```

Maximum length

```ruby
class Book < ApplicationRecord
  has_many :tags, dependent: :destroy
  accepts_nested_attributes_for :tags, allow_destroy: true
  validates_length_of :tags, maximum: 5
end
```

## Test

```
bundle exec rspec
```

## License

MIT
