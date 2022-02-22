export const createTree = (data, parentId = null, level = 1) => {
  return data.reduce((tree, item) => {
    item = { ...item }

    if (Number(item.parent_id || 0) === Number(parentId || 0)) {
      if (!item.level) {
        item.level = level
      }

      item.children = createTree(data, item.id, level + 1)

      tree.push(item)
    }

    return tree
  }, [])
}

export const arr2Kv = (srcArray, options = {}) => {
  const { valueName = 'value', keyName = 'key' } = options

  return srcArray.reduce(
    (kv, item) => ({
      ...kv,
      [item[keyName]]: item[valueName],
    }),
    {}
  )
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

export const isEmpty = (obj) => {
  return Object.keys(obj).length === 0
}
