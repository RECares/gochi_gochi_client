# gochi_gochi_client

## Development notes

### JSON annotations

This application uses the package `json_annotation` to generate code that allows model instances to
be converted to/from JSON messages that are used to interact with the API server application. This
functionality is implemented in each `model.g.dart` file in the models folder, and must be included
by adding the line `part 'model.g.dart';` to each main model file. To generate this code, run the
command `flutter packages pub run build_runner build`. See
https://pub.dev/packages/json_annotation and
https://github.com/dart-lang/json_serializable/blob/master/example for more information.

Dart uses camel case for variable names consisting of two or more words, whereas the API's
implementation language uses snake case. This must be accounted for my adding the annotation
`@JsonKey(name: 'correct_snake_case_name')` to any multi-word variable in a model class.

### Build failures

If using `flutter run` fails to build the application for any unknown reason, run `flutter clean`,
then try running the application again.
