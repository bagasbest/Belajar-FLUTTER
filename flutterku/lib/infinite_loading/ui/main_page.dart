import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterku/infinite_loading/bloc/post_bloc.dart';
import 'package:flutterku/infinite_loading/ui/post_item.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController controller = ScrollController();

  PostBloc bloc;

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;

    if (currentScroll == maxScroll) {
      bloc.add(PostEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<PostBloc>(context);
    controller.addListener(onScroll);

    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite List Loading"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostUninitialized) {
              return Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              PostLoaded postLoaded = state as PostLoaded;
              return ListView.builder(
                  controller: controller,
                  itemCount: (postLoaded.hasReachedMax)
                      ? postLoaded.posts.length
                      : postLoaded.posts.length + 1,
                  itemBuilder: (context, index) =>
                      (index < postLoaded.posts.length)
                          ?
                          // Text(
                          // postLoaded.posts[index].title,
                          // textAlign: TextAlign.justify,
                          // )
                          PostItem(postLoaded.posts[index])
                          : Center(
                              child: Container(
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ));
            }
          },
        ),
      ),
    );
  }
}
