import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:paygo_app/commons/style/application_colors.dart';

Map<String, dynamic>? itemlista;
List<Map<String, dynamic>> listaItens = [];

void addOrUpdateElement(Map<String, dynamic> valor, double quantidade) {
  final index = listaItens.indexWhere((element) => element["id"] == valor["id"]);
  if (index >= 0) {
    listaItens[index]["quantidade"] = quantidade;
    if (listaItens[index]["quantidade"] == 0) {
      listaItens.removeAt(index);
    }
  } else {
    listaItens.add(valor);
  }
}

class PesquisaProdutoWidget extends SearchDelegate {
  String? title;
  dynamic tipoDado;

  PesquisaProdutoWidget(
    var tipo, {
    String? title,
  }) {
    title = title ?? '';
    tipoDado = tipo;
    listaItens.clear();
  }

  @override
  String get searchFieldLabel => 'Pesquisar';

  @override
  TextInputAction get textInputAction => TextInputAction.unspecified;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: ApplicationColors.paygoDark,
      // Text Style
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      //hint Style
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.white.withAlpha(100),
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withAlpha(100),
          ),
        ),
      ),
      // AppBar Style
      appBarTheme: const AppBarTheme(
        color: ApplicationColors.paygoDark, // affects AppBar's background color
        elevation: 0,

        toolbarHeight: 65,
        toolbarTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((v) {
      close(context, query);
    });
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isVisible) {
      return Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: sugestoes(query).length,
                      itemBuilder: (context, index) {
                        return ItemWidget(
                          item: sugestoes(query)[index],
                          index: index,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: isVisible
                ? null
                : Container(
                    height: 65,
                    color: ApplicationColors.paygoDark,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            close(context, listaItens);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ApplicationColors.paygoYellow,
                          ),
                          child: const Text(
                            'Incluir',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: ApplicationColors.paygoDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      );
    });
  }

  List sugestoes(String pesquisa) {
    if (pesquisa.isEmpty) {
      return tipoDado;
    } else {
      return tipoDado
          .where(
            (element) => element["display"].toString().toUpperCase().contains(
                  pesquisa.toUpperCase(),
                ),
          )
          .toList();
    }
  }
}

class ItemWidget extends StatefulWidget {
  final Map<String, dynamic> item;
  final int index;

  const ItemWidget({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  late double qtde;

  @override
  void initState() {
    super.initState();
    qtde = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Código: ${widget.item["codigo"]?.toString()}',
                    style: TextStyle(
                      fontSize: 13,
                      color: ApplicationColors.paygoZinc[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.item["descricao"],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: ApplicationColors.paygoZinc[900],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'EAN: ${widget.item["ean"]}',
                    style: TextStyle(
                      fontSize: 13,
                      color: ApplicationColors.paygoZinc[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Unidade: ${widget.item["unidade"]}',
                    style: TextStyle(
                      fontSize: 13,
                      color: ApplicationColors.paygoZinc[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Preço de Venda: R\$ ${widget.item["valor"].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 13,
                      color: ApplicationColors.paygoZinc[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        qtde++;
                        addOrUpdateElement(widget.item, qtde);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ApplicationColors.paygoZinc[100],
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.add,
                        color: ApplicationColors.paygoDark[500],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    qtde.toStringAsFixed(2),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: ApplicationColors.paygoZinc[900],
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (qtde > 0) {
                          qtde--;
                          addOrUpdateElement(widget.item, qtde);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ApplicationColors.paygoZinc[100],
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.remove,
                        color: ApplicationColors.paygoDark[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
