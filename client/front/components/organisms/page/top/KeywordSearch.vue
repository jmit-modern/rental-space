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
        {{ $t('top.keywordSearch.label') }}
      </h5>
    </div>
    <div class="col-span-3 mt-1 relative">
      <input
        id="keyword"
        v-model="inputs.keywords"
        type="text"
        name="keyword"
        class="
          min-w-0
          block
          w-full
          px-3
          py-2
          rounded-md
          focus:ring-current focus:border-current
          sm:text-sm
          border-gray-300
          pr-12
          bg-light
        "
        :placeholder="$t('top.keywordSearch.placeholder')"
        @keyup.enter="handleSearchKeywords"
      />
      <span
        class="
          inline-flex
          absolute
          -inset-y-0
          right-0
          items-center
          px-3
          rounded-r-md
          text-gray-500
          sm:text-sm
          cursor-pointer
        "
        @click="handleSearchKeywords"
      >
        <outline-search-icon class="w-6 h-6" stroke="#000" />
      </span>
    </div>
  </div>
</template>

<script>
export default {
  components: {},
  data() {
    return {
      inputs: {
        keywords: '',
      },
    }
  },
  computed: {},
  methods: {
    handleSearchKeywords() {
      this.$emit('search', this.inputs)
    },
  },
}
</script>
