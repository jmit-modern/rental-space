export const state = () => ({
  data: [],
  detail: {},
  userTypes: {},
})

export const mutations = {
  set(state, data) {
    state.data = [...data]
  },

  setDetail(state, data) {
    state.detail = { ...data }
  },

  setUserTypes(state, data) {
    state.userTypes = { ...data }
  },
}

export const actions = {
  async fetch({ commit, state }, params = {}) {
    const { users } = await this.$api.fetch('users', { params })

    commit('set', users)
  },

  async fetchDetail({ commit }, id) {
    const { user } = await this.$api.fetch(`user/${id}`)

    commit('setDetail', user)
  },

  async fetchUserTypes({ commit, state }, params = {}) {
    const types = await this.$api.fetch(`user_types`, { params })
    commit('setUserTypes', types)
  },

  async update({ commit, state }, [id, params = {}]) {
    await this.$api.update(`users/${id}/update`, params)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
  userTypes: ({ userTypes }) => userTypes,
  pagination: ({ pagination }) => pagination,
  isReachLastPage: ({ pagination }) =>
    pagination.current_page >= pagination.last_page,
}
