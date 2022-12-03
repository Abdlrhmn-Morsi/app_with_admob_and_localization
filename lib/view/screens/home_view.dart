import 'package:admob_localization_app/data/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/ad_helper.dart';
import '../../logic/change_lang_cubit/change_lang_cubit.dart';
import '../../logic/test_counter_bloc/counter_cubit.dart';
import '../../logic/test_counter_bloc/counter_state.dart';
import '../widgets/banner_ad_widget .dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    InterstitialAdFunc.load();
    RewardedAdUnitFunc.load();
    super.initState();
  }

  String chosenLang = 'Chose lang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Text(
          'app_title'.tr(context),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red.shade900,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Localization',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          DropdownButton(
            hint: Text(chosenLang),
            items: ['en', 'ar']
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text('$e'),
                    ))
                .toList(),
            onChanged: (val) {
              chosenLang = val!;
              ChangeLangCubit.get(context).saveChoseLange(val);
            },
          ),
          Text('hello_msg'.tr(context)),
          const SizedBox(height: 50),
          const Center(child: BannerAdWidget()),
          const SizedBox(height: 50),
          MaterialButton(
            color: Colors.red.shade900,
            onPressed: () {
              InterstitialAdFunc.load();
              InterstitialAdFunc.show();
            },
            child: const Text(
              'Interstitial  Ad',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            color: Colors.black,
            onPressed: () {
              RewardedAdUnitFunc.load();
              RewardedAdUnitFunc.show();
            },
            child: const Text(
              'rewarded  Ad',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            'unit test',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<CounterCubit, CounterState>(
            builder: (context, state) {
              return Text(
                '${state.counterValue}',
                style: const TextStyle(
                  color: Colors.black,
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Colors.black,
                onPressed: () {
                  CounterCubit.get(context).counterIncrement();
                },
                child: const Text(
                  '+',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.black,
                onPressed: () {
                  CounterCubit.get(context).counterDecrement();
                },
                child: const Text(
                  '-',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
