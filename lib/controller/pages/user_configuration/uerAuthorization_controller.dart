import 'dart:collection';

import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/services/pages/user_configuration/getMenuAuthorization_api.dart';
import 'package:flowkit/services/pages/user_configuration/getallUser_api.dart';
import 'package:flowkit/services/pages/user_configuration/updateMenu-api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:get/get.dart';

class UserAuthorizationController extends MyController {
  @override
  void onInit() {
    _callAlluserApi();
    super.onInit();
  }

  List<AllUserData2>? getallUser = [];
  bool isLoad = false;
  bool valueEnquiry = false;
  bool valueLeads = false;
  bool valueOrder = false;
  bool valueFollowup = false;
  bool valueWalkins = false;
  bool valueScanQrCode = false;
  bool valueQuotes = false;
  bool valueStocks = false;
  bool valuePriceList = false;
  bool valueOfferZone = false;
  bool valueAccounts = false;
  bool valueOutstanding = false;
  bool valueCollection = false;
  bool valueSettlement = false;
  bool valueDayStartEnd = false;
  bool valueVistPlan = false;
  bool valueSitein = false;
  bool valueSiteOut = false;
  bool valueLeaveReq = false;
  bool valueLeaveApproval = false;
  bool valueScoreCard = false;
  bool valueEarnings = false;
  bool valuePerformance = false;
  bool valueTargets = false;
  bool valueChallenges = false;
  selectAllDeselectAll(bool val) {
    valueEnquiry = val;
    valueLeads = val;
    valueOrder = val;
    valueFollowup = val;
    valueWalkins = val;
    valueScanQrCode = val;
    valueQuotes = val;
    valueStocks = val;
    valuePriceList = val;
    valueOfferZone = val;
    valueAccounts = val;
    valueOutstanding = val;
    valueCollection = val;
    valueSettlement = val;
    valueDayStartEnd = val;
    valueVistPlan = val;
    valueSitein = val;
    valueSiteOut = val;
    valueLeaveReq = val;
    valueLeaveApproval = val;
    valueScoreCard = val;
    valueEarnings = val;
    valuePerformance = val;
    valueTargets = val;
    valueChallenges = val;

    update();
  }

  _callAlluserApi() async {
    getallUser = [];
    update();
    await GetAllUserListApi.call().then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        if (onValue.data!.isNotEmpty) {
          isLoad = false;
          List<AllUserData2> getallUser2 =
              LinkedHashSet<AllUserData2>.from(onValue.data!).toList();

          // getallUser2.sort((a, b) => a.toString().compareTo(b.toString()));
          getallUser = getallUser2;
          update();
        }
      } else {
        Get.dialog(AlertBox(
          msg: 'Somethink went wrong..!!',
        ));
      }
    });
  }

  List<GetMenuAuthData>? menuData;
  String? valueUser;
  callUserManuAuthDataApi(String val) async {
    valueUser = val;
    menuData = [];
    update();
    await GetMenuAuthorizationApi.call(val).then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        menuData = onValue.data;
        getData(menuData);
        update();
      } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
        Get.dialog(AlertBox(msg: "Something went wrong..!!"));
      } else {
        Get.dialog(AlertBox(msg: "Something went wrong..!!"));
      }
    });
  }

  getData(List<GetMenuAuthData>? menuData) {
    for (var e in menuData!) {
      assignvalue(e.menuName!, e.authStatus == 'Y' ? true : false);
    }
  }

  List<GetMenuAuthData>? posBodymenuData = [];
  bool isLoadSave = false;
  updateMenuStatus() async {
    isLoadSave = true;
    posBodymenuData = [];
    update();
    if (valueUser != null) {
      for (var e in menuData!) {
        bool? val = setpostData(e.menuName!);
        posBodymenuData!.add(GetMenuAuthData(
            userKey: e.userKey,
            menuKey: e.menuKey,
            authStatus: val == true ? "Y" : "N",
            companyCode: e.companyCode,
            menuName: e.menuName));
      }
      await UpdateMenuAuthApi.call(posBodymenuData).then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          Get.dialog(AlertBox(msg: "Sucessfulluy Saved..!!"));
        } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
          Get.dialog(AlertBox(msg: "Not Saved Something went wrong..!!"));
        } else {
          Get.dialog(AlertBox(msg: "${onValue.message}"));
        }
      });
    } else {
      Get.dialog(AlertBox(msg: "Please Select User..!!"));
    }

    isLoadSave = false;
    update();
  }

  bool? setpostData(String type) {
    switch (type) {
      case 'SiteOut':
        return valueSiteOut;
      case 'LeaveRequest':
        return valueLeaveReq;

      case 'LeaveApproval':
        return valueLeaveApproval;
      case 'Collection':
        return valueCollection;
      case 'Settlement':
        return valueSettlement;
      case 'ScanQrCode':
        return valueScanQrCode;
      case 'Quotes':
        return valueQuotes;
      case 'Outstanding':
        return valueOutstanding;
      case 'SiteIn':
        return valueSitein;
      case 'Visitplane':
        return valueVistPlan;
      case 'DayStartEnd':
        return valueDayStartEnd;
      case 'Followup':
        return valueFollowup;
      case 'Accounts':
        return valueAccounts;
      case 'Orders':
        return valueOrder;
      case 'Leads':
        return valueLeads;
      case 'Walkins':
        return valueWalkins;
      case 'Enquiries':
        return valueEnquiry;
      case 'OfferZone':
        return valueOfferZone;
      case 'PriceList':
        return valuePriceList;
      case 'Stocks':
        return valueStocks;
      case 'Challenges':
        return valueChallenges;
      case 'Target':
        return valueTargets;
      case 'Performance':
        return valuePerformance;
      case 'Earnings':
        return valueEarnings;
      case 'ScoreCard':
        return valueScoreCard;
    }
    update();
    return null;
  }

  assignvalue(String type, bool val) {
    switch (type) {
      case 'SiteOut':
        changeState(SwitchBoxType.siteout, val);
        break;
      case 'LeaveRequest':
        changeState(SwitchBoxType.leavereq, val);
        break;

      case 'LeaveApproval':
        changeState(SwitchBoxType.leaveApprove, val);
        break;
      case 'Collection':
        changeState(SwitchBoxType.collection, val);
        break;
      case 'Settlement':
        changeState(SwitchBoxType.settlements, val);
        break;
      case 'ScanQrCode':
        changeState(SwitchBoxType.scanQr, val);
        break;
      case 'Quotes':
        changeState(SwitchBoxType.quotes, val);
        break;
      case 'Outstanding':
        changeState(SwitchBoxType.outstanding, val);
        break;
      case 'SiteIn':
        changeState(SwitchBoxType.siteIn, val);
        break;
      case 'Visitplane':
        changeState(SwitchBoxType.visitplan, val);
        break;
      case 'Followup':
        changeState(SwitchBoxType.daystartend, val);
        break;
      case 'Activities':
        changeState(SwitchBoxType.followup, val);
        break;
      case 'Accounts':
        changeState(SwitchBoxType.accounts, val);
        break;
      case 'Orders':
        changeState(SwitchBoxType.orders, val);
        break;
      case 'Leads':
        changeState(SwitchBoxType.leads, val);
        break;
      case 'Walkins':
        changeState(SwitchBoxType.walkins, val);
        break;
      case 'Enquiries':
        changeState(SwitchBoxType.enquiries, val);
        break;
      case 'OfferZone':
        changeState(SwitchBoxType.offerzone, val);
        break;
      case 'PriceList':
        changeState(SwitchBoxType.pricelist, val);
        break;
      case 'Stocks':
        changeState(SwitchBoxType.stocks, val);
        break;
      case 'Challenges':
        changeState(SwitchBoxType.challenges, val);
        break;
      case 'Target':
        changeState(SwitchBoxType.target, val);
        break;
      case 'Performance':
        changeState(SwitchBoxType.performance, val);
        break;
      case 'Earnings':
        changeState(SwitchBoxType.earnings, val);
        break;
      case 'ScoreCard':
        changeState(SwitchBoxType.scorecard, val);
        break;
    }
    update();
  }

  changeState(SwitchBoxType type, bool val) {
    switch (type) {
      case SwitchBoxType.enquiries:
        valueEnquiry = !valueEnquiry;
        update();
        break;
      case SwitchBoxType.leads:
        valueLeads = !valueLeads;
        update();
        break;
      case SwitchBoxType.orders:
        valueOrder = !valueOrder;
        update();
        break;
      case SwitchBoxType.followup:
        valueFollowup = !valueFollowup;
        update();
        break;
      case SwitchBoxType.walkins:
        valueWalkins = !valueWalkins;
        update();
        break;
      case SwitchBoxType.scanQr:
        valueScanQrCode = !valueScanQrCode;
        update();
        break;
      case SwitchBoxType.quotes:
        valueQuotes = !valueQuotes;
        update();
        break;
      case SwitchBoxType.stocks:
        valueStocks = !valueStocks;
        update();
        break;
      case SwitchBoxType.pricelist:
        valuePriceList = !valuePriceList;
        update();
        break;
      case SwitchBoxType.offerzone:
        valueOfferZone = !valueOfferZone;
        update();
        break;
      case SwitchBoxType.accounts:
        valueAccounts = !valueAccounts;
        update();
        break;
      case SwitchBoxType.outstanding:
        valueOutstanding = !valueOutstanding;
        update();
        break;
      case SwitchBoxType.collection:
        valueCollection = !valueCollection;
        update();
        break;
      case SwitchBoxType.settlements:
        valueSettlement = !valueSettlement;
        update();
        break;
      case SwitchBoxType.daystartend:
        valueDayStartEnd = !valueDayStartEnd;
        update();
        break;
      case SwitchBoxType.visitplan:
        valueVistPlan = !valueVistPlan;
        update();
        break;
      case SwitchBoxType.siteIn:
        valueSitein = !valueSitein;
        update();
        break;
      case SwitchBoxType.siteout:
        valueSiteOut = !valueSiteOut;
        update();
        break;
      case SwitchBoxType.leavereq:
        valueLeaveReq = !valueLeaveReq;
        update();
        break;
      case SwitchBoxType.leaveApprove:
        valueLeaveApproval = !valueLeaveApproval;
        update();
        break;
      case SwitchBoxType.scorecard:
        valueScoreCard = !valueScoreCard;
        update();
        break;
      case SwitchBoxType.earnings:
        valueEarnings = !valueEarnings;
        update();
        break;
      case SwitchBoxType.performance:
        valuePerformance = !valuePerformance;
        update();
        break;
      case SwitchBoxType.target:
        valueTargets = !valueTargets;
        update();
        break;
      case SwitchBoxType.challenges:
        valueChallenges = !valueChallenges;
        update();
        break;
    }
    update();
  }
}

enum SwitchBoxType {
  enquiries,
  leads,
  orders,
  followup,
  walkins,
  scanQr,
  quotes,
  stocks,
  pricelist,
  offerzone,
  accounts,
  outstanding,
  collection,
  settlements,
  daystartend,
  visitplan,
  siteIn,
  siteout,
  leavereq,
  leaveApprove,
  scorecard,
  earnings,
  performance,
  target,
  challenges
}
