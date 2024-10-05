import 'package:shared_preferences/shared_preferences.dart';

class SharedPre {
  static const String customerId = "CustomerID";
  static const String password = "Password";
  static const String usercode = "UserCode";
  static const String token = "Token";
  static const String userid = "UserId";
  static const String userTypeid = "UserTypeId";

//CustomerId
  static setCustomerId(String val) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.reload();

    await pref.setString(customerId, val);
  }

  static getCustomerId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.reload();
    return pref.getString(customerId);
  }

  static removeCustomerId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.remove(customerId);
  }

//Password
  static setPassword(String val) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.reload();

    await pref.setString(password, val);
  }

  static getPasswaord() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.reload();

    return pref.getString(password);
  }

  static removePassword() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(password);
  }

//UserCode
  static setUserCode(String val) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.reload();

    await pref.setString(usercode, val);
  }

  static getUserCode() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.reload();

    return pref.getString(usercode);
  }

  static removeUserCode() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(usercode);
  }

//Token
  static setToken(String val) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.reload();

    await pref.setString(token, val);
  }

  static getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.reload();
    return pref.getString(token);
  }

  static removeToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(token);
  }

//userid
  static setUserid(String val) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.reload();

    await pref.setString(userid, val);
  }

  static getUserid() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.reload();
    return pref.getString(userid);
  }

  static removeUserid() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(userid);
  }

  //userTypeid
  static setUserTypeid(String val) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.reload();

    await pref.setString(userTypeid, val);
  }

  static getUserTypeid() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.reload();
    return pref.getString(userTypeid);
  }

  static removeUserTypeid() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(userTypeid);
  }
}
