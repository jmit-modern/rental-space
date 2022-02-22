<template>
  <div class="card">
    <header class="card-header">
      <ul class="flex border-b border-gray-300 mb-5">
        <li
          v-for="tab in tabs"
          :key="tab"
          :class="[
            'px-4 py-2 cursor-default',
            { 'text-orange border-b-2 border-orange': activeTab === tab },
          ]"
          class="tab-head"
          @click="switchTab(tab)"
        >
          <slot :name="tabHeadSlotName(tab)"> {{ tab }} </slot>
        </li>
      </ul>
    </header>
    <main class="card-body">
      <div class="tab-panel">
        <slot :name="tabPanelSlotName"> </slot>
      </div>
    </main>
  </div>
</template>

<script>
export default {
  props: {
    initialTab: {
      type: String,
      default: null,
    },
    tabs: {
      type: Array,
      default: null,
    },
  },
  data() {
    return {
      activeTab: this.initialTab,
    }
  },
  computed: {
    tabPanelSlotName() {
      return `tab-panel-${this.activeTab}`
    },
  },
  methods: {
    tabHeadSlotName(tabName) {
      return `tab-head-${tabName}`
    },
    switchTab(tabName) {
      this.activeTab = tabName
    },
  },
}
</script>
