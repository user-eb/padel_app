import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/Styles.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_app/blocs/attachments/AttachmentsBloc.dart';
import 'package:padel_app/blocs/chats/Bloc.dart';
import 'package:padel_app/blocs/config/Bloc.dart';
import 'package:padel_app/blocs/contacts/Bloc.dart';
import 'package:padel_app/blocs/home/Bloc.dart';
import 'package:padel_app/config/Constants.dart';
import 'package:padel_app/config/Themes.dart';
import 'package:padel_app/pages/HomePage.dart';
import 'package:padel_app/repositories/AuthenticationRepository.dart';
import 'package:padel_app/repositories/ChatRepository.dart';
import 'package:padel_app/repositories/StorageRepository.dart';
import 'package:padel_app/repositories/UserDataRepository.dart';
import 'package:padel_app/utils/SharedObjects.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/authentication/Bloc.dart';
import 'pages/RegisterPage.dart';

void main() async {
  initSharedObjAndConstants();

  runApp(
    MaterialApp(
      home: InitFlutterFire(),
    ),
  );
}

void initSharedObjAndConstants() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedObjects.prefs = await CachedSharedPreferences.getInstance();
  Constants.cacheDirPath = (await getTemporaryDirectory()).path;
  Constants.downloadsDirPath =
      (await DownloadsPathProvider.downloadsDirectory).path;
}

class InitFlutterFire extends StatefulWidget {
  @override
  _InitFlutterFireState createState() => _InitFlutterFireState();
}

class _InitFlutterFireState extends State<InitFlutterFire> {
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Show error message if initialization failed
    if (_error) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('Initialization failed. Restart the app',
                style: Styles.textLight),
          ),
        ),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Scaffold(
        body: SafeArea(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return PadelApp();
  }
}

class PadelApp extends StatefulWidget {
  @override
  _PadelAppState createState() => _PadelAppState();
}

class _PadelAppState extends State<PadelApp> {
  ThemeData theme;
  Key key = UniqueKey();

  final AuthenticationRepository authRepository = AuthenticationRepository();
  final UserDataRepository userDataRepository = UserDataRepository();
  final StorageRepository storageRepository = StorageRepository();
  final ChatRepository chatRepository = ChatRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
              authRepository, userDataRepository, storageRepository)
            ..add(AppLaunched()),
        ),
        BlocProvider<ContactsBloc>(
          create: (context) => ContactsBloc(userDataRepository, chatRepository),
        ),
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(
            chatRepository,
            userDataRepository,
            storageRepository,
          ),
        ),
        BlocProvider<AttachmentsBloc>(
          create: (context) => AttachmentsBloc(chatRepository),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(chatRepository),
        ),
        BlocProvider<ConfigBloc>(
          create: (context) =>
              ConfigBloc(userDataRepository, storageRepository),
        )
      ],
      child: BlocBuilder<ConfigBloc, ConfigState>(builder: (context, state) {
        if (state is UnConfigState) {
          theme = SharedObjects.prefs.getBool(Constants.configDarkMode)
              ? Themes.dark
              : Themes.light;
        }
        if (state is RestartedAppState) {
          key = UniqueKey();
        }
        if (state is ConfigChangeState &&
            state.key == Constants.configDarkMode) {
          theme = state.value ? Themes.dark : Themes.light;
        }

        return MaterialApp(
            title: 'PadelApp',
            theme: theme,
            key: key,
            debugShowCheckedModeBanner: false,
            home: StartFCM());
      }),
    );
  }
}

final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final String itemId = data['id'];
  final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
    ..status = data['status'];
  return item;
}

class Item {
  Item({this.itemId});
  final String itemId;

  StreamController<Item> _controller = StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
      () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => DetailPage(itemId),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  DetailPage(this.itemId);
  final String itemId;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Item _item;
  StreamSubscription<Item> _subscription;

  @override
  void initState() {
    super.initState();
    _item = _items[widget.itemId];
    _subscription = _item.onChanged.listen((Item item) {
      if (!mounted) {
        _subscription.cancel();
      } else {
        setState(() {
          _item = item;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item ${_item.itemId}"),
      ),
      body: Material(
        child: Center(child: Text("Item status: ${_item.status}")),
      ),
    );
  }
}

class StartFCM extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _StartFCMState createState() => _StartFCMState();
}

class _StartFCMState extends State<StartFCM> {
  String _homeScreenText = "Waiting for token...";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      content: Text("Item ${item.itemId} has been updated"),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, _itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is UnAuthenticated) {
          return RegisterPage();
        } else if (state is ProfileUpdated) {
          if (SharedObjects.prefs.getBool(Constants.configMessagePaging))
            BlocProvider.of<ChatBloc>(context).add(FetchChatListEvent());
          return HomePage();
        } else {
          return RegisterPage();
        }
      },
    );
  }
}
