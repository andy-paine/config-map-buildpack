# files-buildpack

Writes files based on a user provided service

## User Provided Service

To use this buildpack, bind one or more user provided services (UPS) to the application. This buildpack will attempt to process any UPS containing a `files` key.

The format of the UPS is as follows:
```json
{
  "files": [
    {
      "path": "<path/to/write/file/to>",
      "content": "<content of file in correct format>",
      "format": "<plaintext/base64 - defaults to plaintext>"
    },
  ]
}
```

Multiple files can be specified in a single UPS and multiple UPS can be bound to one app and all will be processed.
Directories will be created if they do not exist.
