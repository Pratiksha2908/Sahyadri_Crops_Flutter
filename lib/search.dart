import 'package:flutter/material.dart';

class Search extends SearchDelegate {

  @override
  String get searchFieldLabel => "Search specific crop";

  final List commodityList;

  Search(this.commodityList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? commodityList
        : commodityList
        .where((element) =>
        element['commodityName'].toString().toLowerCase().startsWith(query))
        .toList();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 4),
      ),
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 3.0,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 5.0,),
              Image.network(suggestionList[index]['photo'], width: 20.0, height: 20.0,),
              SizedBox(width: 5.0,),
              Expanded(child: Text(suggestionList[index]['commodityName'])),
            ],
          ),
        );
      },
    );
  }
}