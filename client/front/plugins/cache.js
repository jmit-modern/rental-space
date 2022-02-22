export default (context, inject) => {
  const cache = new Cache()
  inject('cache', cache)
}

class Cache {
  data = {}
  get(key) {
    return this.data[key] ?? null
  }

  set(key, value) {
    this.data[key] = value
    return true
  }

  clear() {
    this.data = {}
    return true
  }
}
