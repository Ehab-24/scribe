import 'package:flutter/material.dart';

import '../../globals/Constants.dart';
import '../ui elements/colors.dart';
import '../widgets/icon_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/app_icon.png'),
                      ),
                      space10h,
                      const Text(
                        'Scribe',
                        style: TextStyle(
                          color: primaryDark,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  MIconButton(
                    onPressed: () {},
                    icon: Icons.settings,
                  ),
                  spaceh(16.0),
                  MIconButton(
                    onPressed: () =>
                        _pushReplacementRoute(context, '/my_words'),
                    icon: Icons.arrow_forward,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'Sweet Home',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Spacer(),
              const _SearchFeild(),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pushReplacementRoute(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }
}

class _SearchFeild extends StatefulWidget {
  const _SearchFeild({
    super.key,
  });

  @override
  State<_SearchFeild> createState() => _SearchFeildState();
}

class _SearchFeildState extends State<_SearchFeild> {
  bool isSelected = false;
  late final TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          alignment: Alignment.center,
          child: Icon(
            Icons.search,
            size: 24,
            color: isSelected ? primaryDark : Colors.black26,
          ),
        ),
        SizedBox(
          width: 260,
          child: TextField(
            controller: searchController,
            onTap: () => _setSelected(true),
            onTapOutside: (_) => _setSelected(false),
            onEditingComplete: _pushWordScreen,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          ),
        ),
        spaceh(50),
      ],
    );
  }

  void _setSelected(bool val) {
    if (!val) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    setState(() {
      isSelected = val;
    });
  }

  Future<void> _pushWordScreen() async {
    Navigator.of(context).pushNamed(
      '/word',
      arguments: searchController.text.trim().toLowerCase(),
    );
  }
}
