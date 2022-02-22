/**
 * @param {Blob} resource
 * @param {String} fileName
 */
export const downloadFile = (resource, fileName) => {
  const url = window.URL.createObjectURL(resource)
  const element = document.createElement('a')

  element.style.setProperty('opacity', '0')

  document.body.appendChild(element)

  element.download = fileName ?? ''
  element.href = url
  element.click()
  element.remove()

  setTimeout(() => URL.revokeObjectURL(url), 100)
}

export const formatFileSize = (
  size,
  units = ['Byte', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
  delimiter = ' '
) => {
  const threshold = 1024
  size = size * threshold
  const i = size === 0 ? 0 : Math.floor(Math.log(size) / Math.log(threshold))
  return (size / Math.pow(threshold, i)).toFixed(2) * 1 + delimiter + units[i]
}
