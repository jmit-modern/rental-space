export const state = () => ({
  data: [],
  new_spaces: [],
  pickup_spaces: [],
  detail: {},
  pagination: {},
})

export const mutations = {
  setData: (state, { data }) => {
    state.data = { ...data }
  },
  set(state, data) {
    state.data = [...data]
  },

  setNewSpaces(state, data) {
    state.new_spaces = [...data]
  },

  setPickupSpaces(state, data) {
    state.pickup_spaces = [...data]
  },

  setDetail(state, data) {
    state.detail = { ...data }
  },

  setPagination(state, params) {
    state.pagination = { ...params }
  },
}

export const actions = {
  async fetch({ commit, state }, params = {}) {
    const { spaces } = await this.$api.fetch('space', { params })

    commit('set', spaces)
  },

  async fetchNewSpaces({ commit, state }, params = {}) {
    const { spaces } = await this.$api.fetch('top/new_spaces', { params })

    commit('setNewSpaces', spaces)
  },

  async fetchPickupSpaces({ commit, state }, params = {}) {
    const { spaces } = await this.$api.fetch('top/pickup_spaces', { params })

    commit('setPickupSpaces', spaces)
  },
}

export const getters = {
  data: (state, getters, rootState, rootGetters) => {
    return state.data
  },
  newSpaces: (state) => state.new_spaces,
  pickupSpaces: (state) => state.pickup_spaces,
}
