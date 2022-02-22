export const state = () => ({
  data: [],
  detail: {},
})

export const mutations = {
  set(state, data) {
    state.data = [...data]
  },

  setDetail(state, data) {
    state.detail = { ...data }
  },
}

export const actions = {
  async fetch({ commit, state }, params = {}) {
    const { reservations } = await this.$api.fetch('reservations', { params })
    commit('set', reservations)
  },

  async fetchDetail({ commit }, { id }) {
    const { reservation } = await this.$api.fetch(`reservations/${id}`)
    commit('setDetail', reservation)
  },

  async fetchOrders({ commit, state }, params = {}) {
    const { reservations } = await this.$api.fetch('reservation_orders', {
      params,
    })
    commit('set', reservations)
  },

  async approve({ commit, state }, [id, params = {}]) {
    const { reservation } = await this.$api.store(
      `reservations/${id}/approve`,
      params
    )
    commit('setDetail', reservation)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
}
