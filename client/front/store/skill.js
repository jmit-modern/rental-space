export const state = () => ({
  data: [],
})

export const mutations = {
  set(state, data) {
    state.data = [...data]
  },
}

export const actions = {
  async fetch({ commit, state }, params = {}) {
    const { skills } = await this.$api.fetch('skills', { params })

    commit('set', skills)
  },
}

export const getters = {
  data: ({ data }) => data,
}
