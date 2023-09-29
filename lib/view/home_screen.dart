import 'package:flutter/material.dart';
import 'package:mvvm_provider/utils/routes/routes_name.dart';
import 'package:mvvm_provider/utils/utils.dart';
import 'package:mvvm_provider/view_model/home_view_model.dart';
import 'package:mvvm_provider/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    HomeViewViewModel homeViewViewModel = HomeViewViewModel();

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewViewModel.fetchMoviesListApi();
  }

  @override
  Widget build(BuildContext context) {

    final userPreferences = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [

          Center(
            child: InkWell(
                onTap: (){
                  userPreferences.remove().then((value){
                    Navigator.pushNamed(context, RoutesName.login);
                  });
                },
                child: Text("Logout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(builder: (context, value, child){
          switch(value.moviesList.status){
            case Status.LOADINNG:
              return Center(child: CircularProgressIndicator());
              
            case Status.ERROR:
              return Center(child: Text(value.moviesList.message.toString()));

            case Status.COMPLETED:
              return ListView.builder(
                itemCount: value.moviesList.data!.movies!.length,
                  itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    leading: Image.network(value.moviesList.data!.movies![index].posterurl.toString(),
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack){
                      return Icon(Icons.error, color: Colors.red,);
                  },
                    ),
                    title: Text(value.moviesList.data!.movies![index].title.toString()),
                    subtitle: Text(value.moviesList.data!.movies![index].year.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(Utils.averageRating(value.moviesList.data!.movies![index].ratings!).toStringAsFixed(1)),
                      Icon(Icons.star, color: Colors.yellow,)
                    ],
                  ),
                  ),
                );
              });
          }
          return Container();
        },),
      )
    );
  }
}

