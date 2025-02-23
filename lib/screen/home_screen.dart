import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// stateless -> stateful
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  // 미리 정의한 state 반환
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

// HomeScreenState 정의
class _HomeScreenState extends State<HomeScreen> {
  // page를 조작할 수 있는 PageController 생성
  final PageController _pageController = PageController();

  Timer? timer;   // 생명주기에서 timer 객체를 관리하기 위함

  // State객체가 초기화될때 Timer객체 생성
  @override
  void initState() {
    super.initState(); // 부모 initState() 실행

    timer = Timer.periodic(
      Duration(seconds: 3),
      (timer) {
        // 현재 페이지 가져오기: page는 중간이 있기 때문에 기본적으로 double 형
        int? currentPage = _pageController.page?.toInt();

        if(currentPage == null) return;

        // 마지막 페이지에 도착하면 첫번째로 이동
        if(currentPage == 4) {
          currentPage = 0;
        } else {  // 마지막 페이지가 아니라면 페이지 1 증가
          currentPage++;
        }

        // 페이지 변경 로직 : 이동할 페이지, 주기, 사용할 애니메이션
        _pageController.animateToPage(currentPage, duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
    );
  }

  @override
  void dispose() {
    if(timer != null) {
      timer?.cancel();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light); // 상태바 색상 변경(흰색으로)
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [1, 2, 3, 4, 5]
            .map(
              (number) => Image.asset(
                'asset/img/image_$number.jpeg',
                fit: BoxFit.cover,
              ),
            )
            .toList(),
      ),
    );
  }
}
