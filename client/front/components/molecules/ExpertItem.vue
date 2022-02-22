<template>
  <div class="px-5 py-6 hover:bg-light">
    <div class="flex">
      <div class="mr-6 flex-shrink">
        <img
          class="inline-block h-16 w-16 rounded-full"
          :src="item.user.photo"
          alt=""
        />
      </div>
      <div>
        <div class="font-bold">{{ item.user.fullName }}</div>
        <div>
          {{ item.skillTitle }}
        </div>
      </div>
    </div>
    <div class="grid grid-cols-3 mt-4">
      <div>{{ yen(item.price) }} / hr</div>
      <JobSuccess :percent="90" />
      <TopRated />
    </div>
    <div
      class="description mt-4 cursor-default"
      v-html="item.description"
    ></div>

    <div class="flex mt-4 space-x-2 flex-nowrap no-scrollbar overflow-x-auto">
      <span
        v-for="(skill, index) in skills"
        :key="index"
        class="
          inline-flex
          items-center
          px-2.5
          py-0.5
          rounded-full
          text-xs
          font-medium
          bg-yellow-100
          text-yellow-800
          cursor-default
          flex-none
        "
      >
        {{ skill.name }}
      </span>
    </div>
  </div>
</template>

<script>
import { yen } from '@/utils/format'
import TopRated from '@/components/atoms/page/TopRated'
import JobSuccess from '@/components/atoms/page/JobSuccess'

export default {
  components: { TopRated, JobSuccess },
  props: {
    item: {
      type: Object,
      default: () => {},
    },
  },
  data() {
    return {}
  },
  computed: {
    skills() {
      return (
        this.item.skills || [
          'Sushi cooking',
          'DJ',
          'Diving',
          'Driving',
          'magician',
          'Sushi cooking',
          'DJ',
          'Diving',
          'Driving',
          'magician',
          'Sushi cooking',
          'Driving',
          'Driving',
          'Driving',
          'magician',
          'Sushi cooking',
          'DJ',
          'Diving',
          'Driving',
          'magician',
        ]
      )
    },
  },
  methods: {
    yen(...args) {
      return yen(...args)
    },
  },
}
</script>

<style lang="scss" scoped>
.description {
  overflow: hidden;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
}
.no-scrollbar {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
.no-scrollbar::-webkit-scrollbar {
  display: none;
}
.progress_bar {
  max-width: 130px;
}
</style>
