import * as pagination from '@/helper/store/pagination'

export const state = () => ({
  data: [],
  detail: {},
  ...pagination.createState(),
})

export const mutations = {
  ...pagination.mutations,
  set(state, data) {
    state.data = [...data]
  },

  setDetail(state, data) {
    state.detail = { ...data }
  },

  addSkill(state, data) {
    state.detail.skills.push(data)
  },
  removeSkill(state, data) {
    const index = state.detail.skills.findIndex(function (skill) {
      return skill.name === data
    })
    state.detail.skills.splice(index, 1)
  },
}

export const actions = {
  async fetch({ commit, state }, params = {}) {
    const { experts, meta } = await this.$api.fetch('experts', { params })

    commit('set', experts)

    commit('setPagination', meta)
  },

  async update({ commit, state }, [id, params = {}]) {
    await this.$api.update(`experts/${id}`, params)
  },

  async fetchDetail({ commit }, { id }) {
    const { expert } = await this.$api.fetch(`experts/${id}`)

    commit('setDetail', expert)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
  pagination: ({ pagination }) => pagination,
  isReachLastPage: ({ pagination }) =>
    pagination.current_page >= pagination.last_page,
}
