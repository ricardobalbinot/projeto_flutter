import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_flutter/main.dart';
import 'package:projeto_flutter/models/contato.dart';

class TelaAdicionar extends StatefulWidget {
  Contato contato;
  MyHomePageState state;

  TelaAdicionar({this.contato, this.state});

  @override
  TelaAdicionarState createState() => new TelaAdicionarState();
}

class TelaAdicionarState extends State<TelaAdicionar> {
  String numero;
  String nome;

  TelaAdicionarState({
    this.nome,
    this.numero,
  });

  @override
  void initState() {
    super.initState();

    if (widget.contato != null) {
      this.numero = widget.contato.numero;
      this.nome = widget.contato.nome;
    } 
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        title: widget.contato != null ? Text('Editando Contato'): Text('Novo Contato'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: 16, left: 24, right: 24),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (value){
                    this.nome = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nome',
                  prefixIcon: Icon(
                    Icons.account_circle,
                    size: 28,
                  ),
                ),
                initialValue: widget.contato != null ? widget.contato.nome : null,
              ),
              Padding(padding: EdgeInsets.only(top: 16)),
              TextFormField(
                keyboardType: TextInputType.phone,
                onChanged: (value){
                    this.numero = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Numero',
                  prefixIcon: Icon(
                    Icons.phone_android,
                    size: 28,
                  ),
                ),
                inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                  ], // On,
                initialValue: widget.contato != null ? widget.contato.numero.toString() : null,
              ),
              Padding(padding: EdgeInsets.only(top: 16)),
              MaterialButton(
                child: Text('Adicionar'),
                minWidth: double.infinity,
                colorBrightness: Brightness.dark,
                padding: EdgeInsets.all(20.0),
                color: Colors.teal,
                elevation: 5,
                splashColor: Colors.tealAccent,
                shape: StadiumBorder(),
                onPressed: () {
                  if (widget.contato != null) {
                    widget.state.setState((){
                      widget.state.allContatos.remove(widget.contato);
                    });      
                  } 

                  widget.state.setState((){
                    widget.state.allContatos.add(Contato(nome: this.nome, numero: this.numero));
                    widget.state.uiCustomContatos = widget.state.allContatos;
                  });

                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}