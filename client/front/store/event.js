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

  delete(state, data) {
    // Remove event from the store event list
    const index = state.data.findIndex(function (event) {
      return event.id === data.id
    })
    state.data.splice(index, 1)
  },

  addImage(state, data) {
    state.detail.eventImages.push(data)
  },

  removeImage(state, data) {
    const index = state.detail.eventImages.findIndex(function (image) {
      return image.id === data.id
    })
    state.detail.eventImages.splice(index, 1)
  },
}

export const actions = {
  async fetch({ commit, state }, params = {}) {
    const { events, meta } = await this.$api.fetch('events', { params })

    commit('set', events)

    commit('setPagination', meta)
  },

  async create({ commit, state }, params = {}) {
    await this.$api.store('events', params)
  },

  async update({ commit, state }, [id, params = {}]) {
    const { event } = await this.$api.update(`events/${id}`, params)

    commit('setDetail', event)
  },

  async addImage({ commit, state }, [id, params]) {
    const { eventImage } = await this.$api.store(
      `events/${id}/add_image`,
      params,
      {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
        withCredentials: false,
      },
      { decamelizeRequest: false }
    )

    commit('addImage', eventImage)
  },

  async removeImage({ commit, state }, [id, imageId]) {
    const { data } = await this.$api.destroy(
      `events/${id}/remove_image/${imageId}`,
      {
        withCredentials: false,
      },
      { decamelizeRequest: false }
    )

    commit('removeImage', data.eventImage)
  },

  async fetchDetail({ commit }, { id }) {
    const { event } = await this.$api.fetch(`events/${id}`)

    commit('setDetail', event)
  },

  async delete({ commit }, id) {
    const { data } = await this.$api.destroy(`events/${id}`)

    commit('delete', data.event)
  },
}

export const getters = {
  data: ({ data }) => data,
  detail: ({ detail }) => detail,
  pagination: ({ pagination }) => pagination,
  isReachLastPage: ({ pagination }) =>
    pagination.current_page >= pagination.last_page,
}
