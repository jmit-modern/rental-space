export default {
  beforeMount() {
    window.addEventListener('click', this.clickInElement)
  },
  beforeDestroy() {
    window.removeEventListener('click', this.clickInElement)
  },
  methods: {
    clickInElement(e) {
      if (!this.$el.contains(e.target)) {
        this.close()
      }
    },
  },
}
