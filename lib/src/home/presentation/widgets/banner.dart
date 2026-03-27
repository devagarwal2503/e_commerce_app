import 'package:e_commerce_app/core/common/views/page_not_found.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: context.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                MediaResources.bannerImage,
                fit: BoxFit.fill,
                alignment: Alignment.bottomRight,
              ),
            ),

            // 2. Text Content Overlay
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '50-40% OFF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Now in (product)\nAll colours',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  UnconstrainedBox(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 150),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PageNotFound.routeName);
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ), // Control the "closeness" of the border
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  context.localText.shopNowText,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 130,
                  //   height: 40,
                  //   child: OutlinedButton(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, PageNotFound.routeName);
                  //     },
                  //     style: OutlinedButton.styleFrom(
                  //       side: const BorderSide(color: Colors.white, width: 2),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       padding: const EdgeInsets.symmetric(
                  //         // horizontal: 20,
                  //         vertical: 12,
                  //       ),
                  //     ),
                  // child: Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     SizedBox(
                  //       width: 100,
                  //       child: FittedBox(
                  //         fit: BoxFit.scaleDown,
                  //         child: Text(
                  //           context.localText.shopNowText,
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 12,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     // SizedBox(width: 8),
                  //     Icon(Icons.arrow_forward, color: Colors.white),
                  //   ],
                  // ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
