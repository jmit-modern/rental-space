import merge from 'lodash.merge'

export const createTree = (data, parentId = null, level = 1) => {
  return data.reduce((tree, item) => {
    item = { ...item }

    if (Number(item.parentId || 0) === Number(parentId || 0)) {
      if (!item.level) {
        item.level = level
      }

      item.children = createTree(data, item.id, level + 1)

      tree.push(item)
    }

    return tree
  }, [])
}

export const createAncestorDict = (children, ancestors = {}) => {
  return children.reduce((ancestors, node) => {
    if (Array.isArray(node.children) && node.children.length > 0) {
      createAncestorDict(node.children, ancestors)
    }

    return Object.assign(ancestors, { [node.id]: node })
  }, ancestors)
}

export const createTreeCache = (tree, cache = {}) => {
  return tree.reduce((cache, node) => {
    if (Array.isArray(node.children) && node.children.length > 0) {
      createTreeCache(node.children, cache)
      node.ancestors = createAncestorDict(node.children)
    }

    return Object.assign(cache, { [node.id]: node })
  }, cache)
}

export const createDict = (items, keyPropName = 'id') =>
  items.reduce((dict, item) => {
    return Object.assign(
      dict,
      typeof item === 'object'
        ? { [item[keyPropName]]: item }
        : { [item]: item }
    )
  }, {})

export const aggrigate = (items, groupingKey) =>
  items.reduce((group, item) => {
    const key = item[groupingKey]

    if (!group[key]) {
      group[key] = []
    }

    group[key].push(item)

    return group
  }, {})

export const createOptions = (items) =>
  items.map(({ id, name }) => ({
    code: id,
    name,
  }))

export const createOnlineCategoryOptions = (items) =>
  items
    .filter((item) => item.parentId == null)
    .map(({ id, name }) => ({
      code: id,
      name,
    }))

export const createOnlineTagOptions = (items) => {
  return items
    .filter((item) => item.parentId !== null)
    .sort((t1, t2) => t1.sort - t2.sort)
    .map(({ id, name, parentId }) => ({
      code: id,
      name,
      sort: items.find((item) => Number(item.id) === Number(parentId)).sort,
    }))
    .sort((t1, t2) => t1.sort - t2.sort)
}

/**
 * 2階層までのツリーを作る
 * @param {Array} items
 */
export const createSecondLevelTree = (items) => {
  const groups = items.reduce((group, node) => {
    if (node.parentId) {
      return group
    }
    return Object.assign(group, { [node.id]: node })
  }, {})

  items.forEach((node) => {
    if (!node.parentId) {
      return
    }

    if (!groups[node.parentId]) {
      return
    }

    if (!Array.isArray(node[node.parentId].children)) {
      groups[node.parentId].children = []
    }

    groups[node.parentId].children.push(node)
  })

  return Object.values(groups)
}

/**
 * ツリーから要素リストを取得する
 * @param {Array} tree
 * @param {String} elementName
 */
export const getElementListFromTree = (tree, eleName) => {
  return tree.reduce((acc, o) => {
    if (o[eleName]) acc.push(o[eleName])
    if (o.children)
      acc = acc.concat(getElementListFromTree(o.children, eleName))
    return acc
  }, [])
}

/**
 * @param {Array<String|Array<String>>} props
 * @returns {Object}
 */
export const createEmpty = (props) => {
  return props.reduce((obj, name) => {
    if (Array.isArray(name)) {
      return merge(obj, createEmpty(name))
    }

    if (name.includes('.')) {
      const names = name.split('.')
      const childObj = createEmpty([names.slice(1).join('.')])
      const firstName = names[0]
      return merge(obj, { [firstName]: childObj })
    }

    return { ...obj, [name]: null }
  }, {})
}
