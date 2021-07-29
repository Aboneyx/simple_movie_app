import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_movie_app/base/provider.dart';
import 'package:simple_movie_app/data/model/movie_model.dart';
import 'package:simple_movie_app/provider/home_provider.dart';
import 'package:simple_movie_app/screens/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<HomeProvider>(
        model: HomeProvider()..init(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              backgroundColor: const Color(0xff253b49),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.white),
                  child: const Text('Clear Cache'),
                  onPressed: model.clearCache,
                )
              ],
            ),
            backgroundColor: const Color(0xff0e212f),
            body: model.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: SmartRefresher(
                      controller: model.refreshController,
                      enablePullUp: true,
                      enablePullDown: true,
                      header: const ClassicHeader(),
                      footer: const ClassicFooter(
                        loadStyle: LoadStyle.ShowWhenLoading,
                        completeDuration: Duration(milliseconds: 500),
                      ),
                      onRefresh: () async {
                        model.onRefresh();
                      },
                      onLoading: () async {
                        model.onLoading(context);
                      },
                      child: _buildList(context, model),
                    ),
                  ),
          );
        });
  }

  _buildList(context, model) {
    return ListView.builder(
        itemCount: model.results.length,
        itemBuilder: (context, index) {
          return _buildCase(
            context,
            model,
            model.fav[model.results[index]],
            model.results[index],
          );
        });
  }

  _buildCase(
    context,
    model,
    bool favorite,
    Results item,
  ) {
    String title = '${item.title}\n ${item.releaseDate}';
    double margin = 0.04 * MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(
                      title: title,
                      item: item,
                      previousModel: model,
                    )));
      },
      child: CachedNetworkImage(
        key: UniqueKey(),
        cacheManager: model.customCacheManager,
        imageUrl: 'https://image.tmdb.org/t/p/w500/${item.posterPath!}',
        placeholder: (context, url) => _buildPlaceHolder(context, margin),
        errorWidget: (context, url, error) =>
            _buildPlaceHolder(context, margin),
        imageBuilder: (context, imageProvider) => Container(
          height: MediaQuery.of(context).size.height * 0.7,
          margin: EdgeInsets.only(top: 8, left: margin, right: margin),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.9), BlendMode.dstATop),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        '${item.voteAverage}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: () {
                        model.changeIcon(item);
                      },
                      icon: !favorite
                          ? const Icon(
                              Icons.star_border,
                              size: 35,
                            )
                          : const Icon(
                              Icons.star,
                              size: 35,
                              color: Colors.yellow,
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset.zero,
                          color: Colors.black,
                          blurRadius: 10,
                        )
                      ],
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildPlaceHolder(context, margin) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      margin: EdgeInsets.only(top: 8, left: margin, right: margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff626262),
      ),
    );
  }
}
