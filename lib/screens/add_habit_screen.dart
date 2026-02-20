import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/neumorphic_input.dart';

class AddHabitScreen extends StatefulWidget {
  final bool showBackButton;

  const AddHabitScreen({super.key, this.showBackButton = false});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _titleController = TextEditingController();
  final List<int> _durations = [7, 14, 21, 30, 60, 90];
  final List<Color> _colors = const [
    Color(0xFF9BDA88),
    Color(0xFFFEBB64),
    Color(0xFFCA5555),
    Color(0xFF88ADDA),
    Color(0xFFD2D2D2),
    Color(0xFFB488DA),
    Color(0xFFCB5B84),
  ];

  final List<String> _icons = const [
    'professional',
    'music',
    'like',
    'flashlight',
    'discover',
    'language',
    'fashion',
    'camera',
    'youtube',
    'sport',
    'invite',
    'app',
    'transport',
  ];

  int? _selectedDuration;
  DateTime? _startDate;
  DateTime? _endDate;
  int _selectedColorIndex = 0;
  int _selectedIconIndex = 0;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  String _dateLabel(DateTime? date, String fallback) {
    if (date == null) return fallback;
    return '${date.day}.${date.month}.${date.year}';
  }

  Future<void> _pickDuration() async {
    final selected = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: const Color(0xFF333333),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _durations.map((days) {
              final isSelected = _selectedDuration == days;
              return ListTile(
                title: Text(
                  '$days kun',
                  style: GoogleFonts.inter(
                    color: isSelected
                        ? const Color(0xFF9BDA88)
                        : const Color(0xFFDBD8D3),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                onTap: () => Navigator.pop(context, days),
              );
            }).toList(),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedDuration = selected;
      });
    }
  }

  Future<void> _pickDate(bool isStart) async {
    final initial = isStart
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? _startDate ?? DateTime.now());
    final result = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (result == null) return;

    setState(() {
      if (isStart) {
        _startDate = result;
        if (_endDate != null && _endDate!.isBefore(result)) {
          _endDate = result;
        }
      } else {
        _endDate = result;
      }
    });
  }

  void _resetForm() {
    setState(() {
      _titleController.clear();
      _selectedDuration = null;
      _startDate = null;
      _endDate = null;
      _selectedColorIndex = 0;
      _selectedIconIndex = 0;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Forma tozalandi')));
  }

  void _saveHabit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Mavzuni kiriting')));
      return;
    }

    if (_selectedDuration == null || _startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Davomiylik va sanalarni tanlang')),
      );
      return;
    }

    if (_endDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Tugash sanasi boshlanishdan oldin bo‘lishi mumkin emas',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '"$title" saqlandi (demo). API ulanganda backendga yuboramiz.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 390.0;
    final double horizontalPadding = 16.0 * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(scale),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24 * scale),
                      _buildHabitNameSection(scale),
                      SizedBox(height: 16 * scale),
                      _buildDurationSection(scale),
                      SizedBox(height: 16 * scale),
                      _buildDateRangeSection(scale),
                      SizedBox(height: 20 * scale),
                      _buildColorPaletteSection(scale),
                      SizedBox(height: 20 * scale),
                      _buildIconTypeSection(scale),
                      SizedBox(height: 30 * scale),
                      _buildActionButtons(scale),
                      SizedBox(height: 40 * scale),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double scale) {
    return Container(
      width: double.infinity,
      height: 60 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (widget.showBackButton)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                child: SvgPicture.asset(
                  'assets/icons/arrow_back_icon.svg',
                  width: 24 * scale,
                  height: 24 * scale,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          if (!widget.showBackButton) SizedBox(width: 52 * scale),
          Text(
            "Habbit qo’shish",
            style: GoogleFonts.inter(
              fontSize: 17 * scale,
              fontWeight: FontWeight.w600,
              height: 1.193,
              color: const Color(0xFFDBD8D3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitNameSection(double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 11 * scale),
          child: Text(
            "Mavzu",
            style: GoogleFonts.inter(
              fontSize: 15 * scale,
              fontWeight: FontWeight.w600,
              height: 1.193,
              color: const Color(0xFFDBD8D3).withValues(alpha: 0.6),
            ),
          ),
        ),
        SizedBox(height: 8 * scale),
        NeumorphicInputContainer(
          width: double.infinity,
          height: 70 * scale,
          borderRadius: 16 * scale,
          child: Padding(
            padding: EdgeInsets.fromLTRB(17 * scale, 14 * scale, 17 * scale, 0),
            child: TextField(
              controller: _titleController,
              style: GoogleFonts.inter(
                fontSize: 17 * scale,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFDBD8D3),
                height: 1.193,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: "Habbit mavzusini yozing",
                hintStyle: GoogleFonts.inter(
                  fontSize: 17 * scale,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFDBD8D3).withValues(alpha: 0.4),
                  height: 1.193,
                ),
              ),
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDurationSection(double scale) {
    return GestureDetector(
      onTap: _pickDuration,
      child: NeumorphicInputContainer(
        width: double.infinity,
        height: 50 * scale,
        borderRadius: 12 * scale,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17 * scale),
          child: Row(
            children: [
              Text(
                _selectedDuration == null
                    ? "Davomiylik (kunlar soni)"
                    : "Davomiylik: $_selectedDuration kun",
                style: GoogleFonts.inter(
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.w500,
                  color: _selectedDuration == null
                      ? const Color(0xFF6E6D6B)
                      : const Color(0xFFDBD8D3),
                  height: 1.193,
                ),
              ),
              const Spacer(),
              Opacity(
                opacity: 0.3,
                child: SvgPicture.asset(
                  'assets/icons/dropdown_icon.svg',
                  width: 16 * scale,
                  height: 16 * scale,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRangeSection(double scale) {
    return Row(
      children: [
        Expanded(
          child: _buildDateInput(
            scale: scale,
            label: _dateLabel(_startDate, "-dan"),
            onTap: () => _pickDate(true),
          ),
        ),
        SizedBox(width: 8 * scale),
        Expanded(
          child: _buildDateInput(
            scale: scale,
            label: _dateLabel(_endDate, "-gacha"),
            onTap: () => _pickDate(false),
          ),
        ),
      ],
    );
  }

  Widget _buildDateInput({
    required double scale,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: NeumorphicInputContainer(
        width: double.infinity,
        height: 50 * scale,
        borderRadius: 12 * scale,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13 * scale),
          child: Row(
            children: [
              Opacity(
                opacity: 0.3,
                child: SvgPicture.asset(
                  'assets/icons/calendar_icon.svg',
                  width: 24 * scale,
                  height: 24 * scale,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 8 * scale),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6E6D6B),
                  height: 1.193,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorPaletteSection(double scale) {
    return Column(
      children: [
        NeumorphicInputContainer(
          width: 140 * scale,
          height: 50 * scale,
          borderRadius: 66 * scale,
          pressedColor: const Color(0xFF333333),
          shadowColorTop: const Color(0x8CFFFFFF),
          shadowColorBottom: const Color(0x73000000),
          child: Center(
            child: Text(
              "Ranglar to'plami",
              style: GoogleFonts.inter(
                fontSize: 15 * scale,
                fontWeight: FontWeight.w600,
                height: 1.193,
                letterSpacing: -0.5,
                color: const Color(0xFFDBD8D3).withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
        SizedBox(height: 20 * scale),
        SizedBox(
          width: 350 * scale,
          height: 44 * scale,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_colors.length, (i) {
              final isActive = i == _selectedColorIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedColorIndex = i),
                child: SizedBox(
                  width: 44 * scale,
                  height: 44 * scale,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 44 * scale,
                        height: 44 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isActive
                                ? _colors[i]
                                : const Color(0xFF454545),
                            width: isActive ? 3 * scale : 2 * scale,
                          ),
                        ),
                      ),
                      Container(
                        width: 28 * scale,
                        height: 28 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _colors[i],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildIconTypeSection(double scale) {
    return Column(
      children: [
        NeumorphicInputContainer(
          width: 104 * scale,
          height: 50 * scale,
          borderRadius: 66 * scale,
          pressedColor: const Color(0xFF333333),
          shadowColorTop: const Color(0x8CFFFFFF),
          shadowColorBottom: const Color(0x73000000),
          child: Center(
            child: Text(
              "Ikon turlari",
              style: GoogleFonts.inter(
                fontSize: 15 * scale,
                fontWeight: FontWeight.w600,
                height: 1.193,
                letterSpacing: -0.5,
                color: const Color(0xFFDBD8D3).withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
        SizedBox(height: 20 * scale),
        SizedBox(
          width: 360 * scale,
          height: 90 * scale,
          child: Stack(
            children: _icons.asMap().entries.map((entry) {
              final i = entry.key;
              final iconName = entry.value;
              final isActive = i == _selectedIconIndex;

              double x = 0;
              double y = 0;
              if (i < 7) {
                x = i * 54.0;
                y = 0;
              } else {
                x = (i - 7) * 54.0;
                y = 54.0;
              }

              return Positioned(
                left: x * scale,
                top: y * scale,
                child: GestureDetector(
                  onTap: () => setState(() => _selectedIconIndex = i),
                  child: SizedBox(
                    width: 36 * scale,
                    height: 36 * scale,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/${iconName}_icon.svg',
                        width: 32 * scale,
                        height: 32 * scale,
                        colorFilter: ColorFilter.mode(
                          isActive
                              ? const Color(0xFF9BDA88)
                              : const Color(0xFF7F7F7F),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(double scale) {
    return Row(
      children: [
        Expanded(
          child: _buildDoubleLayerButton(
            scale: scale,
            text: "Bekor qilish",
            color: const Color(0xFFCA5555),
            onTap: _resetForm,
          ),
        ),
        SizedBox(width: 3 * scale),
        Expanded(
          child: _buildDoubleLayerButton(
            scale: scale,
            text: "Saqlash",
            color: const Color(0xFF9BDA88),
            onTap: _saveHabit,
          ),
        ),
      ],
    );
  }

  Widget _buildDoubleLayerButton({
    required double scale,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60 * scale,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(18 * scale),
        ),
        padding: EdgeInsets.all(4 * scale),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14 * scale),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 17 * scale,
              fontWeight: FontWeight.w500,
              height: 1.193,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: const Offset(0, 1),
                  blurRadius: 1,
                  color: Colors.black.withValues(alpha: 0.45),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
