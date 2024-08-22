import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomDropDown extends StatelessWidget {
  final String? label;
  final String value;
  final bool? isBookmarked;
  final List<String> items;
  final Function()? onHelpIconTap;
  final Function(String?) onChanged;
  final Function()? onBookmarkToggle;

  const CustomDropDown({
    super.key,
    this.label,
    required this.value,
    this.isBookmarked,
    required this.items,
    required this.onChanged,
    this.onBookmarkToggle,
    this.onHelpIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            label != null ? Text(
            label!,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold
              )
            ) : const SizedBox.shrink(),
            const Spacer(),
            onHelpIconTap != null ? InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: (){},
              child: const Icon(Iconsax.info_circle, color: Colors.grey, size: 17),
            ) : const SizedBox.shrink(),
          ],
        ),
        SizedBox(height: label != null ? 4 : 0),
        Container(
          height: 42, // Reduced height
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                value: value,
                isExpanded: true,
                icon: onBookmarkToggle != null ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onBookmarkToggle!();
                      },
                      child: Icon(
                        isBookmarked ?? false ? Icons.bookmark : Icons.bookmark_border,
                        color: isBookmarked ?? false ? Colors.yellow : Colors.grey,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ) : const Icon(Icons.arrow_drop_down, color: Colors.grey),
                style: const TextStyle(color: Colors.black, fontSize: 14),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}