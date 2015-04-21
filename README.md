
## Requirements

To use this script, you must get an API key from [picnic.sh](http://picnic.sh)

## Installation

```
Clone this repo or download picnic.rb and include it in your project.
```

## Examples

```
# initialize the picnic object
@picnic = Picnic.new("YOUR_API_KEY")

# list the websites you've purchased
@picnic.list_websites()

# get the price of a new domain
@picnic.get_price("mynewdomain.com")

# buy the domain and set the HTML
@picnic.create_website("mynewdomain.com", "<html><body>coming soon.</body></html>")

# get information about your website
@picnic.get_website("mynewdomain.com")

# update the content of your website
@picnic.update_website("mynewdomain.com", "<html><body>hello</body></html>")
```

## Questions?

Contact us at help [ a t ] picnic.sh
