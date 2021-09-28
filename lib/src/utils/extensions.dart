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
     'el_gr' : 'αρχική σελίδα'
   }+{
     'en_us' : 'Halal product scanning',
     'tr_tu' : 'Helal ürün taraması',
     'el_gr' : 'Χαλάλ σάρωση προϊόντων'
   }+{
     'en_us' : 'Setting',
     'tr_tu' : 'Ayar',
     'el_gr' : 'Σύνθεση'
   }+{
     'en_us' : 'Religious days',
     'tr_tu' : 'dini günler',
     'el_gr' : 'Θρησκευτικές ημέρες'
   }+{
     'en_us' : 'time',
     'tr_tu' : 'saat',
     'el_gr' : 'χρόνος'
   }+{
     'en_us' : 'Now it\'s Morning time',
     'tr_tu' : 'şimdi sabah vakti',
     'el_gr' : 'τώρα είναι πρωινή ώρα'
   }+{
     'en_us' : 'Now it\'s Sunrise time',
     'tr_tu' : 'şimdi Gündoğumu zamanı',
     'el_gr' : 'τώρα είναι η ώρα της Ανατολής'
   }+{
     'en_us' : 'Now it\'s Noon time',
     'tr_tu' : 'şimdi öğle vakti',
     'el_gr' : 'τώρα είναι ώρα Μεσημέρι'
   }+{
     'en_us' : 'Now it\'s Afternoon time',
     'tr_tu' : 'şimdi öğleden sonra zamanı',
     'el_gr' : 'τωρα ειναι απογευματινη ωρα'
   }+{
     'en_us' : 'Now it\'s Evening time',
     'tr_tu' : 'şimdi akşam vakti',
     'el_gr' : 'τώρα είναι ώρα Βράδυ'
   }+{
     'en_us' : 'Now it\'s Night time',
     'tr_tu' : 'şimdi gece vakti',
     'el_gr' : 'τώρα είναι νύχτα'
   }+{
     'en_us' : 'Morning',
     'tr_tu' : 'sabah',
     'el_gr' : 'πρωί'
   }+{
     'en_us' : 'Sunrise',
     'tr_tu' : 'gündoğumu',
     'el_gr' : 'Ανατολή ηλίου'
   }+{
     'en_us' : 'Noon',
     'tr_tu' : 'Öğle vakti',
     'el_gr' : 'Μεσημέρι'
   }+{
     'en_us' : 'Afternoon',
     'tr_tu' : 'Öğleden sonra',
     'el_gr' : 'Απόγευμα'
   }+{
     'en_us' : 'Evening',
     'tr_tu' : 'Akşam',
     'el_gr' : 'Απόγευμα'
   }+{
     'en_us' : 'Night',
     'tr_tu' : 'Gece',
     'el_gr' : 'Νύχτα'
   }+{
     'en_us' : 'Morning azan',
     'tr_tu' : 'Sabah ezanı',
     'el_gr' : 'Πρωινό αζάν'
   }+{
     'en_us' : 'Noon azan',
     'tr_tu' : 'öğle ezanı',
     'el_gr' : 'Μεσημέρι αζάν'
   }+{
     'en_us' : 'Afternoon azan',
     'tr_tu' : 'ikindi ezan',
     'el_gr' : 'Απογευματινό αζάν'
   }+{
     'en_us' : 'Evening azan',
     'tr_tu' : 'Akşam ezanı',
     'el_gr' : 'Βραδινό αζάν'
   }+{
     'en_us' : 'Night azan',
     'tr_tu' : 'gece ezanı',
     'el_gr' : 'Νυχτερινό αζάν'
   }+{
     'en_us' : 'everyday',
     'tr_tu' : 'Her gün',
     'el_gr' : 'κάθε μέρα'
   }+{
     'en_us' : 'Reminder of Morning prayer',
     'tr_tu' : 'Sabah Namazının Hatırlatılması',
     'el_gr' : 'Πρωινή προσευχή'
   }+{
     'en_us' : 'Reminder of Noon prayer',
     'tr_tu' : 'Öğle namazının Hatırlatılması',
     'el_gr' : 'Προσευχή το μεσημέρι'
   }+{
     'en_us' : 'Reminder of Afternoon prayer',
     'tr_tu' : 'İkindi Namazının Hatırlatılması',
     'el_gr' : 'Απογευματινή προσευχή'
   }+{
     'en_us' : 'Reminder of Sunset prayer',
     'tr_tu' : 'Gün batımı duasının Hatırlatılması',
     'el_gr' : 'Προσευχή ηλιοβασιλέματος'
   }+{
     'en_us' : 'Reminder of Night prayer',
     'tr_tu' : 'Gece namazının Hatırlatılması',
     'el_gr' : 'Νυχτερινή προσευχή'
   }+{
     'en_us' : 'Azan',
     'tr_tu' : 'ezan',
     'el_gr' : 'Αζάν'
   }+{
     'en_us' : 'Reminders',
     'tr_tu' : 'hatırlatıcılar',
     'el_gr' : 'Υπενθυμίσεις'
   }+{
     'en_us' : 'Language',
     'tr_tu' : 'hatırlatıcılar',
     'el_gr' : 'Υπενθυμίσεις'
   };
}
