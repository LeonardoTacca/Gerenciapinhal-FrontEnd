import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/maquinas/cadastro_de_maquinas_page.dart';
import 'package:gerencia_manutencao/ordem_manutencao/Lista_Ordem_Manutencao_Page.dart';
import 'package:gerencia_manutencao/pecas/cadastro_pecas_page.dart';
import 'package:gerencia_manutencao/usuarios/listagem_usuarios_page.dart';
import 'package:gerencia_manutencao/usuarios/usuario.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controllerTelas = PageController();
  SideMenuController sideMenu = SideMenuController();
  List<Widget> itensMenuWidget = [];
  List menuItems = [
    SideMenuItem(
      title: 'Dashboard',
      onTap: (index, sideMenuController) {
        sideMenuController.changePage(index);
      },
      icon: const Icon(Icons.home),
    ),
  ];
  @override
  void initState() {
    sideMenu.addListener((index) {
      controllerTelas.jumpToPage(index);
    });
    processMenuItems();
    super.initState();
  }

  processMenuItems() {
    if (UserData.cargo == Cargos.administradorGeral || UserData.cargo == Cargos.administradorManutencao) {
      menuItems.add(SideMenuItem(
        title: 'Gerenciamento de usuarios',
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
        icon: const Icon(Icons.settings),
      ));
    }
    if (UserData.cargo == Cargos.administradorGeral || UserData.cargo == Cargos.administradorManutencao) {
      menuItems.add(
        SideMenuItem(
          title: 'Cadastro de Peças',
          onTap: (index, sideMenuController) {
            sideMenuController.changePage(index);
          },
          icon: const Icon(Icons.settings),
        ),
      );
    }
    if (UserData.cargo == Cargos.administradorGeral || UserData.cargo == Cargos.administradorManutencao) {
      menuItems.add(
        SideMenuItem(
          title: 'Cadastro de Maquinas',
          onTap: (index, sideMenuController) {
            sideMenuController.changePage(index);
          },
          icon: const Icon(Icons.settings),
        ),
      );
    }
    menuItems.add(
      SideMenuItem(
        title: 'Ordens de serviço',
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
        icon: const Icon(Icons.settings),
      ),
    );
    menuItems.add(
      SideMenuItem(
        title: 'Sair',
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
        icon: const Icon(Icons.settings),
      ),
    );
    processMenuWidgets();
  }

  processMenuWidgets() {
    if (UserData.cargo == Cargos.administradorGeral || UserData.cargo == Cargos.administradorManutencao) {
      itensMenuWidget.add(const ListaUsuariosPage());
    }
    if (UserData.cargo == Cargos.administradorGeral || UserData.cargo == Cargos.administradorManutencao) {
      itensMenuWidget.add(const CadastroPecasPage());
    }
    if (UserData.cargo == Cargos.administradorGeral || UserData.cargo == Cargos.administradorManutencao) {
      itensMenuWidget.add(const CadastroMaquinasPage());
    }
    itensMenuWidget.add(const ListaOrdensManutencaoPageWrapper());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SideMenu(
                controller: sideMenu,
                style: SideMenuStyle(backgroundColor: Colors.white),
                onDisplayModeChanged: (mode) {
                  print(mode);
                },
                items: menuItems,
              ),
              Expanded(
                child: PageView(
                  controller: controllerTelas,
                  children: [
                    const Center(
                      child: Text('Dashboard'),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) => itensMenuWidget[index],
                      itemCount: itensMenuWidget.length,
                    ),
                    const Center(
                      child: Text('Exit'),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
