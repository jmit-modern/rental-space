import validateLanguage from './language-validator'

export default {
  getTranslation(locale) {
    return locale in this.languages ? this.languages[locale] : this.languages.en
  },
  addLanguage(languages) {
    // validate the passed lang objects (returns list with valid keys)
    const valid = validateLanguage(languages)

    // Add valid languages to the lang set.
    this.languages = Object.assign(
      this.languages,
      Object.keys(languages)
        .filter((key) => key in valid)
        .reduce((obj, key) => {
          obj[key] = languages[key]
          return obj
        }, {})
    )
  },

  // Default app languages
  languages: {
    en: {
      showMore: 'Show more',
      dayNameShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      dayNameLong: [
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
      ],
      monthNameShort: [
        'Jan.',
        'Feb.',
        'Mar.',
        'Apr.',
        'May',
        'June',
        'July',
        'Aug.',
        'Sept.',
        'Oct.',
        'Nov.',
        'Dec.',
      ],
      monthNameLong: [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ],
    },
    zh: {
      showMore: '展示更多',
      dayNameShort: ['日', '一', '二', '三', '四', '五', '六'],
      dayNameLong: [
        '星期日',
        '星期一',
        '星期二',
        '星期三',
        '星期四',
        '星期五',
        '星期六',
      ],
      monthNameShort: [
        '一月',
        '二月',
        '三月',
        '四月',
        '五月',
        '六月',
        '七月',
        '八月',
        '九月',
        '十月',
        '十一月',
        '十二月',
      ],
      monthNameLong: [
        '一月',
        '二月',
        '三月',
        '四月',
        '五月',
        '六月',
        '七月',
        '八月',
        '九月',
        '十月',
        '十一月',
        '十二月',
      ],
    },
    ja: {
      showMore: 'もっと見せる',
      dayNameShort: ['日', '月', '火', '水', '木', '金', '土'],
      dayNameLong: [
        '日曜日',
        '月曜日',
        '火曜日',
        '水曜日',
        '木曜日',
        '金曜日',
        '土曜日',
      ],
      monthNameShort: [
        '1月',
        '2月',
        '3月',
        '4月',
        '5月',
        '6月',
        '7月',
        '8月',
        '9月',
        '10月',
        '11月',
        '12月',
      ],
      monthNameLong: [
        '1月',
        '2月',
        '3月',
        '4月',
        '5月',
        '6月',
        '7月',
        '8月',
        '9月',
        '10月',
        '11月',
        '12月',
      ],
    },
    fr: {
      showMore: 'Afficher plus',
      dayNameShort: ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'],
      dayNameLong: [
        'Dimanche',
        'Lundi',
        'Mardi',
        'Mercredi',
        'Jeudi',
        'Vendredi',
        'Samedi',
      ],
      monthNameShort: [
        'Jan.',
        'Fév.',
        'Mar.',
        'Avr.',
        'Mai',
        'Juin',
        'Juil',
        'Aou.',
        'Sep.',
        'Oct.',
        'Nov.',
        'Déc.',
      ],
      monthNameLong: [
        'Janvier',
        'Février',
        'Mars',
        'Avril',
        'Mai',
        'Juin',
        'Juillet',
        'Août',
        'Septembre',
        'Octobre',
        'Novembre',
        'Décembre',
      ],
    },
    de: {
      showMore: 'Weitere anzeigen',
      dayNameShort: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
      dayNameLong: [
        'Sonntag',
        'Montag',
        'Dienstag',
        'Mittwoch',
        'Donnerstag',
        'Freitag',
        'Samstag',
      ],
      monthNameShort: [
        'Jan',
        'Feb',
        'Mrz',
        'Apr',
        'Mai',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Okt',
        'Nov',
        'Dez',
      ],
      monthNameLong: [
        'Januar',
        'Februar',
        'März',
        'April',
        'Mai',
        'Juni',
        'Juli',
        'August',
        'September',
        'Oktober',
        'November',
        'Dezember',
      ],
    },
    ru: {
      showMore: 'Показать больше',
      dayNameShort: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
      dayNameLong: [
        'Воскресенье',
        'Понедельник',
        'Вторник',
        'Среда',
        'Четверг',
        'Пятница',
        'Суббота',
      ],
      monthNameShort: [
        'Янв.',
        'Фев.',
        'Март.',
        'Апр.',
        'Май',
        'Июнь',
        'Июль',
        'Авг.',
        'Сент.',
        'Окт.',
        'Ноя.',
        'Дек.',
      ],
      monthNameLong: [
        'Январь',
        'Февраль',
        'Март',
        'Апрель',
        'Май',
        'Июнь',
        'Июль',
        'Август',
        'Сентябрь',
        'Октябрь',
        'Ноябрь',
        'Декабрь',
      ],
    },
  },
}
