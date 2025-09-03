import 'dart:convert';
//import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/util/list_produtos.dart';
import 'package:myapp/util/modelo_produto.dart';
import 'package:myapp/util/user_provider.dart';
import 'package:myapp/util/widget_pesquisa.dart';
import 'package:provider/provider.dart';

class PaginaCompras extends StatefulWidget {
  const PaginaCompras({super.key});

  @override
  PaginaComprasState createState() => PaginaComprasState();
}

class PaginaComprasState extends State<PaginaCompras> {
  OverlayEntry? _overlayEntry;

  void _mostrarPesquisa(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      maintainState: false,
      opaque: false,
      builder: (context) => Positioned.fill(
        child: Material(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 60, left: 16, right: 16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(68, 255, 255, 255),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const WidgetPesquisa(),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _removerPesquisa,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removerPesquisa() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color: Color.fromARGB(255, 5, 106, 12),
                      width: 2.0,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      _mostrarPesquisa(context);
                    },
                    icon: Row(
                      children: [
                        Text("Ingresso para..."),
                        Padding(padding: EdgeInsetsGeometry.only(left: 150)),
                        Icon(Icons.search),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                const Text("Destaque:"),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 200,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Column(children: [
                  ],
                ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                const Text("mais vendidos"),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 5,
                  width: 100,
                  color: Color.fromARGB(255, 5, 106, 12),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
