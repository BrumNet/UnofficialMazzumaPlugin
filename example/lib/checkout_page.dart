import 'package:flutter/material.dart';
import 'package:unofficial_mazzuma_plugin/unofficial_mazzuma_plugin.dart';

class CheckOutPage extends StatelessWidget {


  final amountController = TextEditingController();
  final numberController = TextEditingController();
  final UnofficialMazzumaPlugin mazzumaPlugin = new UnofficialMazzumaPlugin();

  @override
  Widget build(BuildContext context) {
    String isSelected;
    return Scaffold(
      appBar: AppBar(
        title: Text('checkout'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  'Payment was: ',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: Text('Enter Payment Info',
                              style: TextStyle(
                                fontFamily: 'Champagne_Limousines',
                              )),
                          content: SingleChildScrollView(
                            child: Container(
                              height: 300.0,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                verticalDirection: VerticalDirection.down,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          16.0, 10.0, 16.0, 10.0),
                                      child: DropdownButton(
                                          iconSize: 45.0,
                                          items: <String>[
                                            'MTN',
                                            'VODAFONE',
                                            'AIRTELTIGO'
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String value) {
                                            isSelected = value;
                                          })),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16.0, 10.0, 16.0, 10.0),
                                    child: TextField(
                                      controller: amountController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter Amount ',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Champagne_Limousines',
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16.0, 10.0, 16.0, 10.0),
                                    child: TextField(
                                      controller: numberController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter Your Phone number',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Champagne_Limousines',
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16.0, 5.0, 16.0, 10.0),
                                    child: ButtonTheme(
                                      buttonColor:
                                          Theme.of(context).primaryColor,
                                      minWidth: double.infinity,
                                      height: 45.0,
                                      child: MaterialButton(
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () async {
                                          String apiKey = 'API-KEY-HERE';
                                          if (isSelected == "VODAFONE"){
                                          String token = "TOKEN HERE";//Paying with Vodafone. Costumer must generate token from USSD. Dial *110#; Select Option 4 Select Option *Enter Vod Cash Pin *Check SMS
                                          mazzumaPlugin.vicVodPay( numberController.text, "MTN", "0246346343" ,double.parse(amountController.text),apiKey, token);
                                        }
                                        else{
                                           mazzumaPlugin.sunuPay(isSelected, numberController.text, "MTN", "0246346343",double.parse(amountController.text),apiKey);

                                        }
                                        },
                                        child: Text(
                                          'Process Payment',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily:
                                                  'Champagne_Limousines'),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )));
                },
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.all(16.0),
                child: Text('Make Payment'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
