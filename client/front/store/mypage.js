import * as pagination from '@/helper/store/pagination'

export const state = () => ({
  data: [],
  detail: {},
  mySkills: [],
})

export const mutations = {
  ...pagination.mutations,
  set(state, data) {
    state.data = [...data]
  },

  setDetail(state, data) {
    state.detail = { ...data }
  },

  setMySkills(state, data) {
    state.mySkills = [...data]
  },
}

export const actions = {
  async fetch({ commit, state }, params = {}) {
    const { experts, meta } = await this.$api.fetch('experts', { params })

    commit('set', experts)

    commit('setPagination', meta)
  },

  async update({ commit, state }, params = {}) {
    await this.$api.update('experts/update', params)
  },

  async fetchDetail({ commit }, { id }) {
    const { expert } = await this.$api.fetch(`experts/${id}`)

    commit('setDetail', expert)
  },

  async fetchMySkills({ commit }, { userId }) {
    const { skills } = await this.$api.fetch(
      `skills_by_user/?user_id=${userId}`
    )
    commit('setMySkills', skills)
  },

  async addSkill({ commit }, [{ id }, params = {}]) {
    await this.$api.store(`experts/${id}/add_skill`, params)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
  mySkills: ({ mySkills }) => mySkills,
}
