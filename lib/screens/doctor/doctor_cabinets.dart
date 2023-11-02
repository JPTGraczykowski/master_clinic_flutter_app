import 'package:flutter/material.dart';
import '../../models/cabinet.dart';
import '../../widgets/cabinet_list_item.dart';
import '../../utils/api_helper.dart';
import '../../widgets/screen_title.dart';

class DoctorCabinetsScreen extends StatefulWidget {
  const DoctorCabinetsScreen({
    super.key,
  });

  @override
  State<DoctorCabinetsScreen> createState() => _DoctorCabinetsScreenState();
}

class _DoctorCabinetsScreenState extends State<DoctorCabinetsScreen> {
  late Future<List<Cabinet>> _fetchedCabinets;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchedCabinets = fetchCabinets();
  }

  Future<List<Cabinet>> fetchCabinets() async {
    final url = ApiHelper.cabinetsIndex();
    final response = await ApiHelper.sendGetRequest(url);
    List<Cabinet> loadedCabinets = [];

    if (response == null || response.statusCode! >= 400) {
      onFailureFetchingData();
      return [];
    }

    Map<String, dynamic> responseData = response.data;

    for (Map<String, dynamic> jsonObject in responseData['data']) {
      Cabinet cabinet = Cabinet.fromJson(jsonObject['attributes']);
      loadedCabinets.add(cabinet);
    }

    return loadedCabinets;
  }

  void onFailureFetchingData() {
    setState(() {
      _error = 'Something went wrong. Please try again later.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(
          title: 'My Cabinets',
        ),
      ),
      body: FutureBuilder(
        future: _fetchedCabinets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(_error));
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('You have no Cabinets'));
          }

          final cabinets = snapshot.data!;

          return ListView.builder(
            itemCount: cabinets.length,
            prototypeItem: CabinetListItem(
              cabinet: cabinets.first,
            ),
            itemBuilder: (context, index) {
              return CabinetListItem(
                cabinet: cabinets[index],
              );
            },
          );
        },
      ),
    );
  }
}
