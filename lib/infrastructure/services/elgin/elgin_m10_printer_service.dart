import 'package:flutter/services.dart';

class ElginM10PrinterService {
  final _platform = const MethodChannel('br.com.sacfiscal.pdvandroid_flutter/printer');

  Future<String> verificarStatusDoChannel(String mensagem) async {
    try {
      var retornoMetodo = await _platform.invokeMethod(
        'verificarStatusDoChannel',
        {
          'args': {
            'mensagem': mensagem,
          }
        },
      );
      return retornoMetodo;
    } catch (e) {
      return 'Channel Indisponível';
    }
  }

  Future<int?> abrirConexaoInterna() async {
    try {
      var retornoMetodo = await _platform.invokeMethod(
        'abrirConexaoInterna',
        {'args': {}},
      );
      return retornoMetodo;
    } catch (e) {
      return null;
    }
  }

  Future<int?> abrirConexaoExterna(String ip, int port) async {
    try {
      var retornoMetodo = await _platform.invokeMethod(
        'abrirConexaoExterna',
        {
          'args': {
            'ip': ip,
            'port': port,
          }
        },
      );
      return retornoMetodo;
    } catch (e) {
      return null;
    }
  }

  Future fecharConexao() async {
    await _platform.invokeMethod(
      'fecharConexao',
      {'args': {}},
    );
  }

  Future<int?> verificarStatusImpressora() async {
    try {
      var retornoMetodo = await _platform.invokeMethod(
        'verificarStatusImpressora',
        {'args': {}},
      );
      return retornoMetodo;
    } catch (e) {
      return null;
    }
  }

  Future<int?> avancarLinhas(int quant) async {
    try {
      var retornoMetodo = await _platform.invokeMethod(
        'avancarLinhas',
        {
          'args': {
            'quant': quant,
          }
        },
      );
      return retornoMetodo;
    } catch (e) {
      return null;
    }
  }

  Future<int?> cortarPapel(int quant) async {
    try {
      var retornoMetodo = await _platform.invokeMethod(
        'cortarPapel',
        {
          'args': {
            'quant': quant,
          }
        },
      );
      return retornoMetodo;
    } catch (e) {
      return null;
    }
  }

  Future<int?> cortarPapelTotal(int quant) async {
    try {
      var retornoMetodo = await _platform.invokeMethod(
        'cortarPapelTotal',
        {
          'args': {
            'quant': quant,
          }
        },
      );
      return retornoMetodo;
    } catch (e) {
      return null;
    }
  }

  Future<int?> imprimirTexto({
    String text = 'Elgin Dev',
    String align = 'Esquerda',
    bool isBold = false,
    bool isUnderline = false,
    String font = 'FONT A',
    int fontSize = 4,
  }) async {
    try {
      var retornoMetodo = await _platform.invokeMethod(
        'imprimirTexto',
        {
          'args': {
            'text': text,
            'align': align,
            'isBold': isBold,
            'isUnderline': isUnderline,
            'font': font,
            'fontSize': fontSize,
          }
        },
      );
      return retornoMetodo;
    } catch (e) {
      return null;
    }
  }

  Future<int?> imprimirCodigoDeBarras({
    String barCodeType = 'EAN 8',
    String align = 'Esquerda',
    String text = '78918344',
    int height = 120,
    int width = 4,
  }) async {
    try {
      var retornoMetodo = await _platform.invokeMethod(
        'imprimirCodigoDeBarras',
        {
          'args': {
            'barCodeType': barCodeType,
            'align': align,
            'text': text,
            'height': height,
            'width': width,
          }
        },
      );
      return retornoMetodo;
    } catch (e) {
      return null;
    }
  }

  Future<int?> imprimirQRCode({
    int qrSize = 4,
    String text = 'DEVCSS',
    String align = 'Esquerda',
  }) async {
    try {
      var retornoMetodo = await _platform.invokeMethod(
        'imprimirQRCode',
        {
          'args': {
            'qrSize': qrSize,
            'text': text,
            'align': align,
          }
        },
      );
      return retornoMetodo;
    } catch (e) {
      return null;
    }
  }

  Future<int?> imprimirImagem({
    String? pathImage,
    bool? isBase64,
  }) async {
    try {
      var retornoMetodo = await _platform.invokeMethod(
        'imprimirImagem',
        {
          'args': {
            'pathImage': pathImage,
            'isBase64': isBase64,
          }
        },
      );
      return retornoMetodo;
    } catch (e) {
      return null;
    }
  }

  Future<int?> imprimirXmlNFCe(
    String xml, {
    int indexcsc = 1,
    String csc = 'CODIGO-CSC-CONTRIBUINTE-36-CARACTERES',
    int param = 0,
  }) async {
    try {
      var retornoMetodo = await _platform.invokeMethod(
        'imprimirXmlNFCe',
        {
          'args': {
            'xmlNFCe': xml,
            'indexcsc': indexcsc,
            'csc': csc,
            'param': param,
          }
        },
      );
      return retornoMetodo;
    } catch (e) {
      return null;
    }
  }
}
