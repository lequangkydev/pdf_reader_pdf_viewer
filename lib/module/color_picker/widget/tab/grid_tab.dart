part of '../../color_picker.dart';

class _GridTab extends StatelessWidget {
  const _GridTab({
    required this.onChanged,
    required this.color,
  });

  final void Function(Color color) onChanged;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 10.h,
      ),
      child: BlocBuilder<SelectedColorCubit, Color>(
        builder: (context, state) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 12,
            ),
            itemCount: colorGridData.length,
            itemBuilder: (context, index) {
              final color = colorGridData[index];
              return GestureDetector(
                onTap: () {
                  context.read<SelectedColorCubit>().updateColor(color);
                  onChanged(color);
                },
                child: buildColorItem(
                  color: color,
                  selected: state == color,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Container buildColorItem({
    required Color color,
    bool selected = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: selected
            ? Border.all(
                color: Colors.white,
                width: 3.r,
              )
            : null,
      ),
    );
  }
}
