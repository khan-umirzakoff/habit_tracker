import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/neumorphic_input.dart';

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scale factor
    final double scale = MediaQuery.of(context).size.width / 390.0;
    
    // Figma margins: 390 screen width, 358 content width -> 16px horizontal padding
    final double horizontalPadding = 16.0 * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, scale),
            
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24 * scale),
                      
                      // 1. Habit Name Section
                      _buildHabitNameSection(scale),
                      
                      SizedBox(height: 16 * scale),
                      
                      // 2. Duration Section
                      _buildDurationSection(scale),
                      
                      SizedBox(height: 16 * scale),
                      
                      // 3. Date Range Section
                      _buildDateRangeSection(scale),
                      
                      SizedBox(height: 20 * scale),
                      
                      // 4. Color Palette Section (178:2497)
                      _buildColorPaletteSection(scale),

                      SizedBox(height: 20 * scale),

                      // 5. Icon Type Section (178:2516)
                      _buildIconTypeSection(scale),
                      
                      SizedBox(height: 40 * scale), // Bottom padding
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

  // ===========================================================================
  // HEADER
  // ===========================================================================
  Widget _buildHeader(BuildContext context, double scale) {
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
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 16 * scale,
            child: GestureDetector(
              onTap: () {
                // Back navigation logic if needed
              },
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
          Positioned(
             left: 52 * scale,
             child: Text(
               "Habbit qo’shish",
               style: GoogleFonts.inter(
                  fontSize: 17 * scale,
                  fontWeight: FontWeight.w600,
                  height: 1.193,
                  color: const Color(0xFFDBD8D3),
               ),
             ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 1. HABIT NAME SECTION
  // Group 1000004746
  // ===========================================================================
  Widget _buildHabitNameSection(double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label: "Mavzu" (Group 1000004746 -> Text 178:2483)
        // x:11 relative to group. 
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
        SizedBox(height: 8 * scale), // Gap between label and input (26 - 18 = 8 approx)
        
        // Input Container (Rect 178:2481)
        // 358 x 70, Radius 16
        NeumorphicInputContainer(
          width: double.infinity, // Fill width (358)
          height: 70 * scale,
          borderRadius: 16 * scale,
          child: Container(
             padding: EdgeInsets.fromLTRB(17 * scale, 14 * scale, 17 * scale, 0),
             alignment: Alignment.topLeft,
             child: TextField(
               style: GoogleFonts.inter(
                 fontSize: 17 * scale,
                 fontWeight: FontWeight.w500,
                 color: const Color(0xFFDBD8D3), // fill_65871V
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

  // ===========================================================================
  // 2. DURATION SECTION
  // Group 1000004736
  // ===========================================================================
  Widget _buildDurationSection(double scale) {
    // 358 x 50, Radius 12
    return NeumorphicInputContainer(
      width: double.infinity,
      height: 50 * scale,
      borderRadius: 12 * scale,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17 * scale),
        child: Row(
          children: [
            Text(
              "Davomiylik (kunlar soni)",
              style: GoogleFonts.inter(
                fontSize: 15 * scale,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF6E6D6B), // fill_97ITF7
                height: 1.193,
              ),
            ),
            const Spacer(),
            Opacity(
              opacity: 0.3,
              child: SvgPicture.asset(
                'assets/icons/dropdown_icon.svg',
                width: 16 * scale, // Figma says 24/Bold/dropdown-24 but layout_TI6G7G says 16x16?
                // Group 178:2486 (Image SVG) Layout: 16x16. 
                // Name says "24/Bold/dropdown-24".
                // I downloaded node 171:80 (original component).
                height: 16 * scale,
                colorFilter: const ColorFilter.mode(
                   Colors.white, // Assuming icon is white and opacity handles it
                   BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. DATE RANGE SECTION
  // Frame 2087327727
  // ===========================================================================
  Widget _buildDateRangeSection(double scale) {
    return Row(
      children: [
        // Start Date (-dan)
        Expanded(
          child: _buildDateInput(
            scale: scale,
            label: "-dan",
          ),
        ),
        SizedBox(width: 8 * scale),
        // End Date (-gacha)
        Expanded(
          child: _buildDateInput(
            scale: scale,
            label: "-gacha",
          ),
        ),
      ],
    );
  }

  Widget _buildDateInput({required double scale, required String label}) {
    // 180 x 50, Radius 12
    return NeumorphicInputContainer(
      width: double.infinity, // Flexible
      height: 50 * scale,
      borderRadius: 12 * scale,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13 * scale), // layout_RJD5LV x:13
        child: Row(
          children: [
             // Icon (Calendar)
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
             SizedBox(width: 8 * scale), // Gap between icon and text (45 - 13 - 24 = 8)
             // Text
             Text(
               label,
               style: GoogleFonts.inter(
                 fontSize: 15 * scale,
                 fontWeight: FontWeight.w500,
                 color: const Color(0xFF6E6D6B), // fill_97ITF7
                 height: 1.193,
               ),
             ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. COLOR PALETTE SECTION
  // Figma: 178:2497 — Frame 2087327724
  // Layout: column, alignItems: center, gap: 20px
  // ===========================================================================
  Widget _buildColorPaletteSection(double scale) {
    // Color data from Figma
    // Each color: { fill, strokeColor, strokeWidth, isActive }
    final colors = [
      {'fill': const Color(0xFF9BDA88), 'stroke': const Color(0xFF9BDA88), 'strokeWidth': 3.0, 'active': true},
      {'fill': const Color(0xFFFEBB64), 'stroke': const Color(0xFF454545), 'strokeWidth': 2.0, 'active': false},
      {'fill': const Color(0xFFCA5555), 'stroke': const Color(0xFF454545), 'strokeWidth': 2.0, 'active': false},
      {'fill': const Color(0xFF88ADDA), 'stroke': const Color(0xFF454545), 'strokeWidth': 2.0, 'active': false},
      {'fill': const Color(0xFFD2D2D2), 'stroke': const Color(0xFF454545), 'strokeWidth': 2.0, 'active': false},
      {'fill': const Color(0xFFB488DA), 'stroke': const Color(0xFF454545), 'strokeWidth': 2.0, 'active': false},
      {'fill': const Color(0xFFCB5B84), 'stroke': const Color(0xFF454545), 'strokeWidth': 2.0, 'active': false},
    ];

    return Column(
      children: [
        // Label button: "Ranglar to'plami"
        // 178:2498 — 140x50, borderRadius 66
        NeumorphicInputContainer(
          width: 140 * scale,
          height: 50 * scale,
          borderRadius: 66 * scale,
          pressedColor: const Color(0xFF333333),
          shadowColorTop: const Color(0x8CFFFFFF), // 0.55 opacity matches Figma
          shadowColorBottom: const Color(0x73000000), // 0.45 matches Figma
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8 * scale), // Minimal padding to avoid edge clipping
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Ranglar to'plami",
                  style: GoogleFonts.inter(
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w600,
                    height: 1.193,
                    letterSpacing: -0.5, // Tighten text to mimic SF Pro compactness
                    color: const Color(0xFFDBD8D3).withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 20 * scale), // gap: 20px

        // Color circles row: 350x44
        SizedBox(
          width: 350 * scale,
          height: 44 * scale,
          child: Stack(
            children: colors.asMap().entries.map((entry) {
              final i = entry.key;
              final c = entry.value;
              final fill = c['fill'] as Color;
              final stroke = c['stroke'] as Color;
              final sw = c['strokeWidth'] as double;
              final isActive = c['active'] as bool;

              // Figma x positions: 0, 51, 102, 153, 204, 255, 306
              final xPositions = [0.0, 51.0, 102.0, 153.0, 204.0, 255.0, 306.0];
              final x = xPositions[i];

              return Positioned(
                left: x * scale,
                top: 0,
                child: SizedBox(
                  width: 44 * scale,
                  height: 44 * scale,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer ring (stroke circle)
                      Container(
                        width: 44 * scale,
                        height: 44 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: stroke,
                            width: sw * scale,
                          ),
                        ),
                      ),
                      // Inner filled circle (28x28)
                      Container(
                        width: 28 * scale,
                        height: 28 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: fill,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5. ICON TYPE SECTION
  // Figma: 178:2516 — Frame 2087327723
  // ===========================================================================
  Widget _buildIconTypeSection(double scale) {
    // Icons ordered by Figma coordinates (Row 1 then Row 2)
    // Row 1 (y=0): Professional, Music, Like, Flashlight, Discover, Language, Fashion
    // Row 2 (y=54): Camera, Youtube, Sport, Invite, App, Transport
    final icons = [
      'professional', 'music', 'like', 'flashlight', 
      'discover', 'language', 'fashion',
      'camera', 'youtube', 'sport', 'invite', 'app', 'transport'
    ];
    
    // Mock active index
    int activeIndex = 0;

    return Column(
      children: [
        // Label button: "Ikon turlari"
        // 178:2517 — 104x50
        NeumorphicInputContainer(
          width: 104 * scale,
          height: 50 * scale,
          borderRadius: 66 * scale,
          pressedColor: const Color(0xFF333333),
          shadowColorTop: const Color(0x8CFFFFFF),
          shadowColorBottom: const Color(0x73000000),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8 * scale),
              child: FittedBox(
                fit: BoxFit.scaleDown,
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
          ),
        ),

        SizedBox(height: 20 * scale),

        // Icons Grid
        // Figma Frame: 360x90. 
        // Row 1 y=0. Row 2 y=54.
        // Item size 36x36.
        // Horizontal step 54px.
        SizedBox(
          width: 360 * scale,
          height: 90 * scale, // 54 + 36 = 90
          child: Stack(
            children: icons.asMap().entries.map((entry) {
              final i = entry.key;
              final iconName = entry.value;
              final isActive = i == activeIndex;
              
              // Calculate Position
              double x = 0;
              double y = 0;
              
              if (i < 7) {
                // Row 1
                x = i * 54.0;
                y = 0;
              } else {
                // Row 2
                x = (i - 7) * 54.0;
                y = 54.0;
              }

              return Positioned(
                left: x * scale,
                top: y * scale,
                child: Container(
                  width: 36 * scale,
                  height: 36 * scale,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icons/${iconName}_icon.svg',
                    width: 24 * scale, // Icons inside are usually 24x24
                    height: 24 * scale,
                    colorFilter: ColorFilter.mode(
                      isActive ? const Color(0xFF9BDA88) : const Color(0xFF7F7F7F),
                      BlendMode.srcIn,
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
}
