<template>
  <div class="flex">
    <a href="" class="w-48 h-48">
      <img
        :src="owner.photo"
        alt=""
        class="
          shadow
          rounded-full
          max-w-full
          h-auto
          align-middle
          border-none
          hover:opacity-80
        "
      />
    </a>
    <div class="ml-6">
      <div class="text-lg flex items-center mb-4">
        <a href="" class="text-primary mr-3"> {{ owner.username }} </a>
        <div class="text-sm">
          登録日 {{ dayjs(registerDate).format('YYYY/MM/DD') }}
        </div>
      </div>
      <div class="mb-2">
        {{ owner.description }}
      </div>
      <a :href="`/user/${owner.id}`" class="hover:underline"
        >ホストについてもっと詳しく</a
      >
    </div>
  </div>
</template>

<script>
import dayjs from 'dayjs'
export default {
  props: {
    owner: {
      type: Object,
      default: () => ({}),
    },
  },
  computed: {
    registerDate() {
      return this.owner.createdAt
    },
  },
  methods: {
    dayjs(...args) {
      return dayjs(...args)
    },
  },
}
</script>
