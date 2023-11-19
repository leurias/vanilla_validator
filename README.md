## 🚧 Project Under Development 🚧

## VanillaValidator

VanillaValidator is a lightweight and clean solution for implementing validation in Ruby. It inspired from Laravel Validator and allows you to separate validations from the model layer in your Rails applications. With this gem, you can easily define and enforce validation rules for input data, ensuring the consistency and cleanliness of your application's data.

### Installation:
To use VanillaValidator in your Ruby project, execute the following command to install it:

```ruby
$ bundle add vanilla_validator
```

### Basic Usage
There are two options to use VanillaValidator, in the first place you can invoke `validate` method directlly from `VanillaValidator` class and then result would be an object witch contains different methods to determine the result of validation.

```ruby
params = {
  user: {
    email: 'john@doe.me'
  }
}

validation = VanillaValidator.validate(params, {
  'user.email' => 'required|email'
})

validation.success?
validation.failed?
validation.validated
validation.errors


# In Rails, you can access the validate method directly:
params.validate({
  'user.email' => 'require|email'
})

# If you want validation to stop at the first failure, use a bang sign (!) after 'validate':
params.validate!({
  'user.password' => 'require|min:16'
})
```

### Rules Declaration
You have the flexibility to define validation rules either explicitly or implicitly, depending on your specific requirements. When taking the explicit approach, you must specify the exact attribute you wish to validate. To access nested attributes, you can employ a period (.) in the attribute path, as demonstrated below:

```ruby
params = {
  user: {
    email: 'john@doe.me',
    preferences: {
      notifications: true
    }
  }
}

VanillaValidator.validate(params, {
  'user.email' => 'required|email',
  'user.preferences.notifications' => 'boolean'
})
```

In cases where your input consists of a collection of items, you can specify the attributes implicitly. This can be achieved by using a wildcard (\*) in the attribute path, as shown in the following example:

```ruby
params = {
  user: {
    addresses: [
      { city: 'San Francisco', state: 'CA' },
      { city: 'Los Angeles', state: 'CA' }
    ],
    orders: [
      { total: 50.0, status: 'shipped' },
      { total: 75.0, status: 'delivered' }
    ]
  }
}

validation = VanillaValidator.validate(params, {
  'user.addresses.*.state' => 'required|string|in:CA,NY',
  'user.orders.*.total'    => 'required|numeric|min:0',
  'user.orders.*.status'   => 'required|string|in:pending,shipped,delivered'
})
```

### Available Validation Rules
- [After](#after)
- [AfterOrEqual](#after_or_equal)
- [Before](#before)
- [BeforeOrEqual](#before_or_equal)
- [Boolean](#boolean)
- [Date](#date)
- [Email](#email)
- [EQ](#eq)
- [Falsy](#falsy)
- [Gte](#gte)
- [In](#in)
- [Like](#like)
- [Max](#max)
- [Min](#min)
- [Numeric](#numeric)
- [Required](#required)
- [RequiredIf](#required_if)
- [Url](#url)
- [Custom Validation Rules](#custom_validation_rules)

##### After
The validated field must have a value that is after a specified date.

```ruby
'start_date' => 'required|date|after:tomorrow'
```

##### After Or Equal

##### Before

##### Before Or Equal

##### Boolean

##### Date

##### Email

##### EQ

##### Falsy

##### Gte

##### In

##### Like

##### Max

##### Min

##### Numeric

##### Required

##### Required If

##### Url

##### Custom Validation Rules:

### Contributions:
Contributions to this gem are welcome. Please read the [Contribution Guidelines](link-to-contributing) before submitting your contributions.

### Reporting Issues:
If you encounter any issues or have suggestions for improvements, please open an issue on the [GitHub repository](link-to-issues).

### License:
This gem is available under the [MIT License](https://choosealicense.com/licenses/mit/).
