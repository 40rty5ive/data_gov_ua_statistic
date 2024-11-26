import 'package:data_gov_ua_statistic/cubit/main_cybit_cubit.dart';
import 'package:data_gov_ua_statistic/screens/difference_table.dart';
import 'package:data_gov_ua_statistic/screens/graph_frame.dart';
import 'package:data_gov_ua_statistic/screens/records_talble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCybitCubit()..init(),
      lazy: false,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCybitCubit, MainCybitState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Foreign goods trade'),
          ),
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.all,
                destinations: const <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('All'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.bar_chart),
                    selectedIcon: Icon(Icons.stacked_bar_chart),
                    label: Text('Graph'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.arrow_forward),
                    selectedIcon: Icon(Icons.arrow_forward),
                    label: Text('Dynamic'),
                  ),
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverToBoxAdapter(
                        child: (_selectedIndex == 0)
                            ? RecordsTalble(data: state.data)
                            : (_selectedIndex == 1)
                                ? GraphFrame(data: state.data)
                                : DifferenceTable(data: state.data),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
