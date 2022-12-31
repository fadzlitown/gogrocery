import 'package:flutter/material.dart';

import '../services/Utils.dart';
import '../widgets/feed_item_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);
  static const routeName = "/FeedScreen";

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode  _searchTextFocusNode = FocusNode();


  @override
  void dispose() {
    super.dispose();
    _searchTextFocusNode.dispose();
    _searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);
    bool _isListEmpty = false;

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: util.color),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('All Products',
                style: TextStyle(
                    color: !util.isDarkTheme ? Colors.black87 : Colors.white)),
            backgroundColor:
            util.isDarkTheme ? Theme
                .of(context)
                .cardColor : Colors.white),
        body: _isListEmpty
            ? Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/box.png',
                      height: util.getMediaSize.height * 0.20),
                  Text(
                    'No product on sale yet!',
                    style: TextStyle(
                        color: util.color,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )
                ]),
          ),
        )
            : SingleChildScrollView(
          child: Column( //todo --> if column hold more than 1 widget required list as scrolling, then wrapped with SingleChildScroll
              children: [
                SizedBox(height: util.getMediaSize.height*0.04 ),
                TextFormField(
                  focusNode: _searchTextFocusNode,
                    controller: _searchTextController,
                    decoration: InputDecoration(labelText: 'Search Now',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.greenAccent, width: 1) ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.greenAccent, width: 1) ),
                    hintText: "What's in your mind?",
                    prefixIcon: const Icon(Icons.search),
                    suffix:  IconButton(onPressed: () {
                      _searchTextController.clear();
                      _searchTextFocusNode.unfocus();
                    }, icon: Icon(Icons.close, color: _searchTextFocusNode.hasFocus? Colors.red : util.color))
                    // suffixIcon: const Icon(Icons.close)
                    ),
                    onChanged: (val) {
                      setState(() {

                      });
                    }),
                SizedBox(height: util.getMediaSize.height*0.04),
                GridView.count(
                  ///todo If this widget handling single list, then remove physics & shrinkWrap otherwise used them
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(5),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio:
                    util.getMediaSize.width / (util.getMediaSize.height * 0.59),
                    //todo if any child having out bound pixel, hence, adjusting mediaSize & ratio are required!!
                    children: List.generate(10, (index) {
                      return FeedItemWidget(
                        salePrice: 2,
                        price: 5.00,
                        textPrice: "1",
                        isOnSale: true,
                      );
                    })),
              ]
          ),
        ));
  }
}
