import 'dart:async';

import 'package:dio/dio.dart';

class UnofficialMazzumaPlugin {
  Response response;

  
sunuPay(String userNetwork, String userNumber, String recieverNetwork, String recieverNumber,double paymentAmount,String apiKey) async {

String paymentOption; 
if (userNetwork != "VODAFONE") {
  paymentOption = paymentOptionSunuPlug(userNetwork,recieverNetwork);
  String response = await processPayment(paymentAmount, userNetwork, recieverNumber, userNumber, paymentOption, apiKey);
  return response;
  } else{ return "Error: Use vicVodPay() instead"; }
}

String paymentOptionSunuPlug(userNetwork,recieverNetwork){
  String paymentOption;

   if (userNetwork == "AIRTELTIGO") {
     recieverNetwork == "MTN" ? paymentOption = "ratm" : recieverNetwork == "VODAFONE" ? paymentOption = "ratv" : paymentOption = "rata";
    } else if (userNetwork == "MTN") {
      recieverNetwork == "AIRTEL" ? paymentOption = "rmta" : recieverNetwork == "VODAFONE" ? paymentOption = "rmtv" : paymentOption = "rmtm";
    } else {
      paymentOption = "error";
    }

     return paymentOption;
}


//Paying with Vodafone. Costumer must generate token from USSD. Dial *110#; Select Option 4 Select Option *Enter Vod Cash Pin *Check SMS
vicVodPay(String userNumber, String recieverNetwork, String recieverNumber,double paymentAmount,String apiKey, String token) async {
String userNetwork = "VODAFONE";
String paymentOption = paymentOptionVicPlug(recieverNetwork);

String response = await processPayment2(paymentAmount, userNetwork, recieverNumber, userNumber, paymentOption, apiKey,token);
  return response;
}

String paymentOptionVicPlug(recieverNetwork){
  String paymentOption;

  recieverNetwork == "AIRTEL" ? paymentOption = "rvta" : recieverNetwork == "VODAFONE" ? paymentOption = "rvtv" : paymentOption = "rvtm";
   
return paymentOption;
}




  Future<String> processPayment(
      double price, ///The amount to be paid
      String network, ///This is the network of the mobile money account that would be making the payment (your customer)
      String recipientNumber, ///This is the mobile money account the payments shall end up in. (your account).
      String sender, ///This is the mobile money account that would be making the payment (your customers)
      String option, ///This denotes the direction of cash flow. For example, rmta can be understood as an acronym of the phrase ‘receive mtn to airtel’, which means you would be receiving money to your Airtel account (the recipient number) from an MTN number(the sender). This format would hold for all transaction requests sent to the API. Do not forget to append the r at beginning
      String apiKey ///The API key generated when you created the Mazzuma Business account. This can be accessed or changed via the web dashboard.
      ) async {
    BaseOptions options = BaseOptions(
      baseUrl: "https://client.teamcyst.com",
    );
    
    Dio dio = new Dio(options);

    response = await dio.post("/api_call.php", data: {
      "price": price,
      "network": network,
      "recipient_number": recipientNumber,
      "sender": sender,
      "option": option,
      "apikey": apiKey,
    });
    String _response = response.data.toString();

     if(_response.contains("Successful")){ return "Success: ${response.data}";}
     else if(_response.contains("Failed")){return  "Failed: ${response.data}";}
     else if(response.data.toString().contains("Pending")){return "Pending: ${response.data}";}
     else{return "Error occurred: ${response.data}";}
  }

  Future<String> processPayment2(
      double price, ///The amount to be paid
      String network, ///This is the network of the mobile money account that would be making the payment (your customer)
      String recipientNumber, ///This is the mobile money account the payments shall end up in. (your account).
      String sender, ///This is the mobile money account that would be making the payment (your customers)
      String option, ///This denotes the direction of cash flow. For example, rmta can be understood as an acronym of the phrase ‘receive mtn to airtel’, which means you would be receiving money to your Airtel account (the recipient number) from an MTN number(the sender). This format would hold for all transaction requests sent to the API. Do not forget to append the r at beginning
      String apiKey, ///The API key generated when you created the Mazzuma Business account. This can be accessed or changed via the web dashboard.
      String token //Paying with Vodafone. Costumer must generate token from USSD. Dial *110#; Select Option 4 Select Option *Enter Vod Cash Pin *Check SMS
       ) async {
    BaseOptions options = BaseOptions(
      baseUrl: "https://client.teamcyst.com",
    );

    Dio dio = new Dio(options);

    response = await dio.post("/api_call.php", data: {
      "price": price,
      "network": network,
      "recipient_number": recipientNumber,
      "sender": sender,
      "option": option,
      "apikey": apiKey,
      "token": token,
    });

    String _response = response.data.toString();

     if(_response.contains("Successful")){ return "Success: ${response.data}";}
     else if(_response.contains("Failed")){return  "Failed: ${response.data}";}
     else if(response.data.toString().contains("Pending")){return "Pending: ${response.data}";}
     else{return "Error occurred: ${response.data}";}
  

  }

  ///This plugin can be used by importing and initialise it then provide the required parameters
///import 'package:unofficial_mazzuma_plugin/unofficial_mazzuma_plugin.dart';
///
///UnofficialMazzumaPlugin mazzumaPlugin = UnofficialMazzumaPlugin();
///
///CustomResponse customResponse = mazzumaPlugin.processPayment(paymentAmount, userNetwork, myNumber, userNumber, paymentOption, myApiKey);
}
