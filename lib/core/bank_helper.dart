class BankHelper {
  static String asset = 'assets/banks';
  static BankHelperModel? getBankByBin(String bin) {
    if (bin.length >= 6 &&
        iranianBanks.any((element) => bin.startsWith(element.bin ?? ''))) {
      return iranianBanks
          .firstWhere((element) => bin.startsWith(element.bin ?? ''));
    }
    return BankHelperModel();
  }

  static List<BankHelperModel> iranianBanks = [
    BankHelperModel(
      englishName: 'Eghtesad Novin',
      persianName: 'بانک اقتصاد نوین',
      bin: '627412',
      asset: '$asset/Eghtesad_Novin.svg',
    ),
    BankHelperModel(
      englishName: 'Ansar (Sepah)',
      persianName: 'بانک (سپه) انصار',
      bin: '627381',
      asset: '$asset/Ansar.svg',
    ),
    BankHelperModel(
      englishName: 'Iran Zamin',
      persianName: 'بانک ایران زمین',
      bin: '505785',
      asset: '$asset/Iran_Zamin.svg',
    ),
    BankHelperModel(
      englishName: 'Parsian',
      persianName: 'بانک پارسیان',
      bin: '622106',
      asset: '$asset/Parsian.svg',
    ),
    BankHelperModel(
      englishName: 'Pasargad',
      persianName: 'بانک پاسارگاد',
      bin: '639347',
      asset: '$asset/Pasargad.svg',
    ),
    BankHelperModel(
      englishName: 'Ayandeh',
      persianName: 'بانک آینده',
      bin: '636214',
      asset: '$asset/Ayandeh.svg',
    ),
    BankHelperModel(
      englishName: 'Tejarat',
      persianName: 'بانک تجارت',
      bin: '627353',
      asset: '$asset/Tejarat.svg',
    ),
    BankHelperModel(
      englishName: 'Tosee Taavon',
      persianName: 'بانک توسعه تعاون',
      bin: '502908',
      asset: '$asset/Tosee_Taavon.svg',
    ),
    BankHelperModel(
      englishName: 'Tosee Saderat',
      persianName: 'بانک توسعه صادرات ایران',
      bin: '627648',
      asset: '$asset/Tosee_Saderat.svg',
    ),
    BankHelperModel(
      englishName: 'Hekmat (Sepah)',
      persianName: 'بانک حکمت ایرانیان (سپه)',
      bin: '636949',
      asset: '$asset/Hekmat.svg',
    ),
    BankHelperModel(
      englishName: 'Dey',
      persianName: 'بانک دی',
      bin: '502938',
      asset: '$asset/Dey.svg',
    ),
    BankHelperModel(
      englishName: 'Refah',
      persianName: 'بانک رفاه کارگران',
      bin: '589463',
      asset: '$asset/Refah.svg',
    ),
    BankHelperModel(
      englishName: 'Saman',
      persianName: 'بانک سامان',
      bin: '621986',
      asset: '$asset/Saman.svg',
    ),
    BankHelperModel(
      englishName: 'Sepah',
      persianName: 'بانک سپه',
      bin: '589210',
      asset: '$asset/Sepah.svg',
    ),
    BankHelperModel(
      englishName: 'Sarmayeh',
      persianName: 'بانک سرمایه',
      bin: '639607',
      asset: '$asset/Sarmayeh.svg',
    ),
    BankHelperModel(
      englishName: 'Sina',
      persianName: 'بانک سینا',
      bin: '639346',
      asset: '$asset/Sina.svg',
    ),
    BankHelperModel(
      englishName: 'Shahr',
      persianName: 'بانک شهر',
      bin: '502806',
      asset: '$asset/Shahr.svg',
    ),
    BankHelperModel(
      englishName: 'Saderat',
      persianName: 'بانک صادرات ایران',
      bin: '603769',
      asset: '$asset/Saderat.svg',
    ),
    BankHelperModel(
      englishName: 'Sanat Madan',
      persianName: 'بانک صنعت و معدن',
      bin: '627961',
      asset: '$asset/Sanat_Madan.svg',
    ),
    BankHelperModel(
      englishName: 'Mehr Iran',
      persianName: 'بانک قرض الحسنه مهر ایران',
      bin: '606373',
      asset: '$asset/Mehr_Iran.svg',
    ),
    BankHelperModel(
      englishName: 'Ghavamin (Sepah)',
      persianName: 'بانک (سپه) قوامین',
      bin: '639599',
      asset: '$asset/Ghavamin.svg',
    ),
    BankHelperModel(
      englishName: 'Karafarin',
      persianName: 'بانک کارآفرین',
      bin: '627488',
      asset: '$asset/Karafarin.svg',
    ),
    BankHelperModel(
      englishName: 'Keshavarzi',
      persianName: 'بانک کشاورزی',
      bin: '603770',
      asset: '$asset/Keshavarzi.svg',
    ),
    BankHelperModel(
      englishName: 'Gardeshgari',
      persianName: 'بانک گردشگری',
      bin: '505416',
      asset: '$asset/Gardeshgari.svg',
    ),
    BankHelperModel(
      englishName: 'Markazi',
      persianName: 'بانک مرکزی جمهوری اسلامی ایران',
      bin: '636795',
      asset: '$asset/Bank_Markazi.svg',
    ),
    BankHelperModel(
      englishName: 'Maskan',
      persianName: 'بانک مسکن',
      bin: '628023',
      asset: '$asset/Maskan.svg',
    ),
    BankHelperModel(
      englishName: 'Mellat',
      persianName: 'بانک ملت',
      bin: '610433',
      asset: '$asset/Mellat.svg',
    ),
    BankHelperModel(
      englishName: 'Melli',
      persianName: 'بانک ملی ایران',
      bin: '603799',
      asset: '$asset/Melli.svg',
    ),
    BankHelperModel(
      englishName: 'Mehr Eghtesad (Sepah)',
      persianName: 'بانک مهر اقتصاد (سپه)',
      bin: '639370',
      asset: '$asset/Mehr_Eghtesad.svg',
    ),
    BankHelperModel(
      englishName: 'Postbank',
      persianName: 'بانک پست ایران',
      bin: '627760',
      asset: '$asset/Postbank.svg',
    ),
    BankHelperModel(
      englishName: 'Tosee',
      persianName: 'موسسه اعتباری توسعه',
      bin: '628157',
      asset: '$asset/Tosee.svg',
    ),
    BankHelperModel(
      englishName: 'Kosar (Sepah)',
      persianName: '(سپه) موسسه اعتباری کوثر',
      bin: '505801',
      asset: '$asset/Kosar.svg',
    ),
    BankHelperModel(
      englishName: 'Melall',
      persianName: 'موسسه اعتباری ملل',
      bin: '606256',
      asset: '$asset/Melall.svg',
    ),
    BankHelperModel(
      englishName: 'Resalat',
      persianName: 'بانک رسالت',
      bin: '504172',
      asset: '$asset/Resalat.svg',
    ),
    BankHelperModel(
      englishName: 'Noor',
      persianName: 'موسسه نور',
      bin: '507677',
      asset: '$asset/Noor.svg',
    ),
    BankHelperModel(
      englishName: 'Khavarmiyaneh',
      persianName: 'بانک خاورمیانه',
      bin: '585947',
      asset: '$asset/Khavar_Mianeh.svg',
    ),
  ];
}

class BankHelperModel {
  final String? englishName;

  final String? persianName;

  final String? bin;
  final String? asset;

  BankHelperModel({
     this.englishName,
     this.persianName,
     this.bin,
     this.asset,
  });
}
