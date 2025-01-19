import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quraan_app/cubit/cubit/quraan_page_cubit.dart';
import 'package:quraan_app/cubit/cubit/quraan_page_state.dart';
import 'package:quraan_app/models/ayat_sour_model.dart';

class QuranPageView extends StatefulWidget {
  final List<AyatSour> quranData;
  final int initialIndex;

  const QuranPageView({super.key, required this.quranData, required this.initialIndex});

  @override
  State<QuranPageView> createState() => _QuranPageViewState();
}

class _QuranPageViewState extends State<QuranPageView> {
  double _fontSize = 26.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuranPageCubit()..setPage(widget.initialIndex),
      child: BlocBuilder<QuranPageCubit, QuranPageState>(
        builder: (context, state) {
          if (state is QuranPageLoaded) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Column(
                    children: [
                      Text(
                        ' ${widget.quranData[state.currentPage].name}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.format_list_numbered_rounded,
                            size: 14,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.quranData[state.currentPage].ayat} آية',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                ),
                body: PageView.builder(
                  controller: PageController(initialPage: state.currentPage),
                  itemCount: widget.quranData.length,
                  onPageChanged: (page) => context.read<QuranPageCubit>().setPage(page),
                  itemBuilder: (context, index) {
                    final surah = widget.quranData[index];
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(20, 120, 20, 80),
                      child: Column(
                        children: [
                          Card(
                            elevation: 2,
                            shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.secondary,
                                  ],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: -20,
                                    top: -20,
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: 60,
                                      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
                                    ),
                                  ),
                                  Positioned(
                                    right: -15,
                                    bottom: -15,
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: 50,
                                      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.15),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontSize: _fontSize + 4,
                                        height: 1.6,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
                                            offset: Offset(2, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Card(
                            elevation: 2,
                            shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                surah.displayqoran,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: _fontSize,
                                  height: 2.2,
                                ),
                                textAlign: TextAlign.justify,
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                floatingActionButton: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        heroTag: 'decrease',
                        onPressed: () {
                          setState(() {
                            if (_fontSize > 20) {
                              _fontSize -= 2;
                            }
                          });
                        },
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(Icons.text_decrease_rounded, color: Colors.white),
                      ),
                      SizedBox(width: 16),
                      FloatingActionButton(
                        heroTag: 'increase',
                        onPressed: () {
                          setState(() {
                            if (_fontSize < 40) {
                              _fontSize += 2;
                            }
                          });
                        },
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(Icons.text_increase_rounded, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
                strokeWidth: 2,
              ),
            ),
          );
        },
      ),
    );
  }
}
