import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:equatable/equatable.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  const PageContent.first()
    : this(
        image: MediaResources.onBoardingOne,
        title: "Choose Products",
        description:
            "Dive into an extensive collection of high-quality products curated specifically to match your lifestyle.",
      );
  const PageContent.second()
    : this(
        image: MediaResources.onBoardingTwo,
        title: "Make Payment",
        description:
            "Enjoy complete peace of mind with our military-grade encrypted payment gateway. Choose from a wide variety of trusted options including credit cards, UPI, and digital wallets.",
      );
  const PageContent.third()
    : this(
        image: MediaResources.onBoardingThree,
        title: "Get Your Order",
        description:
            "Experience the joy of lightning-fast delivery right to your doorstep. Track your package in real-time from our warehouse to your home.",
      );

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
