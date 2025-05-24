import 'package:flutter/material.dart';

import '../screen/Homepage/widget/draggablescrollablesheet.dart';

class SearchBarField extends StatelessWidget {
  final bool showIcon;
  const SearchBarField({super.key, required this.showIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const Icon(Icons.search, color: Colors.white),
          Expanded(
            child: TextField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
          if(showIcon)
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => FilterBottomSheet(),
              );
            },
          ),
        ],
      ),
    );
  }
}
