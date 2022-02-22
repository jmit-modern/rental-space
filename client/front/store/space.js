import * as pagination from '@/helper/store/pagination'

export const state = () => ({
  data: [],
  detail: {},
  spaceTypes: {},
  ...pagination.createState(),
})

export const mutations = {
  ...pagination.mutations,
  set(state, data) {
    state.data = [...data]
  },

  reset(state, data) {
    state.data = []
  },

  add(state, data) {
    state.data.push(...data)
  },

  setDetail(state, data) {
    state.detail = { ...data }
  },

  setSpaceTypes(state, data) {
    state.spaceTypes = { ...data }
  },

  setPagination(state, params) {
    state.pagination = { ...params }
  },

  delete(state, data) {
    // Remove space from the store space list
    const index = state.data.findIndex(function (space) {
      return space.id === data.id
    })
    state.data.splice(index, 1)
  },

  addImage(state, data) {
    state.detail.spaceImages.push(data)
  },
  removeImage(state, data) {
    const index = state.detail.spaceImages.findIndex(function (image) {
      return image.id === data.id
    })
    state.detail.spaceImages.splice(index, 1)
  },

  addPlan(state, data) {
    state.detail.spacePlans.push(data)
  },
  updatePlan(state, data) {
    state.detail.spacePlans = state.detail.spacePlans.map((plan) =>
      plan.id === data.id ? data : plan
    )
  },
  removePlan(state, data) {
    const index = state.detail.spacePlans.findIndex(function (plan) {
      return plan.id === data.id
    })
    state.detail.spacePlans.splice(index, 1)
  },
}

export const actions = {
  async fetch({ commit, state }, params = {}) {
    const { spaces, meta } = await this.$api.fetch('spaces', { params })
    commit('set', spaces)
    commit('setPagination', meta)
  },

  async fetchDetail({ commit }, { id }) {
    const { space } = await this.$api.fetch(`spaces/${id}`)
    commit('setDetail', space)
  },

  async fetchSpaceTypes({ commit, state }, params = {}) {
    const types = await this.$api.fetch(`space_types`, { params })
    commit('setSpaceTypes', types)
  },

  async create({ commit, state }, params = {}) {
    await this.$api.store('spaces', params)
  },

  async update({ commit, state }, [id, params = {}]) {
    const { space } = await this.$api.update(`spaces/${id}`, params)
    commit('setDetail', space)
  },

  async addImage({ commit, state }, [id, params]) {
    const { spaceImage } = await this.$api.store(
      `spaces/${id}/add_image`,
      params,
      {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
        withCredentials: false,
      },
      { decamelizeRequest: false }
    )
    commit('addImage', spaceImage)
  },

  async removeImage({ commit, state }, [id, imageId]) {
    const { data } = await this.$api.destroy(
      `spaces/${id}/remove_image/${imageId}`,
      {
        withCredentials: false,
      },
      { decamelizeRequest: false }
    )
    commit('removeImage', data.spaceImage)
  },

  async delete({ commit }, id) {
    const { data } = await this.$api.destroy(`spaces/${id}`)
    commit('delete', data.space)
  },

  async addPlan({ commit, state }, [id, params]) {
    const { spacePlan } = await this.$api.store(`spaces/${id}/plan`, params)
    commit('addPlan', spacePlan)
  },
  async updatePlan({ commit, state }, [id, planId, params]) {
    const { data } = await this.$api.update(
      `spaces/${id}/plan/${planId}`,
      params
    )
    commit('updatePlan', data.spacePlan)
  },
  async removePlan({ commit, state }, [id, planId]) {
    const { data } = await this.$api.destroy(`spaces/${id}/plan/${planId}`)
    commit('removePlan', data.spacePlan)
  },

  async updateFacilities({ commit, state }, [id, params]) {
    const { space } = await this.$api.update(`spaces/${id}/facilities`, params)
    commit('setDetail', space)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
  spaceTypes: ({ spaceTypes }) => spaceTypes,
  pagination: ({ pagination }) => pagination,
  isReachLastPage: ({ pagination }) =>
    pagination.current_page >= pagination.last_page,
}
