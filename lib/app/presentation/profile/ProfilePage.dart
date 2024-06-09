import 'package:flutter/material.dart';
import 'package:medimom/app/domain/api/user.dart';
import 'package:medimom/app/domain/dto/user/response/ProfileResponse.dart';
import 'package:medimom/app/domain/provider/user_provider.dart';
import 'package:medimom/app/presentation/authorization/AuthorizationPage.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfilePage();
  }

}

class _ProfilePage extends State<ProfilePage> {

  final UserAPI _userAPI = UserAPI();
  ProfileResponse? _profile;
  bool _loading = true;

  void _loadProfile() {
    _userAPI.checkProfile().then((value) => _onLoaded(value));
  }

  void _onLoaded(ProfileResponse profile) {
    setState(() {
      _profile = profile;
      _loading = false;
    });
  }

  @override
  void initState() {
    _loadProfile();
    super.initState();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 40),
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.9],
                    colors: [Color.fromRGBO(249, 126, 134, 1), Colors.white],
                  )
              )
            ),
            Container(
              padding: EdgeInsets.only(top: ConstValue.topMargin, left: ConstValue.leftMargin, right: ConstValue.rightMargin),
              child:  Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_loading == false)
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (_profile?.name ?? "").isNotEmpty 
                                ? (_profile?.name ?? "")
                                : "Не указано имя",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                          if (_loading == false)
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (_profile?.iin ?? "").isNotEmpty 
                              ? (_profile?.iin ?? "")
                                : "Не указан иин",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Expanded(child: Container()),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 35),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Text(
                      "Политика конфиденциальности",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Rubik',
                        color: Colors.black,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: InkWell(
                      onTap: () {
                        _launchURL('https://t.me/MediMom_bot');
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Text(
                          "Телеграм бот",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Rubik',
                              color: Colors.black,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: EdgeInsets.only(bottom: ConstValue.bottomMargin),
                    child: InkWell(
                      onTap: () async {
                        final i = await SharedPreferences.getInstance();
                        i.clear();

                        UserProvider().setAuthToken(null).then((value) => {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
                            return const AuthorizationPage();
                          }), (route) => false)
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            const Text(
                              "Выйти",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Rubik',
                                  color: Color.fromRGBO(249, 126, 134, 1),
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 14),
                              child: const Icon(
                                Icons.logout_rounded,
                                color: Color.fromRGBO(249, 126, 134, 1),
                                size: 24,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      );
  }

}

