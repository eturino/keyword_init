# KeywordInit

Gem that provides a keyword argument based initialize method to a class, executing the setter of all the recognised keywords.

## Installation

Add this line to your application's Gemfile:

    gem 'keyword_init'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install keyword_init

## Usage

You can have the basic keyword initialization in your class, by including the `KeywordInit` module in your class. This will include the `initialize` method in the class.

For each keyword that the `initialize` method receives, it will execute the setter if that method exists (it will look for a method called `keyword_name=`). 

It will ignore all keywords that don't have a valid setter.

```ruby
class TestKlass
  include KeywordInit
  
  attr_accessor :attrib
  attr_writer :writeonly
  attr_reader :readonly
  
  def my_data
    {attrib: attrib, writeonly: writeonly, readonly: readonly}
  end
end

o = TestKlass.new attrib: 1, writeonly: 2, readonly: 3
x.attrib # => 1

# did not set the value because there are no `readonly=` method 
x.readonly # => nil

x.my_data # => {attrib: 1, writeonly: 2, readonly: nil}
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/keyword_init/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
