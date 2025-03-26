import 'dart:io';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controllerTelas = PageController();
  SideMenuController sideMenu = SideMenuController();
  @override
  void initState() {
    sideMenu.addListener((index) {
      controllerTelas.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List items = [
      SideMenuItem(
        title: 'Dashboard',
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
        icon: const Icon(Icons.home),
      ),
      SideMenuItem(
        title: 'Gerenciamento de usuarios',
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
        icon: const Icon(Icons.settings),
      ),
      SideMenuItem(
        title: 'Gerenciamento de maquinas',
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
        icon: const Icon(Icons.settings),
      ),
    ];
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.red[200],
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SideMenu(
                controller: sideMenu,
                style: SideMenuStyle(backgroundColor: Colors.white),
                onDisplayModeChanged: (mode) {
                  print(mode);
                },
                items: items,
              ),
              Expanded(
                child: PageView(
                  controller: controllerTelas,
                  children: const [
                    Center(
                      child: Text('Bem vindo ao gerenciador de manutenção'),
                    ),
                    Center(
                      child: Text('Exit'),
                    ),
                    Center(
                      child: Text('Exit'),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
