// ─── features/home/presentation/widgets/welcome_tutorial_dialog.dart ──
// Daily Companion (رفيق يومي) — First-time tutorial onboarding dialog
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/theme/app_theme.dart';

class WelcomeTutorialDialog extends StatefulWidget {
  const WelcomeTutorialDialog({super.key});

  static Future<void> showIfFirstTime(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeen = prefs.getBool('has_seen_tutorial') ?? false;
    if (!hasSeen && context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const WelcomeTutorialDialog(),
      );
    }
  }

  static void showAlways(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const WelcomeTutorialDialog(),
    );
  }

  @override
  State<WelcomeTutorialDialog> createState() => _WelcomeTutorialDialogState();
}

class _WelcomeTutorialDialogState extends State<WelcomeTutorialDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_TutorialSlide> _slides = const [
    _TutorialSlide(
      icon: '⛪',
      title: 'أسرة مار أفرام السرياني',
      subtitle: 'الأسر الجامعية — أسقفية الشباب ✝️',
      description:
          'تطبيق «رفيق يومي» صُنِع بِمَحَبَّة وإعداد أسرة مار أفرام السرياني لخدمة شباب الأسر الجامعية (أسقفية الشباب).\nالمنهج الروحي يتناول مادة «شبابيات» المعتمدة.',
    ),
    _TutorialSlide(
      icon: '🌅',
      title: 'عطية اليوم (Daily Gift)',
      subtitle: 'هدية الله الصباحية لك',
      description:
          'كل يوم تبدأه بعطية روحية تحتوي على آية مباركة، تأمل عميق، وتذكير بالبركة يملأ يومك بالسلام والأمان.',
    ),
    _TutorialSlide(
      icon: '🔥',
      title: 'مذبح القلب (Altar of the Heart)',
      subtitle: 'عطاء وتأكيد حب لله',
      description:
          'لا تكتفِ بالاستلام، بل قدّم لربنا التزاماً يومياً صغيراً بدافع الحب والامتنان (صلاة، خدمة، شكر، تسبيح).',
    ),
    _TutorialSlide(
      icon: '🌱',
      title: 'شجرة النمو الروحي (Growth)',
      subtitle: 'ثمار استمراريتك في الإيمان',
      description:
          'تابع نموك الروحي واستمراريتك يومياً. شاهد شجرة علاقتك بالله تكبر وتزهر مع كل التزام تصنعه.',
    ),
    _TutorialSlide(
      icon: '📅',
      title: 'تحدي الـ 30 يوماً (Challenge)',
      subtitle: 'رحلة عملية لبناء العادات',
      description:
          'رحلة منهجية من 30 يوماً تحتوي على آيات وشواهد وتحديات يومية وتأملات تساعدك على النمو والالتزام.',
    ),
    _TutorialSlide(
      icon: '📖',
      title: 'مادة شبابيات (المنهج)',
      subtitle: 'علاقة الله بالإنسان وحريتك',
      description:
          'تصفح بطاقات المنهج التفاعلية لمادة «شبابيات» مع أسئلة وإجابات وشروح روحية عميقة لتنمو في معرفة الله ونفسك.',
    ),
  ];

  Future<void> _finishTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_tutorial', true);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 520),
        child: Column(
          children: [
            // Header: Skip button & dots
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _finishTutorial,
                  child: const Text(
                    'تخطي',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  children: List.generate(
                    _slides.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _currentPage == i ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _currentPage == i
                            ? AppTheme.primaryColor
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // PageView content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (page) => setState(() => _currentPage = page),
                itemBuilder: (_, index) {
                  final slide = _slides[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: AppTheme.divineLight,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withOpacity(0.12),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          slide.icon,
                          style: const TextStyle(fontSize: 44),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        slide.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        slide.subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          slide.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.textSecondary,
                                height: 1.6,
                              ),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Navigation Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage < _slides.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    _finishTutorial();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  _currentPage == _slides.length - 1 ? 'ابدأ الرحلة 🚀' : 'التالي',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TutorialSlide {
  final String icon;
  final String title;
  final String subtitle;
  final String description;

  const _TutorialSlide({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
  });
}
