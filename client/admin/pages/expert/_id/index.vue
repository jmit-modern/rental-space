<template>
  <div>
    <div class="py-8">
      <h1 class="font-bold text-2xl">Expert Detail</h1>
    </div>
    <div class="text-lg">
      <table class="w-2/3">
        <tr>
          <th class="p-3 text-left">Name</th>
          <td class="p-3">{{ expertUser.fullName }}</td>
        </tr>
        <tr>
          <th class="p-3 text-left">Title</th>
          <td class="p-3">{{ expert.skillTitle }}</td>
        </tr>
        <tr>
          <th class="p-3 text-left">Description</th>
          <td class="p-3">{{ expert.description }}</td>
        </tr>
        <tr>
          <th class="p-3 text-left">Skill</th>
          <td class="p-3">
            <div v-if="skills" class="flex mt-4 flex-wrap">
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
                  mb-4
                  mr-2
                "
              >
                {{ skill.name }}
              </span>
            </div>
          </td>
        </tr>
        <tr>
          <th class="p-3 text-left">Category</th>
          <td class="p-3">{{ category.name }}</td>
        </tr>
        <tr>
          <th class="p-3 text-left">Price</th>
          <td class="p-3">¥ {{ formatNumber(expert.price) }}</td>
        </tr>
        <tr>
          <th class="p-3 text-left">Cancellation deadline</th>
          <td class="p-3">{{ expert.cancellationDeadline }} hrs</td>
        </tr>
        <tr>
          <th class="p-3 text-left">Url</th>
          <td class="p-3">{{ expert.url }}</td>
        </tr>
        <tr>
          <th class="p-3 text-left">Language</th>
          <td class="p-3">{{ language.name }}</td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { formatNumber } from '@/utils/format'

export default {
  async fetch() {
    const { id } = this.$route.params
    await Promise.all([this.$store.dispatch('expert/fetchDetail', id)])
  },
  computed: {
    ...mapGetters({
      expert: 'expert/detail',
    }),
    expertUser() {
      return this.expert.user || {}
    },
    skills() {
      return this.expert.skills || []
    },
    category() {
      return this.expert.category || {}
    },
    language() {
      return this.expert.language || {}
    },
  },
  methods: {
    formatNumber(...args) {
      return formatNumber(...args)
    },
  },
}
</script>
