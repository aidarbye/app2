import 'package:flutter/material.dart';
import 'package:medimom/app/data/HostipalViewData.dart';
import 'package:medimom/app/domain/api/favorite.dart';
import 'package:medimom/app/domain/dto/clinic/response/ClinicResponse.dart';
import 'package:medimom/app/domain/dto/clinic/response/ClinicUserResponse.dart';

class HospitalWidget extends StatefulWidget {

  final ClinicUserResponse clinicData;
  final Function? onClick;

  const HospitalWidget({
    super.key,
    required this.clinicData,
    this.onClick
  });

  @override
  State<StatefulWidget> createState() => _HospitalWidget();

}

class _HospitalWidget extends State<HospitalWidget> {

  final _favoriteAPI = FavoriteAPI();

  late bool _isFavorite;

  void _favoriteClicked() {
    if (_isFavorite) {
      _favoriteAPI.removeClinic(widget.clinicData.clinic.id);
      setState(() {
        _isFavorite = false;
      });
    } else {
      _favoriteAPI.addClinic(widget.clinicData.clinic.id);
      setState(() {
        _isFavorite = true;
      });
    }
  }

  @override
  void initState() {
    _isFavorite = widget.clinicData.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18),
      child: InkWell(
        onTap: () {
          widget.onClick?.call();
        },
        child: SizedBox(
          height: 80,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 18),
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.clinicData.clinic.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.clinicData.clinic.name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      widget.clinicData.clinic.type,
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
                          widget.clinicData.clinic.address,
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
                          widget.clinicData.clinic.rating.toString(),
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
      ),
    );
  }


}