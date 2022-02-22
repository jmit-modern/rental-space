import * as pagination from '@/helper/store/pagination'

export const state = () => ({
  data: [],
  detail: {},
  spaceTypes: {},
  spaceStatuses: {},
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

  setSpaceTypes(state, data) {
    state.spaceTypes = { ...data }
  },

  setSpaceStatuses(state, data) {
    state.spaceStatuses = { ...data }
  },
}

export const actions = {
  async fetch({ commit, state }, params = {}) {
    const { spaces, meta } = await this.$api.fetch('spaces', { params })

    commit('set', spaces)

    commit('setPagination', meta)
  },

  async fetchDetail({ commit }, id) {
    const { space } = await this.$api.fetch(`spaces/${id}`)

    commit('setDetail', space)
  },

  async update({ commit, state }, [id, params = {}]) {
    const { data } = await this.$api.update(`spaces/${id}`, params)
    commit('update', data.space)
  },

  async fetchSpaceTypes({ commit, state }, params = {}) {
    const types = await this.$api.fetch(`space_types`, { params })
    commit('setSpaceTypes', types)
  },

  async fetchSpaceStatuses({ commit, state }, params = {}) {
    const statuses = await this.$api.fetch(`space_statuses`, { params })
    commit('setSpaceStatuses', statuses)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
  spaceTypes: ({ spaceTypes }) => spaceTypes,
  spaceStatuses: ({ spaceStatuses }) => spaceStatuses,
  pagination: ({ pagination }) => pagination,
  isReachLastPage: ({ pagination }) =>
    pagination.current_page >= pagination.last_page,
}
