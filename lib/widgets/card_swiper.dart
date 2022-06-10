import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/routes/routes.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: Swiper(
          itemCount: 3,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: getItemBuilder,
        ));
  }

  Widget getItemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.details,
          arguments: 'movie-instance'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: const FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage('https://via.placeholder.com/300x400'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
