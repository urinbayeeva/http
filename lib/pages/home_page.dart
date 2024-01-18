import 'dart:developer';

import 'package:crud_http/models/person_model.dart';
import 'package:crud_http/services/ntw_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  late List<Person> personModel;

  Future<void> getAllData() async {
    String result = await NetworkService.GET(NetworkService.apiGetAllData);

    personModel = personFromJson(result) as List<Person>;
    setState(() {});
  }

  Future<void> deleteData(int id) async {
    String result =
    await NetworkService.DELETE(NetworkService.apiDeleteData, id);
    log(result);
    if (result == "200" || result == "201") {
      log(result);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${id.toString()} Successfully deleted")));
    }
    await getAllData();
    setState(() {});
  }

  @override
  void initState() {
    getAllData().then((value) {
      isLoading = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "HTTP",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: isLoading
            ? ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (_, index) {
            var item = personModel[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Column(
                children: [
                  Text("Friends: ${item.friends}"),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Profession: ${item.profession}"),
                  Text(
                      " Company Branch ${item.profession.companyBranches}"),
                  Text(" Salary ${item.profession.salary}"),
                  Text("TYPE ${item.profession.type}"),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(CupertinoIcons.delete),
                onPressed: () async {
                  await deleteData(int.parse(item.name));
                },
              ),
            );
          },
          separatorBuilder: (_, index) {
            return const Divider();
          },
          itemCount: personModel.length,
        )
            : const Center(
          child: CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.plus_one),
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                30.0),
          ),
        ));
  }
}
