import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Home(),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/login': (context) => Login(),
        '/pageY': (context) => PageY(),
        '/pageXY': (context) => PageXY(),
      },
      onGenerateRoute: RouterX.generateRoute,
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        titleSpacing: 0,
      ),
      body: Center(child: ColumnX()),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        titleSpacing: 0,
      ),
      body: Center(child: ColumnX()),
    );
  }
}

class PageX extends StatelessWidget {
  final String _title;
  PageX(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        titleSpacing: 0,
      ),
      body: Center(child: ColumnX()),
    );
  }
}

class PageY extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context).settings;
    String _title = settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        titleSpacing: 0,
      ),
      body: Center(child: ColumnX()),
    );
  }
}

class PageZ extends StatelessWidget {
  final String _title;
  PageZ(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        titleSpacing: 0,
      ),
      body: Center(child: ColumnX()),
    );
  }
}

class PageXY extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page XY'),
        titleSpacing: 0,
      ),
      body: Center(
          child: RaisedButton(
        child: Text('pop and send data'),
        onPressed: () {
          Navigator.pop(context, 'Halloo!!! this data from previous screen');
          // Navigator.pop(context, 123);
        },
      )),
    );
  }
}

class ColumnX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text('Page X'),
          onPressed: () {
            final _route = MaterialPageRoute(builder: (context) {
              return PageX('Page X');
            });
            Navigator.push(context, _route);
          },
        ),
        SizedBox(height: 20),
        RaisedButton(
          child: Text('Page Y'),
          onPressed: () {
            Navigator.pushNamed(context, '/pageY', arguments: 'Page Y');
          },
        ),
        SizedBox(height: 20),
        RaisedButton(
          child: Text('Page Z'),
          onPressed: () {
            Navigator.pushNamed(context, '/pageZ', arguments: 'Page Z');
          },
        ),
        SizedBox(height: 20),
        RaisedButton(
          child: Text('pop'),
          onPressed: () {
            // Navigator.pop(context);
            Navigator.maybePop(context);
            // print(Navigator.canPop(context));
          },
        ),
        SizedBox(height: 20),
        RaisedButton(
          child: Text('popUntil home'),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        SizedBox(height: 20),
        RaisedButton(
          child: Text('pushReplacementNamed'),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pushReplacementNamed(
                context,
                '/pageZ',
                arguments: 'Page Z',
              );
            }
          },
        ),
        SizedBox(height: 20),
        RaisedButton(
          child: Text('popAndPushNamed'),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.popAndPushNamed(
                context,
                '/pageZ',
                arguments: 'Page Z',
              );
            }
          },
        ),
        SizedBox(height: 20),
        RaisedButton(
          child: Text('pushNamedAndRemoveUntil'),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', ModalRoute.withName('/'));
            // if (Navigator.canPop(context)) {
            //   Navigator.popAndPushNamed(
            //     context,
            //     '/pageZ',
            //     arguments: 'Page Z',
            //   );
            // }
          },
        ),
        SizedBox(height: 20),
        RaisedButton(
          child: Text('push and wait data'),
          onPressed: () {
            pushAndWait(context);
          },
        ),
      ],
    );
  }
}

pushAndWait(context) async {
  final dynamic result = await Navigator.pushNamed(context, '/pageXY');
  // final result = await Navigator.push(
  //   context,
  //   MaterialPageRoute<String>(builder: (context) => PageXY()),
  // );

  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text('$result'),
      ),
    );
}

class RouterX {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/pageZ':
        String titleX = settings.arguments;
        return MaterialPageRoute(builder: (context) => PageZ(titleX));
        break;
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
