import 'package:flutter/material.dart';
import 'package:medimom/app/data/DoctorTypeViewData.dart';

class DoctorTypeWidget extends StatelessWidget {

  final DoctorTypeViewData doctorTypeViewData;
  final Function? onClick;

  const DoctorTypeWidget({
    super.key,
    required this.doctorTypeViewData,
    this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          onClick?.call();
        },
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(bottom: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromRGBO(249, 126, 134, 1)
                )
              ),
              child: Image.asset(
                doctorTypeViewData.imagePath,
                width: 30,
                height: 30,
              ),
            ),
            Text(
              doctorTypeViewData.name,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.normal,
                color: Colors.black.withOpacity(0.6)
              ),
            )
          ],
        ),
      ),
    );
  }


}