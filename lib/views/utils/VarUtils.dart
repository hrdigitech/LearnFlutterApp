import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VarUtils {
  static GlobalKey<FormState> HomePageFormKey = GlobalKey<FormState>();
  static GlobalKey<FormState> SignInPageFormKey = GlobalKey<FormState>();
  static String phoneNumber = '';
  static String Name = '';
  static String Email = '';
  static String Password = '';
  static String PaymentID = 'None';
  static int ID = 0;
  static int PaymentStatus = 0;
  static int? PaymentMoney;
  static int? SelectedCard = 2;

  static void clearAllVariables() {
    phoneNumber = '';
    Name = '';
    Email = '';
    Password = '';
    PaymentID = 'None';
    ID = 0;
    PaymentStatus = 0;
    PaymentMoney = null;
    SelectedCard = 2;
  }

  static Future<void> saveVariablesSignInToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', VarUtils.phoneNumber);
    prefs.setString('Name', VarUtils.Name);
    prefs.setString('Email', VarUtils.Email);
    prefs.setString('Password', VarUtils.Password);
    prefs.setInt('ID', VarUtils.ID);
  }

  static Future<void> saveVariablesSignUpToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', VarUtils.phoneNumber);
    prefs.setString('Name', VarUtils.Name);
    prefs.setString('Email', VarUtils.Email);
    prefs.setString('Password', VarUtils.Password);
    prefs.setInt('ID', VarUtils.ID);
  }

  static Future<void> saveVariablesPaymentToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('PaymentID', VarUtils.PaymentID);
    prefs.setInt('PaymentStatus', VarUtils.PaymentStatus);
    prefs.setInt('PaymentMoney', VarUtils.PaymentMoney ?? 0);
    prefs.setInt('SelectedCard', VarUtils.SelectedCard ?? 2);
  }

  static Future<void> loadVariablesSignInFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    VarUtils.phoneNumber = prefs.getString('phoneNumber') ?? '';
    VarUtils.Name = prefs.getString('Name') ?? '';
    VarUtils.Email = prefs.getString('Email') ?? '';
    VarUtils.Password = prefs.getString('Password') ?? '';
    VarUtils.ID = prefs.getInt('ID') ?? 0;
  }

  static Future<void> loadVariablesSignUpFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    VarUtils.phoneNumber = prefs.getString('phoneNumber') ?? '';
    VarUtils.Name = prefs.getString('Name') ?? '';
    VarUtils.Email = prefs.getString('Email') ?? '';
    VarUtils.Password = prefs.getString('Password') ?? '';
    VarUtils.ID = prefs.getInt('ID') ?? 0;
  }

  static Future<void> loadVariablesPaymentFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    VarUtils.ID = prefs.getInt('ID') ?? 0;
    VarUtils.PaymentID = prefs.getString('PaymentID') ?? 'None';
    VarUtils.PaymentStatus = prefs.getInt('PaymentStatus') ?? 0;
    VarUtils.PaymentMoney = prefs.getInt('PaymentMoney');
    VarUtils.SelectedCard = prefs.getInt('SelectedCard');
  }

  static Future<void> removeVariablesSignInFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('phoneNumber');
    await prefs.remove('Name');
    await prefs.remove('Email');
    await prefs.remove('Password');
    await prefs.remove('ID');
  }

  static Future<void> removeVariablesSignUpFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('phoneNumber');
    await prefs.remove('Name');
    await prefs.remove('Email');
    await prefs.remove('Password');
    await prefs.remove('ID');
  }

  static Future<void> removeVariablesPaymentFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('ID');
    await prefs.remove('PaymentID');
    await prefs.remove('PaymentStatus');
    await prefs.remove('PaymentMoney');
    await prefs.remove('SelectedCard');
  }
}