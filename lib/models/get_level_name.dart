 getLevelString(level)
  {
      switch (level)
      {
        case '1':
          return 'الصف الأول';

        case '2':
          return 'الصف الثاني';

        case '3':
          return 'الصف الثالث';

        case '4':
          return 'الصف الرابع';

        case '5':
          return 'الصف الخامس';

        case '6':
          return 'الصف السادس';

        case '7':
          return 'الصف السابع';

        case '8':
          return 'الصف الثامن';

        case '9':
          return 'الصف التاسع';

        case '10':
          return 'الصف الأول ثانوي ';

        case '11':
          return 'الصف الثاني ثانوي';

        case '12':
          return 'الصف الثالث ثانوي';

        default:
          return 'غير محدد';

      }
  }