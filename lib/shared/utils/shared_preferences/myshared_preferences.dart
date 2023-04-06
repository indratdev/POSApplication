import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static const String _companyID = '';

  // Fungsi untuk menyimpan companyID
  Future<void> saveCompanyID(String idCompany) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_companyID, idCompany);
  }

  // Fungsi untuk mengambil companyID
  Future<String> getCompanyID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_companyID) ?? "";
  }
}
