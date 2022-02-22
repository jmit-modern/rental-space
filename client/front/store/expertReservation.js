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
    const { expertReservations } = await this.$api.fetch(
      'expert_reservations',
      {
        params,
      }
    )
    commit('set', expertReservations)
  },

  async fetchOrders({ commit, state }, params = {}) {
    const { expertReservations } = await this.$api.fetch(
      'expert_reservation_orders',
      {
        params,
      }
    )
    commit('set', expertReservations)
  },

  async fetchDetail({ commit }, { id }) {
    const { expertReservation } = await this.$api.fetch(
      `expert_reservations/${id}`
    )
    commit('setDetail', expertReservation)
  },

  async approve({ commit, state }, [id, params = {}]) {
    const { expertReservation } = await this.$api.store(
      `expert_reservations/${id}/approve`,
      params
    )
    commit('setDetail', expertReservation)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
}
