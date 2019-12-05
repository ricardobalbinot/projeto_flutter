import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_flutter/main.dart';

class RelatorioSearch extends StatefulWidget {
  MyHomePageState myHomePage;

  RelatorioSearch(this.myHomePage);

  @override
  _RelatorioSearchState createState() => _RelatorioSearchState(myHomePage);
}

class _RelatorioSearchState extends State<RelatorioSearch> {
  final TextEditingController fieldController = TextEditingController();
  bool isLoading = false;
  String search = '';
  MyHomePageState myHomePage;

  _RelatorioSearchState(this.myHomePage);

  void onSubmitted(String v) async {
    myHomePage.setState(() {
      if (v == null || v.isEmpty) {
        myHomePage.uiCustomContatos = myHomePage.allContatos;
      } else {
        myHomePage.uiCustomContatos = myHomePage.allContatos
            .where((contato) =>
                contato.nome.toLowerCase().contains(v.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fieldController.text.isEmpty) {
      fieldController.text = search;
    }

    return ListTile(
      leading: Icon(Icons.search),
      title: TextFormField(
        decoration: InputDecoration(
          hintText: 'Pesquisar',
          border: InputBorder.none,
        ),
        controller: fieldController,
        onChanged: onSubmitted,
      ),
      trailing: searchInfo(context),
    );
  }

  Widget searchInfo(BuildContext context) {
    if (isLoading) {
      return Container(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor),
      );
    } else if (search.isNotEmpty) {
      return IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          fieldController.text = '';
        },
      );
    }

    return null;
  }
}
