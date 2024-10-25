import 'package:adv_flutter_final_exam/modal/expense_modal.dart';
import 'package:adv_flutter_final_exam/views/component/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/expense_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<ExpenseProvider>(context);
    var providerFalse = Provider.of<ExpenseProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 35,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Expanded(
                child: MyTextField(
                  onChanged: (value) {
                    providerFalse.getSearch(value);
                  },
                  controller: providerTrue.txtSearch,
                  label: 'Search',
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: providerFalse.getCategoryExpense(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                providerTrue.searchListCategory = providerTrue.searchList
                    .map(
                      (e) => ExpenseModal.fromMap(e),
                    )
                    .toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: providerTrue.searchListCategory.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Text(
                          providerTrue.searchListCategory[index].id.toString()),
                      title: Text(providerTrue.searchListCategory[index].title),
                      subtitle:
                          Text(providerTrue.searchListCategory[index].category),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(providerTrue.searchListCategory[index].amount),
                          const VerticalDivider(),
                          Text(
                              '${providerTrue.searchListCategory[index].date} PM'),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
