import 'package:flutter/material.dart';
import 'SearchableList_model.dart'; // Import the model file in lowercase

class SearchableListWidget extends StatefulWidget {
  const SearchableListWidget({Key? key}) : super(key: key);

  @override
  State<SearchableListWidget> createState() => _SearchableListWidgetState();
}

class _SearchableListWidgetState extends State<SearchableListWidget> {
  late SearchableListModel _model;

  @override
  void initState() {
    super.initState();
    _model = SearchableListModel(); // Instantiate the model
    _model.fetchClients(); // Fetch clients when initializing
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Clients')),
      body: Column(
        children: [
          TextField(
            onChanged: (query) => _model.searchClients(query),
            decoration: InputDecoration(labelText: 'Search Clients'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _model.filteredClients.length,
              itemBuilder: (context, index) {
                final client = _model.filteredClients[index];
                return ListTile(
                  title: Text(client['name']),
                  subtitle: Text('UID: ${client['uid']}'),
                  onTap: () {
                    // Handle client tap (e.g., open workout page)
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
