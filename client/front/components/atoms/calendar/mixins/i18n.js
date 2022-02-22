import settings from '@/components/atoms/calendar/config'
import languages from '@/components/atoms/calendar/utils/languages'

export default {
  data() {
    return {
      translations: settings.translations,
    }
  },
  mounted() {
    this.translations = languages.getTranslation(settings.locale)
  },
  computed: {
    locale() {
      return settings.locale
    },
    dayOffset() {
      return settings.firstDay
    },
    showMoreLabel() {
      return this.translations.showMore
    },
    yearSuffix() {
      return settings.yearSuffix || null
    },
  },
  methods: {
    printDay(day) {
      const field = settings.fullDayNames ? 'dayNameLong' : 'dayNameShort'
      const dayIndex = parseInt(day + this.dayOffset) % 7

      return this.translations[field][dayIndex]
    },
    printMonth(month) {
      const field = settings.fullMonthNames ? 'monthNameLong' : 'monthNameShort'
      return this.translations[field][month]
    },
  },
}
