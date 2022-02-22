import { decamelizeKeys, camelizeKeys } from '@/utils'

export default function ({ $axios, store }, inject) {
  const apiInstance = $axios.create()

  // Axios middleware to convert all api responses to camelCase
  apiInstance.interceptors.response.use((response) => {
    if (
      response.data &&
      response.headers['content-type'].includes('application/json')
    ) {
      response.data = camelizeKeys(response.data)
    }
    return response
  })

  // Axios middleware to convert all api requests to snake_case
  apiInstance.interceptors.request.use((config) => {
    const newConfig = { ...config }

    const token = store.$auth.getToken('local')

    if (token) {
      newConfig.headers.Authorization = token
    }

    if (newConfig.headers['Content-Type'] === 'multipart/form-data')
      return newConfig
    if (config.params) {
      newConfig.params = decamelizeKeys(config.params)
    }
    if (config.data) {
      newConfig.data = decamelizeKeys(config.data)
    }
    return newConfig
  })

  const api = new API(apiInstance)

  inject('api', api)
}

class API {
  constructor(axios) {
    this.axios = axios
  }

  fetch(url, config = {}) {
    return this.axios.$get(`/${url}`, config)
  }

  store(url, params, config = {}) {
    return this.axios.$post(`/${url}`, params, config)
  }

  update(url, params, config = {}) {
    return this.axios.put(`/${url}`, params, config)
  }

  destroy(url, config = {}) {
    return this.axios.delete(`/${url}`, config)
  }
}
