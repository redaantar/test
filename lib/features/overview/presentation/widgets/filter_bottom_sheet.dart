import 'package:flutter/material.dart';

class FilterBottomSheet extends StatelessWidget {
  final VoidCallback onClear;

  const FilterBottomSheet({super.key, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildFilterOption(
            Icons.calendar_today,
            'Date',
            () {},
          ),
          _buildFilterOption(
            Icons.layers,
            'Type',
            () {},
          ),
          _buildFilterOption(
            Icons.error_outline,
            'Status',
            () {},
          ),
          _buildFilterOption(
            Icons.category,
            'Category',
            () {},
          ),
          _buildFilterOption(
            Icons.view_list,
            'Subcategory',
            () {},
          ),
          _buildFilterOption(
            Icons.local_offer,
            'Tags',
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, color: Colors.black),
        ),
        const Text(
          'Filter by',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onClear,
          child: const Text(
            'Clear',
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterOption(IconData icon, String label, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            const SizedBox(width: 2),
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return FilterBottomSheet(
        onClear: () {
          Navigator.pop(context);
        },
      );
    },
  );
}