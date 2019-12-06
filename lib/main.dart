import 'package:flutter/material.dart';
import 'package:projeto_flutter/adicionar.dart';
import 'package:projeto_flutter/models/contato.dart';
import 'package:projeto_flutter/pesquisa.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new MyHomePage(title: 'Lista de Contatos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final String reloadLabel = 'Reload!';
  final String fireLabel = 'Fire in the hole!';
  final Color floatingButtonColor = Colors.teal;
  final IconData reloadIcon = Icons.refresh;
  final IconData fireIcon = Icons.add;

  @override
  MyHomePageState createState() => new MyHomePageState(
    floatingButtonLabel: this.fireLabel,
    icon: this.fireIcon,
    floatingButtonColor: this.floatingButtonColor,
  );
}

class MyHomePageState extends State<MyHomePage> {
  List<Contato> uiCustomContatos;
  List<Contato> allContatos;
  String floatingButtonLabel;
  Color floatingButtonColor;
  IconData icon;

  MyHomePageState({
    this.floatingButtonLabel,
    this.icon,
    this.floatingButtonColor,
  });

  @override
  void initState() {
    super.initState();
    uiCustomContatos = List<Contato>();
    allContatos = List<Contato>();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        backgroundColor: Colors.teal,
      ),
      
      body: getBody(),
      
      floatingActionButton: new FloatingActionButton(
        backgroundColor: floatingButtonColor,
        child: Icon(Icons.add),
        onPressed: () {
          openScreen(this);
        },
      ),
    );
  }

  Widget getBody() {
    return Column(
      children: <Widget>[
        RelatorioSearch(this),
        Expanded(
          flex: 1,
          child: Container(
            child: ListView.builder(
              itemCount: uiCustomContatos?.length,
              itemBuilder: (BuildContext context, int index) {
                Contato _contato = uiCustomContatos[index];
                return _buildList(_contato, context);
              },
            ),
          ),
        ),
      ],
    );
  }

  ListTile _buildList(Contato c, BuildContext context) {
    return ListTile(
      title: Text(c.nome ?? ""),
      subtitle: Text(c.numero ?? ""),
      leading: new CircleAvatar(
          backgroundColor: Colors.teal, child: Icon(Icons.phone_android)
      ),
      trailing: Container(
        width: 80,
        child: Row(
          children: <Widget>[
            Icon(Icons.phone_in_talk),
            Padding(padding: EdgeInsets.only(left: 16)),
            Icon(Icons.message),
          ],
        ),
      ),
      onTap: () {
        openScreen(this, contato: c);
      },
      onLongPress: () {
        setState(() {
          uiCustomContatos.remove(c);
          allContatos.remove(c);
          
        });
    
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Contato removido', textAlign: TextAlign.center, style:TextStyle(color: Colors.white, fontSize: 25)),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ));
      },
    );
  }

  void openScreen(MyHomePageState myHomePageState, {Contato contato}) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (
        BuildContext context,
      ) {
        return TelaAdicionar(contato: contato, state: myHomePageState);
      },
      fullscreenDialog: true,
    ));
  }
}
