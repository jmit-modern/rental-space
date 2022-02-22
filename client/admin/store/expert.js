import * as pagination from '@/helper/store/pagination'

export const state = () => ({
  data: [],
  detail: {},
  expertStatuses: {},
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

  setExpertTypes(state, data) {
    state.expertTypes = { ...data }
  },

  setExpertStatuses(state, data) {
    state.expertStatuses = { ...data }
  },
}

export const actions = {
  async fetch({ commit, state }, params = {}) {
    const { experts, meta } = await this.$api.fetch('experts', { params })

    commit('set', experts)

    commit('setPagination', meta)
  },

  async fetchDetail({ commit }, id) {
    const { expert } = await this.$api.fetch(`experts/${id}`)

    commit('setDetail', expert)
  },

  async update({ commit, state }, [id, params = {}]) {
    const { data } = await this.$api.update(`experts/${id}`, params)
    commit('update', data.expert)
  },

  async fetchExpertStatuses({ commit, state }, params = {}) {
    const statuses = await this.$api.fetch(`expert_statuses`, { params })
    commit('setExpertStatuses', statuses)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
  expertStatuses: ({ expertStatuses }) => expertStatuses,
  pagination: ({ pagination }) => pagination,
}
