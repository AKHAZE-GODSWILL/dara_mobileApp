import 'package:flutter/material.dart';

class PaginationExample extends StatefulWidget {
  @override
  _PaginationExampleState createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample> {
  ScrollController _scrollController = ScrollController();
  List<String> items = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchData(); // Initially load data
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (!isLoading) {
        _fetchData();
      }
    }
  }

  void _fetchData() {
    setState(() {
      isLoading = true;
    });

    // Simulate an API request for more data
    Future.delayed(Duration(seconds: 2), () {
      final newData = List.generate(20, (index) => 'Item ${items.length + index}');
      setState(() {
        items.addAll(newData);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination Example'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < items.length) {
            return ListTile(
              title: Text(items[index]),
            );
          }
          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox(); // Return an empty container for the "Load More" indicator
        },
      ),
    );
  }
}
