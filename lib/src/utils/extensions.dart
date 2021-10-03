import 'package:prayer_times_flutter/src/utils/size_config.dart';
import "package:i18n_extension/i18n_extension.dart";

extension DoubleExt on double {
  double get rt {
    return this * SizeConfig.textMultiplier!;
  }

  double get rw {
    return this * SizeConfig.widthMultiplier!;
  }

  double get rh {
    return this * SizeConfig.heightMultiplier!;
  }
}

extension IntExt on int {
  String get timePadded {
    if (this.toString().length == 1) {
      return this.toString().padLeft(2, '0');
    } else {
      return this.toString();
    }
  }
}

extension Localization on String {
String get i18n => localize(this, t);
static var t = Translations("en_us") +
   {
     'en_us' : 'Home Page',
     'tr_tu' : 'ana sayfa',
     'el_gr' : 'Αρχική Σελίδα'
   }+{
     'en_us' : 'Halal product scanning',
     'tr_tu' : 'Helal ürün taraması',
     'el_gr' : 'Χαλάλ σάρωση προϊόντων'
   }+{
     'en_us' : 'Setting',
     'tr_tu' : 'Ayar',
     'el_gr' : 'Αρχική Σελίδα'
   }+{
     'en_us' : 'Religious days',
     'tr_tu' : 'Dini Günler/Geceler',
     'el_gr' : 'Ιερές Ημέρες/Νύχτες'
   }+{
     'en_us' : 'time',
     'tr_tu' : 'Vakit',
     'el_gr' : 'Ωρα'
   }+{
     'en_us' : 'Now it\'s Morning time',
     'tr_tu' : 'İmsak vakti',
     'el_gr' : 'Ωρα Εναρξης Νηστείας'
   }+{
     'en_us' : 'Now it\'s Sunrise time',
     'tr_tu' : 'Güneş Vakti',
     'el_gr' : 'Ανατολή Του Ηλίου'
   }+{
     'en_us' : 'Now it\'s Noon time',
     'tr_tu' : 'Öğle Vakti',
     'el_gr' : 'Μεσημεριανή Ωρα'
   }+{
     'en_us' : 'Now it\'s Afternoon time',
     'tr_tu' : 'İkindi Vakti',
     'el_gr' : 'Απογευματινή Ωρα'
   }+{
     'en_us' : 'Now it\'s Evening time',
     'tr_tu' : 'Akşam Vakti',
     'el_gr' : 'Βραδυνή Ωρα'
   }+{
     'en_us' : 'Now it\'s Night time',
     'tr_tu' : 'Yatsı Vakti',
     'el_gr' : 'Νυχτερινή Ωρα'
   }+{
     'en_us' : 'Morning',
     'tr_tu' : 'İmsak',
     'el_gr' : 'Ωρα Εναρξης Νηστείας'
   }+{
     'en_us' : 'Sunrise',
     'tr_tu' : 'Güneş',
     'el_gr' : 'Ανατολή Του Ηλίου'
   }+{
     'en_us' : 'Noon',
     'tr_tu' : 'Öğle',
     'el_gr' : 'Μεσημεριανή Ωρα'
   }+{
     'en_us' : 'Afternoon',
     'tr_tu' : 'İkindi',
     'el_gr' : 'Απογευματινή Ωρα'
   }+{
     'en_us' : 'Evening',
     'tr_tu' : 'Akşam',
     'el_gr' : 'Βραδυνή Ωρα'
   }+{
     'en_us' : 'Night',
     'tr_tu' : 'Yatsı',
     'el_gr' : 'Νυχτερινή Ωρα'
   }+{
     'en_us' : 'Morning azan',
     'tr_tu' : 'Sabah Ezanı',
     'el_gr' : 'Κάλεσμα  Fajr'
   }+{
     'en_us' : 'Noon azan',
     'tr_tu' : 'Öğle Ezanı',
     'el_gr' : 'Κάλεσμα Duhr'
   }+{
     'en_us' : 'Afternoon azan',
     'tr_tu' : 'İkindi Ezanı',
     'el_gr' : 'Κάλεσμα Asr'
   }+{
     'en_us' : 'Evening azan',
     'tr_tu' : 'Akşam Ezanı',
     'el_gr' : 'Κάλεσμα Maghrib'
   }+{
     'en_us' : 'Night azan',
     'tr_tu' : 'Yatsı Ezanı',
     'el_gr' : 'Κάλεσμα Isha'
   }+{
     'en_us' : 'everyday',
     'tr_tu' : 'Her gün',
     'el_gr' : 'Κάθε ημέρα'
   }+{
     'en_us' : 'Reminder of Morning prayer',
     'tr_tu' : 'Sabah namazı ezanı',
     'el_gr' : 'Κάλεσμα Προσευχής  Fajr'
   }+{
     'en_us' : 'Reminder of Noon prayer',
     'tr_tu' : 'Öğle namazı ezanı',
     'el_gr' : 'Κάλεσμα Προσευχής Duhr'
   }+{
     'en_us' : 'Reminder of Afternoon prayer',
     'tr_tu' : 'İkindi namazı ezanı',
     'el_gr' : 'Κάλεσμα Προσευχής Asr'
   }+{
     'en_us' : 'Reminder of Sunset prayer',
     'tr_tu' : 'Akşam namazı ezanı',
     'el_gr' : 'Κάλεσμα Προσευχής Maghrib'
   }+{
     'en_us' : 'Reminder of Night prayer',
     'tr_tu' : 'Yatsı namazı ezanı',
     'el_gr' : 'ΝΚάλεσμα Προσευχής Isha'
   }+{
     'en_us' : 'Azan',
     'tr_tu' : 'Ezan',
     'el_gr' : 'Κάλεσμα'
   }+{
     'en_us' : 'Reminders',
     'tr_tu' : 'Hatırlatma',
     'el_gr' : 'Υπενθήμηση'
   }+{
     'en_us' : 'Language',
     'tr_tu' : 'Dil',
     'el_gr' : 'Γλώσσα'
   };
}
