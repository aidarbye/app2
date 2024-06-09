import 'package:flutter/material.dart';
import 'package:medimom/app/data/DoctorViewData.dart';
import 'package:medimom/app/domain/api/favorite.dart';
import 'package:medimom/app/domain/dto/doctor/response/DoctorResponse.dart';

class DoctorWidget extends StatefulWidget {

  final DoctorResponse doctorData;
  final Function? onClick;

  const DoctorWidget({
    super.key,
    required this.doctorData,
    this.onClick
  });

  @override
  State<StatefulWidget> createState() => _DoctorWidget();
}

class _DoctorWidget extends State<DoctorWidget> {

  final _favoriteAPI = FavoriteAPI();

  late bool _isFavorite;

  void _favoriteClicked() {
    if (_isFavorite) {
      _favoriteAPI.removeDoctor(widget.doctorData.doctor.id);
      setState(() {
        _isFavorite = false;
      });
    } else {
      _favoriteAPI.addDoctor(widget.doctorData.doctor.id);
      setState(() {
        _isFavorite = true;
      });
    }
  }

  @override
  void initState() {
    _isFavorite = widget.doctorData.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18),
      child: InkWell(
        onTap: () {
          widget.onClick?.call(widget.doctorData);
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 18),
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.doctorData.doctor.imageUrl,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(
              height: 64,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.doctorData.doctor.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    widget.doctorData.doctor.type.name,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 12,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.black.withOpacity(0.6),
                        size: 12,
                      ),
                      Text(
                        widget.doctorData.doctor.clinic.clinic.name,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 12,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.normal
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            SizedBox(
              height: 64,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color.fromRGBO(0, 194, 8, 1),
                        size: 14,
                      ),
                      Text(
                        widget.doctorData.doctor.rating,
                        style: const TextStyle(
                            color: Color.fromRGBO(0, 194, 8, 1),
                            fontSize: 12,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: InkWell(
                      onTap: () {
                        _favoriteClicked();
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: const Color.fromRGBO(249, 126, 134, 1),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}