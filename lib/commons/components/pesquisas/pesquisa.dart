import 'package:flutter/material.dart';
import 'package:paygo_app/commons/style/application_colors.dart';

class PesquisaWidget extends SearchDelegate {
  String? title;
  dynamic tipoDado;

  PesquisaWidget(
    var tipo, {
    String? title,
  }) {
    title = title ?? '';
    tipoDado = tipo;
  }

  @override
  String get searchFieldLabel => 'Pesquisar';

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
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
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
          resizeToAvoidBottomInset: false,
          body: Column(
            children: <Widget>[
              Container(
                height: 60,
                color: ApplicationColors.paygoDark,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Descrição",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Código",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
                color: Colors.grey[300],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: ListView(
                    children: sugestoes(query).map(
                      (e) {
                        return Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                close(context, e);
                              },
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 59,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${e["display"]}",
                                          maxLines: 3,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "${e["value"]}",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            (e["value"] != tipoDado.length)
                                ? Divider(
                                    height: 1,
                                    color: ApplicationColors.paygoDark.withAlpha(100),
                                  )
                                : Container()
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              // BottomBar
              (title != '')
                  ? Container()
                  : Container(
                      height: 45,
                      color: ApplicationColors.paygoDark,
                      alignment: Alignment.center,
                      child: Text(
                        title ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
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
