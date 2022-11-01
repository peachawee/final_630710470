
import 'package:flutter/material.dart';
import 'package:nutthipat/models/team_item.dart';
import 'package:nutthipat/services/api.dart';

class VotePage extends StatefulWidget {
  const VotePage({Key? key}) : super(key: key);

  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  List<TeamItem>? _teamList;
  var _isLoading = false;
  String? _errMessage;

  @override
  void initState() {
    super.initState();
    _fetchTeamData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 135.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset('assets/images/logo.jpg',height: 110, width: double.infinity,),
              ),
            ),

            // Column(
            //   children: [
            //     Expanded(
            //       child: Stack(
            //         children: [
            //           if (_teamList != null)
            //             ListView.builder(
            //               itemBuilder: _buildListItem,
            //               itemCount: _teamList!.length,
            //             ),
            //           if (_isLoading)
            //             const Center(child: CircularProgressIndicator()),
            //           if (_errMessage != null && !_isLoading)
            //             Center(
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.all(24.0),
            //                     child: Text(_errMessage!),
            //                   ),
            //                   ElevatedButton(
            //                     onPressed: () {
            //                       _fetchTeamData();
            //                     },
            //                     child: const Text('RETRY'),
            //                   )
            //                 ],
            //               ),
            //             ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),

          ],


        ),
      ),
    );
  }

  void _fetchTeamData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var data = await Api().fetch('fifa');
      setState(() {
        _teamList = data
            .map<TeamItem>((item) => TeamItem.fromJson(item))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    var teamItem = _teamList![index];

    return Card(
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Image.network(
              teamItem.image,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Text(teamItem.name),
          ],
        ),
      ),
    );
  }

}
