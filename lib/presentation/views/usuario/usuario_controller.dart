import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paygo_app/domain/models/databaase/paygo_sqlite/usuario_model.dart';
import 'package:paygo_app/infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/usuario_entity.dart';

import '../../../commons/style/application_colors.dart';

class UsuarioController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final _isLoading = false.obs;
  final _isLoadList = true.obs;
  final _campoBusca = ''.obs;
  final _senhaVisivel = false.obs;

  final usuario = UsuarioModel().obs;

  Rx<List<UsuarioModel>> list = Rx<List<UsuarioModel>>([]);

  GlobalKey<FormState> get formKey => _formKey;

  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  get isLoadList => _isLoadList.value;
  set isLoadList(value) => _isLoadList.value = value;

  get campoBusca => _campoBusca.value;
  set campoBusca(value) => _campoBusca.value = value;

  get senhaVisivel => _senhaVisivel.value;
  set senhaVisivel(value) => _senhaVisivel.value = value;

  void setarVisibilidadeSenha() {
    senhaVisivel = !senhaVisivel;
  }

  Future<void> carregarLista() async {
    isLoadList = true;

    await Future.delayed(const Duration(
      milliseconds: 300,
    ));

    try {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      List<UsuarioEntity>? result = await paygoDatabaseRepository.usuario.listar();

      List<UsuarioModel> listAux = [];
      listAux.addAll(result!.map((e) => UsuarioModel.fromJson(e.toJson())).toList());

      list.value.clear();

      if (campoBusca.trim() != '') {
        list.value.addAll(
          listAux.where((element) {
            return ((element.login.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.nome.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    )));
          }),
        );
      } else {
        list.value.addAll(listAux);
      }
    } finally {
      isLoadList = false;
    }
  }

  Future<void> excluirRegistro() async {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Excluir',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: ApplicationColors.paygoYellow,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 6),
        backgroundColor: ApplicationColors.paygoDark,
        titleTextStyle: TextStyle(
          color: ApplicationColors.paygoYellow,
        ),
        content: const Text(
          'Deseja realmente excluir o registro?',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ApplicationColors.paygoYellow,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Não',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: ApplicationColors.paygoYellow,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
              UsuarioEntity usuarioEntity = UsuarioEntity.fromJson(usuario.toJson());
              paygoDatabaseRepository.usuario.delete(usuarioEntity);
              Get.back();
              Get.back();
            },
            child: const Text(
              'Sim',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void salvarRegistro() async {
    if (_formKey.currentState!.validate()) {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      UsuarioEntity? usuarioEntity = UsuarioEntity.fromJson(usuario.toJson());

      if (usuarioEntity.id == null) {
        paygoDatabaseRepository.usuario.insert(usuarioEntity);
      } else {
        paygoDatabaseRepository.usuario.update(usuarioEntity);
      }

      usuarioEntity = await paygoDatabaseRepository.usuario.listarPorLogin(
        usuario.value.login!,
      );

      usuario.value = UsuarioModel.fromJson(usuarioEntity!.toJson());

      usuario.update((val) {
        val!.id = usuarioEntity!.id;
      });

      Get.back();
    }
  }

  @override
  void onInit() async {
    await carregarLista();
    super.onInit();
  }
}
