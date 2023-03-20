import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../keys.dart';
import '../services/network_helper.dart';

part "gallery_state.dart";

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(const GalleryInitial());

  Future<void> getPhotos() async {
    emit(GalleryLoading());

    List<String> images = [];
    String url = "https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> hitsList = data["hits"] as List;
    for (int i = 0; i < hitsList.length; i++) {
      images.add(hitsList[i]["largeImageURL"]);
    }

    emit(ImagesLoaded(images: images));
  }
}
