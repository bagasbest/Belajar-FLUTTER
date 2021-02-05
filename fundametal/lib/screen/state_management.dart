import 'package:flutter/material.dart';
import 'package:fundametal/provider/done_module_provider.dart';
import 'package:provider/provider.dart';

class StateManagement extends StatefulWidget {
  @override
  _StateManagementState createState() => _StateManagementState();
}

class _StateManagementState extends State<StateManagement> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DoneModuleProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ModulePage(),
      ),
    );
  }
}

class ModulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memulai Pemrograman Dengan Dart'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoneModuleList(
                    /// doneModuleList: doneModuleList,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ModuleList(
        ///  doneModuleList: doneModuleList,
      ),
    );
  }
}



class ModuleList extends StatefulWidget {
  final List<String> doneModuleList;

  ModuleList({this.doneModuleList});

  @override
  _ModuleListState createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {
  final List<String> moduleList = [
    'Modul 1 - Pengenalan Dart',
    'Modul 2 - Memulai Pemrograman dengan Dart',
    'Modul 3 - Dart Fundamental',
    'Modul 4 - Control Flow',
    'Modul 5 - Collections',
    'Modul 6 - Object Oriented Programming',
    'Modul 7 - Functional Styles',
    'Modul 8 - Dart Type System',
    'Modul 9 - Dart Futures',
    'Modul 10 - Effective Dart',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: moduleList.length,
      itemBuilder: (context, index) {
        return Consumer<DoneModuleProvider>(
          builder: (context, DoneModuleProvider data, widget) {
            return ModuleTile(
              moduleName: moduleList[index],
              isDone: data.doneModuleList.contains(moduleList[index]),
              onClick: () {
                setState(
                  () {
                    data.complete(moduleList[index]);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class ModuleTile extends StatelessWidget {
  ModuleTile({this.moduleName, this.isDone, this.onClick});

  final String moduleName;
  final bool isDone;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(moduleName),
      trailing: isDone
          ? Icon(Icons.done)
          : RaisedButton(
              child: Text('Done'),
              onPressed: onClick,
            ),
    );
  }
}

class DoneModuleList extends StatelessWidget {
  final List<String> doneModuleList;

  DoneModuleList({this.doneModuleList});

  @override
  Widget build(BuildContext context) {
    final doneModuleList =
        Provider.of<DoneModuleProvider>(context, listen: false).doneModuleList;

    return Scaffold(
      appBar: AppBar(
        title: Text('Done Module List'),
      ),
      body: ListView.builder(
        itemCount: doneModuleList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(doneModuleList[index]),
          );
        },
      ),
    );
  }
}
