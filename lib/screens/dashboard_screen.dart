import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';
import '../widgets/neumorphic_container.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Scrollable Content
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100), // Space for bottom nav
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60), // Status bar space + top padding
                  _buildHeader(context),
                  const SizedBox(height: 30),
                  _buildCalendarStrip(context),
                  const SizedBox(height: 30),
                  _buildHabitList(context),
                ],
              ),
            ),
          ),
          
          // Floating Bottom Navigation
          Positioned(
            left: 20,
            right: 20,
            bottom: 30, // standard bottom padding
            child: _buildBottomNavBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All Schelduled for Today",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary.withValues(alpha: 0.4),
                  fontSize: 15, // style_JS9IRZ - need to verify, assuming 15
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              // Summary Stats (3 Habits, 82%) - Group 1000004724
              NeumorphicContainer(
                 borderRadius: BorderRadius.circular(30),
                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                 isPill: false, // Standard outer shadow for grouping, or maybe just a container?
                 // Figma says: Group 1000004724 -> Rectangle (fill_5NF45Z) -> Text
                 // But wait, the 82% is OUTSIDE the green pill in Figma hierarchy I saw?
                 // Let's re-read the json snippet carefully if I can.
                 // JSON says: Group 1000004724 contains Rectangle (fill_5NF45Z), "3 Habits" (fill_ED2KH0).
                 // "82%" is OUTSIDE that group, sibling to it.
                 // Let's structure correctly.
                 color: Colors.transparent, // No main container bg?
                 border: Border.all(color: Colors.transparent), // No border
                 child: Row(
                   children: [
                      // Green Pill for "3 Habits"
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.darkerSurface, // fill_5NF45Z ?
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          "3 Habits",
                          style: TextStyle(
                            color: AppColors.textPrimary, 
                            fontSize: 14, 
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // 82% text
                      Text(
                        "82%",
                        style: const TextStyle(
                           color: AppColors.textPrimary,
                           fontSize: 24, // style_TG3TT9
                           fontWeight: FontWeight.w500, // or bold?
                        ),
                      ),
                   ],
                 ),
              ),
            ],
          ),
          // Notification Icon
          NeumorphicContainer(
            width: 44,
            height: 44,
            borderRadius: BorderRadius.circular(12), // standard rounded square
            isPill: false, // Outer shadow for button
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              'assets/icons/notifications.svg',
              // colorFilter: ... inside svg usually
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarStrip(BuildContext context) {
    // Figma: "1-page" didn't explicitly show the full calendar strip in the snippet I saw?
    // Wait, I saw "Group 48100456" in "Home" frame earlier...
    // Actually, let's use the layout from previous analysis: Horizontal list.
    // Days: "Du", "Se", "Chor", "Pa", "Ju", "Sha", "Ya"
    // Selected is 9 (Neumorphic Pill).
    
    return Column(
      children: [
         Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ["Du", "Se", "Chor", "Pa", "Ju", "Sha", "Ya"].map((day) {
                return SizedBox(
                   width: 44,
                   child: Text(
                     day,
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: AppColors.textPrimary.withValues(alpha: 0.3),
                       fontSize: 13,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                );
              }).toList(),
            ),
         ),
         const SizedBox(height: 12),
         SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 7,
              separatorBuilder: (context, index) => const SizedBox(width: 8), // Gap
              itemBuilder: (context, index) {
                final day = 7 + index; // 7, 8, 9...
                final isSelected = day == 9;
                
                if (isSelected) {
                   return NeumorphicContainer(
                      width: 44,
                      isPill: true, // Inner shadow for selected state
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.background,
                      child: Center(
                        child: Text(
                          "$day",
                          style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                   );
                }
                
                // Normal days
                return SizedBox(
                  width: 44,
                  child: Center(
                    child: Text(
                      "$day",
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 17),
                    ),
                  ),
                );
              },
            ),
         ),
      ],
    );
  }

  Widget _buildHabitList(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20),
       child: Column(
         children: [
            _buildHabitCard(
              title: "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
              progress: 0.67,
              streak: "40d",
              missed: "-2d",
              duration: "60 day",
              left: "18",
              color: AppColors.accentGreen,
              iconPath: 'assets/icons/sport_icon.svg',
            ),
            const SizedBox(height: 20),
            _buildHabitCard(
              title: "Kitob o'qish, kuniga 30 bet.",
              progress: 0.44,
              streak: "8d",
              missed: "0",
              duration: "20",
              left: "12",
              color: AppColors.purple,
              iconPath: 'assets/icons/music_icon.svg', // Placeholder
            ),
         ],
       ),
     );
  }

  Widget _buildHabitCard({
    required String title,
    required double progress,
    required String streak,
    required String missed,
    required String duration,
    required String left,
    required Color color,
    required String iconPath,
  }) {
    // Neumorphic Card
    return NeumorphicContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(22),
      isPill: false, // Outer shadow for card
      color: const Color(0xFF1E1E1E), // Dark card bg
      border: Border.all(color: Colors.transparent), // No border visible usually
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w500, // style_R9PTAU
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Progress Ring
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      backgroundColor: color.withValues(alpha: 0.1),
                      color: color,
                      strokeWidth: 4,
                      strokeCap: StrokeCap.round,
                    ),
                    Text(
                      "${(progress * 100).toInt()}%",
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              
              // Stats
              // Streak Pill
              _buildMiniPill(streak, color, isDot: true),
              const SizedBox(width: 8),
              // Missed Pill
              _buildMiniPill(missed, AppColors.blue, isDot: true),
              
              const Spacer(),
              
              // Duration Pill (Outer outlined?)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.strokeDark),
                ),
                child: Row(
                   children: [
                     Text(duration, style: const TextStyle(color: AppColors.yellow, fontSize: 10, fontWeight: FontWeight.bold)),
                     const SizedBox(width: 4),
                     Text(left, style: const TextStyle(color: AppColors.yellow, fontSize: 10)),
                   ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Dates (Start - End)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDateBadge("9.11.2025"),
              _buildDateBadge("9.1.2026"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniPill(String text, Color dotColor, {bool isDot = false}) {
    return NeumorphicContainer(
       borderRadius: BorderRadius.circular(20),
       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
       isPill: true, // Inner shadow for stats? Or just flat?
       // Figma "Rectangle 24961" fills: fill_KWJEOY opacity: 0.43.
       // Let's stick with Inner Shadow for "pressed" look or just flat container.
       // Based on "Refined UI" step, we used NeumorphicContainer isPill=true which gives inner shadow.
       color: AppColors.background,
       child: Row(
         children: [
           if (isDot) ...[
             Container(
               width: 6,
               height: 6,
               decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
             ),
             const SizedBox(width: 6),
           ],
           Text(
             text,
             style: const TextStyle(color: AppColors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold),
           ),
         ],
       ),
    );
  }

  Widget _buildDateBadge(String date) {
    return Container(
       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
       decoration: BoxDecoration(
         color: Colors.transparent,
         borderRadius: BorderRadius.circular(4),
         border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
       ),
       child: Text(
         date,
         style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
       ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return NeumorphicContainer(
       height: 64, // Slightly taller
       borderRadius: BorderRadius.circular(32), // Full rounded
       color: AppColors.surfaceInput,
       isPill: false, // Outer shadow (floating)
       padding: const EdgeInsets.symmetric(horizontal: 20),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
            // Home (Selected) - Neumorphic Inset Circle
            NeumorphicContainer(
               width: 44,
               height: 44,
               borderRadius: BorderRadius.circular(22),
               isPill: true, // Inner shadow
               color: AppColors.surfaceInput,
               padding: const EdgeInsets.all(10),
               child: SvgPicture.asset(
                 'assets/icons/home_nav.svg',
                 // colorFilter: ColorFilter.mode(AppColors.accentGreen, BlendMode.srcIn) 
                 // Assuming asset has color or apply here
               ),
            ),
            
            // Add Button (Center)
            Container(
               width: 44,
               height: 44,
               decoration: const BoxDecoration(
                 shape: BoxShape.circle,
               ),
               child: const Icon(Icons.add, color: AppColors.accentGreen, size: 30),
            ),
            
            // Calendar/Stats (Unselected)
            Container(
               width: 44,
               height: 44,
               padding: const EdgeInsets.all(10),
               child: SvgPicture.asset(
                 'assets/icons/calendar_nav.svg',
                 colorFilter: ColorFilter.mode(Colors.white.withValues(alpha: 0.4), BlendMode.srcIn)
               ),
            ),
         ],
       ),
    );
  }
}
