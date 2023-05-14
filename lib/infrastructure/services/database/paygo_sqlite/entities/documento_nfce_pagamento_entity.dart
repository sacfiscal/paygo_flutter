// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(
  tableName: 'documentoNfcePagamento',
  primaryKeys: ['id'],
)
class DocumentoNfcePagamentoEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int? emitenteId;

  int? documentoId;
  int? indPag;
  String? tPag;
  double? vPag;
  String? descricaoPagamento;
  int? tpIntegra;
  String? cnpj;
  int? tBand;
  String? cAut;
  String? transactionResult;
  String? amount;
  int? installments = 0;
  String? currencyCode;
  String? requiresConfirmation;
  String? confirmationTransactionId;
  String? transactionNsu;
  String? authorizationCode;
  String? transactionId;
  String? providerName;
  String? cardType;
  String? maskedPan;
  String? cardName;
  String? defaultCardName;
  String? cardholderName;
  String? resultMessage;
  String? fullReceipt;
  String? merchantReceipt;
  String? cardholderReceipt;
  String? shortReceipt;
  String? graphicReceiptExists;
  String? merchantGraphicReceipt;
  String? cardholderGraphicReceipt;
  String? paymentMode;
  String? uniqueId;

  DocumentoNfcePagamentoEntity({
    this.id,
    this.emitenteId,
    this.documentoId,
    this.indPag,
    this.tPag,
    this.vPag,
    this.descricaoPagamento,
    this.tpIntegra,
    this.cnpj,
    this.tBand,
    this.cAut,
    this.transactionResult,
    this.amount,
    this.installments,
    this.currencyCode,
    this.requiresConfirmation,
    this.confirmationTransactionId,
    this.transactionNsu,
    this.authorizationCode,
    this.transactionId,
    this.providerName,
    this.cardType,
    this.maskedPan,
    this.cardName,
    this.defaultCardName,
    this.cardholderName,
    this.resultMessage,
    this.fullReceipt,
    this.merchantReceipt,
    this.cardholderReceipt,
    this.shortReceipt,
    this.graphicReceiptExists,
    this.merchantGraphicReceipt,
    this.cardholderGraphicReceipt,
    this.paymentMode,
    this.uniqueId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'documentoId': documentoId,
      'indPag': indPag,
      'tPag': tPag,
      'vPag': vPag,
      'descricaoPagamento': descricaoPagamento,
      'tpIntegra': tpIntegra,
      'cnpj': cnpj,
      'tBand': tBand,
      'cAut': cAut,
      'transactionResult': transactionResult,
      'amount': amount,
      'installments': installments,
      'currencyCode': currencyCode,
      'requiresConfirmation': requiresConfirmation,
      'confirmationTransactionId': confirmationTransactionId,
      'transactionNsu': transactionNsu,
      'authorizationCode': authorizationCode,
      'transactionId': transactionId,
      'providerName': providerName,
      'cardType': cardType,
      'maskedPan': maskedPan,
      'cardName': cardName,
      'defaultCardName': defaultCardName,
      'cardholderName': cardholderName,
      'resultMessage': resultMessage,
      'fullReceipt': fullReceipt,
      'merchantReceipt': merchantReceipt,
      'cardholderReceipt': cardholderReceipt,
      'shortReceipt': shortReceipt,
      'graphicReceiptExists': graphicReceiptExists,
      'merchantGraphicReceipt': merchantGraphicReceipt,
      'cardholderGraphicReceipt': cardholderGraphicReceipt,
      'paymentMode': paymentMode,
      'uniqueId': uniqueId,
    };
  }

  factory DocumentoNfcePagamentoEntity.fromMap(Map<String, dynamic> map) {
    return DocumentoNfcePagamentoEntity(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      documentoId: map['documentoId'] != null ? map['documentoId'] as int : null,
      indPag: map['indPag'] != null ? map['indPag'] as int : null,
      tPag: map['tPag'] != null ? map['tPag'] as String : null,
      vPag: map['vPag'] != null ? map['vPag'] as double : null,
      descricaoPagamento: map['descricaoPagamento'] != null ? map['descricaoPagamento'] as String : null,
      tpIntegra: map['tpIntegra'] != null ? map['tpIntegra'] as int : null,
      cnpj: map['cnpj'] != null ? map['cnpj'] as String : null,
      tBand: map['tBand'] != null ? map['tBand'] as int : null,
      cAut: map['cAut'] != null ? map['cAut'] as String : null,
      transactionResult: map['transactionResult'] != null ? map['transactionResult'] as String : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      installments: map['installments'] != null ? map['installments'] as int : null,
      currencyCode: map['currencyCode'] != null ? map['currencyCode'] as String : null,
      requiresConfirmation: map['requiresConfirmation'] != null ? map['requiresConfirmation'] as String : null,
      confirmationTransactionId:
          map['confirmationTransactionId'] != null ? map['confirmationTransactionId'] as String : null,
      transactionNsu: map['transactionNsu'] != null ? map['transactionNsu'] as String : null,
      authorizationCode: map['authorizationCode'] != null ? map['authorizationCode'] as String : null,
      transactionId: map['transactionId'] != null ? map['transactionId'] as String : null,
      providerName: map['providerName'] != null ? map['providerName'] as String : null,
      cardType: map['cardType'] != null ? map['cardType'] as String : null,
      maskedPan: map['maskedPan'] != null ? map['maskedPan'] as String : null,
      cardName: map['cardName'] != null ? map['cardName'] as String : null,
      defaultCardName: map['defaultCardName'] != null ? map['defaultCardName'] as String : null,
      cardholderName: map['cardholderName'] != null ? map['cardholderName'] as String : null,
      resultMessage: map['resultMessage'] != null ? map['resultMessage'] as String : null,
      fullReceipt: map['fullReceipt'] != null ? map['fullReceipt'] as String : null,
      merchantReceipt: map['merchantReceipt'] != null ? map['merchantReceipt'] as String : null,
      cardholderReceipt: map['cardholderReceipt'] != null ? map['cardholderReceipt'] as String : null,
      shortReceipt: map['shortReceipt'] != null ? map['shortReceipt'] as String : null,
      graphicReceiptExists: map['graphicReceiptExists'] != null ? map['graphicReceiptExists'] as String : null,
      merchantGraphicReceipt: map['merchantGraphicReceipt'] != null ? map['merchantGraphicReceipt'] as String : null,
      cardholderGraphicReceipt:
          map['cardholderGraphicReceipt'] != null ? map['cardholderGraphicReceipt'] as String : null,
      paymentMode: map['paymentMode'] != null ? map['paymentMode'] as String : null,
      uniqueId: map['uniqueId'] != null ? map['uniqueId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentoNfcePagamentoEntity.fromJson(String source) =>
      DocumentoNfcePagamentoEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant DocumentoNfcePagamentoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.emitenteId == emitenteId &&
        other.documentoId == documentoId &&
        other.indPag == indPag &&
        other.tPag == tPag &&
        other.vPag == vPag &&
        other.descricaoPagamento == descricaoPagamento &&
        other.tpIntegra == tpIntegra &&
        other.cnpj == cnpj &&
        other.tBand == tBand &&
        other.cAut == cAut &&
        other.transactionResult == transactionResult &&
        other.amount == amount &&
        other.installments == installments &&
        other.currencyCode == currencyCode &&
        other.requiresConfirmation == requiresConfirmation &&
        other.confirmationTransactionId == confirmationTransactionId &&
        other.transactionNsu == transactionNsu &&
        other.authorizationCode == authorizationCode &&
        other.transactionId == transactionId &&
        other.providerName == providerName &&
        other.cardType == cardType &&
        other.maskedPan == maskedPan &&
        other.cardName == cardName &&
        other.defaultCardName == defaultCardName &&
        other.cardholderName == cardholderName &&
        other.resultMessage == resultMessage &&
        other.fullReceipt == fullReceipt &&
        other.merchantReceipt == merchantReceipt &&
        other.cardholderReceipt == cardholderReceipt &&
        other.shortReceipt == shortReceipt &&
        other.graphicReceiptExists == graphicReceiptExists &&
        other.merchantGraphicReceipt == merchantGraphicReceipt &&
        other.cardholderGraphicReceipt == cardholderGraphicReceipt &&
        other.paymentMode == paymentMode &&
        other.uniqueId == uniqueId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        emitenteId.hashCode ^
        documentoId.hashCode ^
        indPag.hashCode ^
        tPag.hashCode ^
        vPag.hashCode ^
        descricaoPagamento.hashCode ^
        tpIntegra.hashCode ^
        cnpj.hashCode ^
        tBand.hashCode ^
        cAut.hashCode ^
        transactionResult.hashCode ^
        amount.hashCode ^
        installments.hashCode ^
        currencyCode.hashCode ^
        requiresConfirmation.hashCode ^
        confirmationTransactionId.hashCode ^
        transactionNsu.hashCode ^
        authorizationCode.hashCode ^
        transactionId.hashCode ^
        providerName.hashCode ^
        cardType.hashCode ^
        maskedPan.hashCode ^
        cardName.hashCode ^
        defaultCardName.hashCode ^
        cardholderName.hashCode ^
        resultMessage.hashCode ^
        fullReceipt.hashCode ^
        merchantReceipt.hashCode ^
        cardholderReceipt.hashCode ^
        shortReceipt.hashCode ^
        graphicReceiptExists.hashCode ^
        merchantGraphicReceipt.hashCode ^
        cardholderGraphicReceipt.hashCode ^
        paymentMode.hashCode ^
        uniqueId.hashCode;
  }

  @override
  String toString() {
    return 'DocumentoNfcePagamentoEntity(id: $id, ßemitenteId: $emitenteId, documentoId: $documentoId, indPag: $indPag, tPag: $tPag, vPag: $vPag, descricaoPagamento: $descricaoPagamento, tpIntegra: $tpIntegra, cnpj: $cnpj, tBand: $tBand, cAut: $cAut, transactionResult: $transactionResult, amount: $amount, installments: $installments, currencyCode: $currencyCode, requiresConfirmation: $requiresConfirmation, confirmationTransactionId: $confirmationTransactionId, transactionNsu: $transactionNsu, authorizationCode: $authorizationCode, transactionId: $transactionId, providerName: $providerName, cardType: $cardType, maskedPan: $maskedPan, cardName: $cardName, defaultCardName: $defaultCardName, cardholderName: $cardholderName, resultMessage: $resultMessage, fullReceipt: $fullReceipt, merchantReceipt: $merchantReceipt, cardholderReceipt: $cardholderReceipt, shortReceipt: $shortReceipt, graphicReceiptExists: $graphicReceiptExists, merchantGraphicReceipt: $merchantGraphicReceipt, cardholderGraphicReceipt: $cardholderGraphicReceipt, paymentMode: $paymentMode, uniqueId: $uniqueId)';
  }
}
