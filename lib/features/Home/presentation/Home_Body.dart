import 'package:flutter/cupertino.dart';
import 'package:to_do/features/Home/presentation/Button_navbar.dart';
import 'package:to_do/features/Home/presentation/Notes_List_View.dart';
import 'package:to_do/features/Home/presentation/Selected_button_navbar.dart';
import '../../Add_Note/presentation/Add_note_grid.dart';
import 'Home_Header.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool isAnyCardActive = false;

  void _handleNoteCardActiveState(bool isActive) {
    setState(() {
      isAnyCardActive = isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [

            for (var category in AddNoteGrid.noteTypes) ...[
              SliverToBoxAdapter(
                child: HomeHeader(text: category.title),
              ),
              SliverToBoxAdapter(
                child: NotesListView(
                  categoryIndex: category.categoryIndex,
                  onNoteCardActiveStateChanged: _handleNoteCardActiveState,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20), // Space between categories
              ),
            ],
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            ),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          top: MediaQuery.sizeOf(context).height * 0.86,
          child: isAnyCardActive ? SelectedButtonNavbar() : ButtonNavbar(),
        ),
      ],
    );
  }
}
