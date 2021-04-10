import 'package:flutter/cupertino.dart';
import 'package:taxis_app/Models/TaxiModel.dart';

class TaxiProvider with ChangeNotifier{
  List<TaxiModel> _listaTaxis;
  List<TaxiModel> get listaTaxis => this._listaTaxis;
  set listaTaxis(lista){
    this._listaTaxis = lista;
    notifyListeners();
  }
}