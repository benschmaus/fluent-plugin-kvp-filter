# fluent-plugin-kvp-filter [![Build Status](https://travis-ci.org/matt-deboer/fluent-plugin-kvp-filter.png)](https://travis-ci.org/matt-deboer/fluent-plugin-kvp-filter) [![Gem Version](https://badge.fury.io/rb/fluent-plugin-kvp-filter.svg)](https://badge.fury.io/rb/fluent-plugin-kvp-filter)

Fluent filter plugin for parsing key/value fields in records
based on &lt;key>=&lt;value> pattern.

_Forked from [fluent-plugin-fields-parser](https://github.com/tomas-zemres/fluent-plugin-fields-parser)
and converted to a fluentd filter type._

## Installation

Use RubyGems:

    gem install fluent-plugin-kvp-filter

## Configuration

    <filter pattern>
        type                fields_parser

        strict_key_value     false
    </filter>

If following record is passed:

```
{"message": "Audit log user=Johny action='add-user' result=success" }
```

then you will get a new record:

```
{
    "message": "Audit log username=Johny action='add-user' result=success",
    "user": "Johny",
    "action": "add-user",
    "result": "success"
}
```

### Parameter parse_key

For configuration

    <filter pattern>
        type        fields_parser

        parse_key   log_message
    </filter>

it parses key "log_message" instead of default key `message`.

### Parameter remove_parse_key

For configuration

    <filter pattern>
        type                fields_parser

        parse_key           log_message
        remove_parse_key    true
    </filter>

it will remove the key "log_message" after parsing/extracting key/value pairs from it.

### Parameter unmatched_key

For configuration

    <filter pattern>
        type                fields_parser

        parse_key           log_message
        unmatched_key       _unmatched
    </filter>

if any portion of "log_message" is not matched, it will be added to the record under "_unmatched"


### Parameter fields_key

Configuration

    <filter pattern>
        type        fields_parser

        parse_key   log_message
        fields_key  fields
    </filter>

For input like:

```
{
    "log_message": "Audit log username=Johny action='add-user' result=success",
}
```

it adds parsed fields into defined key.

```
{
    "log_message": "Audit log username=Johny action='add-user' result=success",
    "fields": {"user": "Johny", "action": "add-user", "result": "success"}
}
```

(It adds new keys into top-level record by default.)

### Parameter pattern

You can define custom pattern (regexp) for seaching keys/values.

Configuration

    <filter pattern>
        type        fields_parser

        pattern     (\w+):(\d+)
    </filter>

For input like:
```
{ "message": "data black:54 white:55 red:10"}
```

it returns:

```
{ "message": "data black:54 white=55 red=10",
  "black": "54", "white": "55", "red": "10"
}
```

### Parameter strict_key_value

```
    <filter pattern>
        type                fields_parser
        strict_key_value   true
    </filter>
```

If `strict_key_value` is set to `true`, the parser will use the [ruby logfmt
parser](https://github.com/cyberdelia/logfmt-ruby) which will parse the log
message based on the popular [logfmt](https://brandur.org/logfmt) key/value
format.  Do note that this parser will create Fixnum and Float type values
when it parses integer and float values.

All information provided in the log message must be in a strict key=value
format.  For example, if following record is passed:

```
{"message": "msg=\"Audit log\" user=Johnny action=\"add-user\" result=success iVal=23 fVal=1.02 bVal=true" }
```

then you will get a new record:

```
{
    "message": "msg=\"Audit log\" user=Johnny action=\"add-user\" result=success iVal=23 fVal=1.02 bVal=true",
    "msg": "Audit log",
    "user": "Johnny",
    "action": "add-user",
    "result": "success",
    "iVal": 23,
    "fVal": 1.02,
    "bVal": "true"
}
```
