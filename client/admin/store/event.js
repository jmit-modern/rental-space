import * as pagination from '@/helper/store/pagination'

export const state = () => ({
  data: [],
  detail: {},
  eventStatuses: {},
  ...pagination.createState(),
})

export const mutations = {
  ...pagination.mutations,
  set(state, data) {
    state.data = [...data]
  },

  update(state, data) {
    const index = state.data.findIndex((p) => p.id === data.id)
    state.data.splice(index, 1, data)
  },

  setDetail(state, data) {
    state.detail = { ...data }
  },

  setEventTypes(state, data) {
    state.eventTypes = { ...data }
  },

  setEventStatuses(state, data) {
    state.eventStatuses = { ...data }
  },
}

export const actions = {
  async fetch({ commit, state }, params = {}) {
    const { events, meta } = await this.$api.fetch('events', { params })

    commit('set', events)

    commit('setPagination', meta)
  },

  async fetchDetail({ commit }, id) {
    const { event } = await this.$api.fetch(`events/${id}`)

    commit('setDetail', event)
  },

  async update({ commit, state }, [id, params = {}]) {
    const { data } = await this.$api.update(`events/${id}`, params)
    commit('update', data.event)
  },

  async fetchEventStatuses({ commit, state }, params = {}) {
    const statuses = await this.$api.fetch(`event_statuses`, { params })
    commit('setEventStatuses', statuses)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
  eventStatuses: ({ eventStatuses }) => eventStatuses,
  pagination: ({ pagination }) => pagination,
  isReachLastPage: ({ pagination }) =>
    pagination.current_page >= pagination.last_page,
}
