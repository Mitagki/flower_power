import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'nl', 'bg'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? nlText = '',
    String? bgText = '',
  }) =>
      [enText, nlText, bgText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // loginPage
  {
    'ocedoymn': {
      'en': 'Login',
      'bg': '',
      'nl': '',
    },
    'nxu983gg': {
      'en': 'Email Address',
      'bg': '',
      'nl': '',
    },
    'jy232nxs': {
      'en': 'Enter your email...',
      'bg': '',
      'nl': '',
    },
    '2cezeqxj': {
      'en': 'Password',
      'bg': '',
      'nl': '',
    },
    'r10j6j6a': {
      'en': 'Enter your password...',
      'bg': '',
      'nl': '',
    },
    '2xmta117': {
      'en': 'Login',
      'bg': '',
      'nl': '',
    },
    '99nvevhb': {
      'en': 'Forgot Password',
      'bg': '',
      'nl': '',
    },
    'ni0h0333': {
      'en': 'Continue as Guest',
      'bg': '',
      'nl': '',
    },
    'fti26g8s': {
      'en': 'Register',
      'bg': '',
      'nl': '',
    },
    'k9gxcony': {
      'en': 'Email Address',
      'bg': '',
      'nl': '',
    },
    'j54lflus': {
      'en': 'Enter your email...',
      'bg': '',
      'nl': '',
    },
    '0mmmol5q': {
      'en': 'Password',
      'bg': '',
      'nl': '',
    },
    '5ucm3uoo': {
      'en': 'Enter your password...',
      'bg': '',
      'nl': '',
    },
    'rw3lhneu': {
      'en': 'Confirm Password',
      'bg': '',
      'nl': '',
    },
    '3axp9bvn': {
      'en': 'Enter your password...',
      'bg': '',
      'nl': '',
    },
    'yku9j24j': {
      'en': 'Create Account',
      'bg': '',
      'nl': '',
    },
    'hgeg71ls': {
      'en': 'Continue as Guest',
      'bg': '',
      'nl': '',
    },
    '2cnjti2c': {
      'en': 'Home',
      'bg': '',
      'nl': '',
    },
  },
  // completeProfile
  {
    'tkjzzuwx': {
      'en': 'Complete Profile',
      'bg': '',
      'nl': '',
    },
    'eb5tsj3j': {
      'en': 'Upload a photo of you.',
      'bg': '',
      'nl': '',
    },
    'wogswjtq': {
      'en': 'Your Name',
      'bg': '',
      'nl': '',
    },
    'fqmm4jfk': {
      'en': 'Please enter your full name...',
      'bg': '',
      'nl': '',
    },
    'nk9erw98': {
      'en': 'Your Age',
      'bg': '',
      'nl': '',
    },
    '1wqv42i3': {
      'en': 'i.e. 34',
      'bg': '',
      'nl': '',
    },
    '5osoy6vn': {
      'en': 'Your Birth Sex',
      'bg': '',
      'nl': '',
    },
    'ewx0xzvs': {
      'en': 'Male',
      'bg': '',
      'nl': '',
    },
    'qz8laj32': {
      'en': 'Female',
      'bg': '',
      'nl': '',
    },
    'jdnxpx9o': {
      'en': 'Undisclosed',
      'bg': '',
      'nl': '',
    },
    'ohxjrd2z': {
      'en': 'Add Another Profile',
      'bg': '',
      'nl': '',
    },
    'kf1jn4rk': {
      'en': 'Complete Profile',
      'bg': '',
      'nl': '',
    },
    '38z90p5h': {
      'en': 'Home',
      'bg': '',
      'nl': '',
    },
  },
  // forgotPassword
  {
    'j36exgcv': {
      'en': 'Forgot Password',
      'bg': '',
      'nl': '',
    },
    '66aj98bd': {
      'en':
          'Enter the email associated with your account and we will send you a verification code.',
      'bg': '',
      'nl': '',
    },
    'bi3kbbw9': {
      'en': 'Email Address',
      'bg': '',
      'nl': '',
    },
    'szye8dwm': {
      'en': 'Enter your email...',
      'bg': '',
      'nl': '',
    },
    'e9hfwphq': {
      'en': 'Send Reset Link',
      'bg': '',
      'nl': '',
    },
    'y0o2g9lq': {
      'en': 'Home',
      'bg': '',
      'nl': '',
    },
  },
  // addAnotherProfile
  {
    'g830u8ry': {
      'en': 'Add Another Profile',
      'bg': '',
      'nl': '',
    },
    'kq16e1ey': {
      'en': 'Upload a photo for us to easily identify this person.',
      'bg': '',
      'nl': '',
    },
    '3bf6h7ho': {
      'en': 'Persons Name',
      'bg': '',
      'nl': '',
    },
    '370u02qv': {
      'en': 'Official name here...',
      'bg': '',
      'nl': '',
    },
    'h91obosd': {
      'en': 'Persons Age',
      'bg': '',
      'nl': '',
    },
    'bj0qha5h': {
      'en': 'i.e. 34',
      'bg': '',
      'nl': '',
    },
    '4htekofs': {
      'en': 'Location',
      'bg': '',
      'nl': '',
    },
    'g5l4o2x0': {
      'en': 'Please enter a valid email...',
      'bg': '',
      'nl': '',
    },
    'msizsnzn': {
      'en': 'Persons Birth Sex',
      'bg': '',
      'nl': '',
    },
    'czz3kwe9': {
      'en': 'Male',
      'bg': '',
      'nl': '',
    },
    '4lxzc1oq': {
      'en': 'Female',
      'bg': '',
      'nl': '',
    },
    'ckcejfmj': {
      'en': 'Undisclosed',
      'bg': '',
      'nl': '',
    },
    'bsjnv65p': {
      'en': 'Complete Profile',
      'bg': '',
      'nl': '',
    },
    'v4sim6oy': {
      'en': 'Home',
      'bg': '',
      'nl': '',
    },
  },
  // onboarding
  {
    'lg49dag7': {
      'en': 'Welcome to\nFlower Power',
      'bg': '',
      'nl': '',
    },
    'gltstvpx': {
      'en': 'By using the app you contribute to wildflower biodiversity.',
      'bg': '',
      'nl': '',
    },
    'rotb67sh': {
      'en': 'Identify and count wildflowers',
      'bg': '',
      'nl': '',
    },
    '67vgog0m': {
      'en': 'Discover wildflowers by taking advantage of our AI model.',
      'bg': '',
      'nl': '',
    },
    'oxh4tto1': {
      'en': 'Become a wildflower expert',
      'bg': '',
      'nl': '',
    },
    'nyndglb5': {
      'en':
          'Our database provides you with comprehensive wildflower information.',
      'bg': '',
      'nl': '',
    },
    'lyuc5g23': {
      'en': 'Compete in challenges and win medals',
      'bg': '',
      'nl': '',
    },
    '5u5y0qtr': {
      'en':
          'Take part in our weekly updated challenges and win upgradable medals.',
      'bg': '',
      'nl': '',
    },
    'kk4loavo': {
      'en': 'Share your progress with friends',
      'bg': '',
      'nl': '',
    },
    'g1hojno2': {
      'en':
          'Compete with your friends or participate together in group challenges.',
      'bg': '',
      'nl': '',
    },
    'rrh73c96': {
      'en': 'Continue',
      'bg': '',
      'nl': '',
    },
    'nzuh086z': {
      'en': 'Home',
      'bg': '',
      'nl': '',
    },
  },
  // homePage
  {
    'u2xagcjd': {
      'en': 'Hello,',
      'bg': '',
      'nl': '',
    },
    'bdx7effv': {
      'en': 'Take a photo',
      'bg': '',
      'nl': '',
    },
    'pq9ujt04': {
      'en': 'Use the camera of your device to idetify and count wildflowers.',
      'bg': '',
      'nl': '',
    },
    'idvmorvw': {
      'en': 'Upload a photo',
      'bg': '',
      'nl': '',
    },
    'ivstcsdt': {
      'en': 'Upload a photo of wildflowers from the gallery of your device.',
      'bg': '',
      'nl': '',
    },
    'ggqi730k': {
      'en': 'Medals',
      'bg': '',
      'nl': '',
    },
    '897teu7b': {
      'en': 'Contribute to wildflower biodiversity and earn medals.',
      'bg': '',
      'nl': '',
    },
    'jrkmrsd3': {
      'en': 'Challenges',
      'bg': '',
      'nl': '',
    },
    '4bqu2vvj': {
      'en': 'Compete in weekly updated challenges with friends and others.',
      'bg': '',
      'nl': '',
    },
    'twgb9tuw': {
      'en': '•',
      'bg': '',
      'nl': '',
    },
  },
  // myObservations
  {
    'vmjekmkl': {
      'en': 'Observations',
      'bg': '',
      'nl': '',
    },
    'wlvsx0yh': {
      'en': 'My observations',
      'bg': '',
      'nl': '',
    },
    'kzxff2mm': {
      'en': 'Bellis perennis',
      'bg': '',
      'nl': '',
    },
    'wky18u2q': {
      'en': 'Count: 11',
      'bg': '',
      'nl': '',
    },
    'vlj7s7u7': {
      'en': 'Eindhoven',
      'bg': '',
      'nl': '',
    },
    '9he31p3l': {
      'en': '10/05/2023 13:30',
      'bg': '',
      'nl': '',
    },
    '3ovxg89x': {
      'en': 'Ficaria verna',
      'bg': '',
      'nl': '',
    },
    'e9vwzmqa': {
      'en': 'Count: 49',
      'bg': '',
      'nl': '',
    },
    'm7zhvrm4': {
      'en': 'Eindhoven',
      'bg': '',
      'nl': '',
    },
    '0gumizpu': {
      'en': '08/05/2023 11:30',
      'bg': '',
      'nl': '',
    },
    'r5ck5bbt': {
      'en': '•',
      'bg': '',
      'nl': '',
    },
  },
  // appointmentDetails
  {
    '282h0ftn': {
      'en': 'Details',
      'bg': '',
      'nl': '',
    },
    'ftvrq7d3': {
      'en': 'Type of Appointment',
      'bg': '',
      'nl': '',
    },
    '35mggi6e': {
      'en': 'What’s the problem?',
      'bg': '',
      'nl': '',
    },
    'jfz7vveo': {
      'en': 'For',
      'bg': '',
      'nl': '',
    },
    'bx5mb1ds': {
      'en': 'When',
      'bg': '',
      'nl': '',
    },
    'pke3zxrc': {
      'en': 'Reschedule',
      'bg': '',
      'nl': '',
    },
    'mvcxkunt': {
      'en': 'Cancel Appointment',
      'bg': '',
      'nl': '',
    },
    'ixz2hr2f': {
      'en': 'Home',
      'bg': '',
      'nl': '',
    },
  },
  // profilePage
  {
    'cz3gwjb8': {
      'en': 'Last observation',
      'bg': '',
      'nl': '',
    },
    'bytvx97r': {
      'en': 'Bellis perennis',
      'bg': '',
      'nl': '',
    },
    '8mwqujpl': {
      'en': 'Count: 11',
      'bg': '',
      'nl': '',
    },
    '8p20ny0k': {
      'en': 'Eindhoven',
      'bg': '',
      'nl': '',
    },
    '3g6s2pyy': {
      'en': '10/05/2023 13:30',
      'bg': '',
      'nl': '',
    },
    'hvzhk3j2': {
      'en': 'Settings',
      'bg': '',
      'nl': '',
    },
    'h7dol9rz': {
      'en': 'Switch to Dark Mode',
      'bg': '',
      'nl': '',
    },
    '9smjn0be': {
      'en': 'Switch to Light Mode',
      'bg': '',
      'nl': '',
    },
    '7t60a1co': {
      'en': '•',
      'bg': '',
      'nl': '',
    },
  },
  // editProfile
  {
    'tuqzl2uo': {
      'en': 'Edit Profile',
      'bg': '',
      'nl': '',
    },
    'lkytcca3': {
      'en': 'Change Photo',
      'bg': '',
      'nl': '',
    },
    'racz3j6z': {
      'en': 'Your Name',
      'bg': '',
      'nl': '',
    },
    'xvvk4pf9': {
      'en': 'Please enter a valid number...',
      'bg': '',
      'nl': '',
    },
    'vpe6ozzp': {
      'en': 'Email Address',
      'bg': '',
      'nl': '',
    },
    'xktea6jm': {
      'en': 'Your email',
      'bg': '',
      'nl': '',
    },
    '31qn1hvi': {
      'en': 'Your Age',
      'bg': '',
      'nl': '',
    },
    'xy2d1vh3': {
      'en': 'i.e. 34',
      'bg': '',
      'nl': '',
    },
    'vzwat63l': {
      'en': 'Your Birth Sex',
      'bg': '',
      'nl': '',
    },
    'itdu7rgj': {
      'en': 'Male',
      'bg': '',
      'nl': '',
    },
    'u2wpor3c': {
      'en': 'Female',
      'bg': '',
      'nl': '',
    },
    'modag4ov': {
      'en': 'Undisclosed',
      'bg': '',
      'nl': '',
    },
    'stc9wd3q': {
      'en': 'Save Changes',
      'bg': '',
      'nl': '',
    },
    'men2czcd': {
      'en': 'Home',
      'bg': '',
      'nl': '',
    },
  },
  // findWildflowers
  {
    '0qnmjon4': {
      'en': 'Wildflowers',
      'bg': '',
      'nl': '',
    },
    'ltj9i70f': {
      'en': 'Search wildflowers',
      'bg': '',
      'nl': '',
    },
    'uimch9t2': {
      'en': 'Papaver rhoeas, common poppy etc...',
      'bg': '',
      'nl': '',
    },
    '72a055om': {
      'en': 'Bellis perennis',
      'bg': '',
      'nl': '',
    },
    'as2d7274': {
      'en': 'Daisy',
      'bg': '',
      'nl': '',
    },
    'ei15imii': {
      'en': 'Ficaria verna',
      'bg': '',
      'nl': '',
    },
    '5hr0t74q': {
      'en': 'Lesser celandine',
      'bg': '',
      'nl': '',
    },
    'fkod3qws': {
      'en': 'Papaver rhoeas',
      'bg': '',
      'nl': '',
    },
    'xxscywz9': {
      'en': 'Common poppy',
      'bg': '',
      'nl': '',
    },
    '24l0z6ij': {
      'en': 'Glebionis segetum',
      'bg': '',
      'nl': '',
    },
    '9abgrh29': {
      'en': 'Corn marigold',
      'bg': '',
      'nl': '',
    },
    'wncqadst': {
      'en': 'Dianthus barbatus',
      'bg': '',
      'nl': '',
    },
    '1a45mcae': {
      'en': 'Sweet William',
      'bg': '',
      'nl': '',
    },
    'f1lkxc3k': {
      'en': '•',
      'bg': '',
      'nl': '',
    },
  },
  // appointmentDetailsProfile
  {
    '33ke0yio': {
      'en': 'Details',
      'bg': '',
      'nl': '',
    },
    'welikh2e': {
      'en': 'Type of Appointment',
      'bg': '',
      'nl': '',
    },
    'vkjxk88v': {
      'en': 'What’s the problem?',
      'bg': '',
      'nl': '',
    },
    '18qic8qe': {
      'en': 'For',
      'bg': '',
      'nl': '',
    },
    'tbxeh8kk': {
      'en': 'When',
      'bg': '',
      'nl': '',
    },
    '0xmah0rq': {
      'en': 'Remove Appointment',
      'bg': '',
      'nl': '',
    },
    'aeigj7gi': {
      'en': 'Home',
      'bg': '',
      'nl': '',
    },
  },
  // medals
  {
    'c1nk696g': {
      'en': 'Medals',
      'bg': '',
      'nl': '',
    },
    '2xqg8qcx': {
      'en': 'Unlocked',
      'bg': '',
      'nl': '',
    },
    't6scacor': {
      'en': 'Poppies',
      'bg': '',
      'nl': '',
    },
    '1pcjxeqk': {
      'en': 'Marigolds',
      'bg': '',
      'nl': '',
    },
    'h3c0z0oa': {
      'en': 'Lesser celandines',
      'bg': '',
      'nl': '',
    },
    'lrp85z9q': {
      'en': 'Daisies',
      'bg': '',
      'nl': '',
    },
    'zgj20opn': {
      'en': 'Sweet Williams',
      'bg': '',
      'nl': '',
    },
    'gms2asxw': {
      'en': 'Eindhoven',
      'bg': '',
      'nl': '',
    },
    'hefum44e': {
      'en': 'Noord Brabant',
      'bg': '',
      'nl': '',
    },
    'nejyc334': {
      'en': 'Week 1',
      'bg': '',
      'nl': '',
    },
    'gyfabwpb': {
      'en': 'Week 2',
      'bg': '',
      'nl': '',
    },
    'ajsf7en0': {
      'en': 'Available',
      'bg': '',
      'nl': '',
    },
    'a9ogiejs': {
      'en': 'June',
      'bg': '',
      'nl': '',
    },
    'shlg25ld': {
      'en': '•',
      'bg': '',
      'nl': '',
    },
  },
  // challenges
  {
    '0pom9imv': {
      'en': 'Challenges',
      'bg': '',
      'nl': '',
    },
    's5rklsjj': {
      'en': 'Weekly',
      'bg': '',
      'nl': '',
    },
    '4tmat7pq': {
      'en': 'Weekly Eindhoven Challenge',
      'bg': '',
      'nl': '',
    },
    'dl572nwe': {
      'en': '300',
      'bg': '',
      'nl': '',
    },
    'o05sjz4t': {
      'en': 'Eindhoven',
      'bg': '',
      'nl': '',
    },
    'b6q7t6g7': {
      'en': '2 Days left',
      'bg': '',
      'nl': '',
    },
    'fm3inzag': {
      'en': 'Weekly Country Challenge',
      'bg': '',
      'nl': '',
    },
    'g0eajmqh': {
      'en': '500',
      'bg': '',
      'nl': '',
    },
    '5s5p7b0w': {
      'en': 'The Netherlands',
      'bg': '',
      'nl': '',
    },
    'o3tjr9jy': {
      'en': '2 Days left',
      'bg': '',
      'nl': '',
    },
    'leygi9o7': {
      'en': 'Monthly',
      'bg': '',
      'nl': '',
    },
    'aczu5g4d': {
      'en': 'Monthly Eindhoven Challenge',
      'bg': '',
      'nl': '',
    },
    'c0xygp2n': {
      'en': '600',
      'bg': '',
      'nl': '',
    },
    'd05ibrbb': {
      'en': 'Eindhoven',
      'bg': '',
      'nl': '',
    },
    '274ar1ih': {
      'en': '20 Days left',
      'bg': '',
      'nl': '',
    },
    'rpep5rpl': {
      'en': 'Monthly Country Challenge',
      'bg': '',
      'nl': '',
    },
    '46eda24v': {
      'en': '1000',
      'bg': '',
      'nl': '',
    },
    'jpi3p2i3': {
      'en': 'The Netherlands',
      'bg': '',
      'nl': '',
    },
    'a7xhjjq4': {
      'en': '20 Days left',
      'bg': '',
      'nl': '',
    },
    'xrdiltkm': {
      'en': 'Others',
      'bg': '',
      'nl': '',
    },
    '5f70uxr1': {
      'en': 'Poppies',
      'bg': '',
      'nl': '',
    },
    'iknkny92': {
      'en': '2000',
      'bg': '',
      'nl': '',
    },
    'l32yoohb': {
      'en': 'The Netherlands',
      'bg': '',
      'nl': '',
    },
    'o8tofqrp': {
      'en': 'No time limit',
      'bg': '',
      'nl': '',
    },
    'izv0du1i': {
      'en': '•',
      'bg': '',
      'nl': '',
    },
  },
  // wildflowerDetails
  {
    '6fu6v0x1': {
      'en': 'About the species',
      'bg': '',
      'nl': '',
    },
    '4vcib0wl': {
      'en': 'Bellis perennis',
      'bg': '',
      'nl': '',
    },
    'xciuwfj4': {
      'en': 'Daisy',
      'bg': '',
      'nl': '',
    },
    'klvt48l3': {
      'en':
          'Bellis perennis (/ˈbɛləs pəˈrɛnəs/), the daisy, is a European species of the family Asteraceae, often considered the archetypal species of the name daisy. To distinguish this species from other plants known as daisies, it is sometimes qualified as common daisy, lawn daisy or English daisy.',
      'bg': '',
      'nl': '',
    },
    '103ubohh': {
      'en': 'Additional Information',
      'bg': '',
      'nl': '',
    },
    'o82oee7w': {
      'en':
          'Bellis perennis is a perennial herbaceous plant growing to 20 centimetres (8 inches) in height. It has short creeping rhizomes and rosettes of small rounded or spoon-shaped leaves that are from 2 to 5 cm (3⁄4–2 in) long and grow flat to the ground. The species habitually colonises lawns, and is difficult to eradicate by mowing, hence the term \'lawn daisy\'. It blooms from March to September and exhibits the phenomenon of heliotropism, in which the flowers follow the position of the sun in the sky.\n\nThe flowerheads are composite, about 2 to 3 cm (3⁄4–1+1⁄4 in) in diameter, in the form of a pseudanthium, consisting of many sessile flowers with white ray florets (often tipped red) and yellow disc florets. Each inflorescence is borne on a single leafless stem 2 to 10 cm (3⁄4–4 in), rarely 15 cm (6 in) tall. The capitulum, or disc of florets, is surrounded by two rows of green bracts known as \"phyllaries\". The achenes are without pappus.',
      'bg': '',
      'nl': '',
    },
  },
  // observationDetails
  {
    'tqowgiql': {
      'en': 'Observation Details',
      'bg': '',
      'nl': '',
    },
    '2i045o79': {
      'en': 'Bellis perennis',
      'bg': '',
      'nl': '',
    },
    'ityy3417': {
      'en': 'Daisy',
      'bg': '',
      'nl': '',
    },
    '657s9sh6': {
      'en': 'Count',
      'bg': '',
      'nl': '',
    },
    '6v7686mc': {
      'en': '11',
      'bg': '',
      'nl': '',
    },
    'g4adqnwy': {
      'en': 'Location',
      'bg': '',
      'nl': '',
    },
    'tya0a6g4': {
      'en': 'Eindhoven',
      'bg': '',
      'nl': '',
    },
    'x5xocg0w': {
      'en': 'Date & Time',
      'bg': '',
      'nl': '',
    },
    'o8g6pcp4': {
      'en': '10/05/2023 13:30',
      'bg': '',
      'nl': '',
    },
    'b2mfzpqh': {
      'en': 'About the species',
      'bg': '',
      'nl': '',
    },
  },
  // medalDetails
  {
    '8f41o8t8': {
      'en': 'Medal Details',
      'bg': '',
      'nl': '',
    },
    'y5rtq56x': {
      'en': 'Gold Medal',
      'bg': '',
      'nl': '',
    },
    'bcho2a66': {
      'en': 'Awarded for exceptional performance',
      'bg': '',
      'nl': '',
    },
    'e2a88z5j': {
      'en': 'Achievement',
      'bg': '',
      'nl': '',
    },
    'sspw0mif': {
      'en': 'Top 1%',
      'bg': '',
      'nl': '',
    },
    'wzrmjx2a': {
      'en': 'Description',
      'bg': '',
      'nl': '',
    },
    'nteqanjp': {
      'en':
          'This medal is awarded to individuals who have demonstrated exceptional performance in their respective fields. Recipients of this prestigious award have shown dedication, hard work, and a commitment to excellence.',
      'bg': '',
      'nl': '',
    },
    'wepuz5ao': {
      'en': 'Challenge Details',
      'bg': '',
      'nl': '',
    },
  },
  // challengeDetails
  {
    'b7720h4u': {
      'en': 'Challenge Details',
      'bg': '',
      'nl': '',
    },
    '1wt4y7ac': {
      'en': 'Weekly Eindhoven Challenge',
      'bg': '',
      'nl': '',
    },
    'vhbgq2iy': {
      'en': 'Start Date: 01/01/2023',
      'bg': '',
      'nl': '',
    },
    'd72vitqq': {
      'en':
          'Join our Weekly Eindhoven Challenge to kickstart your journey. Participate, track your progress, and share your results with the community.',
      'bg': '',
      'nl': '',
    },
    '2ozdknyn': {
      'en': '30 Days',
      'bg': '',
      'nl': '',
    },
    '9uub2s9t': {
      'en': 'All Levels',
      'bg': '',
      'nl': '',
    },
    'hts67qy7': {
      'en': 'Online',
      'bg': '',
      'nl': '',
    },
    'k178skh7': {
      'en': 'Join Challenge',
      'bg': '',
      'nl': '',
    },
  },
  // observationDetailsCopy
  {
    '3ez0l3ez': {
      'en': 'Observation Details',
      'bg': '',
      'nl': '',
    },
    '3v0q2zym': {
      'en': 'Ficaria verna',
      'bg': '',
      'nl': '',
    },
    'ptf8c8nf': {
      'en': 'Lesser celandine or Pilewort',
      'bg': '',
      'nl': '',
    },
    '6gjlkiee': {
      'en': 'Count',
      'bg': '',
      'nl': '',
    },
    'xyt5adif': {
      'en': '49',
      'bg': '',
      'nl': '',
    },
    'mt36fpq4': {
      'en': 'Location',
      'bg': '',
      'nl': '',
    },
    'tdfaupxy': {
      'en': 'Eindhoven',
      'bg': '',
      'nl': '',
    },
    'b6cummbb': {
      'en': 'Date & Time',
      'bg': '',
      'nl': '',
    },
    'jlnsd82t': {
      'en': '08/05/2023 11:30',
      'bg': '',
      'nl': '',
    },
    'pjn9y3u7': {
      'en': 'About the species',
      'bg': '',
      'nl': '',
    },
  },
  // wildflowerDetailsCopy
  {
    'lg47pvhe': {
      'en': 'About the species',
      'bg': '',
      'nl': '',
    },
    'cyn16tm4': {
      'en': 'Ficaria verna',
      'bg': '',
      'nl': '',
    },
    'nywio16w': {
      'en': 'Lesser celandine or Pilewort',
      'bg': '',
      'nl': '',
    },
    'lny0uvha': {
      'en':
          'Ficaria verna (formerly Ranunculus ficaria L.), commonly known as lesser celandine or pilewort, is a low-growing, hairless perennial flowering plant in the buttercup family Ranunculaceae native to Europe and Western Asia. It has fleshy dark green, heart-shaped leaves and distinctive flowers with bright yellow, glossy petals.',
      'bg': '',
      'nl': '',
    },
    '7eyxheo8': {
      'en': 'Additional Information',
      'bg': '',
      'nl': '',
    },
    'xnnnh57s': {
      'en':
          'It is now introduced in North America, where it is known by the common name fig buttercup and considered an invasive species. The plant is poisonous if ingested raw and potentially fatal to grazing animals and livestock such as horses, cattle, and sheep. For these reasons, several US states have banned the plant or listed it as a noxious weed. It prefers bare, damp ground and is considered by horticulturalists in the United Kingdom as a persistent garden weed  nevertheless, many specialist plantsmen, nursery owners and discerning gardeners in the UK and Europe collect selected cultivars of the plant, including bronze-leaved and double-flowered ones. Emerging in late winter with flowers appearing late February through May in the UK, its appearance across the landscape is regarded by many as a harbinger of spring.',
      'bg': '',
      'nl': '',
    },
  },
  // bookAppointment
  {
    '4jvrmcmb': {
      'en': 'Book Appointment',
      'bg': '',
      'nl': '',
    },
    'gg8vixuz': {
      'en':
          'Fill out the information below in order to book your appointment with our office.',
      'bg': '',
      'nl': '',
    },
    'xwf0myo9': {
      'en': 'Emails will be sent to:',
      'bg': '',
      'nl': '',
    },
    '4q53reno': {
      'en': 'Booking For',
      'bg': '',
      'nl': '',
    },
    'mi4aakm9': {
      'en': 'Doctors Visit',
      'bg': '',
      'nl': '',
    },
    'ww3eexto': {
      'en': 'Routine Checkup',
      'bg': '',
      'nl': '',
    },
    'ohe3on5k': {
      'en': 'Scan/Update',
      'bg': '',
      'nl': '',
    },
    '3d0ocahk': {
      'en': 'Type of Appointment',
      'bg': '',
      'nl': '',
    },
    '1zsk82u8': {
      'en': 'What\'s the problem?',
      'bg': '',
      'nl': '',
    },
    '76s1zv0c': {
      'en': 'Choose Date & Time',
      'bg': '',
      'nl': '',
    },
    '4rh2mp01': {
      'en': 'Cancel',
      'bg': '',
      'nl': '',
    },
    'ydrmvl5o': {
      'en': 'Book Now',
      'bg': '',
      'nl': '',
    },
  },
  // bookingOld
  {
    '114qw7tk': {
      'en': 'Book Appointment',
      'bg': '',
      'nl': '',
    },
    '2w7mi07k': {
      'en':
          'Fill out the information below in order to book your appointment with our office.',
      'bg': '',
      'nl': '',
    },
    'z1qh2h37': {
      'en': 'Email Address',
      'bg': '',
      'nl': '',
    },
    'r9qndv5j': {
      'en': 'Booking For',
      'bg': '',
      'nl': '',
    },
    'z8eamycr': {
      'en': 'Doctors Visit',
      'bg': '',
      'nl': '',
    },
    'pc2mn3pg': {
      'en': 'Routine Checkup',
      'bg': '',
      'nl': '',
    },
    'beco5gtl': {
      'en': 'Scan/Update',
      'bg': '',
      'nl': '',
    },
    'altbwe15': {
      'en': 'Type of Appointment',
      'bg': '',
      'nl': '',
    },
    'sxzxmlie': {
      'en': 'What\'s the problem?',
      'bg': '',
      'nl': '',
    },
    '9f3f3b4a': {
      'en': 'Choose Date',
      'bg': '',
      'nl': '',
    },
    '9gxzk9nn': {
      'en': 'Cancel',
      'bg': '',
      'nl': '',
    },
    '2uiiw86o': {
      'en': 'Book Now',
      'bg': '',
      'nl': '',
    },
  },
  // editBooking
  {
    'jvdagudu': {
      'en': 'Edit Appointment',
      'bg': '',
      'nl': '',
    },
    'kfwg0uer': {
      'en': 'Edit the fields below in order to change your appointment.',
      'bg': '',
      'nl': '',
    },
    'ckfo4lke': {
      'en': 'Emails will be sent to:',
      'bg': '',
      'nl': '',
    },
    'fifypa5r': {
      'en': 'Booking For',
      'bg': '',
      'nl': '',
    },
    'mfbe8ytp': {
      'en': 'Type of Appointment',
      'bg': '',
      'nl': '',
    },
    'jjmdih9x': {
      'en': 'Doctors Visit',
      'bg': '',
      'nl': '',
    },
    'iuozni7f': {
      'en': 'Routine Checkup',
      'bg': '',
      'nl': '',
    },
    'rnnep5hs': {
      'en': 'Scan/Update',
      'bg': '',
      'nl': '',
    },
    'cstmdk7f': {
      'en': 'What\'s the problem?',
      'bg': '',
      'nl': '',
    },
    'xpyhpkaz': {
      'en': 'Choose Date',
      'bg': '',
      'nl': '',
    },
    'szx5vcls': {
      'en': 'Cancel',
      'bg': '',
      'nl': '',
    },
    't0glzhju': {
      'en': 'Save Changes',
      'bg': '',
      'nl': '',
    },
  },
  // EmptyList
  {
    'ss30nysw': {
      'en': 'No Appointments!',
      'bg': '',
      'nl': '',
    },
    'a70bxtwb': {
      'en':
          'You are all caught! No appointments scheduled, need an appointment? Schedule one now.',
      'bg': '',
      'nl': '',
    },
    'k08b22ec': {
      'en': 'Schedule',
      'bg': '',
      'nl': '',
    },
  },
  // wildflowerDetailsComponent
  {
    'f019uhuc': {
      'en': 'Wildflower Details',
      'bg': '',
      'nl': '',
    },
    'evu2fx18': {
      'en': 'Wildflower Name',
      'bg': '',
      'nl': '',
    },
    'nf9vmeoo': {
      'en': 'Scientific Name',
      'bg': '',
      'nl': '',
    },
    'u2eesu2i': {
      'en':
          'This wildflower is native to the region and can be found in various habitats such as meadows, forests, and along roadsides. It blooms in the spring and attracts a variety of pollinators.',
      'bg': '',
      'nl': '',
    },
    'lraa6o3v': {
      'en': 'Button',
      'bg': '',
      'nl': '',
    },
    'o1rrlzx6': {
      'en': 'Height',
      'bg': '',
      'nl': '',
    },
    '0fwnu2w4': {
      'en': 'Bloom Time',
      'bg': '',
      'nl': '',
    },
    'nz3cf73l': {
      'en': 'Habitat',
      'bg': '',
      'nl': '',
    },
    'wd9n3v6s': {
      'en': 'Height',
      'bg': '',
      'nl': '',
    },
    'liykzkzn': {
      'en': 'Additional Information',
      'bg': '',
      'nl': '',
    },
    'usf779pb': {
      'en':
          'This wildflower is an important source of nectar for bees and butterflies, as well as a host plant for various caterpillar species. It is also used in traditional medicine for its various health benefits.',
      'bg': '',
      'nl': '',
    },
  },
  // observationDetailComponent
  {
    'pb3clekl': {
      'en': 'Observation Details',
      'bg': '',
      'nl': '',
    },
    'rfjaktl9': {
      'en': 'Wildflower Name',
      'bg': '',
      'nl': '',
    },
    'w6fd2e7t': {
      'en': 'Scientific Name',
      'bg': '',
      'nl': '',
    },
    '0x3fuc11': {
      'en': 'Count',
      'bg': '',
      'nl': '',
    },
    'as7zednd': {
      'en': '5',
      'bg': '',
      'nl': '',
    },
    'j5vaddqz': {
      'en': 'Location',
      'bg': '',
      'nl': '',
    },
    'qx2fso4l': {
      'en': 'Central Park, New York',
      'bg': '',
      'nl': '',
    },
    'y7p4m6dj': {
      'en': 'Date & Time',
      'bg': '',
      'nl': '',
    },
    'tszirqbm': {
      'en': 'July 20, 2021 - 10:30am',
      'bg': '',
      'nl': '',
    },
    '049jxt11': {
      'en': 'Unlocked Medal',
      'bg': '',
      'nl': '',
    },
    'gqces2sd': {
      'en': 'View Wildflower Details',
      'bg': '',
      'nl': '',
    },
  },
  // medalDetailComponent
  {
    'f4axhewm': {
      'en': 'Medal Details',
      'bg': '',
      'nl': '',
    },
    '8i477rxx': {
      'en': 'Gold Medal',
      'bg': '',
      'nl': '',
    },
    '4j840j4r': {
      'en': 'Awarded for exceptional performance',
      'bg': '',
      'nl': '',
    },
    'ldn1pueb': {
      'en': 'Achievement',
      'bg': '',
      'nl': '',
    },
    'je646blr': {
      'en': 'Top 1%',
      'bg': '',
      'nl': '',
    },
    'jktsru3r': {
      'en': 'Description',
      'bg': '',
      'nl': '',
    },
    'e43yfj5k': {
      'en':
          'This medal is awarded to individuals who have demonstrated exceptional performance in their respective fields. Recipients of this prestigious award have shown dedication, hard work, and a commitment to excellence.',
      'bg': '',
      'nl': '',
    },
    'tzaete1p': {
      'en': 'View Challenge Details',
      'bg': '',
      'nl': '',
    },
  },
  // challengeDetailComponent
  {
    '1ec7cs18': {
      'en': 'Challenge Details',
      'bg': '',
      'nl': '',
    },
    '3cuvkg0k': {
      'en': 'Weekly Eindhoven Challenge',
      'bg': '',
      'nl': '',
    },
    'tdj3sgrk': {
      'en': 'Start Date: 01/01/2023',
      'bg': '',
      'nl': '',
    },
    'uahv9fqr': {
      'en':
          'Join our Weekly Eindhoven challenge to kickstart your journey. Participate, track your progress, and share your results with the community.',
      'bg': '',
      'nl': '',
    },
    'd61fqtlk': {
      'en': '30 Days',
      'bg': '',
      'nl': '',
    },
    'vrao41jx': {
      'en': 'All Levels',
      'bg': '',
      'nl': '',
    },
    '3vp5z5s9': {
      'en': 'Online',
      'bg': '',
      'nl': '',
    },
    'qibaovap': {
      'en': 'Join Challenge',
      'bg': '',
      'nl': '',
    },
  },
  // Miscellaneous
  {
    'p4r7i0za': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'qsawm9x9': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'dldx03oe': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    '1nl6t0i4': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'ca9n97rz': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'n85vnla5': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'f7dlg6oq': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    '2tmjmheh': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    '2ryu9a2o': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    '1zkn87x8': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'j6u4g0z7': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'ossqj8fz': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'wyt7kexi': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'dxjrtuyy': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    '9kot7qzw': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'h32aumn9': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'n90wx8on': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'av58sm58': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    '64sb3bru': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'wl4gii88': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'gkn4bd9l': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'p0utiy4b': {
      'en': '',
      'bg': '',
      'nl': '',
    },
    'q7t2w0wv': {
      'en': '',
      'bg': '',
      'nl': '',
    },
  },
].reduce((a, b) => a..addAll(b));
