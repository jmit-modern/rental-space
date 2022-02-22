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
    const { eventReservations } = await this.$api.fetch('event_reservations', {
      params,
    })
    commit('set', eventReservations)
  },

  async fetchOrders({ commit, state }, params = {}) {
    const { eventReservations } = await this.$api.fetch(
      'event_reservation_orders',
      {
        params,
      }
    )
    commit('set', eventReservations)
  },

  async fetchDetail({ commit }, { id }) {
    const { eventReservation } = await this.$api.fetch(
      `event_reservations/${id}`
    )
    commit('setDetail', eventReservation)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
}
