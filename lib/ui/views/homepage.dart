import 'package:flutter/material.dart';
import 'package:gastrobluecheckapp/color.dart';
import 'package:gastrobluecheckapp/data/entity/role.dart';
import 'package:gastrobluecheckapp/ui/middleware/mainbuttons.dart';
import 'package:gastrobluecheckapp/ui/middleware/useroperation.dart';
import '../middleware/bottomnavigationbar.dart';
import '../middleware/notificationwidget.dart'; // NotificationWidget sınıfı dahil edildi
import 'package:gastrobluecheckapp/ui/views/hotpresentationui/hotpreassetinfoui.dart';
class Homepage extends StatefulWidget {
  final String username; // Kullanıcı adını alacak
  final Role userRole;

  const Homepage({required this.username, required this.userRole, Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  int _showButton = 0;

  final PageController _pageController = PageController(); // PageController oluşturuldu

  final NotificationWidget _notificationWidget = NotificationWidget(notificationText: ""); // NotificationWidget nesnesi

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showButton = index;
    });
    _pageController.jumpToPage(index); // Seçilen sayfaya geçiş yap
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index; // Kaydırarak geçiş yapılan sayfanın indeksini güncelle
    });
  }

  void _logout() {
    UserOperation().logout(context); // Logout işlemi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          "GASTROBLUE CHECK",
          style: TextStyle(
            color: bigWidgetColor,
            fontFamily: "bebasNeue",
            fontSize: 32,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Çıkış yap butonuna tıklandığında logout çağrılır
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
            child: SizedBox(
              height: 130,
              child: PageView(
                scrollDirection: Axis.horizontal,
                children: [
                  // Bildirim 1 - Hoş geldin mesajı (kullanıcı adıyla birlikte)
                  GestureDetector(
                    onTap: () {
                      _notificationWidget.showNotification1(widget.username);
                    },
                    child: NotificationWidget(notificationText: "Welcome, ${widget.username}!"),
                  ),

                  // Bildirim 2 - showNotification2 fonksiyonu çağrılır
                  GestureDetector(
                    onTap: () {
                      _notificationWidget.showNotification2();
                    },
                    child: NotificationWidget(notificationText: "Bildirim 2: Toplantı hatırlatıcısı!"),
                  ),

                  // Bildirim 3 - showNotification3 fonksiyonu çağrılır
                  GestureDetector(
                    onTap: () {
                      _notificationWidget.showNotification3();
                    },
                    child: NotificationWidget(notificationText: "Bildirim 3: Güncelleme mevcut!"),
                  ),
                ],
              ),
            ),
          ),

          // Kaydırılabilir butonlar alanı
          Expanded(
            child: PageView(
              controller: _pageController, // PageController burada kullanılıyor
              onPageChanged: _onPageChanged, // Sayfa değiştiğinde çağrılacak
              children: [
                // İlk sayfa butonları
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: [
                      if(widget.userRole.hotpre == 1)
                      CustomButton(text: "Hot Presentation", height: 60, icon: Icons.local_fire_department,id: 1),
                      if(widget.userRole.coldpre == 1)
                      CustomButton(text: "Cold Presentation", height: 80, icon: Icons.icecream,id: 2),
                      if(widget.userRole.disinf == 1)
                      CustomButton(text: "Disinfection", height: 70, icon: Icons.cleaning_services,id: 3),
                      if(widget.userRole.soak == 1)
                      CustomButton(text: "Soaking", height: 60, icon: Icons.local_drink,id: 4),
                      if(widget.userRole.candr == 1)
                      CustomButton(text: "Cool and Reheat", height: 90, icon: Icons.ac_unit,id: 5),
                      if(widget.userRole.receiving == 1)
                      CustomButton(text: "Receiving", height: 75, icon: Icons.check_circle,id: 6),
                    ],
                  ),
                ),
                // İkinci sayfa butonları
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: [
                      if(widget.userRole.disinf_list == 1)
                      CustomButton(text: "Disinfection", height: 60, icon: Icons.list_alt,id: 7),
                      if(widget.userRole.candr_list == 1)
                      CustomButton(text: "Cool and Reheat", height: 80, icon: Icons.list,id: 8),
                      if(widget.userRole.hotpre_list == 1)
                      CustomButton(text: "Hot Presentation", height: 70, icon: Icons.local_fire_department,id: 9),
                      if(widget.userRole.coldpre_list == 1)
                      CustomButton(text: "Cold Presentation", height: 60, icon: Icons.icecream,id: 10),
                      if(widget.userRole.receiving_firms == 1)
                      CustomButton(text: "Receiving Firms", height: 75, icon: Icons.business,id: 11),
                    ],
                  ),
                ),
                // Üçüncü sayfa butonları
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: [
                      if(widget.userRole.personnel == 1)
                      CustomButton(text: "Personnel", height: 70, icon: Icons.people,id: 12),
                      if(widget.userRole.buffedtimes == 1)
                      CustomButton(text: "Buffed Times", height: 80, icon: Icons.access_time,id: 13),
                      if(widget.userRole.roleconfig == 1)
                      CustomButton(text: "Role Config.", height: 60, icon: Icons.security,id: 14),
                      if(widget.userRole.reports == 1)
                      CustomButton(text: "Reports", height: 75, icon: Icons.report,id: 15),
                    ],
                  ),
                ),
                // Dördüncü sayfa butonları
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: [
                      if(widget.userRole.devices == 1)
                      CustomButton(text: "Devices", height: 70, icon: Icons.device_hub,id: 16),
                      if(widget.userRole.updateuser == 1)
                      CustomButton(text: "Update User", height: 80, icon: Icons.update,id: 17),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Alt gezinme çubuğuna tıklama olayını yönetir
      ),
    );
  }
}