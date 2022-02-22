export const unique = (arr, key = 'id') => {
  const { uniqued } = arr.reduce(
    (dict, element) => {
      const dictKey =
        typeof element === 'object' && element !== null ? element[key] : element

      dict.duplicated[dictKey] = dict[dictKey] !== undefined

      if (!dict.duplicated[dictKey]) {
        dict.uniqued.push(element)
      }

      return dict
    },
    { duplicated: {}, uniqued: [] }
  )

  return uniqued
}

export const range = (start, end, step = 1) => {
  const len = Math.floor((end - start) / step) + 1
  return Array(len)
    .fill()
    .map((_, idx) => start + idx * step)
}
