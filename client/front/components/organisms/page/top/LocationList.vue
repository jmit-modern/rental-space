<template>
  <div
    class="
      grid grid-cols-1
      lg:grid-cols-4
      gap-4
      lg:gap-8
      items-center
      px-4
      py-5
      border-b border-gray-300
    "
  >
    <div class="label">
      <h5 class="font-bold text-primary">
        {{ $t('top.locationList.title') }}
      </h5>
    </div>
    <div class="col-span-3">
      <div class="grid grid-cols-6 gap-4">
        <nuxt-link
          v-for="(location, index) in locations"
          :key="location"
          :to="`/space?area=${index}`"
          class="
            border border-gray-300
            text-center
            py-1.5
            rounded-sm
            bg-light
            text-primary
            hover:bg-orange hover:text-main hover:border-current
          "
        >
          {{ location }}</nuxt-link
        >
      </div>
    </div>
  </div>
</template>

<script>
const locations = [
  '北海道',
  '岩手',
  '茨城',
  '群馬',
  '埼玉',
  '千葉',
  '東京',
  '神奈川',
  '富山',
  '石川',
  '長野',
  '静岡',
  '愛知',
  '三重',
  '京都',
  '大阪',
  '兵庫',
  '奈良',
  '和歌山',
  '福岡',
  '宮崎',
  '沖縄',
]
export default {
  data() {
    return {
      locations,
    }
  },
}
</script>
