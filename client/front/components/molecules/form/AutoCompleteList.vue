<template>
  <div>
    <div class="flex w-full space-x-2">
      <auto-complete
        v-model.trim="newItem"
        :data="chooseOptions"
        placeholder="スキルを検索"
        wrapper-class="flex-1 min-w-0"
        @chosen="handleChosen"
      ></auto-complete>
      <button
        class="
          flex-initial
          inline-flex
          items-center
          px-6
          py-2
          border border-transparent
          shadow-sm
          text-base
          font-bold font-medium
          rounded-md
          text-main
          bg-orange
          focus:outline-none
          hover:opacity-80
          cursor-pointer
        "
        @click.prevent="addItem"
        :disabled="!newItem"
      >
        スキルを追加する
      </button>
    </div>
    <div class="mt-4 space-x-4">
      <BadgeClose
        v-for="item in items"
        :key="item.code"
        :value="item.name"
        @close="handleRemove"
      />
    </div>
  </div>
</template>

<script>
import AutoComplete from '@/components/atoms/input/AutoComplete'
import BadgeClose from '@/components/atoms/badges/BadgeClose'

export default {
  components: {
    AutoComplete,
    BadgeClose,
  },
  props: {
    value: {
      type: Array,
      default: null,
    },
    list: {
      type: Array,
      default: () => [],
    },
    chooseOptions: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      newItem: null,
    }
  },
  computed: {
    items() {
      return this.list || []
    },
  },
  methods: {
    addItem() {
      this.$emit('add', this.newItem)
      this.newItem = null
    },
    handleChosen(item) {
      this.$emit('chosen', item)
      this.newItem = null
    },
    handleRemove(item) {
      this.$emit('remove', item)
    },
  },
}
</script>
