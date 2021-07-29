import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_movie_app/base/provider.dart';
import 'package:simple_movie_app/data/model/movie_model.dart';
import 'package:simple_movie_app/provider/details_screen_provider.dart';
import 'package:simple_movie_app/provider/home_provider.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final Results item;
  final HomeProvider previousModel;
  const DetailsScreen({
    Key? key,
    required this.title,
    required this.item,
    required this.previousModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<DetailsScreenProvider>(
        model: DetailsScreenProvider()..initData(previousModel, item),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                item.title!,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              backgroundColor: const Color(0xff253b49),
            ),
            backgroundColor: const Color(0xff0e212f),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      key: UniqueKey(),
                      cacheManager: previousModel.customCacheManager,
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500/${item.backdropPath!}',
                      placeholder: (context, url) => _buildPlaceHolder(
                          context, Colors.grey[600], Colors.black),
                      errorWidget: (context, url, error) => _buildPlaceHolder(
                          context, Colors.red, Colors.red[900]),
                      imageBuilder: (context, imageProvider) => Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
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
                                      color: Colors.white,
                                      shape: BoxShape.circle),
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
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Center(
                                      child: IconButton(
                                    onPressed: () {
                                      model.changeIcon(item);
                                    },
                                    icon: model.newModel.fav[item] == false
                                        ? const Icon(
                                            Icons.star_border,
                                            size: 35,
                                          )
                                        : const Icon(
                                            Icons.star,
                                            size: 35,
                                            color: Colors.yellow,
                                          ),
                                  )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: Text(
                          item.overview!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        )
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _buildPlaceHolder(context, color, colorIcon) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      color: color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: colorIcon, shape: BoxShape.circle),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: colorIcon, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
