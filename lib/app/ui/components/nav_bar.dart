import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:konsi_test/app/core/common/constants/app_assets.dart';
import 'package:konsi_test/app/core/common/constants/app_colors.dart';
import 'package:konsi_test/app/core/common/extensions/context_extension.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.index,
    required this.onDestinationSelected,
  });

  final int index;
  final void Function(int) onDestinationSelected;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Duration duration = 300.ms;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFFB4B4B4).withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: NavigationBar(
        elevation: 0,
        shadowColor: Colors.black,
        backgroundColor: context.colorScheme.secondaryContainer,
        selectedIndex: widget.index,
        onDestinationSelected: widget.onDestinationSelected,
        animationDuration: duration,
        destinations: <Widget>[
          _buildDestination('Mapa', AppAssets.svgs.map_icon),
          _buildDestination('Caderneta', AppAssets.svgs.passbook_icon),
        ],
      ),
    );
  }

  Widget _buildDestination(String name, String path) {
    return NavigationDestination(
      icon: SvgPicture.asset(
        path,
        colorFilter: const ColorFilter.mode(
          AppColors.grey_500,
          BlendMode.srcIn,
        ),
      ),
      label: name,
      selectedIcon: SvgPicture.asset(
        path,
        colorFilter: ColorFilter.mode(
          context.colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
