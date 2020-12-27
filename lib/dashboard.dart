import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sahyadri_farms/search.dart';

List responseData;
var buyer;

class Crops {
  final String id;
  final String commodityName;
  final String photo;

  Crops({
    this.id,
    this.commodityName,
    this.photo,
  });
}

class Dashboard extends StatefulWidget {
  static const String id = 'dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final String apiUrl = "https://firebasestorage.googleapis.com/v0/b/vesatogofleet.appspot.com/o/androidTaskApp%2FbuyerList.json?alt=media&token=3dcc96c2-9309-4873-868d-bf0023f6266c";

  Future<List<dynamic>> fetchBuyers() async {
    var buyers = await http.get(apiUrl);
    buyer = json.decode(buyers.body);
    return buyer;
  }

  Future<List<Crops>> getCropsReq() async {
    String url = 'https://firebasestorage.googleapis.com/v0/b/vesatogofleet.appspot.com/o/androidTaskApp%2FcommodityList.json?alt=media&token=9b9e5427-8769-4dec-83c4-52afe727dbf9';
    final response = await http.get(url);

    responseData = json.decode(response.body);

    List<Crops> crops = [];
    for(var singleCrop in responseData) {
      Crops crop = Crops(
        id: singleCrop["id"],
        commodityName: singleCrop["commodityName"],
        photo: singleCrop["photo"],
      );
      crops.add(crop);
    }
    return crops;
  }

  @override
  Widget build(BuildContext context) {

    String _buyerName(dynamic buy) {
      return buy['buyerName'];
    }

    String _buyerPhoto(dynamic buy) {
      return buy['photo'];
    }

    String _crop(dynamic cropInfo) {
      return cropInfo['cropInfo']['crop'];
    }

    String _cropPhoto(dynamic cropInfo) {
      return cropInfo['cropInfo']['photo'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(color: Colors.black),), backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers:<Widget> [
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3.2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0, top: 15.0),
                          child: Text('What is your crop?', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 8.0, right: 15.0),
                          child: InkWell(
                            child: Card(
                              elevation: 3.0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.search, color: Colors.black38, size: 25.0,
                                    ),
                                    SizedBox(width: 10.0,),
                                    Text('Search Specific Crop', style: TextStyle(color: Colors.black38, fontSize: 15.0),),
                                  ],
                                ),
                              ),
                            ),
                            onTap: (){
                              showSearch(context: context, delegate: Search(responseData));
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.4,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return FutureBuilder(
                      future: getCropsReq(),
                      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      if(snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height / 4),
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                              elevation: 3.0,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 5.0,),
                                  Image.network('${snapshot.data[index].photo}', width: 20.0, height: 20.0,),
                                  SizedBox(width: 5.0,),
                                  Expanded(child: Text(snapshot.data[index].commodityName)),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      else{
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }
                    );
                  },
                  childCount: 1,
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1.5,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return FutureBuilder(
                        future: fetchBuyers(),
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          if(snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Text('Buyer', style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      SizedBox(height: 10.0,),
                                      Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                        elevation: 5.0,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Image.network(_buyerPhoto(snapshot.data[index]), width: 100.0, height: 100.0,),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Image.network(_cropPhoto(snapshot.data[index]), width: 10.0, height: 10.0,),
                                                      SizedBox(width: 5.0,),
                                                      Text(_crop(snapshot.data[index])),
                                                      SizedBox(width: 15.0,),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.location_pin, color: Colors.red.shade700,size: 11.0,),
                                                            SizedBox(width: 2.0,),
                                                            Text('21 km/45 mins', style: TextStyle(fontSize: 11.0),),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                    child: Text(_buyerName(snapshot.data[index]), style: TextStyle(fontWeight: FontWeight.bold),),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Card(
                                                        color: Colors.blue.shade50,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(buyer[index]['price'][0]['date'], style: TextStyle(fontSize: 12.0),),
                                                              Row(
                                                                children: [
                                                                  Text('₹', style: TextStyle(fontSize: 20.0),),
                                                                  Text(buyer[index]['price'][0]['price'], style: TextStyle(fontSize: 20.0),),
                                                                  Text(buyer[index]['price'][0]['sku'], style: TextStyle(fontSize: 8.0),),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        color: Colors.blue.shade50,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(buyer[index]['price'][1]['date'], style: TextStyle(fontSize: 12.0),),
                                                              Row(
                                                                children: [
                                                                  Text('₹', style: TextStyle(fontSize: 20.0),),
                                                                  Text(buyer[index]['price'][1]['price'], style: TextStyle(fontSize: 20.0),),
                                                                  Text(buyer[index]['price'][1]['sku'], style: TextStyle(fontSize: 8.0),),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        color: Colors.blue.shade50,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(buyer[index]['price'][2]['date'], style: TextStyle(fontSize: 12.0),),
                                                              Row(
                                                                children: [
                                                                  Text('₹', style: TextStyle(fontSize: 20.0),),
                                                                  Text(buyer[index]['price'][2]['price'], style: TextStyle(fontSize: 20.0),),
                                                                  Text(buyer[index]['price'][2]['sku'], style: TextStyle(fontSize: 8.0),),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          else{
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        }
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Text(_buyerName(snapshot.data[index])),
