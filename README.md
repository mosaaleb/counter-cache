# CounterCache
Counter Cache Rails gem provides an easy way to find and auto-update the 
number of belonging objects efficiently by caching counters in the parent model.


## Motivation
CounterCache is an alternative for using native Rails
[counter cache](https://guides.rubyonrails.org/association_basics.html#options-for-belongs-to-counter-cache).

My motivation behind this gem is an attempt to separate counting objects from
`belongs_to` association. If you prefer counting objects and associations
separated, this gem gives you a clear distinction between defining counter
caches and its associations.

This gem also tends to encapsulate defining counters on the parent
model, rather its belonging, so it's clear which counters are specified in every model.

## Getting Started

### Prerequisites
Rails > 5

### Installation
Add this line to your application's Gemfile:

```ruby
gem 'counter_cache'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install counter_cache
```


## Usage

Adding `counter_for` macro in Active Record models will generate update
associated counters from belongings models.

Ex:
```ruby
class Invoice < ApplicationRecord
  has_many :line_items
  counter_for :line_items
end
```

`counter_for :line_items` assumes the that there is a `LineItem` model, and it
will associate the counters in `line_items_count` column.

##### Adding counter columns to parent table
You can either add your counters to your parent table manually. 
**Note:** Your column name should end with `_count`
Ex:
```ruby
counter_for :comments
# column name should be comments_count
```

Or you can use the custom generator provided by this gem:

```bash
rails g counter_cache:add_counters [model name] [counter_for option]
rails g counter_cache:add_counters invoice line_items
```

This will create a new migration for adding an integer `line_items_count`
column in `invoices` table with `0` as default value.

Then run `rails db:migrate`.

- `counter_cached_columns` will return all the cached columns defined per model:
```ruby
Invoice.counter_cached_columns
#=> [:line_items]
```

##### Using custom counter column name

If you want to use another name, you need to use class_name option passing the 
original model name

Ex:
```ruby
class Invoice < ApplicationRecord
  has_many :line_items
  counter_for :items, class_name: :LineItem
end
```

##### Conditional counters

```ruby
class Post < ApplicationRecord
  counter_for :comments
  counter_for :liked_comments, class_name: :Comment, scope: -> { liked? }
end
```

## Roadmap
See the [open issues](https://github.com/mosaaleb/counter-cache/labels/enhancement) 
for a list of proposed features


## License
The gem is available as open source under the terms of
the [MIT License](https://opensource.org/licenses/MIT).

## Tests
The gem is fully tested with minitest
You can run the tests with:

`rake test`


## Author
- Muhammad
  - [GitHub](https://github.com/mosaaleb)
  - [LinkedIn](https://www.linkedin.com/in/muhammadebeid/)
  - [muhammed.ebeid@gmail.com](muhammed.ebeid@gmail.com)

## Contributing
Any contributions you make are greatly appreciated.

1. Fork the Project
2. Create your Feature Branch (git checkout -b feature/AmazingFeature)
3. Commit your Changes (git commit -m 'Add some AmazingFeature')
4. Push to the Branch (git push origin feature/AmazingFeature)
5. Open a Pull Request
