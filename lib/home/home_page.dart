import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/maquinas/cadastro_de_maquinas_page.dart';
import 'package:gerencia_manutencao/ordem_manutencao/Lista_Ordem_Manutencao_Page.dart';
import 'package:gerencia_manutencao/pecas/cadastro_pecas_page.dart';
import 'package:gerencia_manutencao/usuarios/listagem_usuarios_page.dart';

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
        title: 'Cadastro de Peças',
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
        icon: const Icon(Icons.settings),
      ),
      SideMenuItem(
        title: 'Cadastro de Maquinas',
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
        icon: const Icon(Icons.settings),
      ),
      SideMenuItem(
        title: 'Ordens de manutenção',
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
                      child: Text('Dashboard'),
                    ),
                    ListaUsuariosPage(),
                    CadastroPecasPage(),
                    CadastroMaquinasPage(),
                    ListaOrdensManutencaoPageWrapper(),
                    Center(
                      child: Text('Exit'),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
