# CMDQueryStringSerialization

Easily convert between dictionaries and query strings in iOS. The API is similar to `NSJSONSerialization`.

## Usage

```objectivec
    NSString *queryString = [CMDQueryStringSerialization queryStringWithDictionary:dictionary];
```

`CMDQueryStringSerialization` supports arrays encoded in one of the following three formats:

* `key=value1&key=value2`
* `key[]=value1&key[]=value2`
* `key=value1,value2`

The `CMDQueryStringArraySerializationOption` enum contains options that map to each of these formats, with `CMDQueryStringArraySerializationOptionMultipleKeys` being the default if no option is passed.

## License

MIT